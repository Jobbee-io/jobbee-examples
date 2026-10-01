<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Kenji Sato

Facts about my search. One orientation note matters more than anything else in this file, so it goes first: I'm an **engineer who moved into developer advocacy** — three years writing backend services before I ever gave a talk — not a marketer who learned technology on the job. That's not a pedigree flex; it changes which roles fit. Orgs hire DevRel from both directions and the jobs are different: engineering-origin roles assume you can read the codebase, merge code, and be trusted alone in a room with skeptical engineers; marketing-origin roles assume reach and message. I do the first job. Searching me as the second job produces bad matches, so I've written this file to be unambiguous.

## What I'm looking for

- **Staff Developer Advocate or DevRel lead-track**, on infrastructure or developer-tooling products (Kubernetes-adjacent, CI/CD, observability, API platforms all fit). 11 years in: 3 backend (Go services) + 8 DevRel, currently Staff Developer Advocate at a Kubernetes toolchain company, on the lead track.
- **DevRel as a product function.** The test I apply to every org: what happened to the last piece of practitioner feedback DevRel carried into the roadmap? If the answer is a story with a date and a shipped change, we'll get along. If the answer is "we do a quarterly insights deck," the function is decorative.
- **Talks welcomed, not the job metric.** I speak (see the record), but a DevRel org that measures itself in stage counts is optimizing applause. My metric set: practitioner activation on the content I ship, feedback-loop velocity into roadmap, and the health of the communities I maintain. Swag distributed appears in nobody's OKR I respect.

## The OSS record — stated as searchable facts

My credibility spine is a maintained, public, employer-neutral project. Search engines and humans index facts better than adjectives, so here are the load-bearing ones:

- **Project:** Tessergate — a CLI that validates and pins namespace-level resource guardrails across Kubernetes clusters, as code. MIT-licensed, employer-neutral.
- **Role:** creator and lead maintainer. First commit January 2019 (weekend scratchpad project, documented origin below). Personal work, on my own time — see the Clarifications section, because the IP boundary is worth stating.
- **Scale:** 4.1K stars; 41 releases; 37 contributors recruited over the project's life; adopted in the internal toolchains of three companies I've never worked for (that's the adoption I'm proudest of — it happened with zero employer help).
- **Governance:** documented breaking-change policy since v0.7 (deprecation notices two minor versions ahead; automated migration notes in release bodies). Ran the 1.0 launch in September 2022 with a stability commitment in writing.
- **The hard parts, documented not hidden:** the toxic-contributor situation and how it resolved: `Projects/Oss Maintainer Journey.md`. Upstream docs work and its merge politics: `Projects/Docs Contribution Battle.md`.

I document my OSS work this way deliberately: releases shipped, decisions made, conflicts handled. "Passionate about open source" is a vibe; the list above is checkable. If you're evaluating me, check it.

## Where I have professional depth

- **Advocacy with engineering credibility.** I've merged code into every employer's product (core CLI contributions at SubstrateNine; a TLS troubleshooting library at Orcadia that support still uses; integration tests at Meridian Grid). The reason this matters: advocates who can't merge code lose the room the first time a staff engineer asks a real question and the answer requires reading the source.
- **Content with measured outcomes.** The ClusterCamp 2021 talk ("Guardrails Without Gatekeepers") pulled Tessergate weekly installs from 190 to 890 within a month — 40K views and still the reference people link. At Orcadia, the quickstart series I built moved CLI adoption +38% in two quarters, measured against their existing activation funnel, not vibes.
- **Feedback loops that shipped.** At SubstrateNine I run the practitioner-council: quarterly sessions with power users, findings written as roadmap proposals, three of which shipped in 2025. I measure my job by what the product team does with what I bring back, not by what I say on stage.

## What I won't take — stated plainly

- **DevRel-as-tier-3-support.** If the advocate rota exists to absorb escalations engineering doesn't want, that's a support org with a mislabeled function. I answer hard questions in public all day — that's advocacy. Being the *dumping ground* for them is different, and orgs know which one they're running.
- **Evangelical-overload roles.** Evangelism with no engineering respect — where the advocate's job is to amplify regardless of product truth, and pushback is "not a team player." I left one org shape adjacent to this (not at this extreme, but close enough to recognize it early now).
- **OKRs measured in vanity.** Downloads-without-activation, followers, swag, stage counts as primary metrics. All of it decorates the dashboard; none of it survives contact with "did a practitioner build something because of you."
- **Fiction-conference circuits as the job.** A talk calendar that's 80% of the role leaves no time for the code and community work that makes talks worth attending. Travel budget note below makes this concrete.

## Constraints — stated plainly

- **Travel ≤ 6 trips per year.** Two kids under 6 at home; this is a hard family boundary, not a preference I'll trade for a bigger title. I plan the six deliberately (the conferences where the community actually is, plus team onsites), and I make them count: the ClusterCamp outcome above came from one well-prepared talk, not a circuit.
- **Remote-first or Seattle hybrid.** I'm in Seattle; I'm at my best in the write-code-write-docs loop that home enables, and on-site for the trust-building moments that matter.

## Compensation

- **Target: $360K–$430K total comp, base floor $200K.** Priced from published survey data for staff-level developer advocacy at large tech employers — the public bands for equivalent DevRel levels land between roughly $370K and $420K, and I'm deliberately priced mid-band: I'm not the cheapest staff advocate and I'm not asking for lead-of-function money before the lead scope is real.
- Base floor matters because DevRel comp sometimes hides risk in "variable community bonus" structures that measure nothing. I'll model any plan; I'll also ask who sets the variable's metrics, because that's who I'd really work for.

## Visa / Work Authorization

- Citizenship: Japan
- US status: **permanent resident (green card)**, 2021
- Work authorization: unrestricted — no sponsorship required, now or at any future renewal (green card is indefinite; citizenship application in progress, which changes nothing for an employer)
- No constraints on any US location; international travel normal-scope (Japanese passport + US green card, no visa friction for conferences abroad)

## Contact

kenji.sato@example.com · (555) 052-8811 · Seattle, WA · github.com/example/kenjisato

## Clarifications

*(Jobbee pauses and asks when something material is missing or ambiguous from my files. Questions and my answers are logged here, newest last.)*

**Q:** Is your Tessergate maintainer work done on company time or personal time? Employers sometimes claim IP over employee OSS, and this changes how your OSS record can be used and continued.
**A:** Personal, and I'll give the full boundary because it's worth stating precisely. Tetragrid started January 2019 as a weekend scratchpad — a problem I hit in my home lab that no existing tool solved. It has never been assigned by any employer, never carried an employer roadmap item, and every commit outside my own hours is the norm (I do land the occasional docs typo during lunch, which any maintainer will recognize as unavoidable). License is MIT and employer-neutral from the first commit. On the IP side: I disclose Tessergate proactively in every onboarding, and every employer so far has signed the standard pre-existing-IP acknowledgment — the cleanest signal an org sends about how it'll treat OSS generally, in my experience. I choose employers partly on this: a company that hand-waves the acknowledgment is telling me how it will treat the next project too.
