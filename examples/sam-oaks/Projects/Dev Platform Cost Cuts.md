<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Developer platform cost reduction program

Fernbrook Systems, Platform & Developer Experience, October 2023 to October 2024. Annual infrastructure spend $6.1M → $4.3M (−29%) across 46 teams. I ran the program: built the cost model, found the money, priced the latency cost of every cut, and handled the politics, including two cuts I argued for and lost. The resume has one bullet. This file has the method, the numbers and their definitions, the timeline, and what's still unsolved.

## How it started

In 2023 planning, growth targets were flat and the infrastructure bill was up 34% year over year. In the exec staff meeting the CTO said: "Platform owns the infra bill; platform gets the savings target." My VP translated it for me afterwards: "Congratulations, you have a program."

That framing shaped everything. Platform had something no service team had: a company-wide view and no product roadmap to defend. Service teams would reasonably protect their own spend. Platform could be the honest broker and the one doing the work, because it owned the shared infrastructure where much of the money was.

## How the numbers are defined

- **Annual infra spend** is the monthly run rate times 12: cloud compute, storage and network, CI, and the observability vendor. Baseline: September 2023, $6.1M. Result: September 2024, $4.3M.
- **It isn't traffic-normalized.** Customer requests grew 18% over the same year, so cost per 1,000 customer requests fell about 40%.
- **Sustained:** September 2025 run rate was $4.5M with requests up 31% on the baseline, about 44% below baseline per request.
- **Identified versus realized:** the audit sized about $2.1M of opportunity; about $1.8M was realized in the year. The gap is itemized below.

## Who did what

I wrote the first version of the cost model myself in the first 3 weeks: SQL over the cloud billing export joined to Kubernetes usage data and CI telemetry. Two engineers from the platform infrastructure team then worked on it full time through December to make it a maintained pipeline with dashboards. An analyst from finance owned the reconciliation to the actual invoices. Each of the 46 team leads accepted or rejected the cuts for their own services. I ran the charter, the reviews, every escalation, and the program's own postmortem.

## The cost model

- **Kubernetes cost by resource requests, not usage,** priced at the blended cost of a node. Several teams wanted usage-based attribution, which made their numbers smaller. I kept requests, because requests are what force us to buy nodes, and showed usage next to it so over-requesting was visible rather than hidden. That one disagreement took most of November.
- **CI by pipeline minutes** per team.
- **Storage by tags.** At the start, 22% of spend had no owner tag. A tagging push (an untagged-resource list sent to the most likely owner every week) brought it to 3% by the end of December.
- **Shared costs** (platform, observability) allocated in proportion to each team's direct spend.
- **Unit costs:** infrastructure dollars per 1,000 customer requests, per pipeline run and per developer-day. Totals start fights between teams. Rates start conversations about efficiency, and every team can improve a rate.

## Where the money was: five buckets

| Bucket | Sized | Realized |
|---|---|---|
| Non-prod environments running 24/7 at prod-like sizing (41% of non-prod environments) | ~$900K | ~$720K |
| CI executor sprawl: three overlapping fleets at 12% utilization, cold caches | ~$500K | ~$500K |
| Storage from decommissioned services (the oldest from a service retired in 2021) | ~$310K | ~$290K |
| Log volume: one service writing 2.1 TB/day of debug logs nobody had queried in a year | ~$260K | ~$260K |
| Production rightsizing, 9 services | ~$180K | ~$40K |
| **Total** | **~$2.15M** | **~$1.81M** |

The gap of about $340K: about $180K of non-prod exceptions I under-modeled, about $140K from the two rightsizing rounds I lost, and $20K of storage that owners reclaimed.

## What we cut, and what each cut cost

The charter rule, enforced: every cut has a measured cost, and the affected service owner accepts it in writing. "Free savings" usually means a latency number nobody has looked at.

