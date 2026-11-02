<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Streaming orders pipeline

Pennacott Home, data platform team. Designed in September 2024, built from October 2024 to February 2025 around a code freeze for peak season, live in March 2025, and run by me until March 2026. I designed it and wrote most of it. On my resume it's one bullet with the freshness number. This file holds the options, the design down to the merge conditions, the delivery semantics, late data, how we checked it, the timeline, what broke and what it didn't cover.

## Why

Until 2025, orders data reached the lake once a night: an Airflow job diffed the orders tables in Postgres and loaded the changes. Analysts saw orders up to 30 hours late. The fulfillment team couldn't wait that long, so they queried the production read replica directly. In November 2023 one of those queries pushed replica lag past 20 minutes during peak, and the customer order-status page showed stale data. The ask was simple: fresh orders data in the lake, so nobody needs the replica.

Volume was modest. About 6M orders a year and around 14 lifecycle events per order is about 3 events a second on an average day. The hard parts were duplicates, ordering and late data, not throughput.

## The options

- Run the batch more often: an hourly diff from the read replica. It still loads the replica, freshness is still an hour or more, and a diff sees only an order's latest state, not the steps it went through.
- Change data capture straight from the order tables with Debezium. No work for the order service team, but our pipeline would depend on 6 internal tables and their joins, and any schema change of theirs would break us.
- The order service writes events to Kafka itself. That's two writes, to Postgres and to Kafka, with no transaction across them: an order could commit while its event was lost.
- An outbox. The order service writes each event to an outbox table in the same transaction as the order change, and Debezium publishes the outbox. The event exists if and only if the change committed, and its shape is an agreement between teams, not a copy of internal tables. This is what we built.

The order service's tech lead pushed back on the outbox: more work for his team, and an extra insert on the order write path. We measured it in staging: 1.8 ms more at p95 on order writes. His team built the outbox in about 3 weeks, and my team took on the Debezium connector and its on-call. Getting the replica load off their database was worth it to them too.

For processing I chose Spark Structured Streaming, because my team already ran Spark on EMR. Flink would have been a new runtime with nobody to run it. The Iceberg sink for Kafka Connect was young in 2024, and it couldn't express "update only if the event sequence is higher".

## The design

- Debezium reads the outbox and publishes to a Kafka topic with 24 partitions, keyed by `order_id`, so all events for one order stay in order on one partition. 24 is far more than 3 events a second needs. Adding partitions later breaks per-key ordering, so I bought headroom once.
- Each event carries `event_id`, `order_id`, a per-order `event_seq`, `event_type`, `event_time` and the payload, as Avro in Schema Registry with backward-transitive compatibility. `event_seq` comes from a counter on the order row, incremented in the same transaction, so it only goes up for a given order. I agreed that shape with the order service team before any code. It was our first data contract, before we called it that.
- Outbox rows are deleted after 45 days.
- Spark Structured Streaming on EMR reads the topic every 2 minutes. In `foreachBatch` it writes two Iceberg tables:
  - `order_events`: an event is inserted only if its `event_id` is new. The merge joins on `event_id` and `event_time`. A duplicate carries the same event time, so Iceberg can prune to the days in the batch instead of scanning all of history.
  - `orders_current`: one row per order. The batch is first reduced to the highest `event_seq` per order, and the merge updates a row only if the incoming `event_seq` is higher than the stored one. This table is merge-on-read, because it takes small updates all day.
- Carrier tracking scans arrive on a second topic, from carrier webhooks and batch files. These can be days late.
- Checkpoints on S3 hold the Kafka offsets. If a batch fails after its Iceberg commit but before its checkpoint, it runs again, and the merges turn the second run into a no-op.

## Delivery semantics

As I wrote them in the design doc: Kafka and Debezium give us at-least-once, so duplicates will arrive. Both tables are idempotent, so a replay changes nothing. Effectively once in the tables, at least once on the wire.

My first draft said "exactly-once" in the title. A staff engineer on the platform team asked me to show it held across a connector reset. I couldn't, so the title changed. That review kept me from promising something the system didn't do.

