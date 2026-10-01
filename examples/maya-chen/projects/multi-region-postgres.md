<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Multi-region Postgres: the evaluation that ended in "don't"

Northwind Labs, data platform. Sep 2021 – Apr 2022. I ran the evaluation, and I'm the one who argued against the thing I was asked to evaluate. The shipment-tracking product had grown two large EU enterprise customers and a US federal-adjacent customer with a data-residency requirement, and "multi-region active-active Postgres" was assumed to be the answer. My job was to make it real. The honest result was that it shouldn't be built — and what we built instead.

## The assignment as given

"Make the database multi-region so EU customers get EU latency and a region loss doesn't take the product down." Timeline: one quarter to a recommendation, with a mandate leaning yes. I was explicitly told the exec team expected active-active. I want that on the record because arguing against your mandate is a career decision, and I'd make it again.

## What we evaluated

Three months, two engineers plus me, running against a staging replica of the real workload: ~2.1 TB core relational data (tracking events, shipment state machines, customer tenancy tables) and a 6 TB append-only telemetry set. Peak write load ~9K writes/sec, reads ~10× that.

**Option A: active-active multi-primary (bi-directional replication).** We prototyped two candidates:
- A logical-replication-based design (Postgres 14, per-table publication, loop prevention via origin filters). It worked in the happy path and failed the review in the unhappy paths: conflict resolution on the shipment-state tables was a distributed state machine we'd now have to formally specify. Our PoC surfaced ~14 conflict scenarios; for 11 of them "last write wins" produced a shipment state that our own state-machine validator rejected. The fixes were application-level merge logic per table — that's a product of its own.
- A CRDT-flavored rewrite of the hot tables. Not serious at our scale of table count (400+) and query surface (2,300 unique queries in the workload capture). This died on the whiteboard, and I'm including it here only to show we considered it.

**Option B: one primary + async replicas cross-region, manual promotion.** Simple, but the measured failover numbers were bad: cross-region promotion rehearsal took 6–11 minutes of human-driven steps, and the last-transaction loss window was real (async lag p99 4.2s cross-region, so RPO was "seconds, unbounded at the worst moment").

**Option C (my addition): regional tenant placement + sync replica in-region + automated failover in-region.** EU tenants' primary in eu-west, US tenants' primary in us-east. Every region's primary also had a synchronous replica in-region and an async warm standby cross-region. Tenancy was already clean at the row level (every table carried tenant_id), which made placement a routing problem, not a data-model problem.

## Why "don't" won — the actual reasons, not the vibes

1. **Conflict semantics are a product decision disguised as infrastructure.** Active-active turns every multi-region race into a merge policy a product owner must own. For shipment state machines, "both regions accepted status transitions concurrently" isn't a data problem; it's a business-rules problem. We could not write those policies without effectively freezing feature velocity on the hottest tables for a quarter-plus.
2. **The measured latency win didn't justify the operational class it added.** Simulated EU-user latency with EU placement (Option C): p95 96ms. With true active-active: p91 ≈ 88ms. Twelve milliseconds of p95 improvement was the entire prize, because reads were already cache-heavy. Meanwhile active-active's steady-state tax — cross-region replication capacity, conflict telemetry, per-table merge logic — was permanent.
3. **RPO math.** Async-replica active-active still loses data on region loss (our PoC: cross-region replication lag p99 4.2s ≈ 38K shipment events). True zero-RPO active-active would need synchronous cross-region commits: measured write-ack penalty 190–310ms and a hard availability coupling between two regions that 3,000 miles apart share weather and maintenance windows with. We'd be buying latency and fragility to solve a failure mode Option C handles with a 90-second in-region failover instead.
4. **Operational surface.** One Postgres with proven streaming replication we had drills for, versus a federation we'd be the first at this company to operate. Our on-call had 8 people. Active-active needed tooling, training, and blast-radius discipline we'd have to invent under pressure.

## What we shipped (Option C), and how it did

- **Regional tenant placement** for EU/US: routing at the API edge via tenant lookup, data resident in-region. This satisfied the residency requirement, which — embarrassing but true — was the actual forcing function all along, and active-active *didn't* satisfy it cleanly anyway.
- **Synchronous in-region replica + automated failover:** RTO 90 seconds (drill-verified quarterly, real event once, Sept 2022: 74 seconds end-to-end, no data loss), RPO 0 in-region.
- **Cross-region async warm standby** per region for true region-loss: RPO "seconds," accepted explicitly in the design doc with the number attached, plus quarterly restore drills.
- **Read traffic:** 4 read replicas in the primary region for the analytics-adjacent load.

Cost: 2.4× the previous DB spend (regional pairs + standbys), which the doc priced against the alternative honestly. Active-active's PoC ran at 3.1× and carried unbuilt tooling on top.

## What I got wrong in the process

- I spent the first three weeks building the active-active PoC to "earn the right" to kill it. That was backwards. The conflict-scenario enumeration (the 14 cases) should have come first — it's what killed the idea, and it would have taken two weeks, not seven. I burned a month and a half proving a thing the analysis already implied.
- The exec readout initially buried the recommendation on slide 14 after 13 slides of data. The second version (after feedback) led with "we recommend not doing this, and here's what we do instead." The first version almost lost the room. If your recommendation is "don't," say it in the first sentence and spend your credibility budget on the alternative.

## What I kept from the experience

- "Don't" is a legitimate engineering deliverable. The doc that killed active-active has been referenced in three subsequent architecture debates at two companies, and the pattern — enumerate conflict semantics before benchmarking throughput — is how I approach any multi-writer proposal now.
- Quarterly failover drills with real promotion, timed and written up, are the difference between an RTO number that's decoration and one that's true. Our 74-second real event is the proof point I cite most.
