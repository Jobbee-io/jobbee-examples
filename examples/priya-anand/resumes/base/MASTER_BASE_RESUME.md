<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Priya Anand

priya.anand@example.com · (555) 020-1177
Toronto, ON · github.com/example/priyaanand · linkedin.com/in/example-priyaanand

*The long record. Everything that didn't fit on one page — the decisions, the trade-offs, the numbers behind the numbers. Project files in `projects/` carry the full stories; this file indexes them.*

---

## Summary

Product leader in payments and developer platforms. Nine years as PM after four as a backend engineer; the engineer years still shape how I work — I read the code path before the roadmap slides, and I write specs engineers argue with instead of around. Took an internal API to a public developer platform (2,300 partners, 41B calls/month), expanded marketplace payments into three countries (two launched, one killed and documented), redesigned subscription pricing with an experiment I published internally when it contradicted my own hypothesis, and retired a legacy API with 4,000 dependent customers without breaking trust. Looking for Principal/Group PM roles on platform or fintech products, written-strategy cultures, and engineers who push back.

---

## Experience

### Cassline (payments infrastructure) — Principal Product Manager, Developer Platform
*Mar 2021 – present · Toronto (remote-first team)*

- Own the public developer platform: APIs, SDKs, docs, pricing, partner-facing tooling. Grew integrated partners from ~400 to **2,300** and API traffic from 6B to **41B calls/month**.
- **Platform build-vs-buy decision (2022).** Wrote the doc that chose "buy the tokenization core, build the orchestration layer" over building both. Saved an estimated 9–12 engineer-months in year one; the honest entry in the ledger is that the vendor's roadmap misaligned twice and we paid for two escalations to get what we needed. Full story: `projects/developer-api-platform.md`.
- **Retired legacy API v1** — 4,000 dependent customers, some of them whales. Ran the migration program (deprecation runway, migration tooling, office hours, dedicated big-account plans) to a zero-incident cutover; the one whale we nearly lost, I called myself. Full story: `projects/api-sunset-legacy-v1.md`.
- Designed the usage-based pricing model for API consumption, replacing flat tiers. Revenue on metered plans grew 34% in the first year; churn on the largest tier went *up* briefly during the transition, which I consider a data point in favor of honesty in pricing comms, and which I wrote up as such.
- Recruited and managed three PMs; two promoted. I measure my management by whether the team writes decisions down when I'm not in the room — they do.

**Influence note (read before quoting my numbers):** the traffic and partner numbers are the platform's, not mine alone. What I own is the strategy, the pricing model, the deprecation program, and the roadmap decisions that produced them. PM numbers are team numbers the PM made more likely.

### Cartway (marketplace platform) — Senior Product Manager → Lead PM, Seller Payments
*Sep 2017 – Feb 2021 · Toronto → hybrid*

- Led seller payments product for the marketplace (11,000 active sellers at peak). Owned payout timing, risk holds, and the seller money experience end to end.
- **Three-country expansion (2018–2020):** Canada and the UK launched; **Germany was killed** at the pilot stage when the licensing timeline made the unit economics not close. Writing the kill memo was the most useful document I produced that year — it became the template the org used for two later sunset decisions. Full story: `projects/payments-marketplace-expansion.md`.
- **Subscription pricing redesign for seller tooling (2020):** my hypothesis — that sellers would pay for analytics tiers — lost to the experiment. The winning structure bundled analytics into the base plan and priced on automation. Full story and the A/B numbers: `projects/subscription-pricing-redesign.md`.
- Promoted to Lead PM (2019) with no direct reports — scoped to lead the payments PM group's planning and hold the cross-team roadmap. The highest-leverage thing I did in the role: the weekly written decisions log that replaced a meeting nobody loved.

### Ferroline Systems (logistics software) — Product Manager, Internal Tools
*Jul 2015 – Aug 2017 · Toronto*

- Built the internal platform product that became company standard: shipment exception tooling adopted by 14 ops teams, replacing per-team spreadsheets and one heroic Access database. Classic influence-without-authority grind — I had no authority and eventually had everyone's data model. Full story: `projects/zero-to-one-internal-tooling.md`.
- This is where I learned the 0→1 craft: pilot with one skeptical team, expand on proof, never demo before the tool survives a realistic failure.

### Ferroline Systems — Backend Engineer, Integrations
*Jun 2012 – Jun 2015 · Toronto*

- Four years writing the integration layer: carrier EDI feeds, webhook fan-out, retry queues. The kind of code where a bad retry loop shows up as someone's missing shipment.
- Wrote the internal API style guide that outlived me by years — the first document I ever wrote that people followed when I wasn't in the room.

**Why the engineer years are on here:** because "started as a backend engineer" is not decoration — it's why I spec idempotency keys into product requirements and why partner engineers take my API versioning docs seriously.

### Braeburn School of Business — MBA, product strategy concentration
*2013 – 2015, part-time evening program while engineering*

