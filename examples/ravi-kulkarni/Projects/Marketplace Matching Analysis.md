<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Marketplace matching analysis: the analysis that changed the weights

Brightlane Commerce, March to September 2023. An observational analysis of buyer-seller matching led to new matching weights, and the A/B test that followed measured **+6.2% in seller response rate to first contact**. On my resume it's one bullet. This file holds why an observational analysis earned a product change, what it found, how I handled confounding, and the test that confirmed it.

## The full story

When I started this in March 2023, Brightlane's matching weights had not been revisited since 2021. The matching PM had a three-page list of hypotheses and no evidence for any of them. A test of all six weights at once would have taken quarters, so I proposed an observational analysis first, to turn the list into one sharp hypothesis a single A/B test could confirm or kill.

The analysis and the doc were mine. I worked through 14 months of request-seller exposures, about 9.4M pairs. Three findings held up: tenure was overweighted, price-band fit was non-linear, and unavailable sellers were still being matched. The obvious objection was confounding. I answered it in the doc itself, with conditional framing, a sensitivity analysis, and the line that the change would ship as an experiment or not at all. That line is what got the PM to spend experiment budget. The PM owned the decision to change the weights, and an ML engineer built the new scoring.

The test ran four weeks in August 2023, pre-registered under the standard I was building at the same time. Seller response rate to first contact rose 6.2%, and every guardrail held. The one scare was new sellers: because we were demoting tenure, a dip in their early exposures mattered. We watched it for another cycle, and it washed out. The new weights rolled out in September.

The weak spot was my own design. I split the test by request, so both arms shared the same sellers, and the lift may be somewhat overstated. I said so in the readout instead of claiming a clean number. Request resolution was up about 3% two quarters later, which suggests most of the lift was real. The shared-seller problem itself is still open, for this change and for most of Brightlane's tests.

## The surface

Brightlane's marketplace connects buyers who post requests with sellers who can fulfill them. The first contact matters most. Seller response rate to a buyer's first message, within 24 hours, was the liquidity metric the marketplace ran on: a response leads to a conversation, which leads to a transaction.

For each request, the matching engine scored candidate sellers with a weighted blend of six signals: category expertise, historical response rate, price-band fit, distance, availability and tenure. The weights were set when the marketplace launched in 2020, tuned once in 2021 by intuition and grid search, and never revisited. The matching PM had a three-page list of hypotheses and no evidence for any of them.

## My role

I designed and ran the analysis, wrote the doc, designed the confirming experiment and analyzed it. The matching PM owned the decision to change the weights. An ML engineer implemented the new scoring.

## Why observational first

A factorial experiment over six weights wasn't feasible: too many arms, too little traffic per arm, and quarters of runtime. The right order was an observational analysis to produce a small, sharp hypothesis, then an A/B test to confirm it. The observational part could only propose. Everything that followed depended on the team treating it that way.

## What the data said

The dataset was 14 months of request-seller exposures, about 9.4M pairs. Each had its match score broken down by weight component, what the seller did (responded or not), and what happened next. I did the analysis in BigQuery and Python, with every transformation in dbt so the pipeline could be audited.

Three findings survived the obvious confounding critiques:

1. **Tenure was overweighted.** It carried the second-largest weight but added almost nothing to response probability once recent response rate was conditioned on properly. Tenure was standing in for reliability, but the system already had a direct reliability signal. It was double-counting a proxy, and newer sellers with fast response histories were being buried.
2. **Price-band fit was non-linear where we modeled it as linear.** Being slightly outside a buyer's band cost little; being far outside cost a lot, and the responses that did come in went nowhere. The linear term mispriced both tails.
3. **Availability was barely used.** Sellers who had blocked out their calendars still got matched at nearly the full rate. Their response probability was close to zero, and each of those matches took a slot a live seller could have had.

## The confounding problem, handled in the open

The obvious critique: sellers who respond quickly differ in ways that drive both their response rate and how often they're selected. I handled it in the doc itself:

- The analysis estimated response probability conditional on exposure. It asked, "given that a seller was shown, who responds?" That is the question a weight change can act on. It did not claim the engine caused response rates.
- A sensitivity analysis asked how strong an unmeasured seller-quality factor would have to be to explain away the tenure finding. It would have needed to be implausibly strong; the number is in the doc.
- The conclusion said: "This is a hypothesis-generating analysis. The weight change ships as an experiment or not at all." That sentence is why the PM trusted it enough to spend experiment budget on it.

## The change and the experiment

The new weights:
- tenure's weight cut by about 70%, with that weight moved to recent response rate;
- a piecewise distance function for price-band fit;
- a hard availability filter, with an exemption path, because calendars lie.

The test ran for four weeks in August 2023: a 50/50 split by request, with about 2.1M requests in treatment. It was pre-registered under the experimentation standard I'd built (`Projects/Experimentation Platform Migration.md`). The primary metric was seller response rate to first contact within 24 hours. Guardrails: buyer request-resolution rate, seller complaint volume, and new-seller first-transaction rate. Since we were demoting tenure, we had to check we weren't starving new sellers of early exposure.

Results:
- **Primary metric: +6.2%**, with a 95% interval of roughly +4.8% to +7.6%.
- **All guardrails clean.** Brand-new sellers showed a small, non-significant dip in early exposures. We watched it for another cycle and it washed out. Recent response rate is something a new seller can earn quickly; tenure is something they could only wait out.
- **Rollout:** September 2023.

Two quarters later, request-resolution rate was up about 3%. Seller comments mentioning "relevant requests" also rose. I counted those informally; the other numbers aren't informal.

One limit I put in the readout: the split was by request, so both arms shared the same sellers. Treatment sent more requests to the most responsive sellers, and their time is finite, so they may have answered control requests a little more slowly. That would overstate the lift. I flagged it rather than claiming a clean estimate. The check was the full rollout: if the lift had been mostly borrowed from control, request resolution wouldn't have risen afterwards.

## What I took from it

- An observational analysis earns a product change only by showing its limits: conditional framing, a sensitivity analysis, and "ships as an experiment or not at all."
- Proxy features double-count when the direct signal already exists. Weights pile up proxies over years without anyone deciding to.
- When a ranking change moves exposure between seller groups, guard the group that loses. They can't file a ticket.
