<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Maya Chen

maya.chen@example.com · (555) 010-2233
github.com/example/mayachen · linkedin.com/in/example-mayachen
Seattle, WA

*This is my resume's bigger sibling. A one-pager holds the top 10% of the story; this file holds the rest — the scope, the decisions, the failures, and the numbers behind every line. No length limit, on purpose. Where a story is long, the project files in `Projects/` carry the full version and this file links to them.*

---

## Summary

Backend engineer, ~9 years, currently Staff on the Payments Platform at Bluepeak Systems. I've spent my career on the unglamorous load-bearing parts of backend systems: payment capture and idempotency, event streaming at tens of thousands of events per second, Postgres replication and failover, and the on-call systems that keep all of it operable. I've worked at three stages of scale — a marketplace payments company, a logistics platform doing 40K events/sec, and a fintech infrastructure company whose ledger core sustains ~11,000 TPS. I write things down, I measure before I fix, and I have one genuinely expensive outage in my past that I rebuilt a whole subsystem because of.

---

## Experience

### Bluepeak Systems — Staff Backend Engineer, Payments Platform (Feb 2023 – present)

Business banking platform, ~3.2M business accounts. Payments Platform team of 12. Promoted to Staff in March 2025.

- **Ledger core rewrite (2023–2024).** Led the rewrite of the double-entry ledger write path in Go: 3.7× throughput (3,000 → 11,000 TPS sustained), p99 write latency 180ms → 60ms. The hard part wasn't speed, it was proving equivalence: we ran old and new ledgers in parallel for nine weeks with a continuous reconciliation diff (1.4B events/day through Kafka, 240 topics) before cutting over.
- **Reconciliation drift find (2024).** Found a recurring reconciliation gap costing ~$1.2M/year in manual review effort, caused by clock skew in one consumer group writing settlement events out of order. Fixed with monotonic sequence fences per account rather than trusting timestamps. Wrote the doc that made this legible to auditors.
- **VM → Kubernetes migration (2024).** Led the migration of the last 31 VM-hosted services onto the company k8s platform (~900 pods at peak now). Did capacity planning from measured p95s, not vendor defaults; the fleet shrank 22% in the move.
- **On-call overhaul (2024).** Org-wide: alert rules 340 → 92, pages ~900/month → ~65/month, MTTR 47 → 19 minutes. Full notes: `Projects/On Call Overhaul.md`.
- **Hiring.** Designed the backend loop (now the company standard for backend roles), interviewed ~90 candidates, 9 hires currently on the platform.
- Era tech: Go, Postgres (partitioning, vacuum tuning), Kafka, Kubernetes, OpenTelemetry, gRPC.

### Northwind Labs — Senior Backend Engineer, Data Platform (Aug 2020 – Feb 2023)

Shipment-tracking SaaS for large shippers. Event telemetry peaked at 40K events/sec, ~28 TB of event data per month. Joined when the data workstream was 5 engineers; it was 8 when I left, and I led it for the last year.

- **Kafka → Redpanda migration (2022).** Planned and drove the cutover of 96 topics and 12 consumer groups from an 18-broker Kafka cluster to 12 Redpanda brokers, with a six-week dual-write window. Produce p95 28ms → 11ms; streaming infra spend $214K → $131K/year. Full notes including what broke on day 2: `Projects/Kafka To Redpanda Migration.md`.
- **Multi-region Postgres evaluation (2021–2022).** Ran the three-month active-active evaluation and argued against it. What shipped instead: regional tenant placement for EU customers, four read replicas, and drill-verified automated failover (RTO 90s, RPO 0 in-region). Full reasoning: `Projects/Multi Region Postgres.md`.
- **Consumer-lag program (2021).** End-to-end delivery p95 3.8s → 900ms by fixing a mix of partition skew (two hot keys, fixed with salting), unbounded consumer polling, and one misconfigured `max.poll.interval`.
- **Mentoring.** Took three engineers through promotion — one to senior, two to mid-level. Wrote the promotion-doc template the org still uses.

### Cartway — Backend Engineer → Senior Backend Engineer, Payments (Oct 2017 – Aug 2020)

Marketplace payments platform: payment intents peaked around 2,500 TPS; partitioned Postgres ledger ~4 TB by 2020. Promoted to Senior in 2019.

- **Double-charge incident and idempotency rebuild (May 2019 – Dec 2019).** A gateway retry plus a non-idempotent capture endpoint (with an in-memory dedupe that didn't survive multi-instance deploys) double-charged 1,912 transactions, $486K, all refunded within 40 hours. I owned the RCA and then the six-month rebuild of the capture path around end-to-end idempotency keys. Zero service-caused duplicates in the 14 months after launch. This is the incident that shaped how I work. Full notes: `Projects/Payments Idempotency.md`.
- **Monolith carve-out (2018–2020).** Co-led carving a Ruby monolith into Go services — 14 services by 2020 — chosen by transaction boundaries, not fashion. Kept the ledger in Postgres throughout; resisted a NoSQL detour I'm still glad we resisted.
- **Payouts reconciliation (2019).** Built nightly reconciliation for marketplace payouts; unexplained balance days went from ~6/month to zero. Boring, and the most-used tool I built there.

### Earlier

- **Harborlight Software — Software Engineering Intern (summer 2016).** Internal status dashboard for a 40-person consultancy. First exposure to on-call, as a shadow. Learned that dashboards nobody looks at are decoration.
- **Freelance web work (2014–2016, part-time during school).** ~20 small sites for local nonprofits. Learned to ship alone, scope alone, and invoice alone.

---

## Education

**BS Computer Science, Alder Ridge University, 2013–2017.** Coursework leaned systems: databases, operating systems, networks. TA for the databases course in my senior year.

---

## Skills, by era (because tools are biographical)

- **2017–2020:** Ruby/Rails (monolith era), Go (from 2018), Postgres, Redis, RabbitMQ → Kafka, early Terraform.
- **2020–2023:** Go (primary), Kafka at scale, Redpanda, Postgres HA (replication, failover tooling), gRPC, Prometheus/Grafana, Kubernetes.
- **2023–now:** Go, Postgres internals (partitioning, autovacuum tuning), Kafka operations, Kubernetes operations (not just deploys), OpenTelemetry, SLOs and burn-rate alerting, capacity planning.

---

## Numbers I can defend in an interview

- 2,500 TPS payment intents (Cartway); ~11,000 TPS ledger core (Bluepeak).
- 40K events/sec peak telemetry; 28 TB/month; 96 topics; 12 consumer groups (Northwind).
- $486K double-charged, 100% refunded in 40 hours, 1,912 transactions (the incident).
- Six-week dual-write window, 18 → 12 brokers, produce p95 28ms → 11ms (the migration).
- ~900 → ~65 pages/month, MTTR 47 → 19 min, alert rules 340 → 92 (the on-call overhaul).
- RTO 90s drill-verified, RPO 0 in-region (the failover design that replaced active-active).

## Failures, indexed honestly

- The double-charge incident (2019) — mine to own; rebuilt the capture path because of it.
- The active-active proposal I championed for three weeks before the data killed it — killed it myself, in writing.
- A week-2 consumer-lag regression after the Redpanda cutover that better shadow-phase metrics would have caught pre-cutover. The dashboards were supposed to be done first. I let the schedule argue me out of it.
