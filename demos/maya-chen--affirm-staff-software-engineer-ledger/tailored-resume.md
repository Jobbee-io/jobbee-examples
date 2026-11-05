> The text of [tailored-resume.pdf](tailored-resume.pdf), the resume Jobbee delivered, for reading and search. See [README.md](README.md) for the job and what to compare.

```text
Maya Chen                                         Staff Software Engineer, Backend — Ledger & Payments Infrastructure
maya.chen@example.com · (555) 010-2233 · github.com/example/mayachen · linkedin.com/in/example-mayachen · Seattle, WA
KEY TECHNICAL IMPACT

     Ledger Engineering: Led the year-long rewrite of the double-entry ledger core at a 3.2M-account banking platform — 3,000 →
     11,000 TPS sustained, p99 180 → 60 ms — proven equivalent over a nine-week parallel run.
     Audit-Grade Accuracy: Compared 2.8B journal entries across old and new ledgers with controller's-office sign-off on every amount-
     touching difference — zero unexplained mismatches through month-end and year-end close.
     Operational Excellence: Led the org-wide on-call overhaul — alert rules 340 → 92, pages ~900 → ~65/month, MTTR 47 → 19
     minutes — with the customer-impact incident rate unchanged.

PROFESSIONAL EXPERIENCE
Bluepeak Systems — Senior Backend Engineer, Payments Platform                                                           Feb 2023 – Present
   Wrote the design doc and capacity model that set the year-long ledger rewrite in motion — load tests put the legacy write path's ceiling
   at 3,000 TPS, 14 months out — then led the Go/gRPC rewrite to 11,000 TPS sustained, p99 180 ms → 60 ms.
   Designed the hot-account fix that made it possible — append-only internal postings with an async balance aggregator, group commit,
   and deadlock-free lock ordering — ending the row-lock queues behind 70% of month-end p99 latency.
   Rejected three simpler-looking designs in architecture review — ledger sharding, a distributed SQL engine, and Kafka as the system of
   record — writing the trigger that reopens sharding when growth demands it.
   Proved equivalence with a nine-week parallel run: 2.8B journal entries compared via a continuous Kafka diff (1.4B events/day, 240
   topics), zero unexplained mismatches for the final 14 days across month-end and year-end close.
   Authored the change-management evidence package internal audit accepted for the ledger, written so a non-engineer could trace each
   mismatch from detection to sign-off; external auditors sampled 25 entries at year-end with no findings.
   Led the cutover from a 23-step runbook — 41-second write pause, no duplicate postings — then decommissioned the legacy Java
   service and its 24 VMs, holding a reverse-shadow rollback for three weeks.
   Tuned per-partition autovacuum after the first month-end on the new path spiked p99 to 95 ms; the next close held 61 ms.
   Traced a recurring reconciliation gap worth ~$1.2M/year in manual review to clock-skewed settlement events; fixed it with monotonic
   per-account sequence fences and documented it legibly for auditors.
   Led the last 31 VM-hosted services onto Kubernetes (~900 pods); capacity planning from measured p95s shrank the fleet 22%.
   Led the org-wide on-call overhaul: migrated ~40 CPU/disk rules to SLO burn-rate conditions, cut alert rules 340 → 92, rotations 7 → 4,
   runbooks CI-gated per pageable alert — pages ~900 → ~65/month, MTTR 47 → 19 minutes.
   Designed the backend hiring loop (now the company standard); interviewed ~90 candidates for 9 hires on the platform.
Northwind Labs — Senior Backend Engineer, Data Platform                                                              Aug 2020 – Feb 2023
  Planned and drove the Kafka → Redpanda cutover of 96 topics and 12 consumer groups (peak 40K events/sec) through a six-week
  dual-write window: produce p95 28 → 11 ms, spend $214K → $131K/year on S3-tiered storage, zero data loss.
  Ran the three-month multi-region active-active Postgres evaluation and recommended against it with measured conflict data; shipped
  regional tenant placement with drill-verified automated failover instead — RTO 90 s, RPO 0 in-region, 74-second real failover.
  Cut end-to-end consumer delivery p95 3.8 s → 900 ms by resolving partition skew, unbounded polling, and consumer misconfiguration.
  Led a data workstream (5 → 8 engineers); mentored three engineers to promotion; wrote the org-wide promotion-doc template.
Cartway — Backend Engineer → Senior Backend Engineer, Payments                                                          Oct 2017 – Aug 2020
  Owned the RCA of a $486K double-charge incident (1,912 transactions, all refunded within 40 hours) and led the six-month rebuild of the
  capture path on end-to-end idempotency keys in Postgres — zero duplicates in the 8 months after launch.
  Justified same-transaction Postgres idempotency over Redis and DynamoDB in a one-page decision doc — 4 ms slower at p99 for a
  correctness guarantee that cannot drift from the money.
  Built nightly payout reconciliation nine weeks from finance's request to production; unexplained balance days fell from ~6/month to zero
  and ~10 analyst-hours/week of manual spreadsheets were retired.
  Co-led carving a Ruby monolith into 14 Go services by transaction boundaries; ledger kept in partitioned Postgres (~4 TB).
Harborlight Software — Software Engineering Intern                                                                           Summer 2016
Freelance Web Development — ~20 sites for local nonprofits, part-time during school                                            2014 – 2016

SKILLS
Languages & APIs: Go (primary since 2018), Ruby, gRPC                 Data & Streaming: PostgreSQL at scale (partitioning, replication,
                                                                      failover), Kafka, Redpanda, S3 tiered storage
Infrastructure & Ops: Kubernetes (migration & operations), SLO        Financial      Systems:      double-entry      ledgers, idempotency,
burn-rate alerting, capacity planning                                 reconciliation, parallel-run migrations, audit evidence
EDUCATION
BS, Computer Science — Alder Ridge University                                                                                  2013 – 2017
Systems coursework — databases, operating systems, networks; teaching assistant for the databases course in senior year.
```
