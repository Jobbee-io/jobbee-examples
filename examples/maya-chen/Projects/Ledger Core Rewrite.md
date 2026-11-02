<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Ledger core rewrite

Bluepeak Systems, Payments Platform. March 2023 to March 2024. I was the tech lead: I wrote the design and the capacity model, built the core of the new write path, ran the parallel run and led the cutover. On my resume this is one bullet with three numbers: 3,000 → 11,000 TPS sustained, p99 write latency 180 ms → 60 ms, and a nine-week parallel run. This file is the overview. The two parts that would swamp it have their own files.

Companion files: `Ledger Core Rewrite Parallel Run.md` (how we proved the new ledger matched the old one), `Ledger Core Rewrite Cutover.md` (the switch, what broke after it, and the decommission).

## What the ledger is, and why it had to change

Bluepeak is a business banking platform with about 3.2M business accounts. Every movement of money (ACH, wires, card settlement, book transfers, fees, interest) ends up as a journal entry in the ledger: a balanced set of 2 or more postings that sum to zero. Each business account has three ledger accounts (available, pending, holds), so about 9.6M customer ledger accounts, plus about 1,900 internal accounts such as fee income and ACH clearing.

The write path was a Java service from 2017 in front of one Postgres primary. For every entry it locked every account the entry touched with `SELECT ... FOR UPDATE`, checked balances, wrote postings and updated balance rows. In October 2023 it handled about 45M journal entries a day: about 520 TPS on average and about 2,600 TPS at the month-end peak, when interest, fees and statement jobs land on top of normal traffic.

The problem was 12 internal accounts. ACH clearing, card settlement, fee income and a few others appeared in about 60% of all entries. Because the old path locked them like any customer account, every entry touching ACH clearing waited for the same row lock. At month-end, lock waits were about 70% of p99 latency.

In April 2023 I load-tested the old path on a production-size copy. It held 3,000 TPS and no more. Entry volume was growing about 45% a year, so the month-end peak would reach that ceiling around June 2024. That date set the schedule.

## How I define the numbers

- **TPS** means journal entries committed per second. "Sustained" means the highest rate held for a 4-hour soak at production mix (including the hot internal accounts) without breaching the write SLO (p99 ≤ 250 ms) or returning errors. Same harness, same mix, before and after. The old path held 3,000 TPS; at 3,300 lock timeouts started. The new path held 11,000 TPS with p99 at 74 ms during the soak.
- **p99 write latency** is measured at the ledger's gRPC write endpoint, from request received to commit acknowledged, on production traffic over a 28-day window. Old path: October 2023, 180 ms (p50 38 ms). New path: March 2024, 60 ms (p50 14 ms).
- **Event volume.** During the parallel run the ledger's Kafka footprint was 240 topics carrying about 1.4B events a day: the upstream input topics, the change feed that drove the new ledger, both ledgers' output topics, and the diff's own topics. The breakdown is in the parallel-run file.

## Options I considered

1. **Tune the old path** (bigger primary, shorter lock scope, better pooling). Estimated ceiling about 3,900 TPS: one more year. It left the hot-account serialization in place. Rejected as the plan.
2. **Shard the ledger across several Postgres clusters by account.** About 60% of entries touch a hot internal account, so most entries would cross shards and need two-phase commit or a saga. I estimated 6 to 9 extra months, plus in-doubt transactions to handle for money. Rejected for now, with a written trigger for when to revisit it (below).
3. **A distributed SQL database.** A 3-week proof of concept at production mix gave p99 of 140 ms at 5,000 TPS. Moving the hot rows to a new database doesn't remove the contention on them. It also added a new class of system for an on-call of 8. Rejected.
4. **Kafka as the system of record**, with balances as projections. Balance checks need to read their own writes. A projection even 1 second behind means overdrafts. And the record that auditors accept is the Postgres journal. Rejected.
5. **Chosen: stay on one Postgres primary, stop locking hot accounts, and batch commits.** The capacity model said this would reach about 20,000 TPS on the next instance size, enough for about 4 years at the growth rate we had then.

## The design

- **A Go writer service**, stateless, 12 pods on Kubernetes, serving gRPC for synchronous writes (outgoing payments that need a balance check) and consuming Kafka for settlement and batch postings.
- **Customer accounts are locked; internal accounts are not.** Writers lock customer ledger accounts in ascending account-ID order, so deadlocks can't happen by construction. Inside the lock they check the balance, assign the next per-account sequence number and write the postings.
- **Internal accounts are append-only.** Postings to them are written with no balance update. A balance aggregator, one writer per internal account, folds new postings into the balance row every 250 ms. Nothing in the write path checks an internal account's balance, so a staleness of up to 1 second is safe. End-of-day reports read internal balances only after the aggregator has passed that day's close marker.
- **Group commit.** The writer collects entries for up to 5 ms or 64 entries, whichever comes first, and commits them in one transaction. If a batch fails on a constraint, it is retried one entry at a time so one bad entry can't block 63 good ones.
- **A balanced-entry check in the database.** A deferred constraint trigger rejects any transaction where an entry's postings don't sum to zero. I added it after a bug of mine split an entry across two batches (see the parallel-run file).
- **Idempotency in the same transaction.** Every entry carries a key from its source (source system plus source event ID), stored under a unique constraint in the same transaction as the postings. A retry returns the recorded result. It's the pattern I built at Cartway after the double charge (`Payments Idempotency.md`), applied to a ledger.
- **Outputs through an outbox.** Posting events go into an outbox table in the same transaction, and a relay publishes them to Kafka.