- **The platform's own fleets first.** The CI fleets were mine. We cut them in December and January, before asking anyone else for anything: three executor fleets into one autoscaled pool with warm remote caches, utilization from 12% to about 48%. No measurable cost. It was the same lesson as my build-system work at Grousemont: the money is in cache hits and one fleet. It also bought goodwill for the cuts that did cost something.
- **Non-prod on a schedule.** Environments switched off from 20:00 to 08:00 on weekdays and all weekend: 64% of the week. The cost was real: engineers working late hit sleeping environments. Mitigations: a wake command that brings an environment back in about 3 minutes, and an exception for teams with genuine weekend deploys, which 11 teams took. 39 of 46 team leads signed the acceptance; 4 teams had no non-prod environments; 3 held out (below). One lead whose team worked weekends wrote: "I accept this, and I resent it." I published that quote in the charter, because honesty about trade-offs is what the program ran on.
- **Storage purge.** Two weeks' notice to reclaim anything listed. No claims on $290K of the $310K; we kept the $20K that owners did claim.
- **Log volume.** The 2.1 TB/day service moved debug logging to sampling, with full logging behind a runtime flag for incidents. The meeting where I showed its query logs (nobody had read those logs in a year) was the turning point for the whole bucket. The cost came 4 months later: an incident where the team wanted a log line after the fact and sampling had dropped it. The postmortem recorded it as a program cost. The fix, shipped in a week because the acceptance doc had named this exact failure mode: the service keeps 6 hours of unsampled logs in a cheap rolling buffer.
- **Production rightsizing.** For each of 9 services we agreed a p99 target with the owning team and sized to it with a headroom policy (40% at peak). Seven went through, for about $40K. Two didn't.

## The two rounds I lost

- **The public query API's edge tier (about $90K a year).** My model said 32 → 20 nodes would add about 4 ms at p99. The team showed me two things I hadn't seen: their enterprise contracts set latency at p99.9, not p99, and in a burst replay p99.9 doubled at 20 nodes. Two enterprise renewals the year before had cited tail latency. They were right and my model was wrong. Since then I size against the percentile the customer contract uses.
- **The ingestion service's memory headroom (about $50K a year).** The team cited a large customer onboarding that would need the headroom. I accepted the projection without asking for a date. Six months later utilization was still 31%, and the onboarding hadn't happened. It was cut in Q2 2025 as a routine change. This one was me negotiating badly: every "we'll need it" claim needs a date.

A cost program that can't lose a round in public loses its credibility in private. Publishing both losses, with the reasons, is part of why the next year's target went smoothly.

## Timeline and turning points

- **October to November 2023:** cost model v1 and attribution; the requests-versus-usage argument.
- **December 2023:** charter and acceptance template published; platform's own CI cuts begin; tagging down to 3% untagged.
- **January to February 2024:** storage purge; the log meeting and sampling.
- **February to May 2024:** non-prod scheduling rollout. In April, after two months of voluntary adoption, three teams were still holding out. I used the CTO's mandate once: one calendar invite from the CTO's chief of staff, and it was done. The mandate's existence did the work; I never used it again.
- **April to August 2024:** rightsizing waves; the two losses in June; the log-sampling incident and fix.
- **September 2024:** measurement. **October 2024:** the program's own postmortem.

## The savings-credit fight

Finance wanted the whole $1.8M booked as "the program". I insisted on per-cut attribution with owner names, with the platform's cuts listed first: the platform's CI cut was the largest single line. Teams could see the ledger was fair. That's why the next year's target (smaller, but real) got eye-rolls instead of resistance.

## Outcomes

- $6.1M → $4.3M run rate (−29%), as defined above, and $4.5M a year later with 31% more traffic.
- Latency cost across all cuts: p99 +0 to 5 ms on the rightsized services, one incident from log sampling (fixed), no other customer-visible regressions.
- The cost model and unit-cost dashboards became permanent platform tooling. Two product teams adopted unit-cost metrics for their own planning without being asked.
- CI got $220K back the following year for a new cache tier: spending to save, visibly, once.

## The miss in my own postmortem

I'd sized non-prod scheduling at $900K and got $720K. The gap was exception uptake: I modeled 4 teams taking the weekend exception, and 11 did. It cost nothing but forecast credibility. I now model exception uptake at 3 times my instinct.

## What isn't solved

- **Showback, not chargeback.** Teams see their costs, but budgets aren't charged to them. The dashboards inform; they don't enforce.
- **Drift.** Untagged spend crept back to 6% by mid-2025 once the weekly push stopped.
- **The observability vendor contract,** about $700K a year, was out of scope because it's a multi-year contract. It renews in 2027, and it's the largest lever left.

## What I'd do differently

- Enforce tags in the deploy pipeline from day 1 instead of a manual push that faded.
- Size against contract percentiles from the start; the query-API loss was predictable.
- Put a date on every headroom claim before accepting it.
- Model exception uptake pessimistically.
