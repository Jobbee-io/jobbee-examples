<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Demo environment rebuild

Cairnwatch, SE organization (34 SEs worldwide). Proposed in January 2023, in use by July 2023, handed to a rotating group of SEs in January 2024. On my resume it's one bullet: demos logged with an environment problem fell from 14% to 2%. It wasn't my job. I did it next to a full deal load.

## What was wrong

Every SE demoed from one shared demo tenant fed by a synthetic data generator. The data was too clean: metrics moved in perfect waves, traces had no real service calls behind them, and logs repeated every few minutes. Engineers in the audience noticed. It also broke. After each live demo, SEs fill in a short form, and one field is "environment problem": an empty view, stale data or a broken link during the demo. In Q4 2022 that box was checked on 61 of 436 logged demos, 14%. 2 of those were mine, in front of VPs, and one cost a second meeting.

## What I built

A real application to demo against. Pantrylane is a fictional grocery-delivery app: 22 services in Go, Java, Python and Node, instrumented with OpenTelemetry, with a load generator that follows daily and weekly shopping patterns. It has 9 failure scenarios behind feature flags, such as a bad deploy, a slow database query, a memory leak, a payment provider timing out and Kafka consumer lag. An SE turns one on mid-demo and shows the platform finding it.

Each SE gets their own copy in a namespace on a shared Kubernetes cluster, created with Terraform and Helm in about 15 minutes. Copies reset at 03:00 Pacific every night, so nobody inherits someone else's broken state.

## My role

I wrote the proposal and the design, and about 60% of the code: the order, payment and inventory services, the load generator and the flag system. 3 SEs gave one day a week each for 2 months, mostly on the Java and Node services and the scenario scripts. A platform engineer was lent to us for 6 weeks for the cluster and the Terraform. SE leadership approved $6K a month for cloud costs. I spent about one day a week on it for 6 months, plus more evenings than I'd like.

## Decisions and why

- A real app instead of better synthetic data: buyers are engineers, and engineers can tell. A real call graph also lets a demo answer questions nobody scripted.
- One copy per SE instead of a shared tenant: one SE's experiment can't break another SE's demo.
- A nightly reset: a clean start every morning mattered more than keeping changes. That choice hurt once (below).
- Plain feature flags instead of a chaos-engineering tool: SEs needed one switch they could flip while talking.

## The numbers, and their definitions

- Environment-problem rate, from the post-demo form: 61 of 436 demos (14%) in Q4 2022, 11 of 552 (2%) in the second half of 2023.
- Prep time for a prospect-specific scenario: about 2 days to about 3 hours, median. Self-reported in a survey I ran in late 2023 with 19 responses, so it's a rough number.
- Adoption: 29 of 34 SEs had run at least one customer demo on it by the end of Q3 2023.
- Cost: about $5,400 a month at full adoption, under the $6K budget.
- It served as the reference app in 6 POCs, to show failure scenarios in the first week before the prospect's own data arrived.

## What went wrong

- The nightly reset wiped an SE's customized copy the night before a large demo, and she lost a day of prep. I added a pin flag that skips the reset for up to 7 days. I should have asked SEs how they prepare before choosing the reset rule.
- I built too many scenarios. The flag logs showed that 3 of the 9 (the bad deploy, the slow query and the payment timeout) were used in about 80% of demos. The other 6 still needed upkeep. I retired 3 of them in 2024.
- I was the only maintainer for 5 months. In December 2023 a dependency update broke the Node service build the week before quarter-end, and I fixed it on a weekend. In January 2024 I handed it to a group of 4 SEs who rotate ownership each quarter, with a runbook.
- The docs came last, after the second person asked me the same question.

## What I'd do differently

- Put the hand-off and the docs in the plan from day one.
- Start with 3 scenarios and add more only when the flag logs ask for them.
- Interview 5 SEs about how they prepare before designing the reset rule.
