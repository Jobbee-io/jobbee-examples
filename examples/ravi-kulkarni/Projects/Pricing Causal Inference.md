<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Pricing causal inference: the synthetic control that killed a rate change

Halcyon Insurance, March to November 2021. A VP proposed a rate-structure change for a coverage add-on, to be piloted in three test states and then rolled out. The pricing elasticity model his team relied on projected a gain of $2.3M a year. My analysis projected a loss of about $4.1M a year, and the proposal was killed. The methods doc became the company's standard for state-level policy evaluation. On my resume this is one bullet. The analysis took six weeks; the politics took most of the rest of the year. This file holds both: why synthetic control, how it was set up, the numbers and their limits, what went wrong in my own work, and who disagreed.

## The proposal, and the history behind it

The add-on covered roadside assistance and rental reimbursement. Until mid-2019 it came in one tier at one price everywhere. In July 2019, a month after I joined and before I had anything to do with it, pricing added a cheaper basic tier in three mid-size states. I'll call them A, B and C.

In February 2021 the VP of product for personal auto proposed phase 2 for those same three states: cut the basic tier's rate by 18%, and make it the default option in the quote flow. The plan was to file the rates in Q2, pilot from July 2021, read the results after six months, and roll out to all 34 states Halcyon wrote in. The elasticity model projected +$2.3M a year at full rollout, mostly from more customers buying the add-on.

The plan had a flaw before any analysis. "Pilot, then read the results," with no evaluation design, is a fight waiting to happen. With three states and no randomization, any result can be argued either way, and the argument gets settled by seniority.

In early March the chief actuary asked my manager for an independent evaluation, and it came to me.

## The options, and why synthetic control

The key realization was that phase 1 was already a natural experiment. The question was how customers respond to a cheaper tier. Phase 1 had put a cheaper tier into A, B and C twenty months earlier. That was the best evidence we had, so I set out to measure phase 1 properly.

- **Randomize at the quote.** Not possible for price. Insurance rates are filed with each state's regulator and must be applied consistently. Quoting two different rates to similar risks as a test would be unfair discrimination. That removes the usual tool.
- **Before and after in A, B and C.** Rejected: it attributes everything else that changed over 20 months to the tier.
- **Difference-in-differences against the other 31 states.** Rejected. It assumes parallel trends, and the pre-period showed they didn't hold. From 2016 to 2019, add-on attach rates in A, B and C rose 0.4 points a year faster than in the other states (p = 0.01).
- **Synthetic control.** Chosen. For each treated state, it builds a weighted combination of untreated states that tracks the treated state's pre-period path closely. That combination becomes the counterfactual after the change. It doesn't need parallel trends, only a good pre-period fit, which you can check and report.

## The design