In the load harness, removing the internal-account locks took the ceiling from 3,000 to about 6,800 TPS. Group commit took it to 11,000. After that the limit was WAL write throughput on the primary, not locks.

## Who did what

The core group was me, 4 backend engineers from the 12-person Payments Platform team, and an SRE at half time. Our engineering manager handled staffing and executive updates. Two people from the controller's office owned the accounting rules and signed off every explained difference between the ledgers. Internal audit reviewed the evidence before cutover.

I wrote the design doc and capacity model, the batch assembler and lock ordering in the writer, and the matching logic in the diff service. I ran the daily parallel-run triage, wrote the cutover runbook, led the cutover, and presented the evidence to the controller's office and internal audit. The other engineers built the gRPC API, the Kafka consumers, the outbox relay, the balance aggregator and the migration tooling. The SRE built the new Postgres cluster and the load harness infrastructure.

## Timeline and turning points

- **April 2023:** the load test that found the 3,000 TPS ceiling, and the growth curve that put it at June 2024. Rewrite approved.
- **May 2023:** architecture review. Option 5 chosen over sharding.
- **August 2023:** first soak of the new path without batching: 6,800 TPS. **September:** with group commit, 11,000.
- **November 6, 2023:** parallel run starts. Week 1 mismatch rate: 1 in 40,000 entries.
- **November 30:** first month-end in the run. Both ledgers kept up; the diff fell 3 hours behind.
- **December 23 to January 5:** 14 days with zero unexplained mismatches, across the year-end close.
- **January 14, 2024:** cutover, with a 41-second write pause.
- **January 17:** a fraud service reading the old database directly got stale balances. **January 31:** the first month-end on the new path, and a 40-minute latency bump from autovacuum.
- **February 5:** old path read-only. **March 2024:** old database archived and the Java service deleted.

## Who disagreed, and how it was settled

- **A principal engineer from core banking** argued for sharding now, so we'd only migrate once. I answered with the capacity model and a written trigger: start the sharding design when the month-end peak stays above 60% of the tested ceiling for two consecutive months. The architecture review accepted that.
- **The controller's office** worried that unlocked internal accounts meant wrong balances at report time. The close marker settled it: reports read only after the aggregator has passed the day's close, and the aggregator's lag has an alert at 1 second.
- **Our VP of engineering** wanted a 4-week parallel run. I argued the window had to include a month-end and the year-end close, because those are the days the ledger behaves differently. We wrote exit criteria instead of a date. They were met after 9 weeks.
- **Finance** wanted to fix an old interest-rounding behavior during the rewrite. I argued against mixing a migration with a change to money math. The controller agreed. The full story is in the parallel-run file.

## Outcomes

- 3,000 → 11,000 TPS sustained, and p99 180 ms → 60 ms, as defined above.
- About 2.8B journal entries compared during the parallel run. Zero unexplained mismatches for the last 14 days.
- No customer-visible balance error traced to the new write path from cutover to October 2026, going by support and reconciliation classifications.
- Month-end peak in October 2026: about 5,600 TPS, about half the tested ceiling.

## Second-order effects

- **Per-account sequence numbers** made a later fix possible. In 2024 I traced a recurring reconciliation gap to clock skew in a settlement consumer that wrote events out of order. The fix was sequence fences per account instead of timestamps, and the sequences were the ones this rewrite introduced.
- **The SLO burn-rate alerts** we wrote for the cutover became the pattern for the on-call overhaul that started a month later (`On Call Overhaul.md`).
- **The diff stayed, in a smaller form.** It now replays a 1% sample of accounts against every ledger release before deploy, as a regression check.
- **Two reporting jobs had to change** to read after the close marker. That was the real cost of not locking internal accounts.

## What isn't solved

The single primary is still the ceiling. Growth slowed to about 29% a year after 2023. At that rate month-end peaks reach 11,000 TPS around 2029, and the 60% trigger will likely fire in 2027. The sharding design is written but not started. The hard part of that design is the same as in 2023: entries that touch a shared internal account would cross shards.

## What I'd do differently

- Inventory every reader of the old database from its query logs before the parallel run, not after cutover. The fraud-service miss came from trusting the architecture diagram.
- Size the diff for month-end from day 1. It's the tool that proves equivalence, and it had the same hot-key problem as the ledger.
- Review how interest accrual posts during design, with finance in the room. We found a 6-year-old rounding behavior in week 1 of the parallel run that a design review in May could have found.
- Pair on the batching core. I wrote most of it myself. When parallel-run triage took all my time, only one other engineer understood the batch-retry path, and that was a real risk for 2 months.
