<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Rohan Ghaisas

rohan.ghaisas@example.com
Pune, India · github.com/example/rohanghaisas · linkedin.com/in/example-rohanghaisas

*The long version of my resume. The one-pager keeps the top lines; this file keeps the scope, the numbers with their definitions, and the things that went wrong. Where a story is long, a file in `Projects/` holds the full version and the bullet points to it.*

---

## Summary

Senior Site Reliability Engineer, about 9 years, based in Pune. I started as a Linux sysadmin on night shifts in a hosting company's NOC, moved into DevOps at a grocery-delivery startup during the 2020 lockdown, and since 2022 I've been an SRE at Larkspan Software, an Indian B2B SaaS company that sells accounts-payable automation to US mid-market companies. Every customer I've served for nearly 5 years is in the US, and our US office is 9.5 to 10.5 hours behind me. I run Kubernetes at fleet level, keep Terraform honest, command incidents, and I designed the follow-the-sun rotation that stopped my Pune team being woken up for US daytime problems.

---

## Experience

### Larkspan Software — Senior Site Reliability Engineer (Apr 2023 – present); Site Reliability Engineer (Feb 2022 – Mar 2023)

Accounts-payable automation (invoice capture, approvals, vendor payments) for about 1,400 US mid-market customers, about 3.8M invoices a month. Engineering is about 120 people in Pune and 15 in our US office in Columbus, Ohio. Platform and SRE group of 13: 10 in Pune, 3 in Columbus. One public cloud, a primary region on the US East Coast and a secondary on the West Coast. 16 Kubernetes clusters (6 production), about 140 services, about 3,600 production pods at peak.

- **Region-outage incident command (Oct 2025).** Incident commander for 8 hours of a 12-hour-48-minute incident when our cloud provider's primary US region degraded. Moved invoice ingestion to the secondary region in 39 minutes once we decided; zero data lost, zero duplicate payments. I also own the mistakes: a 40-minute wait for the provider's status page and 1,870 duplicate invoices from our replay. Full notes: `Projects/Region Outage Incident Command.md`.
- **Follow-the-sun on-call between Pune and Columbus (designed late 2024, live Jan 2025).** Two 12-hour layers instead of a 24x7 Pune rotation. Night pages to Pune engineers (22:00–07:00 IST) went from about 31 a month to about 2; median night acknowledgement from 9 minutes to 3. Includes the daylight-saving gap I built into the schedule. Full notes: `Projects/Follow The Sun On Call.md`.
- **Logging cost cut (Mar–Aug 2025).** Hosted logging bill $46K → $19K a month; ingest 4.6 → 1.5 TB a day. Net of new object storage, about $315K a year. Full notes: `Projects/Logging Cost Cut.md`.
- **Kubernetes fleet upgrade (Feb–Oct 2024).** Program owner. All 16 clusters from 1.24 to 1.28, 64 version hops, zero customer-facing outage minutes, one 14-minute latency degradation that I count against the program. Ended about $5,800 a month in extended-support fees. Full notes: `Projects/Kubernetes Fleet Upgrade.md`.
- **Terraform drift cleanup (Jul–Dec 2023).** 1,940 drifted resources to 0, 612 unmanaged resources imported or deleted, nightly drift detection since. Full notes: `Projects/Terraform Drift Cleanup.md`.
- **Incident command.** On the incident-commander rotation since mid-2023. IC for 11 SEV-1 and SEV-2 incidents. I write the postmortem for every incident I command.
- **Working with the US side.** Weekly reliability review with the Columbus customer-success leads (Wednesdays, 19:30 IST). Two business trips to Columbus: 2 weeks in June 2023, 1 week in April 2025.
- **Mentoring and hiring.** Mentored 4 SREs in Pune; 2 were promoted. Interviewed about 60 SRE candidates.
- Tech in this era: Kubernetes, Helm, Argo CD, Terraform, Prometheus, Grafana, OpenTelemetry Collector, managed PostgreSQL, Redis, Python, Go (small tools), Bash.

### Grocevine — DevOps Engineer (Apr 2020 – Jan 2022)

