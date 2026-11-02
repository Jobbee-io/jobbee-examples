<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Kafka → Redpanda migration

Northwind Labs, data platform. January 2022 to September 2022. I planned it, drove the cutover and owned the follow-up. 96 topics, 12 consumer groups, peak 40K events per second, about 28 TB of event data a month.

## Why we moved

The 18-broker Kafka 2.8 cluster, self-managed on the same VM fleet as everything else, was expensive three ways:

- Money: $214K a year in infrastructure.
- People: about 1.5 FTE of my team's time over a year. Broker patching, partition reassignments after every node loss, ZooKeeper problems, and one rebalance storm that took consumer groups down for 40 minutes.
- Latency: produce p95 of 28 ms, spiking past 200 ms during rebalances, which then tripped our tracking services' freshness SLOs.

We evaluated, in order:

- **Confluent Cloud.** A good product with the wrong shape for us. Egress pricing at 28 TB a month was very high, and two enterprise customers needed their data kept in-region. Rejected on cost and residency.
- **Upgrade in place to Kafka 3.x with KRaft.** A real option, and we kept it open for months. But our pain was operations, not features, and we'd still be running the brokers.
- **Redpanda.** Kafka-API compatible (our clients were librdkafka and franz-go: no client changes), no ZooKeeper, tiered storage to S3. What decided it in the proof of concept: partition rebalancing didn't stall producers.

## Timeline

- **January:** 3-week proof of concept on a shadow cluster, replaying two weeks of recorded produce traffic. p95 11 ms, no rebalance stalls.
- **February:** the decision doc. It took a month because I insisted on costing "stay on Kafka" honestly. Staying cost more; we were just used to paying it.
- **March to April:** the prerequisite. Every consumer group had to be idempotent or deduplicate by key before any dual-producing. Three weren't, including the shipment-status group. Two months.
- **May to early August:** the staged cutover below, 12 weeks.
- **September:** measured the results.

## The cutover

Dual-write in stages, each with a rollback that didn't depend on luck.

1. **Stage 0 (weeks 1 to 2):** MirrorMaker 2 from the old cluster to the new one, one way. Consumers stayed on the old cluster. Purpose: prove the new cluster held a faithful copy under real load.
2. **Stage 1 (weeks 3 to 4):** shadow consumers on the new cluster for the five tolerant consumer groups (metrics rollups, audit trail). Their output was compared with the old-cluster consumers; the drift budget was zero over 48 hours.
3. **Stage 2 (weeks 5 to 10):** producers flipped topic by topic, least critical first, writing to both clusters during the window. New consumers came up per topic as their producers flipped. The plan said 4 weeks; we took 6 because of what happened on day 2.
4. **Stage 3 (weeks 11 to 12):** old cluster read-only, kept warm for two weeks, then decommissioned. MirrorMaker 2 ran the whole time for any group that fell behind.

## What broke

- **Day 2 of stage 2: a consumer-lag regression.** The first topic we flipped was telemetry-raw. Its main consumer group's lag climbed to 4.1M messages within hours. Redpanda's fetch behavior with our record sizes differed enough that effective fetch throughput dropped about 35% for that group's franz-go version. We tuned the fetch parameters and raised that consumer's parallelism from 12 to 20; the lag drained in 40 minutes. Kafka-API compatible is not Kafka-behavior identical. Shadow consumers exist to catch exactly this, and we had them on only five groups. This group wasn't one of them. That was my scheduling shortcut, not the tool's fault.
- **Second week of stage 2: heartbeat settings.** Two groups had aggressive heartbeat and session timeouts tuned against old Kafka defaults. On Redpanda they triggered rebalances that hadn't happened before. We moved them to current defaults, which we should have done anyway.
- **No data loss at any point.** Both clusters held full copies through the overlap, with MirrorMaker 2 lag alarms from day 1. The dual-write window is what let every breakage be an inconvenience instead of an incident.

## Results, measured September 2022

- Produce p95: 28 ms → 11 ms. Rebalance stalls: about 2 a month → zero.
- Streaming infrastructure: $214K → $131K a year. Brokers: 18 → 12.
- Broker patching and reassignment tickets went from weekly to almost never; the team got back roughly the 1.5 FTE.
- Two enterprise customers' freshness SLOs stopped being our most likely breach.

## If I ran it again

- Shadow consumers on every group before any producer flips, not just the tolerant five. The day-2 regression was caught by customer-visible lag, and it didn't have to be.
- Freeze consumer-group config changes during the overlap. One owning team re-tuned its group mid-migration and cost us a confusing afternoon.
- Lead the decision doc with ops time, not infrastructure cost. The dollars got the meeting; the 1.5 FTE is what justified the move.
