<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The $1.5M three-year deal — Harvestlane Foods, soup to nuts

Fennec Systems, 2021–2023. $1.5M TCV ($500K ACV × 3 years), 14-month cycle, nine-person buying committee. The deal that makes the deal sheet real, and the one I walk every interviewer through, because it has all three of the hard things in one account: a committee that wanted to say no, a price I refused to cut, and a pilot I proposed in an act of desperation that turned out to be the best deal-structure call of my career.

## The account

Harvestlane Foods: grocery chain, ~900 stores, $14B revenue. Their deployment story was ugly — 30+ years of homegrown ops tooling layered over a warehouse-management system nobody inside wanted to admit they still ran. Fennec's deployment-automation product fit the pain precisely; the problem was that the pain was spread across four divisions and owned by nobody with a budget line big enough to buy the fix.

## The committee, mapped

By month 6 I had all nine, with their actual objections:

| Stakeholder | Role | Real position |
|---|---|---|
| Dan M. | VP Infrastructure (champion) | Wanted this badly; owned the outage history that justified it |
| Priya S. | CFO delegate, procurement | "Show me the 3-year TCO, not the year-1 invoice" |
| Marcus O. | CTO | Indifferent — saw this as "plumbing" |
| Ellen T. | VP Stores Ops | The silent veto: if store teams felt lab rats, no |
| Robert K. | Head of Security | New to role; inherited 400 open findings; said no to everything by default |
| Amara D. | Platform Engineering lead | Liked the product, distrusted vendors on principle |
| Jorge L. | Legal counsel | Wanted unlimited liability carve-out; got a cap instead |
| Susan P. | CIO | Arms-length; had been burned by a previous "transformation" |
| Teresa N. | Divisional VP, Regions | Controlled 3 of 9 votes in practice via her regional directors |

The map mattered more than the product. Ellen's and Teresa's objections were never about features — they were about *who bears the risk of looking wrong*, and no feature demo in the world touches that.

## The cycle, by phase

- **Months 1–5, discovery and the technical sell.** Weekly working sessions with Amara's platform team; I did discovery without an SE for the first month because the architecture questions were ones I could answer, then brought the SE in to go deep. POC in a staging environment, 40 stores' worth of configs.
- **Months 6–9, the security wall.** Robert K. stalled the evaluation for ten weeks. I got him a named Fennec security engineer, a remediation doc for the 12 findings that mattered to him, and — the move that unlocked it — I got him invited into the platform working group so the fix was his story to tell. Detail in `Projects/Procurement Security Win.md`.
- **Months 10–13, the no-vote and the pilot.** At month 10 the committee leaned no: too big a bet, one vendor, unproven at their scale. Teresa's regions were the swing bloc. I proposed a **60-store pilot, 90 days, $45K, explicitly scoped to produce a go/no-go memo written by Teresa's own regional ops leads** — not by me, not by Fennec. The pilot hit its three success criteria (deployment time, rollback safety, store-manager adoption) and the go memo was theirs. The committee voted yes 6–3, with two of the three "no" votes recorded as "not yet."
- **Month 14, procurement.** Three rounds of redlines. I held price — full stop — and traded structure instead: year-1 term shortened, success criteria written into the SOW, and ramp clauses I negotiated personally because comp-structure literacy is also contract literacy (I won't sign a customer ramp I can't get paid on). Priya S. got her 3-year TCO model; I ran the analysis myself, on a call, with her analyst.

## What I actually did (vs. what the product did)

- Mapped a nine-person committee in the first 90 days and treated the two *non-technical* objectors as the real deal.
- Proposed the pilot structure that let Teresa's team own the go decision — the single highest-leverage call in the deal, and it came from reading the room, not the playbook.
- Ran the TCO model personally rather than delegating to SE or sales engineering.
- Kept the deal alive through a champion change (Dan M. got promoted out of the seat at month 11; I'd already multi-threaded to Amara and Teresa, so the deal didn't wobble).

## What went wrong that I'd do differently

- **I underestimated Robert K. by six weeks.** I read him as a checkbox and he was a voter. Cost: ten weeks of stall. Now security gets a named engagement in every deal's first month, not when they stall.
- **The pilot cost me 15% of my Q3 in discount risk I didn't need to take** — I offered $45K against a $500K ACV because I panicked at the no-vote. In hindsight $85K would have passed unchanged; I gave away margin on fear. I now price pilots against the committee's risk, not against my own.
- Dan M.'s promotion nearly became a stall because I'd let him be the single thread early. Multi-threading is now a standing rule from week 2, not a rescue move at month 11.

## Numbers I can defend

- $1.5M TCV, 14 months, 9 stakeholders, 60-store pilot, 3 rounds of redlines, zero price concession, 6–3 final vote.
- Pilot success criteria: deployment time down 61%, rollback under 4 minutes, store-manager adoption at 78% in 30 days — all measured by Teresa's ops leads, not by me.
- The deal renewed at 3 years in 2026 with a 22% expansion — the pilot's go memo is still cited internally, which is the compounding return on letting the customer own their own decision.
