<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Kenji Sato

kenji.sato@example.com · (555) 052-8811
Seattle, WA · github.com/example/kenjisato

*The long record. Engineer first, advocate since — this file is ordered that way on purpose, because the three backend years are why the eight DevRel years work. The OSS project has its own section and gets treated as first-class work history, because that's what it is.*

---

## Summary

Staff Developer Advocate with an engineer's spine: 3 years building Go backend services, then 8 in developer relations on infrastructure and tooling products. Creator and lead maintainer of Tessergate (Kubernetes guardrails-as-code; 4.1K stars, 41 releases, 37 contributors, MIT). Merged code into every employer's product — core CLI, a TLS troubleshooting library, integration tests — because advocates who can't merge code lose the room. Talks with measured outcomes (40K views, one adoption curve that quadrupled), content tied to activation funnels, and a feedback-loop practice that has shipped three roadmap changes in the last year. Looking for DevRel as a product function, at orgs where the advocate's opinion of the product is load-bearing.

---

## Experience

### SubstrateNine (Kubernetes toolchain) — Staff Developer Advocate
*Mar 2024 – present · Seattle (hybrid)*

- Own the practitioner surface of the toolchain's CLI and guardrails story. Lead-track: my scope this year is the advocate roadmap, not just the advocate calendar.
- **Core CLI contributions, merged:** 14 merged PRs in 2025 across the validation engine and config parser — the work that keeps me honest in front of staff engineers, and the reason my feedback gets answered in hours instead of quarters.
- **The practitioner council:** quarterly sessions with 20–30 power users; findings written as roadmap proposals with evidence attached. Three shipped in 2025 (policy-report output format, air-gapped install path docs, a CLI flag deprecation reversal — the reversal came from a council session, which is the loop working exactly as designed).
- **Quickstart rebuild (2024):** cut first-success time from 34 to 11 minutes by rebuilding the onboarding path with the onboarding PM. Activation on the new path: +52%. The old quickstart's problem was that it explained the product; the new one gets you to the moment the product is useful, which is a different document.
- **Tessergate integration:** built and maintain the official guardrails starter configs for SubstrateNine users — personal project, employer-neutral license, disclosed and acknowledged (see `projects/oss-maintainer-journey.md` for how the boundary is managed).

### Orcadia Cloud (observability platform) — Senior Developer Advocate
*Feb 2022 – Feb 2024 · remote (Seattle)*

- **Quickstart series for the CLI** (8 posts + interactive labs): CLI adoption +38% over two quarters, measured against the existing activation funnel. The series worked because every post ended in a working thing, not a concept.
- **Shipped the `logline` TLS troubleshooting library** (open-sourced under Orcadia's org with my authorship): built out of the 40 most-repeated support escalations; support still routes TLS cases to it. Advocate work that reduced escalations instead of absorbing them — the anti-tier-3 proof.
- **Nordhavn Freight migration series** (5 posts, real anonymized migration): the single highest-converting content asset of my tenure — 2,100 completions, 19% of completers starting a trial.
- **The failure, documented:** the 1.0 announcement post for the platform's new agent (`projects/advocacy-failure-recovery.md` — technically wrong about the reconciliation behavior; the community found it in nine hours; I shipped the correction, the root-cause note, and the internal review process that made it the last one of its kind).
- Conference record: **ClusterCamp 2021** (as Meridian, see below), **ShipScale** 2022 and 2023 (deep-dive workshops, 300+ attendees each, workshop NPS 62 and 68).

### Meridian Grid (edge orchestration) — Developer Advocate → Senior Advocate
*Oct 2018 – Jan 2022 · Seattle*

- First DevRel seat at a company learning what the function was. Wrote my own charter in month 3 (the "advocate as translator" doc the CTO still referenced at offsites) and staffed the team to four by 2021.
- **ClusterCamp 2021: "Guardrails Without Gatekeepers."** The talk that introduced Tessergate publicly: the namespace-guardrails problem, the policy-as-code approach, and a live demo failing once and recovering. **40K views** on the recording to date; Tessergate weekly installs went **190 → 890** within a month of the talk and never fell back below 500 — the adoption curve is the outcome, the views are just how it traveled.
- **Integration tests for the scheduling engine:** 60+ scenario tests merged in 2020 after I kept finding the same class of bug from the practitioner side. Filed as a week-long engineering rotation, kept as a standing contribution.
- Built Meridian's practitioner-insights loop (the forerunner of SubstrateNine's council): the 2019 feedback cycle that changed the edge-agent's default config was my first roadmap win, and I still think of it as the moment my job made sense.

