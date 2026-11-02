<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Halverd Payments: the competitive POC that won the deal

Cairnwatch, Enterprise West. Discovery in February 2025, POC from March 3 to April 11, contract signed on May 22, 2025. On my resume this is one bullet: 5 of 5 criteria, 184 of 200 alert rules migrated by tooling, $820K first-year ARR. It's the POC I'd walk an interviewer through first, so this file has all of it: discovery, the options for running the POC, the architecture, the week-by-week timeline, the converter, how each number is measured, what I broke, and what is still open.

## Halverd, and why they were buying

Halverd is a payments processor with about 520 engineers and about 430 services on Kubernetes across 3 production clusters, plus 2 staging clusters. In early 2025 they ran their own Prometheus (6 HA pairs) and their own Elasticsearch cluster for logs, and paid an incumbent APM vendor for tracing on 40 services. Keeping the logging cluster up took roughly 2 engineers' time.

Two things made it urgent. The logging cluster went down twice in Q4 2024 during production incidents, and in one of them on-call worked for about 3 hours without logs. And the incumbent's APM contract renewed on June 30, 2025. Their VP of engineering wanted one platform for logs, metrics and traces signed before that date. They ran a formal three-vendor evaluation: us, the incumbent's full platform, and a hosted competitor built on open-source components.

## My role

I was SE of record. I ran technical discovery, wrote the success criteria with their staff SRE, Joaquin, designed and built the POC environment and tooling, and ran the weekly readouts. The AE, Nate, owned the commercial side, the mutual action plan and the relationship with their VP of engineering. A Cairnwatch support engineer set up SSO with me, our security team reviewed the data-handling design, and our metrics PM joined 2 readouts.

I logged about 150 hours on the deal: about 20 in discovery, 15 on the criteria and the POC plan, 30 building the environment, 40 on the alert converter, 25 on readouts and written updates, and 20 on fixes, including the one under "What went wrong".

## Discovery

I ran my sizing worksheet in the second technical call. It's the 8-question worksheet I built after the Sandvane loss (`Sandvane Technical Loss Postmortem.md`).

- Metrics: about 4.1M active series, read from their Prometheus TSDB stats. Our tested limit was 10M per tenant.
- Logs: 800 GB a day, their estimate. It was the one volume I didn't measure, and it was wrong (below).
- Traces: 40 services instrumented, about 430 if they moved everything. About 180K spans a second at peak with full instrumentation, Joaquin's estimate from their APM bill.
- Retention: 30 days for logs, 13 months for metrics, 15 days for traces. US region. PCI DSS scope for anything near card data.

Every line came in under a tested limit, so there was no fit note to write. The risk on this deal was trust, not fit. In the first call Joaquin told me the incumbent had demoed on its own data, and that he didn't believe any vendor's numbers yet.

## The success criteria

I asked for the criteria in writing before we touched their environment. Joaquin and I drafted them over 2 weeks. He signed on February 26, and his VP co-signed.

1. Log search: ingest 1.2 TB a day, with p95 search time of 5 seconds or less on a 7-day window for their 20 most-used saved queries. Joaquin set the volume at 1.5 times their 800 GB estimate, for headroom.
2. Trace one payment authorization end to end across the 14 services in that path, with each span's logs one click away.
3. Migrate their top 200 Prometheus alert rules, with at least 90% converted by tooling rather than by hand.
4. Per-team access for their 31 teams, mapped from SSO groups.
5. A cost model at their 18-month projected volume, under a $950K yearly budget.

We also wrote down what was out of scope: front-end monitoring, security analytics, and the 2 production clusters we wouldn't touch.

## How to run it: 3 options

