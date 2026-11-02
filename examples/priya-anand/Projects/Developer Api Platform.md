<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Developer API platform — from internal API to public platform

Cassline, March 2021 to now. I inherited a well-liked internal payments API and turned it into the company's public developer platform. The resume has the headline numbers. This file has the strategy doc and who argued with it, the build-vs-buy call and its honest ledger, the pricing model and its defense, the walk-back I own, the versioning policy I lost an argument about, and what is still unsolved. The v1 retirement is its own file: `Projects/Api Sunset Legacy V1.md`.

## Starting point (March 2021)

- About 400 integrated partners and 6B API calls a month. Most partners came in through sales. Integration support ran in one Slack channel per partner.
- Reference pages only. No guides, no sandbox you could open without a contract, and API keys were issued by hand. Median time from contract signature to first successful sandbox call: 9 days.
- Three flat tiers: $500, $2,000 and $10,000 a month. Nothing below enterprise terms for anyone who wanted to try first.
- 24 platform engineers in 4 teams, no docs owner, and me as the only PM.
- Engineering had asked for a real platform investment for two years. The roadmap kept saying no, because the API had no story finance could forecast.

## The strategy doc that got funded

June 2021, 6 pages, three claims:

1. **The API was already the product** for a class of customers we served badly: mid-market fintechs who integrate once and then scale quietly. They buy by trying, not by taking sales calls. Of our ~60 mid-market accounts, 41 had started as a developer emailing support to ask for a sandbox key.
2. **Self-serve onboarding plus usage pricing** would grow that segment without proportional headcount, because integration cost, not price, was the barrier. In 12 months of lost-deal notes, "time to integrate" was cited 3 times as often as price.
3. **Buy a tokenization core, build the orchestration layer.** Don't build both.

The ask: 11 more engineers (24 to 35) over 18 months, a docs lead and 2 developer advocates.

The doc was argued with for three weeks. That is how I knew it was any good.

- Finance challenged the forecast. My base case was 1,100 partners by the end of 2023. Finance cut my revenue line by 30% and funded against their number, not mine. I agreed: it made the plan survivable if I was wrong. Actual at the end of 2023 was about 1,400 partners.
- The infra lead challenged build-vs-buy (below).
- Sales challenged the self-serve premise with two real counterexamples. One became part of the plan: a white-glove lane for regulated partners (banks and licensed money transmitters), who need a named contact and a due-diligence pack whatever the docs say. About 1 in 12 new partners still goes through it. The other was a single account whose procurement team required a paper contract. It turned out to be an edge case, now handled with an order form.

Funded in July 2021.

## What shipped, in order

- Q4 2021: public guides, an open sandbox, instant sandbox keys.
- February 2022: the build-vs-buy decision record signed off.
- June 2022: v2 generally available: scoped keys, an idempotency contract on every write endpoint, one error format. Production access through automated business verification, median 2 business days. A payments platform can't be fully self-serve in production, and pretending otherwise is how you onboard fraud.
- July 2022: usage-based pricing for new partners.
- September 2022: the tokenization vendor live in production.
- January 2023: existing $2,000-tier partners moved to metered pricing (the walk-back, below).
- April 2023: v1 sunset announced.
- November 2023: versioning policy final. First dated version in January 2024.

## Build-vs-buy, in detail

The two layers:

- The tokenization core vaults card and bank credentials. It is a commodity function with brutal compliance requirements: PCI DSS scope, key management, yearly audits.
- The orchestration layer is routing, retries, idempotency semantics and the contract we make with partners about all three. That is where our differentiation lives.

The options, with engineering's estimates, which I reviewed line by line with the infra lead:

- **Build both.** About 14 engineer-months to build the vault, about 2 engineers ongoing to keep it certified, and PCI scope spreading across most of the platform. Rejected: our scarcest people on the part customers never see.
- **Buy both.** Orchestration vendors existed. Rejected: the idempotency contract and retry semantics are what partners integrate against. Outsource them and the vendor's roadmap becomes our API.
- **Buy the core, build orchestration.** Chosen. Estimated 9–12 engineer-months saved in year one, and the compliance surface is the vendor's to keep certified.

The infra lead's objection was that a vendor in the money path is a vendor in every incident. He was right. We settled it with a thin abstraction over the vault: our own token format, mapped to the vendor's, so a second vendor could be added without partners noticing. It cost about 2 engineer-months. The decision record puts the exit cost at about 6 months of migration work.

**The honest ledger on the buy.** The vendor's roadmap misaligned with ours twice:

1. Q4 2022: their network-token support slipped two quarters past a date we had committed to two partners. We built a wrapper ourselves: about 3 engineer-weeks, and we still maintain it.
2. Mid-2023: they planned to retire an endpoint our bank-credential vaulting depended on, with 6 months' notice. We escalated under the contract's roadmap clause and paid for a priority tier ($90K a year) to get a 12-month extension and a seat in their roadmap reviews.

I'd still make the call. The savings were real. But the decision record underplayed the ongoing cost of keeping two roadmaps aligned. The version I'd write today has a section on it: who on our side owns the vendor roadmap, how often we review it, and the exit-cost estimate, refreshed every year.

## Pricing: the design and the argument

The flat tiers taxed our best partners least. A partner at 500M calls a month and a partner at 5M calls could both sit on the $10,000 tier.

Options considered:

