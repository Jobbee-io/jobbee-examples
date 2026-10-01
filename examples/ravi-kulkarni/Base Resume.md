<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Ravi Kulkarni

ravi.kulkarni@example.com · (555) 028-6611
Charlotte, NC

*The long record behind the one-pager — methods, numbers, and one model that didn't ship, documented because it taught me the most. Full stories live in `Projects/`.*

---

## Summary

Senior data scientist, six years in, specializing in experimentation and causal inference: A/B platform design, quasi-experimental methods for when randomization isn't possible, and the institutional politics of acting on evidence. Built or rebuilt experimentation practices at three companies — twice as the first DS hired to do exactly that. Bayesian modeling in PyMC/Stan as the daily driver; BigQuery/dbt for the data platform layer. I measure my work by decisions changed and money measured honestly, not by model count. One churn model that never shipped is in here too, on purpose.

---

## Experience

### Brightlane Commerce (marketplace, retail) — Senior Data Scientist, Experimentation
*Aug 2022 – present · Charlotte, NC (remote-first company)*

- First experimentation-focused DS at the company; inherited a world of "we shipped it, we think it worked." Built the practice: experiment review standards, a lightweight A/B platform wrapper, and the cultural muscle of pre-registered metrics.
- **Marketplace matching analysis (2023):** an observational analysis of buyer–seller matching that led to changing the matching weights — measured **+6.2% in marketplace liquidity** (seller response rate to first contact) in the confirming A/B that followed. Full story: `Projects/Marketplace Matching Analysis.md`.
- Designed the guardrail-metric system for all experiments (see `Projects/Experimentation Platform Migration.md`): every experiment declares, before launch, the metrics it is not allowed to hurt. Boring, mandatory, and the reason two harmful launches were caught in review.
- Ran ~40 experiments to decision through 2023–2025; killed roughly half in analysis, which I consider the function working.
- Mentored two junior DS; ran the internal "causal inference for product people" seminar, 6 sessions, attended by product managers voluntarily (the only seminar in company history with waiting-list energy, per the internal survey).

### Halcyon Insurance (auto insurance) — Data Scientist II, Pricing & Experiments
*Jun 2019 – Jul 2022 · remote (Charlotte-based team)*

- **Pricing causal inference (2021):** synthetic-control analysis of a proposed rate change in three test states; the analysis showed the change would lose ~$4.1M annually against a projected $2.3M gain — the proposal was killed, and the methods doc became the standard for state-level policy evaluation at the company. The politics of killing a VP's initiative are part of the story: `Projects/Pricing Causal Inference.md`.
- Built the CUPED-style variance-reduction layer for renewal experiments: average **31% variance reduction**, cutting required experiment durations by roughly a third for typical effect sizes. This one number changed the experimentation calendar more than any single test.
- Bayesian hierarchical models for small-state pricing: three states with too little data for classical rate indications; the partial-pooling approach gave credible estimates where the classical method returned noise, and the pricing committee used them.
- Owned the claims-severity dataset (2.1B rows, BigQuery): dbt models, documentation, and the data-contract discipline that let analysts self-serve without paging me. I was deliberately *not* the SQL person here, and the structure is why.

### Meridian Analytics (consultancy) — Associate Data Scientist
*Jul 2018 – May 2019 · Raleigh, NC*

- Client work across retail and healthcare: A/B test design and analysis, survey design, the unglamorous data-cleaning that is 60% of the real job. Shipped 14 client engagements; the two I'm proud of involved telling clients their pet metric was noise.
- Learned the consulting skill I use daily: "here's what the data says, here's what it doesn't, here's what I'd need to say more" — in one page, before the meeting.

### Before that

- **MS Statistics, Ohio State University** (2016–2018). Thesis on Bayesian model comparison for small-sample hierarchical problems — more useful in industry than it sounds.
- **BS Mathematics, University of Pune** (2012–2016).

---

## A failure, indexed honestly

**The churn model that didn't ship (Halcyon, 2020).** Built a gradient-boosted churn model for policy renewal that hit 0.84 AUC in offline evaluation and died in review — correctly, as it turned out. Late-stage validation found label leakage: a field proxied from an internal save-team workflow leaked the *outcome* (policies flagged for save attempts were disproportionately the ones saved), so the model had learned "who the save team touches" rather than "who will churn." Found two weeks before the scheduled production pilot, after ~3 months of work. The honest ledger: the leakage was findable earlier with a stricter train/serve feature audit; the review process caught it before customers did, which is the review process working; and I wrote the postmortem myself (`Projects/Churn Model Postmortem.md`) including the timeline showing where I should have caught it. I've run a leakage audit on every model since, and I teach the checklist.

---

## Methods I actually use (not a keyword dump)

- **Causal:** randomized experiments (design and analysis), synthetic control, difference-in-differences, regression discontinuity (twice, both times defensibly), CUPED-style variance reduction, sensitivity analysis for unmeasured confounding.
- **Bayesian:** hierarchical models, PyMC and Stan, posterior predictive checking as a habit, prior-elicitation conversations with domain experts (underrated skill: turning "how sure are you?" into a distribution).
- **Platform thinking:** experiment orchestration, guardrail design, sequential testing (always-valid CIs), logging schemas that make analysis possible a quarter later.
- **Deliberately shallow:** deep learning (I use pretrained tools; I don't build architectures), streaming systems, MLOps infrastructure — I partner with people whose job that is, and I know enough to be a good partner.

---

## Numbers I can defend

- +6.2% seller response rate from the matching-weight change (A/B-confirmed after the observational analysis that proposed it).
- ~$4.1M avoided annual loss — the rate change killed by the synthetic-control analysis, against a projected $2.3M gain.
- 31% average variance reduction from the CUPED-style layer; roughly one-third shorter experiments for typical effect sizes.
- ~40 experiments run to decision at Brightlane; ~50% killed in analysis.
- 0.84 AUC, and why it was meaningless — the churn model postmortem, in the projects folder because failure evidence belongs next to success evidence.

## How I work

- Pre-registered hypotheses and metrics, or the experiment doesn't launch — including for my own analyses.
- Every causal claim ships with its identifying assumption and the sentence "this breaks if."
- I'd rather kill my own analysis in review than watch someone else do it in production.
- Visa status is fully documented in my applicant profile — H-1B with premium-transfer mechanics and an explicit PERM-restart trade-off — so nobody discovers it as a surprise in week six. I write these things down first, not last.

## Contact

ravi.kulkarni@example.com · (555) 028-6611 · Charlotte, NC
