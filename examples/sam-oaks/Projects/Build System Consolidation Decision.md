<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Build system consolidation: the decision

Companion to `Build System Consolidation.md`. This file covers February and March 2021: how the division chose one build system, the options doc I wrote, the scoring, and the two escalation rounds it took to make the choice stick. Wanting one build system was easy. Getting 800 engineers to accept a specific one was the real work, so I made the decision process the deliverable.

## The full story

In February 2021 the division had five build systems, and 62% of engineers said they'd lost at least a day to build problems in the last quarter. Everyone wanted one system. Nobody agreed on which. I spent three weeks writing the options doc alone: an inventory of all 650 repos, production numbers for Maven, Gradle and Bazel from inside Grousemont, and the two counter-proposals in their authors' own words. I also scored all three options myself, and that was my mistake. Round 1 with the division VP, in mid-March, became an argument about my scores, and he sent the doc to the CTO's review instead of deciding. I added the sensitivity analysis after that round. At the end of March the CTO accepted Bazel in front of both counter-proposal authors, with three conditions.

What the decision left open went straight into the migration. My Bazel estimate leaned on a transpiler I hadn't built yet, and on Gradle B behaving like the other trees, which it didn't. The learning-curve objection stayed live until the six-month check in September showed the "lost a day" number down to 38%. And at the batch-plan review at the end of March, Kelvin's author, whose deploy-step objection this doc never addressed, blocked his 75 repos. Both stories are in `Build System Consolidation Migration.md`. One part of the learning curve was still open when I left in March 2022: Bazel knowledge sat with 4 people, and anything off the common path still went to them.

## What went into the doc

- An inventory of all 650 repos: build tool and version, plugins used, build times from CI telemetry, and the dependency graph between repos (about 70 dependencies crossed from one tree to another).
- The Q4 2020 survey (62% had lost at least a day to build problems).
- Production data from inside Grousemont, which is why there was no bake-off (below).

## The candidates

Five at the start: Maven, Gradle, Bazel, Pants and Buck. Pants and Buck were screened out in the first pass. Pants was strongest for Python and our estate was about 90% JVM. Buck had a small outside community for JVM work in 2021, which mattered for hiring and help.

That left three, and all three already ran in production at Grousemont: Maven and Gradle in our division, and Bazel in the infrastructure division (about 300 engineers, 4 years in). So each could be scored on real numbers from our own company.

## The two counter-proposals

- **Standardize on Gradle,** from the architect who owned Gradle tree A. Extend his tree's conventions to everyone and use Gradle's build cache. The strongest alternative.
- **Standardize on Maven,** from the architect behind Maven tree A. Upgrade the plugins, share one repository manager. The least migration for the 340 Maven repos.

Both were in the doc as named proposals with their authors' own arguments, next to mine.

## Why no bake-off

A bake-off would have taken 6 to 8 weeks, and it would have re-argued team loyalties instead of producing new information. We already had production numbers for all three: the infrastructure division's Bazel builds had a clean-build p50 of about 6 minutes with an 85% remote-cache hit rate; Gradle tree A, with Gradle's build cache, had a p50 of about 12 minutes and a hit rate around 55% (many of its tasks weren't hermetic, so their outputs couldn't be shared); the Maven trees ran 28 to 31 minutes. The doc was the contest. Once it closed, the rest was logistics.

## The scoring

Six criteria, scored 1 to 5, with these weights:

| Criterion | Weight | Maven | Gradle | Bazel |
|---|---|---|---|---|
| Cache architecture and CI cost | 25% | 1 | 3 | 5 |
| Build time | 20% | 1 | 3 | 5 |
| Migration cost | 20% | 4 | 3 | 2 |
| Onboarding and learning curve | 15% | 4 | 4 | 2 |
| Escape hatches for custom logic | 10% | 3 | 4 | 3 |
| Support and hiring | 10% | 4 | 4 | 4 |
| **Weighted total** | | **2.55** | **3.35** | **3.65** |

What the scores rested on:

- **Migration cost** in engineer-weeks: Maven about 60 (moving the Gradle and Kelvin repos), Gradle about 95, Bazel about 140 by hand. A transpiler for the Maven trees brought my Bazel estimate to about 90, and that is where the transpiler came from. The real Gradle-B work later blew past my estimate (see the migration file).
- **Learning curve:** the infrastructure division said new hires took about 3 weeks to be comfortable with Bazel. That was the loudest objection: "you're replacing tools people know with one nobody here knows." My answer was golden-path templates and one doc, and a commitment to measure.
- **Support:** the infrastructure division's Bazel team agreed to share their remote-cache design and act as escalation for it.

**The sensitivity I published.** If learning curve is weighted 30% and cache 10%, Gradle wins, 3.5 to 3.2. So the decision came down to one judgment: was the division's main cost CI time and spend, or ramp-up time? I argued CI, with the numbers: 26-minute builds hit every engineer every day, while the learning curve hit each engineer once. I put that sentence in the doc's first paragraph so nobody had to find the weighting on page 6.

## Two escalation rounds

**Round 1, the division VP (mid-March).** He asked for a bake-off. I declined and asked for a decision on the doc as written, because a bake-off would delay the choice without changing the data. He sent it to the CTO's architecture review instead of deciding. Fair; it was bigger than one division's budget.

**Round 2, the CTO's architecture review (end of March).** The CTO accepted Bazel in the review, in front of both counter-proposal authors, with three conditions:

1. The Gradle-A architect owns the golden-path templates for new repos. His tree had the best conventions, and this gave him a real stake in the result.
2. A six-month onboarding check: if the "lost a day" number got worse, we'd stop starting new trees and revisit. At six months (September 2021) it had fallen from 62% to 38%, mid-migration.
3. We run our own remote cache on the infrastructure division's design, with their team as escalation.

The public acceptance mattered more than the decision itself. Every later "why Bazel?" question could be answered with a link instead of a meeting.

## What I'd do differently

- **Have each author score their own option.** I wrote the doc alone for 3 weeks, and round 1 was really an argument about my scores for Gradle and Maven. Co-written scores would have moved the argument to the weights, where it belonged.
- **Lead with the sensitivity.** I added it after round 1. It's the most honest part of the doc, because it shows exactly which judgment the decision rests on.
- **Ask for the CTO review first.** The VP was always going to send it up. Going straight to the review would have saved about 2 weeks.
