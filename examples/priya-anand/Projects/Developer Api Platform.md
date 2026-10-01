<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Developer API platform — from internal API to public platform

Cassline, 2021–present. I inherited a well-liked internal payments API and turned it into the company's public developer platform. This is the story of the strategy, the pricing, and the versioning war that taught me most of what I know about API products.

## Starting point

When I took the platform, the API was "internal-plus": about 400 partners integrated, most of them introduced by sales, with integration support happening in individual Slack channels. No public docs beyond reference pages, no self-serve onboarding, no pricing below the enterprise tier. Engineering had been asking for a real platform investment for two years; the roadmap had other plans because the API didn't have a story that finance could forecast.

## The strategy doc that got funded

I wrote a 6-page doc with three claims:

1. **The API was already the product** for a class of customers we were serving badly — mid-market fintechs who integrated once and scaled quietly. Sales-led motion didn't fit their buying pattern.
2. **Self-serve + usage pricing** would grow the mid-market segment without proportional headcount, because integration cost — not price — was the barrier.
3. **We should buy a tokenization core and build the orchestration layer**, not build both.

The doc got argued with for three weeks, which is how I knew it was any good. Finance challenged the forecast; the infra lead challenged the build-vs-buy; sales challenged the self-serve premise with two real counterexamples, one of which I folded into the plan (a white-glove lane for regulated partners) and one of which turned out to be an edge case.

## Build-vs-buy, in detail

The tokenization core — vaulting card and bank credentials — is a commodity with brutal compliance requirements. The orchestration layer — routing, retries, idempotency semantics, our idempotency contract with partners — is where our differentiation lives.

**The honest ledger on the buy:** the vendor's roadmap misaligned with ours twice. The first time we shipped a wrapper; the second time we escalated contractually and paid for priority. Net-net I'd still make the call — 9–12 engineer-months saved in year one, and the compliance surface is someone else's to keep certified — but the doc underplayed ongoing roadmap-alignment cost, and the version I'd write today has a whole section on it.

## Pricing: the design and the argument

Replaced flat tiers ($500/$2,000/$10,000 per month, which taxed our best partners least) with usage-based metering: per-API-call bands with volume discounts, plus platform fee.

- Modeled partner bill distribution before proposing: 71% would pay less or the same; the top decile paid more, which was the point.
- The CFO's objection was revenue predictability, and it was fair. The compromise: annual commitments with metered overage, which is what enterprise buyers wanted anyway.
- Result: metered-plan revenue **+34% in year one**; the mid-market segment grew from ~60 to ~700 accounts.

**The walk-back I own:** the first pricing migration set a 60-day grandfathering window for an existing mid-tier segment. 18% churned or downgraded — in writing, citing the window, not the price. We extended to 12 months and the cohort stabilized. The lesson: the transition is the product. I'll never again set a grandfathering window by feel.

## The versioning war (my favorite scar)

By 2023, v1 of the public API was 4,000 dependent customers deep (see `Projects/Api Sunset Legacy V1.md` for that program). The war was about v2's **versioning and deprecation policy** — because v1's policy was "we'll support it basically forever," which is how you get 4,000 dependents in the first place.

- Engineering proposed strict semver with 12-month deprecation windows. Sales said partners would revolt. Both were half right.
- What shipped: versioned-by-date paths (`/v2024-01/...`), 18-month minimum support per version, published deprecation schedule, and a contractual carve-out only for enterprise contracts signed before the policy.
- The argument I lost: I wanted 12-month windows to keep the surface small. The data from the v1 migration said 18 months was what migration curves actually needed for the long tail. I updated the doc and I say "I was wrong about the window" in interviews, because the fix came from evidence, not seniority.

## Where it stands

- 2,300 integrated partners, 41B API calls/month (from ~400 and 6B).
- Self-serve onboarding: median time-to-first-successful-API-call down from 9 days (sales-assisted) to 40 minutes.
- The written strategy is on version 4, and version 4 got argued with too, which is the review I actually want.

## What I'd claim vs. what the team did

The numbers are the platform's. Mine: the strategy doc, the pricing model and its defense, the build-vs-buy call, the versioning policy, the deprecation program. A platform PM's job is to make the team's numbers possible, not to be the number.