- A: demo on our own reference app (Pantrylane, from `Demo Environment Rebuild.md`) plus exported samples of their logs. About 1 week to set up. I ruled it out because it was what the incumbent had done, and Joaquin had told me what he thought of that.
- B: a full production deployment on all 3 clusters. The only way to show everything at full scale. But a new vendor in the production data path of a payments processor needed their security review and PCI scoping, which they quoted at 8 to 10 weeks. That ran past June 30.
- C, what we did: collectors in both staging clusters, plus a mirror of one production cluster, the one running merchant-facing APIs, which handles no card data. Real traffic, out of PCI scope, at the cost of up to 2 weeks of setup risk.

Nate wanted option A. The incumbent was pushing Halverd for a decision by the end of March, and C could cost us 2 weeks. I committed to data flowing from the mirror by day 5, with A as the fallback if it wasn't. Nate agreed and my SE manager backed the plan. Data was flowing on day 4.

## The architecture

- Logs: their Fluent Bit agents already shipped logs to Elasticsearch. We added a second output to Cairnwatch and left Elasticsearch running. The same data sat on both sides, so search results and speed could be compared query by query, and nothing they depended on changed.
- Metrics: Prometheus remote write from their existing servers. Their scrape configs didn't change.
- Traces: an OpenTelemetry collector agent on every node, sending to a gateway tier. The gateway routed spans by trace ID, so every span of a trace reached the same collector, which made the sampling decision: keep every trace with an error, every trace over 2 seconds, and 10% of the rest.
- Card data: the gateway collectors dropped 4 named fields and anything matching a card-number pattern before data left their network. We tested it by sending test card numbers through staging, and none reached our side. Our security team reviewed the config before the mirror went live.
- Access: SSO groups mapped to roles for the 31 teams, each team seeing only its own services.

## Week by week

- Week 1 (March 3 to 7): staging collectors live, the production mirror live on day 4, log dual-write live.
- Week 2: on day 9 I broke their settlement traces (below). The same week their finance team asked for a custom dashboard pack, and I said yes.
- Week 3: the mirror gave us a measured log volume, 1.2 TB a day, not 800 GB. I rebuilt the cost model and sent it on March 20.
- Week 4: criterion 2. 3 Java services in the authorization path had no instrumentation. I paired with their engineers to add the OpenTelemetry Java agent in staging rather than skip those services, and showed the full 14-service trace on March 27. All 31 teams confirmed their access the same week.
- Week 5: the alert backtest, then 2 calls with Joaquin on the 16 rules the converter wouldn't translate.
- Week 6: their script ran the log search benchmark. Final readout to their VP of engineering on April 11.
- April 14: Joaquin's written technical-win note. Nate ran the commercial negotiation through April and May, and the contract was signed on May 22.

## Criterion 3: the alert converter

I expected criterion 3 to decide the deal. Halverd had about 1,100 Prometheus alert rules, holding 10 years of their operations knowledge. Joaquin picked the top 200 by how often they had fired in the last 90 days. The "90% by tooling" condition was his: he wanted proof that the other 900 could move the same way after the POC, without a services engagement.

My manager asked whether professional services should migrate the 200 by hand instead. At about 20 minutes a rule that was about 65 hours, and it would have proved nothing about the other 900. So I wrote a converter in Go, about 1,400 lines. It parses each rule with Prometheus's own PromQL parser, rewrites the expression into our alert format, carries over the `for` duration, labels and annotations, and turns their Alertmanager routing tree into our notification routes for the 31 teams. When it isn't sure, it refuses and flags the rule. It never guesses.

It flagged 16 of the 200:
- 7 depended on recording rules, which version 1 didn't migrate.
- 5 used `absent()`, and our engine handles a missing series differently.
- 4 used subqueries over windows longer than our alert evaluation allowed.

Joaquin and I rewrote those 16 by hand on 2 calls, so his team saw every one.

"Converted by tooling" has a strict meaning here. We ran the original rules and the converted rules over the same 14 days of metric data, March 17 to 30. A converted rule passed if it fired in the same windows as the original, within one 1-minute evaluation interval, with no manual edit. 184 passed, and Joaquin's team reviewed every diff.

