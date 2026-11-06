<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Subscription pricing redesign — the experiment that beat my hypothesis

Cartway, 2020. I led the pricing overhaul for seller tooling: analytics, automation and reporting, sold as subscription tiers above the free marketplace account. The experiment contradicted my hypothesis. I designed the test and wrote the hypothesis and the memo; our analyst ran the statistics; two engineers built the tiers.

## Starting state

Three tiers: Starter ($9/mo), Growth ($29/mo), Scale ($99/mo). Analytics lived in Growth and Scale.

- **The tier wall.** Starter sellers hit the analytics paywall just as they got successful enough to want answers. The wall punished traction.
- **Bundle confusion.** Support logs showed sellers buying Scale "for the analytics" and then using only automation.
- **Upgrade cliff.** Starter to Growth conversion was 3.1%; Growth to Scale, 0.9%.

## My hypothesis, recorded because it lost

Analytics is the anchor value: sellers upgrade to see what's happening, and automation is the retention layer once they're in. So split analytics into its own tier, price it as the flagship, keep automation in the mid tier. I predicted a conversion lift from a sharper value story.

Design: 18,400 seller accounts in the test pool, split 50/50, six weeks, powered to detect a 0.75-point change in conversion. Primary metric: paid conversion (an upgrade to any higher plan in the window). Guardrails: churn, support tickets, GMV per seller. Kill criteria written before launch.

## What happened

Treatment: a standalone analytics tier at $19/mo, automation bundled into Growth, Scale reframed as automation plus API access.

- Conversion to any paid plan: 4.4%. A lift, but the composition was wrong. It came from sellers buying the $19 tier instead of Growth.
- Revenue per paid seller: 11% lower than control. My flagship tier was eating the bundle.
- The planned segment read finished it. The sellers most likely to buy standalone analytics were the smallest, with the least data to analyze. They churned within two billing cycles, once the dashboard confirmed they didn't have much traffic yet. For them, analytics was a mirror.
- Six weeks was long enough for conversion, not for churn. The churn signal arrived in week nine and confirmed the segment read. The writeup says so.

## What shipped instead

The control structure won, with one change: analytics folded into a richer base plan, and automation became the premium axis, priced on actions (rule runs, bulk edits, payout scheduling), not seats or dashboards. Sellers pay for time returned, not information provided.

After full rollout, two quarters:

- Paid conversion: 3.1% to 4.6%, the treatment's lift without its revenue dilution.
- Revenue per paid seller: +9% against the pre-test baseline.
- Automation attachment: 22% of paid sellers within one quarter.
- The $19 tier: gone.

## The memo

Before the winning rollout, I sent the whole product org the hypothesis, the design, the result, and the sentence "my hypothesis was wrong in an interesting way." Two other PMs ran their pricing tests in the same pre-registered format that quarter, and it became the org's standard pricing-test format.

What I check in any A/B I'm asked to bless, all from this test: a hypothesis and kill criteria written before launch; a segment read planned in advance, because the aggregate hid the composition problem; a guardrail on the failure mode we feared (revenue dilution), not only on the result we hoped for; and a stated limit on what the test duration can show.

## What's still open

Nothing is open: the new structure shipped, the $19 tier is gone, and the test format became the org's standard. The one thing the six-week test couldn't show, churn, was answered in week nine, when the churn signal confirmed the segment read.