- **Units:** 34 states. 3 treated, 31 untreated. I excluded 5 untreated states, with reasons written into the doc: 2 changed the same add-on during the window, 2 had rate-approval regimes that delayed filings by more than a year, and 1 had a major channel change when Halcyon closed its agency network there. That left 26 donors. The exclusion list is part of the deliverable; without it the analysis is theater.
- **Pre-period:** July 2015 to June 2019, 48 months.
- **Post-period:** July 2019 to February 2020, 8 months. I stopped before March 2020 on purpose. States responded to the pandemic differently, and a state-specific shock that lines up with the treatment is exactly what breaks synthetic control. I showed the run through December 2020 separately, as a robustness check, flagged.
- **Outcomes, monthly, on new policies in each state:** total add-on attach rate (any tier), full-tier attach rate, and add-on margin per new policy. In the donor states the only tier was full, so their attach rate is a full-tier attach rate. That's what made the switching estimate possible.
- **Predictors:** lagged outcomes, new-policy volume, and channel mix (the share of new policies sold through agents).
- **Inference:** in-space placebos (run the same method on each donor as if it had been treated, and rank the treated state's post-to-pre error ratio among them); an in-time placebo (pretend the change happened in July 2018); and leave-one-out runs (drop each donor with positive weight in turn).
- **The sentence in every version of the doc:** "This estimate assumes the synthetic counterfactual would have kept tracking the treated state without the change. It breaks if a state-specific shock coincides with the change."

## What phase 1 showed

The fits were good once I fixed state C (see below). Pre-period RMSPE was 2.1%, 2.6% and 3.4% of the mean for A, B and C. Each synthetic state drew on 4 to 6 donors, and no donor had a weight above 0.45.

Averaged across the three states over the 8 post months:
- **Total attach rate:** 26.8%, against 22.5% for the synthetic. That's +4.3 points. The elasticity model had predicted +4.6. The volume story was right.
- **Full-tier attach rate:** 19.4%, against 22.5% for the synthetic. That's −3.1 points.
- **Basic-tier attach rate:** 7.4%.
- **Switching:** 3.1 points of full-tier loss out of 7.4 points of basic-tier sales. So about 42% of basic-tier buyers would have bought the full tier without the change. The elasticity model assumed 15%.
- **Margin per new policy on the add-on:** down about 4% against the synthetic. Volume was up almost a fifth, and margin still fell, because the basic tier earns about 30% of the full tier's margin.

The inference held up:
- **In-space placebos:** A and B ranked 1st of 27 on the full-tier outcome, and C ranked 2nd. That's permutation p-values of about 0.04, 0.04 and 0.07.
- **In-time placebo:** the fake July 2018 change showed nothing; every estimate was within 0.4 points.
- **Leave-one-out:** the switching estimate stayed between 38% and 47%.
- **Range:** the per-state estimates were 36%, 41% and 51%. Across all the runs, the plausible range for switching was 29% to 55%. I called it a range, not a confidence interval, because synthetic control with three treated units doesn't give you a clean interval.

## From phase 1 to a projection for phase 2

This step is a model of a model, and I said so in the doc. Phase 2 was never run, so its effect can only be projected.

The projection took the elasticity team's own volume response to the 18% cut and finance's margin tables. It replaced only one assumption: the 15% switching rate, which their model had never been able to measure, became the 42% phase 1 showed. I used phase 1's rate even though making basic the default would probably push switching higher. That made my estimate lean in the proposal's favor.

- With 15% switching, the projection reproduces their +$2.3M a year.
- With 42% switching, it's about −$4.1M a year at full rollout.
- Break-even is about 25% switching, below the bottom of phase 1's range.

The mechanism was a composition effect. Volume rose, but the mix shifted toward the low-margin tier, and the old model priced the volume and ignored the mix. That decomposition is the part that survived scrutiny. The headline numbers were headlines because committees need one.

## What went wrong in my own work

- **State C's first fit was poor.** RMSPE was 6.8% of the mean, because C had shifted sales toward agents in 2017 and none of my predictors captured it. I added channel mix as a predictor and dropped two donors with no agency channel. RMSPE fell to 3.4%.
- **I first reported one pooled estimate.** That hid how much noisier C was than A and B. A reviewer asked for per-state results, and per-state became the standard in the doc.
- **I used my own elasticity estimates in the first draft,** fitted on three states and eight months. That was a weak foundation next to a model built on six years of rate changes across all states. The draft said −$4.9M.
- **I sent the draft to the committee chair before the proposing team had seen it.** They learned the conclusion in the meeting. That, more than the method, is why the first review was a draw. Since then, the team whose proposal I'm evaluating sees my draft a week before anyone else does.

## The politics

- **First review, May 2021: a draw.** The VP's team challenged the donor pool, and I walked through the exclusion reasons. They challenged my elasticities, and I agreed with them. I re-ran everything with their elasticities and finance's margins; that is when the central estimate moved from −$4.9M to −$4.1M. Then I ran the most favorable case I could defend: their elasticities, and switching at the bottom of my range, 29%. It still lost about $1.0M a year. Re-running on their assumptions was the most effective thing I did. It changed the debate from "your model against ours" to "does the sign survive the most favorable assumptions." It did.
- **Second review, June 2021: the kill.** The SVP who chaired the pricing committee, the proposer's boss, asked one question: "If we pilot anyway, could we read the result?" My honest answer was not cleanly. Phase 1 was already in those states, so the pilot would be a change on top of a change. The filings would be approved on different dates; A's regulator had taken 5 weeks for phase 1 and C's 4 months, so there would be no common start. And with three units, any read would be another synthetic control with a messier pre-period. The pilot would have been a rollout with extra steps. The proposal was killed in that meeting.
- **September 2021: a revised proposal.** An 8% cut, with no change to the default. I ran it through the same method in two weeks. The projection ranged from −$0.6M to +$0.4M a year: not worth the filing costs. The VP withdrew it himself.
- **The relationship.** The proposing VP and I worked together for another year without strain. I never framed the analysis as "your model is wrong," only as "here's the piece it can't see, and here's the sign under your own assumptions." I also gave the elasticity team a real technical review of their document, not a rhetorical demolition.

## The standard it became

In November 2021 the pricing committee adopted the methods doc as the template for state-level policy evaluation. It covers the design, the donor-pool exclusions with reasons, fit diagnostics, placebo tests, the "this breaks if" sentence, and a required re-run under the proposer's assumptions. Between the kill and my leaving in July 2022 it was used four more times, on rate changes, a claims-process change and a marketing-region change. It killed two proposals and validated two. If everything a method touches survives, it isn't doing its job.

## Second-order effects, and what was left open

- In Q4 2021 the elasticity team added a tier-switching term to their model, estimated from phase-1 data. That was the most useful outcome of the whole affair.
- Phase 1 stayed in place. Removing a tier needs its own filing and disrupts customers who chose it. The 2022 filings raised the basic tier's rate by 6% in A, B and C instead. I left before that could be read.
- The −$4.1M was never observed and never can be, because the change never happened. It is a projection that rests on a measured switching rate, and I've never presented it as anything else.
- One part of phase 2 could have been randomized: the default option in the quote flow is a design choice, not a rate. I proposed a quote-flow test of the default on the existing prices. It hadn't run when I left. It's the experiment I'd most like to have seen.

## What I'd do differently

- Share the draft with the proposing team first. I lost a month to a meeting that was about surprise, not substance.
- Start from the other team's elasticities, not mine. Using their strongest assumptions from the start would have reached the same conclusion faster.
- Report per-state results from the first draft.
