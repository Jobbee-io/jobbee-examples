<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Subscription pricing redesign — the experiment that beat my hypothesis

Cartway, 2020. I led the pricing overhaul for seller tooling — analytics, automation, and reporting features sold as subscription tiers above the free marketplace account. The result contradicted the hypothesis I started with, and shipping the losing hypothesis's postmortem internally did more for my credibility than any winning launch.

## Starting state

Seller tooling was priced as three tiers: Starter ($9/mo), Growth ($29/mo), Scale ($99/mo). Analytics lived in Growth and Scale. The problems:

- **The tier wall.** Sellers on Starter hit the analytics paywall at exactly the moment they got successful enough to want answers — the wall punished traction.
- **Bundle confusion.** Support logs showed sellers buying Scale "for the analytics" but using only automation. We were pricing a spreadsheet with two products stapled together.
- **Upgrade cliff.** Conversion from Starter→Growth was 3.1%; from Growth→Scale, 0.9%.

## My hypothesis (recorded here, because it lost)

My hypothesis: **analytics is the anchor value** — sellers upgrade to *see* what's happening, and automation is the retention layer once they're in. Therefore: split analytics into its own premium tier, price it as the flagship, and keep automation in the mid tier. I predicted a conversion lift from a sharper value story.

The experiment design: 50/50 split, six weeks, 18,400 seller accounts in the treatment pool, primary metric = paid conversion rate, guardrails = churn, support tickets, GMV per seller (no dark-pattern upsells).

## What actually happened

The treatment created a standalone analytics tier at $19/mo, automation bundled into Growth, and Scale reframed around automation + API access.

**Treatment conversion to any paid plan: 4.4% — a lift, but the composition was wrong.** The lift came from sellers buying the $19 analytics tier *instead of* Growth. Revenue per paid seller in the treatment cohort was **11% lower** than control. My flagship-tier hypothesis was eating the bundle.

And the segment breakdown killed the last of it: the sellers most likely to buy standalone analytics were the *smallest* sellers — the ones with the least data to analyze, churning within two cycles when the dashboard confirmed they didn't have much traffic yet. Analytics as a standalone product was, for this population, a mirror. Nobody upgrades forever to watch a small number.

## The winning structure (the control won, with one modification)

Analytics folded back into a richer base plan; pricing moved to **automation as the premium axis** — priced on actions (rule runs, bulk edits, payout scheduling), not on seats or dashboards. The insight the experiment surfaced: sellers pay for *time returned*, not *information provided*. Information raises questions; automation answers them.

Rollout numbers (post-full-rollout, two quarters):

- Paid conversion: 3.1% → 4.6% (the treatment's lift, achieved without the revenue dilution).
- Revenue per paid seller: +9% vs. the pre-test baseline.
- Automation-tier attachment: 22% of paid sellers within one quarter.
- The $19 mirror tier: gone, and good riddance.

## The part I'm actually proud of

Not the numbers — the memo. I published the hypothesis, the design, the result, and the sentence "my hypothesis was wrong in an interesting way" to the whole product org, before the winning rollout. The postmortem became a reference artifact: two other PMs ran their pricing tests with the same pre-registered-hypothesis format that quarter.

What made the experiment trustworthy (and what I check in any A/B I'm asked to bless):

- Pre-registered hypothesis and kill criteria — written before launch, not after.
- Segment read *planned in advance*, because the aggregate hid the composition problem.
- Guardrails that measured the failure mode we feared (revenue dilution), not just the one we hoped for.
- Six weeks was long enough for conversion but not for churn effects on the mirror tier — the churn signal arrived in week nine and confirmed the segment read. Duration honesty belongs in the writeup.

## Transfer lesson

Pricing experiments don't test prices; they test *stories about what the customer values*. My story (insight is the anchor) was plausible, defensible, and wrong — which is exactly why it needed an experiment instead of my conviction. The most valuable thing a PM can ship is a decision system that survives being wrong.
