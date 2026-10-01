<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Pricing causal inference — the synthetic control that killed a rate change

Halcyon Insurance, 2021. A VP proposed a rate-structure change in three test states; my synthetic-control analysis showed it would lose roughly $4.1M a year against its projected $2.3M gain, and it was killed. The methods doc became the company standard for state-level policy evaluation. The analysis took six weeks; the politics took most of the rest of the year. Both are the story.

## The proposal

The pricing organization wanted to restructure how a particular coverage add-on was bundled in three mid-size states. The internal model — a demand elasticity estimate from historical price variation — projected **+$2.3M annual gain** from the new structure. The proposal was to pilot it in the three states, read the results, and roll out.

The flaw was visible before any analysis: a "pilot then read the results" plan with no experimental design. States aren't users — you can't randomize, you can't hold out, and one state's experience is one observation wearing a costume. Left alone, this would have produced an uninterpretable pilot: whatever happened, attribution would be a fight, and the fight would be settled by seniority.

## Why synthetic control, and what it does

You can't A/B a state, but you can build a **synthetic comparison**: a weighted combination of untreated states that tracks the treated state's outcome trajectory closely before the intervention, then serves as the counterfactual after. The method is standard in policy evaluation; the craft is in the fit quality and the honesty about what it can't tell you.

My design:

- **Outcome:** new-policy conversion rate for the affected coverage bundle, monthly, 48 months of pre-period.
- **Donor pool:** the 31 untreated states, filtered for comparable regulatory regime and product mix (a few states with unique regulation excluded and documented — the exclusion list is part of the deliverable, or the analysis is theater).
- **Fit diagnostics reported, not buried:** pre-period RMSPE, weights disclosed, and placebo testing — run the same method on untreated states pretending each was treated, to show how often random noise produces an effect this size.
- **The sentence that was in every version of the doc:** *"This estimate assumes the synthetic counterfactual would have continued to track the treated state absent the change; it breaks if a state-specific shock coincides with the intervention."*

## The result

Across all three treated states, the synthetic controls tracked pre-period outcomes closely (RMSPE small enough that I'd defend it in review, numbers in the appendix of the original doc). Post-period simulation of the proposed structure — using the company's own elasticity model to project the counterfactual-under-treatment, then comparing against synthetic baselines — showed the structure underperforming baseline by a projected **$4.1M/year net**, driven by a composition effect the elasticity model missed: the new bundle structure shifted customers toward the lower-margin configuration of the add-on, and the volume gain was real but the mix was not.

To be precise about the epistemics: this is a *model-of-a-model* estimate. The elasticity model's $2.3M projection and my $4.1M loss projection share assumptions about demand. What my analysis added was the composition effect — verifiable in historical data with a straightforward decomposition — and the counterfactual discipline. The decomposition is what survived scrutiny; the headline numbers were the headline because committees need one.

## The politics

- **The first review meeting was a draw.** The VP's team challenged the donor pool; I produced the exclusion rationale; they challenged the elasticity model's role in my projection; I agreed with half of that challenge and re-ran the projection using their model's assumptions throughout — the loss shrank but did not change sign. Re-running *with their assumptions* was the single most effective move in the whole affair. It converted the debate from "your model vs. ours" to "does the sign survive the most favorable assumptions" — and it didn't.
- **The second review meeting was the kill.** The VP of pricing (the proposer's boss, to his credit) asked one question: "If we pilot anyway, could we read the result?" My answer was honest: not cleanly — with three treated states and confounded timing, we'd learn almost nothing interpretable in the pilot window, which meant the pilot was a rollout with extra steps. The proposal was killed in that meeting.
- **The relationship note.** The proposing VP and I worked together for another year, comfortably. What made that possible: I never framed the analysis as "your model is wrong," only "here's the component it misses, and here's the sign under your own assumptions." Also, genuinely, I had done the elasticity model team the respect of a technical review of *their* document rather than a rhetorical demolition. The result was theirs to hear; the method was offered as reusable, and it was.

## The standard it became

The methods doc — design, diagnostics, placebo testing, the "this breaks if" sentence, and the assumptions-favorable-to-the-proposal re-run — was adopted as the template for state-level policy evaluation: rate changes, claims-process changes, marketing-region changes. Over the following year it was used four times; it killed two proposals and validated two, which is the correct batting average for a good method — you're not doing your job if everything it touches survives.

## Transfer lessons

- When you can't randomize, the counterfactual is the entire game; spend your budget on its quality and its honesty, not on sophistication for its own sake.
- Re-run the analysis under the *proposer's* assumptions before the meeting. If your conclusion survives, the meeting is short.
- Every causal deliverable ships with its identifying assumption attached. The day you omit the "this breaks if" sentence is the day someone treats your number as the truth instead of an estimate.