## The numbers, and their definitions

- Criteria met: 5 of 5, confirmed in Joaquin's written technical-win note on April 14.
- Log search p95: 3.1 seconds. Their script ran each of the 20 saved queries 50 times over a working day on a 7-day window, 1,000 runs in all. The same script against their own Elasticsearch cluster gave about 11 seconds.
- Alert migration: 184 of 200 rules (92%) converted by the tool, by the backtest definition above.
- Trace: one payment authorization across all 14 services, with each span's logs one click away.
- Cost model: $870K a year at their 18-month projected volume (1.5 TB of logs a day, about 5M active series, all 430 services traced at the agreed sampling), against the $950K budget.
- Deal: $820K first-year ARR, 3-year term. First-year ARR is priced on committed year-one volume, which is why it's below the 18-month model. It was the largest of my 20 closed-won deals in 2025.
- Competition: after the decision, Joaquin told us the open-source-based competitor met 3 of 5 criteria, and the incumbent met 4 of 5 but came in at about 1.4 times the budget. That's his account, not something I measured.

## What went wrong

Day 9: I broke their trace data. My tail-sampling config waited 10 seconds before deciding on a trace. Their settlement service sends spans up to 25 seconds after the authorization, so the late spans arrived after the decision and were dropped. For about 20 hours, 31% of settlement traces were incomplete. I found it from a gap in the span counts, told Joaquin the same afternoon, raised the wait to 30 seconds, and added a rule that keeps every trace with a settlement span. A 30-second wait holds 3 times as many spans in memory, so I also took the gateway tier from 3 collectors to 5. Joaquin said later that the same-day message counted for more than the fix.

My first cost model was wrong by 35%. I built it in February from their 800 GB a day. That number turned out to be the daily index size on disk in Elasticsearch, after compression. We price on raw bytes in, and the mirror showed 1.2 TB. Logs were about 70% of the modeled cost, so 50% more log volume moved the total from about $645K to $870K. The criteria already had 1.2 TB in them as headroom, and I still priced on the estimate. I sent the corrected model in week 3, before they asked. If their procurement team had found the gap at contract time, the number they'd approved would have been $225K a year too low.

I said yes to an informal sixth request in week 2: the dashboard pack for their finance team. It took about 4 days and had no effect on the decision.

## Who disagreed, and how it was settled

- Nate, on running the POC on real traffic. Settled by the day-5 commitment with a written fallback.
- Halverd's VP of engineering wanted 4 weeks, not 6. Joaquin and I asked for 6 because the alert backtest needed 14 days of their metric data in our system before it could run. He agreed once he saw the timeline.
- Our metrics PM wanted the 5 `absent()` rules described in the readout as "supported with a workaround". I wrote them up as a product gap, with the workaround next to it. Joaquin told me later that slide was why he trusted the rest of the readout.

## After the deal

- Halverd moved onto the platform in phases. Their Elasticsearch cluster was switched off in October 2025, according to their customer success manager.
- 2 other SEs in the region used the converter in POCs later in 2025. I handed it to professional services in August 2025 with tests and a README, and they added recording-rule support.
- Still open: the `absent()` difference. I filed it with the 5 rules as test cases. As of September 2026 it hasn't shipped, and every Prometheus migration still needs those rules rewritten by hand.
- I added 2 checks to the monthly POC review I run: test sampling rules against the prospect's slowest flow before turning them on, and build the cost model from measured volume.

## What I'd defend, and what I'd do differently

I'd defend running on real traffic instead of a demo tenant, and a converter that refuses rather than guesses. Both cost time, and both gave Joaquin's team something they could check for themselves.

I'd measure volume in week 1 and price from that, never from the prospect's estimate. I'd test sampling against the slowest flow before switching it on. And I'd add any new request to the written criteria or decline it: no informal extras during a POC.
