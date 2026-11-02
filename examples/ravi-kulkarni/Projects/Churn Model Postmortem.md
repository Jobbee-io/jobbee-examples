<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Churn model postmortem: the model that never shipped

Halcyon Insurance, 2020, about 11 weeks of work. My policy-renewal churn model scored 0.84 AUC offline and was killed in final review for label leakage, two weeks before its pilot. I wrote the postmortem myself: the mechanism, where I should have caught it, and what I changed.

## What it was for

Halcyon's save team called policies flagged as likely to lapse. The flag was rule-based (payment behavior plus tenure bands) and known to be crude. The model would rank policies by renewal risk so the team's calls went to the highest-risk ones first. Agreed success metric: saved policies at fixed call capacity against the rule-based flag, in a pilot randomized within the flagged population.

## The build

- **Population:** auto policies at renewal, about 900K per cycle.
- **Label:** renewed at the next cycle, with a 45-day grace window after the due date.
- **Features:** payment history, claims history, tenure, product mix, channel, prior save-team contact, and about 120 engineered features from those families.
- **Model:** gradient-boosted trees, evaluated on a temporal holdout: trained through Q2 2019, tested on Q3 and Q4 2019. It scored **0.84 AUC**, against 0.68 for the rule-based flag on the same window.

## Why it died

In final review, a risk-and-compliance reviewer from outside my team asked: "Prior save-team contact is a feature. How does it correlate with your label?" Very highly, and here's why:
- The rule-based flag decided who the save team contacted, so "was contacted" encoded "the old flag thought you'd churn."
- Contact also caused renewals; that was its purpose, and it worked.
- So the label was partly written by the save team's own actions.

The model had largely learned who the save team touches, not who will churn. At best it would have rediscovered the old flag. At worst, as the reviewer said, it would under-target policies never contacted before: exactly where a save call had the most counterfactual value.

## Where I should have caught it

| When | What happened | What I should have done |
|---|---|---|
| Week 2, feature design | "Prior save-team contact" went in as obviously relevant history | Sent it for leakage review. I wrote "may encode treatment" in my notes and moved on. Noting isn't handling. |
| Week 4, exploration | Contact rate was about 4% overall but concentrated among churn labels; I put it down to the flag targeting churners | Separated the feature's predictive power from the intervention. I never ran that analysis. |
| Weeks 5 to 8, iteration | AUC rose every time I enriched contact-related features | Treated that as a leakage smell. I read it as signal. |
| Week 9, offline evaluation | 0.84 vs 0.68; deck built; demoed widely | Included an ablation without the contact features. It was one slide, missing from two weeks of demos. |
| Week 11, final review | The reviewer's question. Model dead in 20 minutes. | — |

A checklist would have found it in week 2, and a standard ablation in week 9. It was found in week 11 by someone whose job was to be suspicious of me.

## What I changed

1. **A written leakage checklist, run on every model before evaluation.** For each feature: is it affected by, or a proxy for, an intervention? Is it available at scoring time with the same meaning as in training? Is it built from data after the outcome, or from a process next to the outcome?
2. **Ablations by feature family in every evaluation.** Any family with an outsized contribution needs a mechanism explanation, not just a SHAP plot.
3. **Treatment-aware methods wherever an operational process shapes the label** (save teams, fraud escalations, manual reviews): an experiment on the intervention, an uplift framing, or explicit de-biasing with stated assumptions.
4. **The reviewer, early.** I formally added that risk-and-compliance reviewer to my model-design reviews from then on.

Since then the checklist has caught two leakage issues at design stage, one at each company; this class of bug is everywhere. I teach it. The price was about 3 months of work with no production value.
