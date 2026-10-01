<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# API sunset — retiring legacy v1 with 4,000 dependent customers

Cassline, 2023–2024. I ran the program to retire v1 of the public API: 4,000 dependent customers, zero-incident cutover, 94% migrated before the hard date — and one whale we nearly lost because I almost managed the relationship like a program instead of like a relationship.

## Why sunset v1 at all

v1 predated the versioning policy (see `Projects/Developer Api Platform.md`): no deprecation schedule, no date-versioned paths, and a support stance of "basically forever." By 2023 it cost the platform team real money:

- **Dual-surface tax:** every new feature shipped twice or not at all; roughly 30% of platform engineering capacity was v1 parity work.
- **Risk concentration:** v1 lacked the idempotency contract v2 had. The retry-related incident reviews read like a museum of 2019-era API design.
- **Security posture:** v1's auth (legacy key scheme, no granular scopes) was the weakest link in every security audit for three years running.

The board-level pitch was one line: *every quarter we keep v1, we pay 30% of a platform team to maintain our past instead of building our future.*

## The program design

18-month runway, announced with a published schedule:

- **Months 0–3: announce + instrument.** Deprecation notices on every v1 response header (`Sunset`, `Deprecation`, link to the migration guide), and the single most valuable artifact of the program: a per-customer usage dashboard. We instrumented *which* v1 endpoints each account called, so outreach could be specific ("you use 3 endpoints, here's the v2 mapping") instead of generic terror.
- **Months 3–9: migration tooling.** A v1→v2 request-translation proxy (opt-in) that let partners run v2 semantics behind their existing integration while they migrated properly — a safety net, not a destination, with hard rate limits and a banner in every response. Plus codemods for the four languages that covered 80% of our SDK usage.
- **Months 9–15: segmentation + outreach waves.** Four segments by usage depth and account value, each with its own motion: self-serve (docs + codemods), assisted (integration-engineer office hours), managed (named migration plan), executive (see the whale section).
- **Months 15–18: the hard date.** v1 returns structured 410s with the migration guide link. A 6-month read-only fallback window existed in the plan and, notably, was never used — the 410s did the work.

## The numbers

- 4,000 dependent customers at announcement.
- 94% migrated before the hard date; 5.1% of the remainder were dormant accounts we'd already tried three times; 0.9% took the negotiated extensions written into pre-policy enterprise contracts. Nobody was surprised on the day.
- Zero incidents at cutover. The boring metric that was the whole point.
- Post-migration platform velocity: v2-only feature shipping went from "quarterly, if v1 didn't object" to the normal release train.

## The angry whale

Our largest v1-only customer — a marketplace processor with 40% of their integration on v1 endpoints we'd mapped as "low usage" by *call count*. Call count was a lie: their low-frequency endpoints were settlement-critical, running monthly reconciliation jobs that moved eight figures.

Their VP of engineering found out about the sunset from our deprecation header, not from us. The call was not friendly. Two things went wrong, both mine to own:

1. **I segmented by call count, not by blast radius.** Monthly-but-massive is not "low usage," and my dashboard's definition of usage encoded a program metric, not a customer-reality metric.
2. **The program ran outreach; the account ran the relationship.** The CSM relationship was our trust channel, and I'd routed the sunset through program email sequences instead of through the human who'd earned the right to have the conversation.

The recovery: I called (not emailed) within the hour of the escalation, we co-wrote their migration plan with their two integration engineers over three weeks, and their migration landed two months before the hard date. The extension I'd have been right to offer up front — the read-only fallback window — I instead offered as part of the co-written plan, where it functioned as a commitment device rather than an escape hatch.

**The postmortem I wrote for ourselves** changed two things permanently: segmentation models now include a blast-radius axis reviewed with account teams (usage dashboards are audited against "what would break if this stopped tomorrow," not call counts), and sunsets get a named human owner per top-50 account — programs support the relationship; they don't replace it.

## What this project proves about me

Deprecation is a trust product. The API was killed on schedule with 94% voluntary migration — not because the schedule was clever, but because every artifact of the program (the usage dashboard, the translation proxy, the codemods, the co-written whale plan) was designed to make *yes* easier than *no*. Killing things well is a growth skill, whatever the org chart says.
