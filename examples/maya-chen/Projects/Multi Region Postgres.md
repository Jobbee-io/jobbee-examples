<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Multi-region Postgres: the evaluation that ended in "don't"

Northwind Labs, data platform. September 2021 to April 2022. I ran the evaluation, recommended against the thing I was asked to evaluate, and led what we built instead. The shipment-tracking product had two large EU enterprise customers and a US federal-adjacent customer with a data-residency requirement, and "multi-region active-active Postgres" was assumed to be the answer.

## The assignment

"Make the database multi-region so EU customers get EU latency and a region loss doesn't take the product down." One quarter to a recommendation. I was told directly that the exec team expected active-active. Recommending against your mandate is a career decision, and I'd make it again.

## What we evaluated

Three months, two engineers and me, against a staging copy of the real workload: about 2.1 TB of core relational data (tracking events, shipment state machines, tenancy tables) plus a 6 TB append-only telemetry set. Peak writes about 9K per second, reads about 10 times that.

**Option A: active-active, multi-primary.**
- Logical replication (Postgres 14, per-table publications, loops prevented with origin filters). It worked on the happy path. Our proof of concept found 14 conflict scenarios; in 11 of them, last-write-wins produced a shipment state our own state-machine validator rejected. Fixing that meant merge logic per table, a product of its own.
- A CRDT-style rewrite of the hot tables. Not realistic with 400+ tables and 2,300 unique queries in the workload capture. It died on the whiteboard.

**Option B: one primary, async replicas in other regions, manual promotion.** Simple, but the measured failover was bad. A cross-region promotion rehearsal took 6 to 11 minutes of manual steps. Async lag p99 was 4.2 seconds, so RPO was "seconds, unbounded at the worst moment".

**Option C, which I added: regional tenant placement, a synchronous replica in each region, automated failover within the region.** EU tenants' primary in eu-west, US tenants' in us-east. Each regional primary had a synchronous replica in-region and an async warm standby in the other region. Every table already carried `tenant_id`, so placement was a routing problem, not a data-model problem.

## Why "don't" won

1. **Conflict resolution is a product decision.** Active-active turns every concurrent cross-region update into a merge policy someone in product must own. For shipment state machines, two regions accepting different status transitions at once is a business-rules problem. Writing those policies would have frozen feature work on the hottest tables for a quarter or more.
2. **The latency gain was small.** Simulated EU-user p95: 96 ms with Option C, 88 ms with true active-active. Eight milliseconds of p95 was the whole prize, because reads were already mostly cached. The cost (cross-region replication capacity, conflict telemetry, merge logic per table) would have been permanent.
3. **RPO.** Async active-active still loses data when a region fails: replication lag p99 of 4.2 seconds was about 38K shipment events. Zero-RPO active-active needs synchronous cross-region commits: measured write-ack penalty 190 to 310 ms, and two regions that must both be healthy to accept a write. That buys latency and fragility to cover a failure Option C handles with a 90-second in-region failover.
4. **Operational surface.** One Postgres setup with streaming replication we had already drilled, versus a federation nobody at the company had operated. Our on-call was 8 people.

## What we shipped (Option C)

- **Regional tenant placement** for EU and US, routed at the API edge by tenant lookup, with data resident in-region. This met the residency requirement, which turned out to be the real driver all along. Active-active didn't meet it cleanly anyway.
- **Synchronous in-region replica with automated failover.** RTO 90 seconds, drill-verified quarterly. One real event, September 2022: 74 seconds end to end, no data loss. RPO 0 in-region.
- **Async warm standby in the other region** for a full region loss: RPO of seconds, written into the design doc with the number, plus quarterly restore drills.
- **4 read replicas** in the primary region for analytics-style reads.

Cost: 2.4 times the previous database spend (regional pairs plus standbys). The active-active proof of concept ran at 3.1 times, before any of the tooling it still needed.

## What I got wrong

- For the first three weeks I championed active-active. Then I spent four more weeks finishing the proof of concept to "earn the right" to kill it. Seven weeks in total, when the conflict-scenario list that actually killed it would have taken two. I now enumerate conflict semantics before benchmarking anything multi-writer.
- My first exec readout put the recommendation on slide 14, after 13 slides of data, and nearly lost the room. The second version opened with "we recommend not doing this, and here's what we do instead." If the answer is "don't", it goes in the first sentence.

## What came after

- The recommendation doc has been referenced in three later architecture debates, at two companies.
- The quarterly failover drills, with real promotion, timed and written up, are why the 90-second RTO is a measured number. The 74-second real event is the one I cite most.