- Chose the evening program over quitting to study: kept the salary, paid the tuition, slept less. Strategy coursework applied the week it was taught — my capstone was the pricing analysis that got me moved onto the internal-tools PM track.

---

## Decisions I'll defend in an interview

- **Pricing model choice (usage-based vs. flat tiers):** chose usage-based for the developer platform. The debate was real — flat tiers are easier to sell and forecast. I chose metering because API value scales with usage and flat tiers tax our best customers least. Defended it to the CFO with cohort curves; happy to redo the analysis on a whiteboard.
- **Platform build-vs-buy:** bought the commodity core, built the differentiating layer. The doc is `projects/developer-api-platform.md`; the vendor roadmap friction is in there too.
- **The Germany kill:** launching into a market to hit an expansion goal is how you get a market you can't serve. The licensing math didn't close; we killed it while the sunk cost was still small.
- **The v1 sunset:** deprecated on a published schedule with migration tooling rather than running two API versions forever. The trust cost of forced migration is real; the trust cost of an API that never dies is worse.

## A failure, indexed honestly

**The partner pricing launch that got walked back (2023).** I shipped usage-based pricing for a mid-tier segment with a grandfathering window I set at 60 days. It was too short: 18% of the segment churned or downgraded, several in writing citing the window, not the price. We extended grandfathering to 12 months and the cohort stabilized, but the churn was real and it happened on my call. What I changed: pricing migrations now get a 90-day minimum observation window before final terms lock, and I no longer set grandfathering windows by feel. The lesson wasn't "usage pricing is risky" — it was "the transition is the product."

## Leadership — influence-shaped, honestly

- Three PMs managed at Cassline, two promoted; before that, two years leading a PM group with zero reports, which is its own skill and I can describe exactly how it worked.
- The numbers I quote are platform numbers; my contribution is the strategy, the calls, and the written artifacts that made the team's work compound. I say this because PM resumes that claim org-level numbers as personal output get (deservedly) grilled in interviews, and I'd rather set the record straight here.

---

## Numbers I can defend

- 2,300 integrated partners, 41B API calls/month on the developer platform (grew from ~400 partners / 6B calls).
- Legacy v1 API sunset: 4,000 dependent customers, zero-incident cutover, 94% migrated before the hard date.
- Pricing: metered-plan revenue +34% year one; the walked-back launch's 18% segment churn — both numbers, in the same list, on purpose.
- Three-country payments expansion: 2 launched (CA, UK), 1 killed (DE) with the kill memo as org template.
- 11,000 active sellers on Cartway payments; payout timing redesign cut "where is my money" support tickets 41%.
- 14 ops teams adopted the exception tooling at Ferroline; the Access database is dead and buried.

## Education

- **MBA, Braeburn School of Business** — product strategy concentration, evening program, 2013–2015.
- **BS Computer Science, Halden University** — 2008–2012. The distributed-systems coursework aged well.

## Skills

Product: platform strategy, API product management, pricing and packaging, payments/marketplace mechanics, regulatory navigation (money-transmitter licensing timelines), 0→1 and scale, deprecation/migration programs, PM hiring and development.
Working knowledge (from the engineer years, kept current by use): TypeScript and Python for prototypes and internal tools, SQL, REST and webhook design, the fun parts of distributed systems and none of the pager.

## The record, indexed

For anyone reading this before a conversation, the full files this resume summarizes — each one written when the work ended, not when the search started:

- `projects/developer-api-platform.md` — the strategy doc, the pricing design and defense, the build-vs-buy ledger, the versioning war, and the walk-back I own.
- `projects/payments-marketplace-expansion.md` — CA/UK launches, the FCA/safeguarding surface, and the Germany kill memo that became the org's sunset template.
- `projects/subscription-pricing-redesign.md` — the pre-registered hypothesis I lost, the A/B that beat it, and the memo format it created.
- `projects/api-sunset-legacy-v1.md` — the 4,000-customer deprecation program, the numbers, and the whale.
- `projects/zero-to-one-internal-tooling.md` — the internal platform product, team by team, and the mechanics of adoption without authority.

The pattern across all five: every file contains at least one thing I got wrong and the number that proved it. That's deliberate. A record you only put wins in stops being usable as evidence, and the whole point of keeping files like these is that they're evidence.

## How I work

- Docs before decks, decisions written where people can argue with them, arguments conducted with data or not conducted.
- I hold a monthly 30 minutes with each team lead I serve — forever, not for the launch. Adoption is measured in "when did you last open the old spreadsheet," not license counts.
- Pricing and deprecation decisions get pre-registered criteria where they can have them; grandfathering windows get data, never feel.
- I'd rather ship the losing-hypothesis memo than the winning-launch deck. The memo compounds; the deck expires.

## Contact

priya.anand@example.com · (555) 020-1177 · github.com/example/priyaanand (personal tooling and one unmaintained but beloved CLI) · linkedin.com/in/example-priyaanand
