<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Churn model postmortem — the model that never shipped

Halcyon Insurance, 2020. I built a policy-renewal churn model that scored 0.84 AUC offline and never shipped — caught in final review with label leakage, two weeks before its scheduled pilot. I wrote the postmortem myself. This file is that postmortem's argument: the failure was real, the review process worked, and the timeline shows exactly where I should have caught it myself.

## What the model was for

Halcyon's retention strategy included a save-team that contacted policies flagged as likely-to-lapse. The flagging was rule-based (payment behavior + tenure bands), crude, and known to be imprecise. The proposal: a supervised churn model to rank policies by renewal risk, so the save team's finite call capacity went to the highest-risk policies first. Success metric agreed up front: at fixed call capacity, saved-policy count vs. the rule-based baseline, measured in a pilot with randomized assignment *within* the flagged population.

## The build

- Population: auto policies at renewal, ~900K policies per cycle.
- Label: did the policy renew at the next cycle (with a 45-day post-due grace window).
- Features: payment history, claims history, tenure, product mix, channel of record, prior save-team contact, and ~120 engineered features from those families.
- Model: gradient-boosted trees. Offline evaluation on a temporal holdout (trained through 2019-Q2, evaluated on 2019-Q3+Q4 — I did at least get the temporal discipline right): **0.84 AUC**, well above the rule-based flag's 0.68 on the same window. The team was excited. I was excited.

## Where it died

Final review, two weeks before the pilot, a risk-and-compliance reviewer (not on my team, which mattered) asked the question that ended it: *"Prior save-team contact is a feature. What's the correlation between save-team contact and your label?"*

High. Very high. Here's the mechanism:

- The rule-based flag decided who got save-team contact. So "was contacted" encoded "the crude model thought you'd churn."
- But save-team contact *caused* renewals — that was its entire purpose, and it worked reasonably well.
- So the label ("renewed") was partially *written by* the save team's own actions, and the feature "prior contact" was a proxy for both the old flag and the intervention that shaped the outcome.

The model had learned, in large part, **"who the save team touches"** rather than **"who will churn."** The 0.84 AUC was real; it was just measuring the wrong thing. In production, at best it would have rediscovered the rule-based flag at higher resolution; at worst — and this was the reviewer's sharper point — ranking by it would systematically under-target policies that *hadn't* been contacted before, starving exactly the population where a save attempt had the most counterfactual value.

## The timeline, honestly scored

This is the part of the postmortem that matters — not the mechanism, the *when I could have caught it*:

| When | What happened | What I should have done |
|---|---|---|
| Feature design (week 2) | "Prior save-team contact" entered the feature set as obviously-relevant history | Flagged it for leakage review *then*. I noted it as "may encode treatment" in my own notes and moved on. Noting is not handling. |
| EDA (week 4) | Contact-rate ~4% overall, but among "churned" labels, prior contact was disproportionately common in ways I attributed to "rule flag targets churners" | The correct read was available: the feature's predictive power *couldn't* be separated from the intervention without an experiment or a de-trending analysis. I never ran the separation analysis. |
| Model iteration (weeks 5–8) | AUC improved each time contact-related features were enriched | Improvement that concentrates in treatment-adjacent features is a leakage smell. I read the AUC curve as signal. It was partly an alarm. |
| Offline eval (week 9) | 0.84 vs 0.68; deck built; demoed widely | The deck should have included a no-contact-features ablation. One line of the review meeting, absent from two weeks of demos. |
| Final review (week 11) | Reviewer's question. Model dead in 20 minutes. | — |

Total: the leakage was findable at week 2 by a checklist and at week 9 by a standard ablation. It was found at week 11 by someone whose job it was to be suspicious of me.

## What I changed, permanently

1. **The leakage audit is now a written checklist I run on every model**, before any evaluation: for each feature — is it affected by, or a proxy for, any intervention? Is it observable at scoring time in production, same semantics as training? Is any feature a function of the label's neighborhood (post-outcome data, outcome-adjacent processes)?
2. **The ablation is standard:** every evaluation includes performance with each feature family removed, and feature families with outsized contributions get a mechanism explanation, not just a shapley plot. "It predicts well" is not an explanation of *why*, and "why" is where leakage lives.
3. **Interventions get treatment-aware methods:** where an operational process shapes the label (save teams, fraud escalations, manual reviews), the honest options are an experiment on the intervention, an uplift/contrastive framing, or explicit de-biasing with stated assumptions. A plain outcome model over treated data answers a question nobody asked.
4. **The reviewer gets baked in early:** the risk-and-compliance reviewer from this episode got added to my model-design reviews going forward — formally, by me. The cheapest time to be audited is before the demo, and the best auditors are people paid to distrust you.

## What I'll claim and won't

**Claim:** I write postmortems on my own failures with the timeline attached; the checklist this produced has caught two feature-leakage issues in later models at design stage (different companies, same class of bug — this class is everywhere); I teach the checklist and I'd teach it to your team in week one.

**Won't claim:** that the review process "saving" this was a comfort. It was the correct outcome of a process I'd have failed sooner if I'd run my own audit. The model never shipped; the discipline it bought has shipped in everything since. That's the trade, and it was worth it — but I note the price honestly: ~3 months of work, zero production value, one permanent improvement.
