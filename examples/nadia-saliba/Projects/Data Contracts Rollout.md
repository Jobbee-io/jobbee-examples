<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Data contracts rollout

Pennacott Home, June 2025 to February 2026. I proposed it, designed it and ran it. It was unfinished when I was laid off: 31 of 40 planned contracts in place. On my resume it's one bullet. It's also my real answer to "how do you handle upstream changes you don't control?". This file holds what a contract meant for us, how the checks work, how teams adopted it, what the numbers mean, and where I went wrong.

## Why

In 2024 we had 23 data incidents caused by changes upstream. A service team changed something in their database or their events, and a model or dashboard downstream broke or, worse, kept running with wrong numbers. Three examples from my proposal:

- `discount_amount` changed from cents to dollars in a release. Promo reporting was off by 100x for 4 days.
- A new order status, `PARTIAL_REFUND`, appeared. Our models treated it as a full refund, and net revenue was understated by about $310K for a week.
- A column rename broke the nightly load. That one was at least loud.

The median time from the change to someone noticing was 2.5 days, and the someone was usually an analyst who knew what the number should be. The streaming pipeline had already shown me the fix: agree the shape of the data with the team that produces it, before the change ships.

## What a contract was

- For Kafka topics: an Avro schema in Schema Registry with `BACKWARD_TRANSITIVE` compatibility, checked in the producer's CI.
- For database tables we read through CDC: a short YAML file in the producer's repo. It lists the columns we consume, their types and units, the allowed values for status fields, whether they can be null, the owning team, and the freshness we expect.
- On our side: dbt tests generated from the same file, plus freshness checks.
- Breaking changes are still allowed, with 14 days' notice and the new version running next to the old one.

## How the checks work

In the producer's repo, a CI job starts an empty Postgres, applies every migration, reads the resulting schema and compares it with the YAML. A removed column, a changed type or a column that becomes nullable fails the build. So does a new value in a status field that the contract lists, which is the `PARTIAL_REFUND` case. A schema can't show units, so units are checked on our side by the generated dbt tests, with range rules like "discount is never larger than the order subtotal".

A failed check has two ways out: change the migration, or bump the contract version. A new version means the producer writes the old and new shapes side by side for at least 14 days while we move our models, and then drops the old one.

## My role

I wrote the proposal, the contract format, the producer CI check and the rollout plan, and I sat with each producer team to write their first contract. A staff engineer on the platform team sponsored it with engineering leadership. The analytics engineering lead co-owned the dbt test generator and set test severity with me. Nine producer teams did the work in their own repos.

## How it went

I started with the order service team, who knew the idea from the streaming pipeline, then went down the list by revenue impact: payments, catalog, inventory, returns. Each team got one 90-minute session. We wrote the contract together from what downstream actually used, and they merged it in their own repo.

The rule that made it work: a contract covers only the columns someone downstream consumes. We found those from dbt lineage and query history. That cut a typical contract from about 40 columns to about 12.

## The numbers

- Contracts: 31 across 9 producer teams by February 2026. 30 of them cover sources of revenue reporting: 30 of the 38 tables and topics it reads from, about 80%.
- Breaking changes blocked in producer CI before merge: 12, from August 2025 to February 2026. 7 were fixed in the same pull request once the engineer saw what they would break. 5 shipped as a new contract version.
- Data incidents caused by upstream changes: 7 in Q1 2025, 2 in Q4 2025. Both Q4 incidents came from a team without a contract (below).
- Median time to detect, for incidents our contract tests caught: 2.5 days → 35 minutes.
- Generated dbt tests: 1,400 at launch, 520 after pruning.

## What went wrong

- I wrote version 1 of the format alone. It asked for every column, with units and descriptions. The first two producer teams said no, politely, and they were right. Version 2, built from lineage, took me another 3 weeks. I should have written version 1 with the order service team in the room.
- I turned on all 1,400 generated tests at once. The alert channel got about 300 warnings a day, and analysts muted it within a week. We split the tests into three tiers (stops the pipeline, pages someone, weekly digest), agreed which tier each belonged in, and deleted most of the rest.
- The pricing team declined to join, and I let it go to avoid a fight. Their promo price field went null twice in Q4 2025, and both times promo reporting was wrong for a day. I escalated after the second incident. I should have escalated when they said no.
- The layoff ended it with 9 contracts left. The CI checks still run. As far as I know, nobody owns the program now.

## What I'd do differently

- Write the format with the first producer team, not for them.
- Agree the severity tiers before turning on a single alert.
- Ask leadership on day one for one rule: any new table on the revenue path needs a contract before launch.
