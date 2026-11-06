<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Build system consolidation: the migration

Companion to `Build System Consolidation.md`. This file covers April 2021 to February 2022: how 650 repos moved to Bazel, the gates each batch passed, the transpiler, what broke, the eight-month standoff over Kelvin, and how the old systems were shut down.

## The full story

The CTO's decision at the end of March 2021 left me with 650 repos to move and one round already lost: at the batch-plan review, Kelvin's author had blocked his 75 repos, and the division VP had sided with him.

I wrote the first version of the transpiler in March and April. Two engineers from the core team of five made it a production tool, and the core team did most of the batch work. I designed the gates and ran the weekly batch review. From month 3 the golden-path templates put every new repo on Bazel, so the old pile stopped growing, and the first Maven A batch moved.

Three things broke on the way. In month 4 Maven B's artifact names collided with tree A's; the parity gate caught it before production, and untangling it took two weeks. From month 5 the Gradle-B rewrite took 44 engineer-weeks against my budget of 18. I knew by week 3 and re-scoped in week 7. In November 2021 the remote cache filled its disks and slowed builds for 3 hours.

Kelvin was my own delay. I drafted the fix in month 3 and sat on it for 7 months. In month 10 the CFO's cost review put Kelvin's $11K a month on screen. I took the offer to its author privately, he co-designed the deploy rule, and his repos moved in months 11 and 12. All 650 repos were on Bazel by the end of January 2022.

When I left in March 2022, Maven A, Gradle A and Gradle B were deleted, and Kelvin was in its 60-day read-only hold; `big-daddy-2` was retired in April. What was still open: Maven B's frozen path, kept for two long-term-support release lines and due to retire when the last one ended in 2023, and Bazel knowledge that sat with 4 people.

## Batches by tree, not by team

Repos moved in dependency-ordered batches of 15 to 25, one build tree at a time. Two reasons. Each tree needed one translation approach (transpiler for Maven, hand rewrite for Gradle B), so batching by tree let the core team get fast at one approach before switching. And most dependencies stayed inside a tree. For the about 70 that crossed trees, migrated repos kept publishing their artifacts to the same repository manager, so repos not yet migrated could still consume them.

Order: Maven A first (largest, best understood), then Maven B, Gradle B, Gradle A, and Kelvin whenever it was unblocked. Gradle A went near the end because it was healthy and its team was busy writing the golden-path templates.

## The gates every batch passed

1. **Output parity.** Artifacts built by both systems had to match: checksums where the build was deterministic, and diffed manifests (class lists, resources, dependency trees) where it wasn't, for example JARs with embedded timestamps.
2. **CI duration ceiling.** No repo's CI could get more than 10% slower during the transition, even before the cache warmed up.
3. **Owner sign-off.** The owning team approved the generated build files and the parity report.

A batch that failed any gate went back to the queue with a written reason. Over the year, 9 of 38 batches failed a gate at least once. Parity failures were the most common, and every one of them was a real difference.

## The transpiler

I wrote the first version in March and April 2021, about 3 weeks of my own coding. It read each repo's effective POM (after parent-POM inheritance) and generated Bazel build files plus pinned external dependencies. Two core engineers turned it into a production tool.

- It handled about 85% of a typical Maven repo automatically. The rest came out as marked TODOs for a person: mostly the 23 custom Maven plugins in use across the two trees, each of which needed a hand-written Bazel rule once.
- From batch 3 on, it also produced a side-by-side report for owners: their POM section next to the build file it became. That report did more to win skeptics than any meeting. People accept their own build, translated, much more easily than someone else's rewrite.
- 340 repos went through it. Measured on the first 3 batches, it saved 0.3 to 0.4 engineer-days a repo, or 4 to 6 engineer-months overall.

## Stopping the pile from growing

From month 3, the golden-path templates (owned by the Gradle-A architect, a condition of the decision) created every new repo on Bazel. By the end of month 4, almost no new repos were being created on the old systems. That made the rest of the migration feel inevitable instead of contested.

## What broke

**Month 4: artifact name collisions.** When Maven tree B's artifacts started publishing into the shared repository manager, 40+ of them collided with names already used by tree A. The parity gate caught it, not production. Untangling it took two weeks of mapping old names to new ones, work I had only half scoped. The batch schedule's buffer absorbed it.

**Months 5 to 7: the Gradle-B cliff.** Orben's custom build logic didn't transpile, so all 140 repos needed real rewrites. I'd budgeted 3 engineers for 6 weeks (18 engineer-weeks). It took 4 engineers for 11 weeks (44). I knew the estimate was wrong by week 3 and re-scoped in week 7, because the Orben team was proud of their DSL, correctly, and I let that slow a conversation I should have had in public right away.

**November 2021: the remote cache filled up.** The cache nodes' disks reached 100% because eviction was misconfigured. Cache writes failed, reads slowed, and CI p50 rose to about 21 minutes for 3 hours until we cleared space. Fix: size-capped eviction, disk alerts at 80%, and a 2-second fetch timeout so a sick cache makes builds cold instead of stuck.

## Kelvin: the eight-month holdout

At the batch-plan review at the end of month 2, Kelvin's author (still at the company, still senior, still proud of it) blocked the migration of his 75 repos. His objections ranged from territorial to one legitimate one: Kelvin built artifacts and pushed them straight to the legacy services' deploy hosts, and nothing in the new setup could do that. The division VP sided with him for the year: no risk to legacy deploys. I lost that round.

My mistake came next. In month 3 I drafted the fix: port Kelvin's deploy step as a first-class Bazel rule, with its author named as designer. Then I sat on it for 7 months, because I didn't want to lose a second time in public. Meanwhile Kelvin's executor fleet and `big-daddy-2` kept running at about $11K a month.

In month 10 the CFO's infrastructure cost review put the Kelvin line on screen and someone with a bigger title than either of us asked what it was. I took the drafted offer to the author first, privately, before the VP. He accepted, co-designed the deploy rule, and his repos moved in months 11 and 12, last of all and without incident. Under the posture there was one real problem, and building it in cost less than the standoff did.

## Decommissioning

The rule for every old system: after its last repo moved, 60 days read-only (CI configs disabled but kept, executors drained), then deletion.

- **Maven A, Gradle A, Gradle B:** deleted by February 2022. CI configs removed, executor fleets retired, repository namespaces archived.
- **Kelvin:** last repo moved in January 2022. `big-daddy-2` was retired in April 2022, after I'd left, at the end of its hold.
- **Maven B:** kept as a frozen, read-only path. Two long-term-support release lines had customer contracts requiring patches built exactly as before, and rebuilding them on Bazel would have meant re-certification. It was due to be retired when the last of those lines ended in 2023.

## What I'd do differently

- Ship the owner-facing side-by-side report with the first batch, not the third.
- Run a Gradle-B pilot of 5 repos before estimating 140. One week of pilot would have shown the cliff.
- Take the Kelvin offer back in month 3. The legitimate objection was clear by then.