## Late events

Fulfillment wanted orders per warehouse per 5 minutes. They first asked for 1-minute freshness. Their staffing decisions were made on 5-minute counts, so we agreed on 5 minutes at p95. I used event time, not processing time, with a 30-minute watermark. Events later than that go to a `late_events` table, and a nightly job restates the affected days. The ops view marks the last 2 days as "provisional until 02:00", so nobody treats a 5-minute count as final.

Measured over 2025: 98.1% of order events arrived within 1 minute of their event time. For carrier scans, 6.4% arrived more than 30 minutes late and 0.9% more than 24 hours late, nearly all from one carrier that sends batch files.

## How we checked it

- A shadow run from mid-January to the end of February 2025. The stream and the nightly batch both ran, and every morning I compared `orders_current` with the batch table: order counts, and status and totals per order.
- Nightly reconciliation since go-live: `orders_current` against a snapshot of the orders database. Mismatches are re-checked 10 minutes later, and only the ones that persist alert.
- Alerts on consumer lag over 10 minutes, no new commit in 15 minutes, a jump in `late_events`, and reconciliation over target.
- A load test in October 2025, before Cyber Monday: 3,000 events a second in staging, 5 times the largest burst we'd seen.

## The numbers

- Freshness of `orders_current`, p95 from event time to queryable: up to 30 hours → 4 minutes.
- Nightly reconciliation: 0.002% of orders differ, almost all of them orders changing at the moment of the snapshot. My target was under 0.01%.
- Cyber Monday 2025: 1.1M events in the day, with bursts of 600 events a second when carrier batch files landed. No page.
- The fulfillment team stopped querying the read replica in April 2025. We removed their access in May.
- The always-on EMR cluster for the stream cost about $2,800 a month. Kafka ran on the shared MSK cluster.

## Timeline

- September 2024: design doc and review.
- October to mid-November 2024: the outbox (order service team) and the Debezium connector (my team).
- Mid-November 2024 to early January 2025: code freeze for peak season. I wrote the Spark job and its tests against recorded events.
- January and February 2025: shadow run.
- March 2025: live. April: fulfillment off the replica. May: their access removed, and the connector reset (below).
- November 2025: Cyber Monday without a page.
- March 2026: handed over after the layoff (`Three Week Handover.md`).

## What went wrong

- Small files. I started with a 30-second trigger because I could: 2,880 Iceberg commits a day on `orders_current`, each with tiny files. Within three weeks Trino spent 20 seconds planning a query on it. We moved to a 2-minute trigger, hourly compaction and 3-day snapshot expiry, and planning time went back under 1 second.
- The connector reset. In May 2025, during a move to a new MSK Connect version, the Debezium offsets were lost and the connector re-read the outbox: 9.4M events replayed. Both tables were fine. The 5-minute ops view wasn't. I had built it from the raw stream instead of the deduplicated table, and it double-counted orders for 50 minutes. We rebuilt it on `order_events`. Fulfillment noticed before we did. We had a runbook for a connector reset, and nobody had tested it; we rehearsed it in staging the next month.
- For the first month I let the fulfillment team believe the 5-minute counts were final. The "provisional" label came after a shift lead planned staffing on a count that was later restated by 4%.
- Writes that skipped the outbox. In 2025 reconciliation found 3 orders that stayed wrong after the re-check. An admin script updated orders directly in the database, outside the service code, so no outbox row was written. The order service team moved the script onto the service's own update path. The outbox is only complete if every write goes through the service, and reconciliation is how you find out it didn't.

## What it didn't cover

- Returns live in a separate service that still loads nightly, so `orders_current` shows a return the next day.
- One carrier's batch files keep the last 2 days provisional. Nothing on our side fixes that.

## What I'd do differently

- Build every aggregate from the deduplicated table, never from the raw stream.
- Choose the trigger interval and the compaction schedule together, on day one.
- Rehearse a connector reset in staging before go-live, not after the first one.