Online grocery delivery in 4 cities in Maharashtra, Pune headquarters, about 45 engineers. I joined in the first weeks of the 2020 lockdown as the second person on a 3-person infrastructure team.

- Order volume grew 3.4x between March and May 2020. Scaled the order API and its PostgreSQL database (read replicas, PgBouncer, query fixes with the backend team) and kept checkout p95 under 800ms through the Diwali 2020 sale week, which peaked at about 9x normal weekday orders per minute.
- Moved 22 services from hand-deployed VMs (Jenkins, shell scripts, Ansible) onto the company's first Kubernetes cluster. Deploys went from about 2 a week, each with a 40-minute manual checklist, to about 25 a day through CI.
- Started the first on-call rotation (5 people) and the postmortem template the team still used when I left.
- The PostgreSQL 11 → 13 upgrade in August 2021 ran 47 minutes past its 30-minute window. Mine; see failures below.

### Deccan Rackworks — Linux Systems Administrator (Jul 2017 – Mar 2020)

Managed hosting and colocation in Pune. About 1,100 Linux servers (mostly CentOS) for about 60 small and mid-sized clients, monitored from a 24x7 NOC.

- Worked rotating night shifts in the NOC for my first 18 months (Jul 2017 – Dec 2018), 3 nights a week. That is where my views on humane on-call come from.
- Automated monthly patching with Ansible, with a canary group per client. The patch cycle went from about 9 working days to 2.
- Moved 140 client servers from CentOS 6 to CentOS 7 ahead of CentOS 6 end of life (2019–2020).

---

## Education

**BE Computer Engineering, Torna Institute of Engineering, Pune, 2013–2017.**

## Certifications

- Red Hat Certified System Administrator (RHCSA), 2018
- Certified Kubernetes Administrator (CKA), 2022, renewed 2025

## Skills (honest)

- Strong: Kubernetes operations (upgrades, scheduling, disruption budgets, autoscaling), Terraform and state design, Linux, Prometheus and Grafana, SLO burn-rate alerting, incident command, Bash, Python.
- Working: Helm, Argo CD, OpenTelemetry Collector pipelines, managed PostgreSQL operations (replicas, failover, major upgrades), Go for small tools and kubectl plugins.
- Limited: I'm deep on one public cloud and have working knowledge of a second. I'm not a backend developer. I've run a service mesh, but never designed one.

---

## Numbers I can defend

- 16 clusters, 64 version hops, 0 customer-facing outage minutes, 1 degradation of 14 minutes (the Kubernetes program).
- About 31 → 2 night pages a month for Pune engineers; median night acknowledgement 9 → 3 minutes (follow-the-sun, Feb–Sep 2025 average).
- $46K → $19K a month for logging; 4.6 → 1.5 TB a day of ingest.
- 1,940 → 0 drifted Terraform resources; 431 resources imported, 181 deleted; plan time on the largest state 14 minutes → under 90 seconds.
- Region outage: 1 hour 39 minutes of failing uploads (peak 39% of uploads), 0 data lost, 0 duplicate payments, 1,870 duplicate invoices voided within 2 business days.
- 3.4x order growth between March and May 2020, Diwali peak about 9x, checkout p95 under 800ms (Grocevine).

## Failures, indexed honestly

- 2018, Deccan Rackworks: I scheduled a kernel patch for a UK client's web servers in IST when their maintenance window was written in UK time. The reboot landed in their evening peak: 22 minutes down. My first lesson in writing every time with its zone.
- 2021, Grocevine: I rehearsed the PostgreSQL 11 → 13 upgrade on a 10% copy of the data. On the full database the post-upgrade statistics rebuild took far longer, and checkout was down 47 minutes past the planned window.
- 2023, Larkspan: during the Terraform cleanup I deleted an "orphaned" access role that one customer's file-import integration still used. Their invoices arrived about 9 hours late.
- 2025, Larkspan: my follow-the-sun schedule had a one-hour gap every day for a week after the US clocks changed. One real incident waited 26 minutes for an acknowledgement.
- 2025, Larkspan: during the region outage I waited 40 minutes for the provider's status page before deciding to fail over, when our own telemetry had the answer 20 minutes in.