- Keep tiers, add a fourth. Easy to sell, easy to forecast. Rejected: it moves the cliff instead of removing it.
- Pure per-call metering. Rejected by finance on predictability. Fair.
- A revenue share on payment volume. Rejected: partners already pay processing fees on volume. In 5 of 6 customer interviews where we tested it, a second fee on the same base read as double-charging.
- Per-call bands with volume discounts, plus a platform fee: chosen.

Before proposing it, I modeled the bill for every partner active in Q4 2021, about 600, on 12 months of their own call logs (annualized for newer partners). 71% would pay less or the same. The top decile paid more, which was the point.

The CFO's objection was revenue predictability, and it was fair. The compromise: annual commitments with metered overage. Enterprise buyers wanted that structure anyway, and it gave finance a committed number to forecast.

Results, with definitions:

- Metered-plan revenue +34% in year one. Same-partner basis: for each pre-existing partner, API revenue (platform fee, commitment and overage) in its first 12 months on a metered plan, against its last 12 months on a flat tier. New partners are excluded. Including them makes the number bigger and less useful.
- Mid-market accounts grew from ~60 to ~700 between the June 2022 launch and mid-2024. Mid-market here means partners processing $10M–$500M a year through us.
- Churn on the largest tier went up, briefly. Monthly logo churn on the old $10,000 tier went from 1.1% to 2.4% for two quarters while those partners moved, then returned to baseline. These were the partners paying more. Most stayed because the commitment discount was larger than the increase, and I'd told them the increase in writing, with their own numbers, before the change.

## The walk-back I own

January 2023. I moved the 146 partners on the old $2,000 tier to metered pricing with a 60-day grandfathering window. I set 60 days by feel.

26 of the 146 (18%) churned or downgraded within 90 days of the announcement. Several said in writing that the window, not the price, was the reason. 60 days is shorter than many partners' budget cycle, and shorter than the time it takes them to re-forecast their own usage.

In March 2023 we extended grandfathering to 12 months for everyone still in the segment. The cohort stabilized, and churn in the segment was back to baseline within two quarters. 4 of the 26 came back within a year.

What changed: pricing migrations now run a 90-day observation window on a sample before final terms lock, and grandfathering windows are set from data (budget cycles, contract renewal dates), never by feel. The lesson was not "usage pricing is risky." It was that the transition is the product. It went straight into the design of the v1 sunset, announced the next month.

## The versioning policy (the argument I lost)

v1 had no policy beyond "supported basically forever," which is how it reached 4,000 dependent customers. v2 shipped in June 2022 under a single `/v2/` path, and by 2023 it needed a policy before it repeated v1's history.

The positions:

- Engineering: strict semver, 12-month deprecation windows.
- Sales: partners would revolt at forced migrations; support every version as long as anyone uses it.
- Me: date-based versions and 12-month windows, to keep the live surface small.

Engineering and sales were each half right. What shipped in November 2023:

- Date-based versions (`/v2024-01/...`). A partner pins a date, and the end of support is computable from it. Semver's "major" meant nothing to partners. Additive changes (new fields, new endpoints) ship without a new version. Anything that can break a correct integration needs a new dated version. `/v2/` became an alias for `/v2024-01/`.
- 18 months minimum support per version, on a published schedule.
- `Deprecation` and `Sunset` headers from the day a version is deprecated.
- A contractual carve-out only for enterprise contracts signed before the policy.

The argument I lost was the window. By November 2023, seven months into the v1 runway, about 1,500 v1 accounts had finished migrating. Median time from first engagement (first visit to the migration guide, or first reply to outreach) to last v1 call was 3.5 months for self-serve accounts and 8 months for assisted ones. Fitting each segment's curve forward, the slowest tenth of assisted and managed accounts would finish around month 15 or 16. A 12-month window would have cut off the accounts with the most money moving through us.

I rewrote the policy doc myself to say 18 months, with the curves in it. I say "I was wrong about the window" in interviews, because the fix came from evidence, not seniority.

## Where it stands (Q3 2026)

- 2,300 integrated partners, from about 400. An integrated partner is an account with at least one successful production call in the last 30 days. The ~400 at my start is back-filled from logs with the same definition.
- 41B API calls a month, from 6B. All authenticated production requests, all status codes, trailing 30 days.
- Median time to first successful API call: 40 minutes self-serve, from 9 days sales-assisted. Measured from account creation (contract signature on the old path) to the first 2xx response in the sandbox, median over the trailing quarter.
- 35 platform engineers in 5 teams, a docs lead, 2 developer advocates, and 3 PMs I recruited, two of them since promoted.
- The written strategy is on version 4, and version 4 got argued with too, which is the review I actually want.

## Second-order effects, and what isn't solved

- The long tail is cheap to acquire, not cheap to serve. About 1,400 of the 2,300 partners are small. They bring about 6% of API revenue and about 40% of support tickets. Better error messages and docs moved the ratio; they didn't fix it. It is the main open question in strategy version 4.
- The vendor dependency is managed, not solved. The abstraction layer exists; no second vault vendor has been integrated yet.
- Version count. We release a dated version about twice a year, so 3 or 4 are live at any time. Each one adds test-matrix time across every SDK language. The policy made the cost visible. It didn't make it small.

## What I'd claim vs. what the team did

The numbers are the platform's. Mine: the strategy doc and its revisions, the pricing model and its defense to the CFO, the build-vs-buy call, the versioning policy, the deprecation program, and the walk-back. Engineering built the platform. The docs lead and the developer advocates built the onboarding that produced the 40 minutes. Finance co-designed the commitment structure. A platform PM's job is to make the team's numbers possible, not to be the number.
