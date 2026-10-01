<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Developer platform cost reduction program

Fernbrook Systems, Platform & Developer Experience, Oct 2023 – Oct 2024. Annual infra spend $6.1M → $4.3M (−29%) across 46 teams. I ran the program: found the money, cut it, priced the latency cost of each cut, and navigated the politics — including the two cuts I argued against and lost, and why I now think losing one of them was correct.

## How this started (context that shaped everything)

2023 planning: growth targets flat, infra bill up 34% year-over-year, and the CTO — a pragmatist I liked — said in the exec staff meeting, within my hearing: "platform owns the infra bill; platform gets the savings target." My VP translated it for me in the hallway: "Congratulations, you have a program."

That framing — *savings as a platform deliverable* — determined the design of everything below. Platform had something no service team had: a division-wide view and no product roadmap to defend. Every service team would (reasonably) fight to protect its own spend; the platform could be the honest broker *and* the executor, because it owned shared infrastructure where the biggest money was.

## How the money was found

**Two months of allocation work before any cutting.** Built the cost model: per-service infra attribution from k8s usage data, CI executor telemetry, storage inventories, and — the piece that made arguments winnable — **unit costs** (infra dollars per 1K customer requests, per pipeline run, per developer-day). Total-spend charts start fights between teams; unit-cost curves start conversations about efficiency, which is a competition everyone can win.

The audit found five buckets, sized at **~$2.1M of identified opportunity**; ~$1.8M of it was realized in-year — the gap being the two lost rounds (below), exception uptake, and the reclaim window. Here they are, as sized:

1. **Over-provisioned compute:** 41% of non-prod environments ran 24/7 at prod-like sizing. **~$900K/yr.**
2. **CI executor sprawl:** five overlapping executor fleets, 12% sustained utilization, cold caches forcing rebuilds. **~$500K/yr.**
3. **Zombie storage:** snapshots and volumes from decommissioned services (the oldest belonged to a service killed in 2021). **~$310K/yr.**
4. **Log and observability volume:** one service emitted 2.1 TB/day of debug logs nobody had queried in a year (confirmed with the query logs, which was a fun meeting). **~$260K/yr.**
5. **Rightsizing and the shared platform itself:** my own platform's over-provisioning, found last and cut hardest, ~$180K/yr — deliberately, because asking others to cut while my own fleet was fat would have killed the program's credibility.

## What we cut, and what it cost

Principle, written into the program charter and enforced: **every cut has a measured cost, and the affected service owner accepts it in writing.** No silent regressions. "Free savings" is usually a latency number nobody's read.

- **Non-prod on a schedule** (off nights/weekends, 41% of hours): the cost was accepted process cost — engineers hitting sleeping environments after hours. Mitigation: a 3-minute wake path and an "on-call prod-like" exception for teams with real weekend deploys (11 teams took it). Accepted in writing by 39 of 46 team leads; the direct quote in the charter from a lead whose team worked weekends: "I accept this, and I resent it," which I published, because honesty about trade-offs is the program's currency.
- **CI consolidation:** one executor fleet, warm remote caches. Cost: none measurable — this was found money, and it funded goodwill for the cuts that *did* have costs.
- **Zombie purge:** none. The two-week reclaim window produced zero claims on $290K of the $310K; the claims we honored cost $20K/yr to keep, and the goodwill was worth it.
- **Log volume:** the 2.1 TB/day service moved debug logging to sampled, with full-fidelity behind a runtime flag for incident windows. Cost: one incident (4 months later) where a non-sampled pattern was wanted post-hoc and sampling had it — the postmortem honestly logged this as a program cost, and the flag design got fixed. That fix shipped in a week because the acceptance doc had named the failure mode in advance.
- **Rightsizing with latency SLOs as the guardrail:** per-service p99 targets set *with* the owning team, then sized to the target with headroom policy. This is where the two losses happened.

## The politics, honestly

- **The two cuts I argued against and lost.** Both were rightsizings where my number-crunching said "safe with p99 impact <5ms" and the service owners said "our tail latency is our product." I lost — they escalated with customer data I hadn't seen. Net program impact: ~$140K/yr left on the table. **I now think one of the two losses was correct** (their customers demonstrably churned on latency; the unit-cost argument couldn't see that), and the other was us negotiating badly. Both losses taught me the same thing: a cost program that can't lose a round in public dies in private.
- **The CTO mandate was a tool and I used it exactly once.** Non-prod scheduling had three holdout teams after two months of consenting adults. One escalation, one calendar invite from the CTO's chief of staff, done — but the mandate's *existence* did the work; I never needed it again. Programs that run on repeated mandates rot; programs that need one, early, to establish that consent is the default, hold.
- **The savings credit fight.** Finance wanted the whole $1.8M booked as "the program"; I insisted per-cut attribution with owner names — my platform's cuts listed first and largest-per-owning-team. That fight mattered: teams saw the ledger was fair, which is why the *next* year's target (smaller, but real) was met with eye-rolls instead of mutiny.

## Outcome, 12 months on

- **$6.1M → $4.3M** (−29%), sustained. Give-back clause honored: CI got $220K of it back as a new cache tier the following year (spend to save, visibly, once).
- Latency cost, total, across all cuts: p99 +0–5ms on rightsized services, one honest incident from log sampling (flag-fixed), zero customer-visible regressions otherwise.
- The cost model + unit-cost dashboards became permanent platform tooling; two product teams adopted unit-cost metrics for their own planning unprompted, which is the adoption signal I'm proudest of.
- **My program postmortem** (I run postmortems on successes too) recorded the miss: I'd scoped non-prod scheduling savings at $1.1M, actual was $900K — exception uptake (11 teams, not the 4 I modeled) was the gap. Cost of the miss: nothing but forecast credibility; I've modeled exception uptake at 3× my instinct ever since.

## What transfers to any cost program

1. Attribution before cutting — you cannot cut what you cannot name, and per-team attribution is what makes it feel fair instead of extractive.
2. Unit costs, not totals — nobody rallies around a total; everybody competes on a rate.
3. Every cut carries an accepted, written cost — and sometimes the right answer is losing the round in public.
4. Cut your own platform first and loudest.
5. Book savings with names attached, or next year's program starts from distrust.
