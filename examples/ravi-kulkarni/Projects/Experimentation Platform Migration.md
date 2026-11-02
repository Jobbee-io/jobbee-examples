<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Experimentation platform migration: from ad-hoc A/B to a platform

Brightlane Commerce, August 2022 to December 2024, with the follow-up audit in January 2025. I was hired as the first experimentation-focused data scientist. The company had about 30 product teams and ran A/B tests the way most companies do before they have a platform: heroically, inconsistently, and around a shrine to one famous early win. On my resume this is two bullets: building the practice, and the guardrail-metric system. This file holds the audit, the options and why I rejected most of them, how the pieces work, the timeline, who pushed back, what broke, each number's definition, and what is still unsolved.

## The starting audit

In my first five months I inventoried every experiment the company had run in the previous two years, August 2020 to July 2022. There were 61 "A/B tests":
- 17 had no controlled variant: the "test" was a launch with a dashboard.
- 11 peeked daily and shipped on any p-value under 0.05, uncorrected.
- 9 picked their primary metric after the fact. One "video-player change lifted conversion"; cart size fell, and nobody had looked.
- 19 were underpowered or never analyzed; no readout existed.
- 5 were sound. One person on one team had read about experiment design, and it showed. That was individual knowledge, not company practice.

In February 2023 I sent the memo to the CPO and the six product directors. It didn't say "you're doing it wrong." It said: "Here are 61 experiments' worth of money spent. Here's what we can trust. It's 5."

## The options

I was one person, not a platform team. That shaped everything.

**Option 1: buy a full experimentation platform.** The best vendor quote was about $210K a year plus two quarters of integration. I rejected it. The audit showed practice failures: no control group, peeking, metrics chosen afterwards. A tool doesn't fix those by itself. And a vendor tool would have computed metrics from its own event stream, separate from the dbt metric definitions that finance and product already trusted. I wrote down when I'd revisit: more than 150 experiments a year, or a funded platform team.

**Option 2: our feature-flag vendor's experimentation add-on,** about $60K a year. Rejected. Its stats engine used fixed-horizon t-tests with no sample-ratio check, and it also computed metrics from its own events. We'd have had two versions of "conversion" in the same meeting.

**Option 3: build thin, in-house.** A wrapper on the flag SDK for logging, dbt models in BigQuery, a small Python analysis library, and written standards. That's what I chose. The cost was my time, about six weeks of one data engineer, and three weeks of one backend engineer for the SDK wrapper.

## What I built

Standards first, then scaffolding, then a service.

**1. The experiment lifecycle as a one-page contract.** Every experiment declares, before launch:
- a hypothesis;
- one primary metric and up to five secondary metrics;
- guardrails (below);
- the minimum detectable effect and a power calculation (80% power, two-sided alpha of 0.05);
- a duration in whole weeks, at least 14 days;
- launch and kill criteria;
- a named analyst of record.

At first enforcement was social: no review without the page. From October 2023 it was structural: the experiment tracker wouldn't accept an experiment without the fields.

**2. The wrapper and the data model.**
- The flag service still decides the variant, from a hash of the unit ID and an experiment salt.
- The wrapper logs an assignment event: experiment ID, variant, unit type (user, request or seller), unit ID, timestamp, flag version, platform.
- From June 2023 it also logs a separate exposure event when the changed surface actually renders (see "What broke").
- dbt models build assignment and exposure tables, plus one row per unit per experiment, joined to the same metric definitions finance uses, with 28 days of pre-period data for variance reduction.

**3. The analysis library.** Each experiment gets the same checks and the same readout:
- a sample-ratio-mismatch check, a chi-square test that alerts at p < 0.001;
- CUPED variance reduction, using the 28-day pre-period value of the same metric. On Brightlane's buyer metrics it cut variance by about 22% on average. I had built the same layer at Halcyon, where it was 31% on renewal metrics.
- the delta method for ratio metrics;
- sequential tests for the teams that opted in.

A daily health job checks sample ratio, units that appear in both variants, and the exposure-to-assignment ratio.

**4. Guardrail metrics, the design that mattered most.** Every experiment declares the metrics it may not hurt, with thresholds.
- Universal guardrails on everything: p75 page latency (no worse than +5% relative), client error rate (+0.2 percentage points), unsubscribe and opt-out rate (+10% relative), and support tickets per 1,000 active users (+15% relative, after the calibration below).
- Surface guardrails: checkout watches payment-failure rate and refund requests; search watches zero-result rate; seller-facing changes watch seller complaints.

The argument was over what triggers a stop. "Statistically significant harm" comes too late; by then you've hurt people. We chose a decision threshold: if a guardrail breaches its declared threshold at the interim review, the experiment stops, however good the primary metric looks. Interim review is at half the planned duration. A breach means the point estimate is past the threshold and the 80% confidence interval excludes zero harm.

**5. Sequential testing.** The search-ranking and seller-tools teams ran long marketplace experiments and checked results daily. In Q1 2024 they moved to mixture sequential tests with always-valid confidence intervals. People will peek, so give them a peek that doesn't invalidate the test. The cost: the intervals are wider, so they need roughly 20% to 30% more sample for the same power. Both teams accepted that in exchange for daily looks.

## The timeline

- **August 2022:** joined.
- **September 2022 to January 2023:** the audit.
- **February 2023:** the audit memo.
- **March 2023:** the lifecycle template, and my offer of analysis as a service.
- **April to June 2023:** the wrapper and dbt models built. Exposure logging added in June.
- **July 2023:** the CPO and CTO signed the guardrail policy in the product leadership meeting.
- **August 2023:** the first guardrail stop, on latency.
- **September 2023:** threshold rules recalibrated after A/A tests.
- **October 2023:** tracker fields made mandatory.
- **November 2023:** the seller-notification dispute.
- **January 2024:** first re-audit, of 2023 launches.
- **Q1 2024:** sequential testing for two teams.
- **Q2 2024:** I became the bottleneck.
- **January 2025:** second re-audit, of 2024 launches.

