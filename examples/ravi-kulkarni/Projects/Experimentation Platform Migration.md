<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Experimentation platform migration — from ad-hoc A/B to a platform

Brightlane Commerce, 2022–2024. I was hired as the first experimentation-focused DS and inherited an org that ran A/B tests the way most companies do before they have a platform: heroically, inconsistently, and with a shrine to one famous early win. This is the story of moving ~30 product teams from vibes to a system, and of the guardrail-metric design that did more work than any single statistical method I shipped.

## Starting state, honestly audited

Six months in, I inventoried every experiment the company had run in two years. Findings from 61 "A/B tests":

- 17 had no controlled variant (a "test" was a launch with a dashboard).
- 11 peeked daily and shipped on any p-value under 0.05 — peeking with a spreadsheet, uncorrected.
- 9 had primary metrics decided after the fact ("we looked at everything and the video-player change lifted conversion" — no, cart size fell and you didn't look).
- 5 were genuinely sound. The team that ran those had one member who'd read a statistics blog consistently; institutional knowledge, not institutional practice.

The inventory memo was the political turning point: not "you're doing it wrong" but "here is 61 experiments of money spent, here's what we can trust, it's 5."

## What I built

Not a platform team — I was one person. The build was standards + scaffolding + service, in that order.

**1. The experiment lifecycle as a written contract.** Every experiment requires: pre-registered primary metric, secondary metrics, a power calculation, launch/kill criteria, and duration. The template was one page. Enforcement was social at first ("no review without the page"), then structural (the experiment-tracking tool required the fields).

**2. A lightweight experiment wrapper** over the existing feature-flag system: assignment logging with a consistent schema, exposure timestamps, and automatic experiment-health checks (sample-ratio mismatch detection, assignment-leak checks between variants). Nothing exotic — the value was that every team's test produced the same shape of logs, which meant every team's analysis could be checked the same way.

**3. Guardrail metrics — the design that mattered most.** Every experiment declares, before launch, the metrics it is not allowed to hurt, with thresholds:

- *Universal guardrails* on everything: page latency (p75), error rates, unsubscribe/opt-out, support ticket rate.
- *Surface-specific guardrails:* checkout experiments watch payment-failure rate and refund requests; search experiments watch zero-result rate; seller-facing experiments watch seller outreach complaints.
- *The threshold is the argument that matters.* We debated whether guardrails should be "statistically significant harm" (too late — you've already hurt people) or a decision threshold (chosen: a guardrail breaching its pre-declared threshold kills the experiment at interim review regardless of the primary metric). Two harmful launches were stopped in review by guardrail breaches while their primary metrics looked great — a latency-degrading "engagement" win and a seller-notification change that tripled complaint volume. Guardrails are where you put the things you already know you value, so the experiment can't discover them as casualties.

**4. Sequential testing with always-valid confidence intervals** for the two teams whose experiments were long-running marketplace changes, replacing the daily-peek ritual with peeking that doesn't invalidate the test. This one is statistics serving psychology: people will peek; give them a peek that's valid.

## The politics, itemized

- **The famous-win shrine.** The company's origin story involved one legendary early A/B. I never attacked it — I cited it as what experiments *can* do, then asked for the same rigor everywhere. You fight the practice, not the folklore.
- **Two senior PMs pushed back** on pre-registration as bureaucracy. I offered both a deal: pre-register, and I'd personally run the analysis within 48 hours of experiment end (analysis-as-a-service). Both took it; both became pre-registration's loudest advocates within two quarters, because the speed was real and the pre-registration made their reads faster.
- **The hard moment:** a director-level launch failed its guardrail in interim review and the director asked to "note the concern and ship anyway." The pre-declared threshold policy survived only because leadership had signed the policy when it was abstract. When we set the rule, I made sure the sign-off meeting included the sentence "this applies to everyone" — awkward then, load-bearing later.

## Results at steady state (two years in)

- 61 ad-hoc "tests" over two years before → ~40 experiments/year run to *decision* under the system.
- Roughly half of experiments killed in analysis — the honest output of a portfolio, not a failure rate.
- Median time from experiment-end to decision: 3 days (from "whenever someone got to it").
- Two harmful launches prevented at interim by guardrails; one partially-harmful launch reworked and relaunched successfully.
- The inventory ritual became annual: we re-audit everything we shipped on experimental evidence. Year-two audit: 84% of launches traceable to a decision-grade experiment, up from the original 5-trustworthy-of-61 baseline.

## What I'd tell the next person building this

The statistics is the easy 20%. The platform is trust: same log shape everywhere, analysis anyone can check, thresholds signed before the argument arrives, and a service posture (48-hour reads) that makes the standard feel like leverage instead of law. Build the shrine a new one, where the ritual is pre-registration — and make the first exhibit the memo that audited the old one.