### Rookline Systems (fintech infrastructure) — Backend Engineer, Go
*Jul 2015 – Sep 2018 · Seattle*

- Three years on the payments-correlation service: Go, gRPC, high-cardinality telemetry, and the paging rotation that taught me what practitioners actually mean when they say "your tool failed at 3am."
- Built the internal runbook tooling that support used daily — my first taste of writing for practitioners under pressure, which is what every doc and talk is, if you're honest about it.
- The engineering years stay on this resume first-class because they're the credential behind every claim below: I have been the skeptical engineer in the audience. I know exactly which sentences that audience forgives and which it files away as evidence you've never carried a pager.

---

## Open source — Tessergate (first-class section, because it's first-class work)

**Tessergate** — validate and pin namespace-level Kubernetes resource guardrails, as code. MIT, employer-neutral, created January 2019, maintained continuously since.

- **Scale:** 4.1K stars, 41 releases, 37 contributors recruited, 1.0 shipped September 2022 with a written stability commitment.
- **Governance:** documented breaking-change policy since v0.7 — deprecation notices two minor versions ahead, automated migration notes in every release body. The 1.0 launch ran on this policy and zero breaking-change complaints followed it.
- **Maintainer decisions that show the craft:** the breaking-changes policy (`projects/oss-maintainer-journey.md`), the toxic-contributor resolution (same file), the upstream docs merge politics (`projects/docs-contribution-battle.md`).
- **Why it's employer-neutral by design:** personal project, personal time, disclosed in every onboarding — the Clarifications log in my applicant file carries the full boundary statement, because OSS status has IP dimensions and I'd rather state them than have them discovered.

## Talks

- **ClusterCamp 2021** — "Guardrails Without Gatekeepers" · 40K views · Tessergate installs 190→890/week within a month. The measured-outcome talk.
- **ShipScale 2022 & 2023** — deep-dive workshops (guardrails-in-practice; the observability migration path) · 300+ attendees each · workshop NPS 62, 68.
- **HelmPoint 2020** — "The Edge Agent's Honest Failure Modes" · the incident-postmortem talk; the recording is still linked in Meridian's own docs.

## Content with numbers

- Orcadia quickstart series: CLI adoption +38% in two quarters.
- Nordhavn Freight migration series: 2,100 completions, 19% trial-start rate.
- SubstrateNine quickstart rebuild: first-success 34 → 11 minutes, activation +52%.
- The wrong 1.0 announcement post: ~4,100 views before correction, corrected same week — indexed honestly, because the correction is the credential.

## The failure, on the record

The 1.0 agent announcement post of March 2023 stated the agent's reconciliation behavior incorrectly (I wrote what the design doc said, not what the code did). A practitioner reproduced the discrepancy in nine hours; I had the correction, a root-cause note (design-doc drift after a hotfix), and an internal review change shipped within the week. Full account and what it changed: `projects/advocacy-failure-recovery.md`. The short version of the lesson: the audience doesn't remember the error, it remembers the error *handling* — and I'd rather demonstrate the handling here than hide the error.

## Numbers I can defend

- 4.1K stars / 41 releases / 37 contributors on Tessergate — the scale facts, checkable in public.
- ClusterCamp 2021: 40K views; weekly installs 190 → 890 within a month, stable above 500 since.
- Orcadia CLI content: +38% adoption, measured against the existing funnel by their analytics team.
- SubstrateNine: quickstart activation +52%; three roadmap changes shipped from the practitioner council in 2025.
- 14 merged core-CLI PRs in 2025 — the credibility metric I watch most closely myself.

## Education

- **BS Computer Science, Northsound University (Tacoma, WA)** — 2011–2015. Distributed-systems coursework; senior project was a scheduler, which in hindsight was on the nose.

## Skills

Engineering: Go (primary), Python and Bash (tooling), Kubernetes internals (controllers, admission, scheduling), gRPC, CI systems. Enough Rust to read it and know when I'm out of my depth.
Advocacy: technical narrative and talk craft, quickstart and onboarding design, practitioner-research loops, community governance, content measurement (activation-funnel design, not vanity dashboards).
The boundary I hold: I can read any codebase I advocate for, and I know the difference between "I can demo this" and "I can ship to this" — I claim the first everywhere and the second only where I've merged.

## Contact

kenji.sato@example.com · (555) 052-8811 · github.com/example/kenjisato · Staff Developer Advocate / DevRel lead-track searches; travel cap and IP-boundary notes in my applicant file, stated up front so nobody rediscovers them at offer stage.