## Who pushed back, and how it was settled

- **The famous win.** The company's origin story included one legendary early A/B test. I never attacked it. I cited it as what experiments can do, then asked for the same rigor everywhere. You fight the practice, not the folklore.
- **Two senior PMs called pre-registration bureaucracy.** I offered both a deal: pre-register, and I'll personally deliver the analysis within 48 hours of the experiment ending. Both took it. Within two quarters both were pre-registration's loudest advocates, because the speed was real and pre-registered reads are faster to do.
- **The director who wanted to ship anyway.** In November 2023 a seller-notification change sent "new request near you" alerts more often. Seller response rate, the primary metric, was up 3.1%. Seller complaints went from 0.4 to 1.2 per 1,000 notified sellers, three times the baseline, against a threshold of +25%. The director of seller growth asked to "note the concern and ship." Under the policy I took it to the CPO, who upheld the stop. The policy held only because leadership had signed it while it was still abstract. When it was signed, I made sure the meeting included the sentence "this applies to everyone." It was awkward then and load-bearing later. The change was dropped.

## What broke, and the exact fixes

- **Diluted effects (spring 2023).** The first version logged a unit at assignment, when the flag was evaluated. Many users were assigned but never saw the changed surface: a checkout change counted every visitor, not every checkout. Real effects were diluted toward zero. The fix: a separate exposure event, and analysis on exposed units, with assignment kept for the sample-ratio check.
- **False stops on a noisy guardrail (summer 2023).** Support tickets per 1,000 users is a noisy, lumpy metric. In Q3 2023 I ran 24 A/A tests, where both arms got the same experience. The ticket guardrail "breached" its original +10% threshold in 7 of the 24 by noise alone, so it would have killed good experiments. In September 2023 I changed the rule for every guardrail to require the 80% interval to exclude zero as well as the point estimate passing the threshold, and raised the ticket threshold to +15%. False breaches across the A/A set dropped to 1 in 24.
- **Bot traffic and sample ratio (2023).** Several experiments failed the sample-ratio check because bot filtering ran after assignment, and one variant's page attracted more crawler traffic. Filtering now runs before assignment logging, the same way for both arms.
- **Me, as the bottleneck (Q2 2024).** The 48-hour promise didn't scale. At one point I had 9 readouts in flight, and median time to decision rose to 6 days. The fix: a standard readout notebook anyone could run, and two junior data scientists I mentored, trained as analysts of record. Median time to decision was back to 3 days by Q4 2024.

## The numbers, and their definitions

- **Decision-grade experiment:** pre-registered, passes the sample-ratio check, ran its planned duration, analyzed to the template. Company-wide there were 31 in 2023 and 58 in 2024. The "~40" on my resume counts the experiments where I was analyst of record, from 2023 to mid-2025.
- **Kill rate:** experiments that ended without shipping. About half in both years (29 of 58 in 2024). That's the honest output of a portfolio, not a failure rate.
- **Median time to decision:** from the scheduled end date to the decision recorded in the tracker. 3 days in 2024. Before the system there was no record. Where I could reconstruct it from the audit, the median was about 19 days.
- **Traceable launches:** a shipped launch whose ticket links a decision-grade experiment whose readout supported shipping. The denominator is launches eligible for an experiment: user-facing changes with enough traffic to test, excluding infrastructure and legally required changes. 2023 launches: 52%. 2024 launches: 84% of 97 eligible.
- **Guardrail outcomes:** two harmful launches stopped at interim review. One was the latency stop: a homepage module that lifted engagement but added 11% to p75 latency. The other was the seller-notification change. A third launch was reworked and relaunched: a one-page checkout that raised payment failures by 0.3 points because of a card-verification bug on one card network. It was fixed and relaunched clean.

## Second-order effects

- The guardrail list became a design-review artifact. Teams now discuss what they mustn't hurt before they build, not after.
- My six-session seminar, "causal inference for product people," gave PMs the vocabulary to ask for these things themselves. Attendance was voluntary.
- The system made later work credible. The 2023 matching-weights change shipped as a pre-registered experiment with a guardrail on new sellers (`Projects/Marketplace Matching Analysis.md`).

## What isn't solved

- **Marketplace interference.** Most teams still randomize by user or request. In a two-sided marketplace, both arms share the same sellers, so a ranking change in one arm can change what sellers do in the other. In 2024 I ran one cluster-randomized test by metro: 12 metros over 6 weeks. Most teams find that too slow. Today I flag interference risk in the readout rather than remove it.
- **Long-term effects.** There's no persistent holdout. In 2024 I proposed a 5% holdout, refreshed quarterly, to measure the combined effect of everything we ship. Product leadership declined, because holding features back from 5% of users has a cost. It's still open, and I still think it's the most important missing piece.
- **Metric definitions drift.** A change to a dbt metric definition in the middle of an experiment silently changes the readout. In Q4 2024 I added version pinning for experiment metrics, but backfills are still manual and painful.

## What I'd do differently

- Log exposure from day one; the dilution cost us three months of understated results.
- Run the A/A calibration before leadership signed the guardrail policy, not after. The thresholds were right in principle and wrong in detail for two months.
- Hand over analyst-of-record duty earlier. Building a service that depends on one person was the right way to win trust and the wrong way to scale.
