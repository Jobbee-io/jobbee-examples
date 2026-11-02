<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Build system consolidation: five systems to one

Grousemont Systems, February 2021 to February 2022. The division Cinderpeak had been folded into (about 800 engineers) ran five build systems across 650 repos. I was the Senior Staff Engineer in its Developer Productivity group and ran the consolidation end to end: the audit, the choice, the migration and the decommissioning. Build systems are my origin story, and this is the project I'd spend an interview on. This file is the overview.

Companion files: `Build System Consolidation Decision.md` (the options doc, the scoring and the two escalations that settled it), `Build System Consolidation Migration.md` (batches, the transpiler, what broke, the holdout, and the decommissioning).

## The starting estate

The division had grown through four acquisitions in six years, and each had brought its own build:

1. **Maven tree A:** the original product line. 210 repos, Java 8, plugins pinned to 2016 versions, a parent POM hierarchy four levels deep that two people fully understood.
2. **Maven tree B:** from the Veltis acquisition (2017). 130 repos. Also Maven, but with its own repository manager, artifact naming and release tooling.
3. **Gradle tree A:** the API and client-SDK teams. 95 repos and the healthiest of the five; the team that owned it had taste.
4. **Gradle tree B:** from Orben Digital (2019). 140 repos, with a custom build-logic DSL that was elegant and completely unportable.
5. **Kelvin:** a homegrown Perl build orchestrator from 2009 wrapping 75 repos of the legacy services group. Its CI ran on a cron server called `big-daddy-2`, configured years earlier by a contractor, that nobody wanted to touch.

Cinderpeak's own code was out of scope: it was Go, built with Go's own toolchain, and its clean builds already took about 3 minutes.

**Baseline (January 2021):**
- Clean-build p50 26 minutes, p95 71, across the 650 repos.
- About $2.9M a year of CI spend in the division, of which about $1.2M was the build and unit-test executors for these repos. The rest (integration environments, performance labs, packaging) wasn't in scope.
- Survey: 62% of engineers said they'd lost at least a day to build problems in the previous quarter (Q4 2020, 410 responses).
- The division onboarded about 15 engineers a month, and every one of them met whichever build their team happened to use.

## My role and the team

I wrote the options doc and the migration plan, designed the batch gates, wrote the first version of the Maven-to-Bazel transpiler, ran the weekly batch review, and owned the decommissioning. A core team of 5 engineers from Developer Productivity did most of the migration work; two of them took my transpiler from prototype to the tool that handled 340 repos. Owning teams spent about 2 days per batch on review and sign-off. For the Gradle-B rewrite we added 2 Orben engineers. The infrastructure division, which had run Bazel for 4 years, lent us advice and the design of their remote cache.

## The decision, in short

Bazel, with a self-hosted remote cache, over two counter-proposals from division architects: standardize on Gradle, or on Maven. No bake-off: three of the five candidates already ran in production at Grousemont, so I scored them on real data instead of re-running team loyalties for 6 to 8 weeks. Bazel won on cache architecture and CI cost and lost on learning curve, and I published that the result flips if you weight learning curve much higher. It took two escalation rounds before the CTO accepted the doc as the decision, with three conditions. Details in the decision file.

## The migration, in short

Repos moved in dependency-ordered batches of 15 to 25, per tree. Each batch passed three gates: build-output parity, a CI-duration ceiling, and the owning team's sign-off. The two Maven trees (340 repos) went through the transpiler, which turned each repo's effective POM into Bazel build files its owners could review as "your own build, translated". New repos were created on Bazel from month 3, so the old pile stopped growing. Details in the migration file.

## Timeline and turning points

- **Month 1 (February 2021):** inventory of all 650 repos, build-time baseline, survey.
- **Months 1 to 2:** options doc, two escalation rounds, CTO decision at the end of March.
- **End of month 2:** at the batch-plan review, Kelvin's author blocked his 75 repos, and I lost that round.
- **Month 3:** transpiler v1, remote cache running, golden-path templates for new repos, first Maven-A batch.
- **Month 4:** Maven tree B's artifact names collided with the main registry: a two-week detour.
- **Months 5 to 7:** the Gradle-B rewrite, which took 44 engineer-weeks against a budget of 18.
- **Month 8:** the six-month onboarding check required by the CTO's conditions: the "lost a day" number had fallen to 38%.
- **Month 10 (November 2021):** the CFO's infrastructure cost review put Kelvin's cost on screen, and the block lifted. The same month, the remote cache filled its disks and slowed builds for 3 hours.
- **Months 11 to 12:** Kelvin's repos moved, last of all. All 650 repos on Bazel by the end of January 2022.

## Outcomes and how they're measured

- **Build systems in use: 5 → 1.** All 650 repos built with Bazel. When I left in March 2022, 3 of the 5 old systems were fully decommissioned (Maven A, Gradle A, Gradle B). Kelvin was in its 60-day read-only hold and was retired in April 2022. Maven B stayed as a frozen, read-only path for rebuilding two long-term-support release lines that customer contracts required us to patch exactly as built.
- **Clean-build p50: 26 → 4 minutes; p95: 71 → 9.** "Clean" means a CI build of main from a fresh checkout with an empty local cache and the remote cache available, January 2022 against January 2021. Before, there was no shared cache, so clean meant cold. A truly cold build, with the remote cache bypassed, still had a p50 of about 17 minutes; a scheduled job measured that weekly so we'd see if it drifted.
- **CI compute: −41%,** about $1.2M → about $700K a year: the executor spend for the 650 repos, Q4 2021 run rate against Q4 2020. It came from a CI remote-cache hit rate of about 88% and from replacing five executor fleets with one autoscaled pool.
- **Onboarding:** "lost at least a day to build problems last quarter" fell from 62% to 11% (Q1 2022, 455 responses).
- **The transpiler was reused by two other divisions.** That reuse is what got the work written up internally.

## Who disagreed, and how it was settled

- **The two architects behind the Gradle and Maven proposals.** Settled by the CTO's review, and by making the Gradle-A team's architect the owner of the golden-path templates. He went from opponent to the person new repos copied.
- **The division VP**, who first asked for a bake-off and later sided with Kelvin's author. The bake-off question went to the CTO. The Kelvin decision reversed after the cost review.
- **Kelvin's author.** He had one legitimate objection under a lot of posture. Building that objection into the new system is what moved his repos.
- **The Orben team,** who were right that their DSL would be hard to translate, and whose pride slowed my re-scoping.

## Second-order effects and what isn't solved

- The remote cache became production infrastructure the moment builds depended on it. The November outage showed we'd built it like a test service. It now has eviction limits, disk alerts and a 2-second fetch timeout so builds degrade to cold instead of hanging.
- Bazel knowledge sat with 4 people when I left. Templates and docs covered the common path; anything unusual still went to them.
- Maven B's frozen path still needed someone who understood Maven B until the last supported release line ended.
- Cinderpeak's Go code stayed on its own toolchain. That was the right call for one fast repo, and it means "one build system" carries an asterisk I state up front.

## What I'd do differently

- Have each counter-proposal's author score their own option in the doc. The first escalation was about my scores, not the choice.
- Re-scope Gradle B in public the week I knew it was wrong (week 3), not in week 7.
- Bring the Kelvin offer back in month 3, when I'd already drafted it, instead of waiting 7 months to avoid a second public loss. The delay cost about $90K in CI and server spend.
- Treat the remote cache as production from day 1.
