<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Marketplace matching analysis — the analysis that changed the weights

Brightlane Commerce, 2023. An observational analysis of buyer–seller matching that ended with the matching weights changed and a measured **+6.2% in seller response rate to first contact** — confirmed by the A/B test that followed. This file is the full arc: why an observational analysis earned a product change, what the analysis actually said, and the discipline that made it believable.

## The surface

Brightlane's marketplace connected buyers posting requests with sellers who could fulfill them. First contact mattered disproportionately: seller response rate to a buyer's first message was the liquidity metric the whole marketplace ran on (response within 24h → conversation → transaction). The matching engine scored potential seller candidates for each request with a weighted blend of: category expertise, historical response rate, price-band fit, geographic proximity, seller availability, and seller tenure.

The weights had been set by the founding team, tuned once in 2021 by intuition and grid search, and never revisited. The matching PM had a hypothesis list three pages long. Nobody had evidence for any of it.

## Why observational first, experiment second

A full factorial experiment over six weights was infeasible: too many arms, thin traffic per arm, quarters of runtime. The right sequence was: **observational analysis to generate a small, sharp hypothesis; then an A/B to confirm.** The observational part could only *propose* — the credibility of everything downstream depended on the team treating it that way.

## What the data said

Dataset: 14 months of request–seller exposures (~9.4M exposure pairs), with match scores decomposed by weight-component, seller actions (respond/no-respond), and downstream outcomes. Analysis in BigQuery + Python; every transformation in dbt models so the pipeline was auditable.

Three findings survived the obvious confounding critiques:

1. **Tenure was overweighted.** Seller tenure carried the second-largest weight and contributed almost nothing to response probability once historical response rate was properly conditioned on. Newer sellers with fast histories were being buried. The mechanism was intuitive once seen: tenure was a stand-in for reliability, but the data already *had* direct reliability (recent response rate) — tenure was double-counting a proxy.
2. **Price-band fit was non-linear where we modeled it linear.** Distance-from-band-midpoint predicted response drop-off that flattened at the extremes: being slightly outside the band cost little; being far outside cost a lot and *also* correlated with no-response quality (responses that went nowhere). The linear term was mispricing the tails in both directions.
3. **Availability was underexploited at the margin.** Sellers with calendar-blocked unavailability still received matches at near-full rate. These exposures were dead on arrival — measurable as near-zero response probability — and each one was a wasted exposure slot that a live seller could have had.

## The confounding problem, handled in the open

The obvious critique: sellers who respond quickly are different in ways that cause *both* their response rate and their selection. My handling, stated in the analysis doc itself:

- The analysis estimated response probability **conditional on selection** — it asked "given exposure, who responds," which is the causal question the weight change could act on. It did not claim the matching engine caused response rates.
- Sensitivity analysis for unmeasured confounding: how strong would an unobserved seller-quality factor have to be to explain away the tenure finding? (The required strength was implausible; the number is in the doc.)
- The doc's conclusion section explicitly said: *"This is a hypothesis-generating analysis. The weights change ships as an experiment or not at all."* That sentence is why the PM trusted the analysis enough to spend experiment budget on it.

## The change and the experiment

New weights: tenure weight reduced ~70%, its mass redistributed to recent response rate; price-band term replaced with a piecewise distance function; hard availability filter added (with an exemption workflow, because calendars lie).

A/B: 50/50 request-side split, four weeks, ~2.1M requests in treatment. Pre-registered primary metric: **seller response rate to first contact within 24h.** Guardrails (per the experimentation standard I'd built — see `Projects/Experimentation Platform Migration.md`): buyer request-resolution rate, seller complaint volume, new-seller first-transaction rate (we were demoting tenure; we needed to watch that we weren't *starving* new sellers of their early exposures).

Result: primary metric **+6.2%** (95% CI roughly +4.8% to +7.6%), all guardrails clean. The new-seller guardrail showed a small, non-significant dip in early exposures for brand-new sellers that we monitored for another cycle and it washed out — because the recent-response-rate term is something a new seller can *earn quickly*, unlike tenure, which they could only wait out.

Downstream, two quarters later: request-resolution rate up ~3%, and seller-side NPS comments mentioning "relevant requests" up visibly in the verbatims (I counted; the counting was informal, the other numbers aren't).

## Transfer lessons

- Observational analysis earns a product change only by wearing its limits visibly: conditional framing, sensitivity analysis, and the sentence "this ships as an experiment or not at all."
- Proxy features (tenure for reliability) double-count when the direct signal (recent response rate) already exists in the system. Audit weights for proxy-overload — it's usually years of accretion, not anyone's decision.
- Guardrail the *distributional* consequence of ranking changes, not just the aggregate: a weights change moves exposures between seller segments, and the segment that loses exposures can't file a ticket. Decide in advance that you'll watch for them.
