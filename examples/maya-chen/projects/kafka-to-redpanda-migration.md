<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Kafka → Redpanda migration

Northwind Labs, data platform. Jan 2022 – Sep 2022. I planned it, drove the cutover, and owned the follow-up. 96 topics, 12 consumer groups, peak 40K events/sec, ~28 TB of event data per month.

## Why we moved

The 18-broker Kafka 2.8 cluster (self-managed, on the same VM fleet as everything else) was our top operational cost center in three senses: money ($214K/year in infra), people (~1.5 FTE-equivalent of my team's time across a year: broker patching, partition reassignments after every node loss, ZooKeeper quirks, one rebalance storm that took consumer groups down for 40 minutes), and latency (produce p95 28ms, occasionally spiking to 200ms+ during rebalances — which then tripped our tracking services' freshness SLOs).

We evaluated, in order:
- **Confluent Cloud** — great product, wrong shape for us: data egress pricing at 28 TB/month was brutal, and procurement wanted the data resident in-region for two enterprise customers. Rejected on cost + data residency.
- **Upgrade in place to Kafka 3.x with KRaft** — honest option, kept on the table for months. But our pain was operations, not features, and we'd still own the brokers.
- **Redpanda** — Kafka-API compatible (our clients were librdkafka and franz-go; zero client changes), no ZooKeeper, tiered storage to S3, and the thing that actually sold me in the PoC: partition rebalancing that didn't stall producers.

Three-week PoC on a shadow cluster replaying two weeks of recorded produce traffic: p95 11ms, no rebalance stalls. Decision doc took one more month because I insisted we cost the "stay on Kafka" option honestly — the answer was that staying cost more and we were just used to it.

## The cutover strategy

Dual-write, in stages. No big bang; every stage had a rollback that wasn't "hope."

1. **Stage 0 (weeks 1–2):** MirrorMaker 2 from old → new, one-way. Consumers stay on old. Purpose: prove the new cluster holds a faithful copy under real load.
2. **Stage 1 (weeks 3–4):** Shadow consumers on the new cluster for the five *tolerant* consumer groups (metrics rollups, audit trail). Compare output to the old-cluster consumers; drift budget: zero over 48 hours.
3. **Stage 2 (weeks 5–8):** Flip producers topic-by-topic, ordered by blast radius (least critical first). Producers wrote to both clusters during this window (dual-produce). New consumers came up per topic as their producers flipped. Six-week overlap total — the plan said four, we took six because of what week 2 taught us (below).
4. **Stage 3 (weeks 9+):** Old cluster switched to read-only, then kept warm for two weeks, then decommissioned. MM2 ran the whole time for any lagging group.

**The thing that made dual-produce safe:** every consumer group's processing was idempotent or keyed-deduped *before* the migration started. That was a two-month prerequisite project on three groups that weren't (exactly the payments-adjacent shipment-status group among them). I've since told every team planning a queue migration: the migration is only as safe as the consumers you had before it.

## What broke

- **Day 2 of stage 2 — the tracking-service lag regression.** The first flipped topic (telemetry-raw) saw its main consumer group's lag climb to 4.1M messages within hours. Root cause: Redpanda's default `fetch.max.bytes` behavior differed enough under our record sizes that effective fetch throughput dropped ~35% for that group's franz-go version. Tuned fetch parameters + bumped that consumer's parallelism (12 → 20), lag drained in 40 minutes. Lesson, which I keep repeating: Kafka-API-compatible is not Kafka-behavior-identical. Shadow consumers exist to catch exactly this and we had them on only five groups — this group wasn't one of them. That was my scheduling shortcut, not the tool's fault.
- **Week 3 — one consumer group's `session.timeout` semantics.** Two groups used aggressive heartbeats tuned against old-Kafka defaults; on Redpanda, rebalances triggered where they hadn't before. Fixed by re-tuning to modern defaults, which we should have done anyway.
- **Nothing data-loss-shaped, ever.** Both clusters held full copies through the overlap; MM2 lag alarms from day 1. The dual-write window is what bought us the ability to treat every breakage as an inconvenience instead of an incident.

## Aftermath (measured, Sept 2022)

- Produce p95: 28ms → 11ms. Rebalance stalls: gone (from ~2/month to zero).
- Streaming infra: $214K → $131K/year. Brokers: 18 → 12.
- Ops time: broker-patching and reassignment tickets went from weekly to essentially never; the team got back roughly the 1.5 FTE I'd been spending.
- Two enterprise customers' freshness SLO stopped being our most-likely breach.

## If I ran it again

- All consumer groups get shadow consumers before any producer flips, not just the tolerant five. The week-2 regression was caught by customer-visible lag, and it didn't have to be.
- I'd freeze consumer-group config changes during the overlap window. One group got "helpfully" re-tuned by its owning team mid-migration and cost us a confusing afternoon.
- The decision doc would lead with ops-time cost, not infra cost. Infra dollars got the meeting; ops time is what actually justified it.
