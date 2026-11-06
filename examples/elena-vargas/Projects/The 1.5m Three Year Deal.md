<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The $1.5M three-year deal — Harvestlane Foods, soup to nuts

Fennec Systems, December 2021 to January 2023, renewed in January 2026. $1.5M TCV ($500K average ACV × 3 years), a 14-month cycle, a nine-person buying committee. It has all three hard things in one account: a committee that wanted to say no, a price I refused to cut, and a pilot I proposed when the deal was about to die. This file has the committee map, the cycle month by month, the options I had at the no-vote, the pilot design and its numbers, the procurement trades, and what I got wrong.

## The account

Harvestlane Foods: a grocery chain with about 900 stores and $14B of revenue. Their deployment story was ugly: 30+ years of homegrown ops tooling layered over a warehouse-management system nobody inside wanted to admit they still ran. Every change to store systems went out by hand, region by region.

Harvestlane came out of my coverage plan, not inbound (`Projects/Turnaround Territory.md`). It was a tier-1 target because of a public signal: a 2021 holiday-weekend outage in store systems that their own postmortem traced to a bad deployment.

Fennec's deployment-automation product fit the pain precisely. The problem was that the pain was spread across four divisions and owned by nobody with a budget line big enough to buy the fix.

## The committee, mapped

I had named all nine by day 90. By month 6 I had each one's real position:

| Stakeholder | Role | Real position |
|---|---|---|
| Dan M. | VP Infrastructure (champion) | Wanted this badly; owned the outage history that justified it |
| Priya S. | CFO delegate, procurement | "Show me the 3-year TCO, not the year-1 invoice" |
| Marcus O. | CTO | Indifferent; saw this as plumbing |
| Ellen T. | VP Stores Ops | The silent veto: if store teams felt like lab rats, no |
| Robert K. | Head of Security | New to the role; inherited 400 open findings; said no to everything by default |
| Amara D. | Platform Engineering lead | Liked the product, distrusted vendors on principle |
| Jorge L. | Legal counsel | Wanted unlimited liability for data breaches; got a cap instead |
| Susan P. | CIO | Arm's length; had been burned by a previous "transformation" |
| Teresa N. | Divisional VP, Regions | Swayed 3 of the 9 votes in practice, through her regional directors |

The map mattered more than the product. Ellen's and Teresa's objections were never about features. They were about who bears the risk of looking wrong, and no feature demo touches that.

## The cycle, month by month

**Months 1–5 (December 2021 to April 2022): discovery and the technical sell.** Weekly working sessions with Amara's platform team. I ran discovery without an SE for the first month, because the architecture questions were ones I could answer. Then I brought the SE in to go deep. The proof of concept ran in their staging environment on 40 stores' worth of configs, March to April. Amara's team signed off on it technically.

**Months 6–9 (May to August 2022): the security wall.** Robert K. stalled the evaluation for ten weeks, from early June to mid-August. For the first six weeks I treated him as a document exchange: questionnaires in, answers out. In mid-July I changed approach. I got him a named Fennec security engineer, a remediation doc for the 12 findings that actually mattered to him, and an invitation into the platform working group, so the fix became his story to tell. He signed off in mid-August.

The same blind spot killed my Rivermont deal on August 4, in the middle of this stall. I'd started fixing it at Harvestlane and hadn't carried the fix to my other accounts in time. The two together became the security checklist I now run on every deal: `Projects/Procurement Security Win.md`.

**Month 10 (September 2022): the no-vote.** At the September committee review, the committee leaned no. Too big a bet, one vendor across 900 stores, unproven at their scale, and if it failed, it would fail in stores. Teresa's regions were the swing bloc, and Susan P. was against.

**Months 10–13 (September to December 2022): the pilot.** Detail below. It ran 90 days, from mid-September to mid-December, and hit all three success criteria. The go memo was written by Teresa's own regional ops leads. The committee voted on December 20: yes, 6 to 3. Susan P. voted no. Marcus O. and Priya S. were recorded as "not yet": Marcus wanted to see the first region live, and Priya wanted her TCO model.

**Month 11 (October 2022): the champion moved.** Dan M. was promoted out of the seat to run supply-chain systems. He stayed a supporter but stopped being the sponsor of record. I'd been working Amara and Teresa since month 6, so the vote didn't wobble. But the procurement intake and Priya's TCO review had run only through Dan's office, and his successor had to re-sponsor both. That cost three weeks.

**Month 14 (January 2023): procurement.** Three rounds of redlines, detail below. Signed January 27, 2023.

## The no-vote: options I had

1. **Cut the price to shrink the bet.** Rejected. A lower price doesn't change who bears the risk of looking wrong. It would also have set the price for years 2 and 3, and told the CFO delegate the number was soft.
2. **Shrink to one division, about $150K ACV.** Rejected. It meant re-running the committee for each division, giving up enterprise terms, and Teresa's regions would still have been the swing.
3. **Escalate.** Fennec's CEO to Susan P. I held it in reserve. An executive escalation aimed at a CIO burned by a "transformation" would have looked like one.
4. **A pilot where the skeptics own the verdict.** Chosen.

My turnaround pilots in 2021 were technical pilots, and the champion's engineers wrote the go/no-go memo. Here the technical case was already won. The doubt sat with the regions, so the verdict had to come from the regions.

## The pilot design

- 60 stores across Teresa's regions, 90 days, $45K. $45K was under Teresa's $100K signing authority, so it needed no committee vote and was signed in 10 days.
- Three success criteria, written by Teresa's regional ops leads before the start, with their own thresholds.
- A go/no-go memo authored by those ops leads, not by me and not by Fennec.

Results, as the ops leads measured them:

| Criterion | How they defined it | Threshold | Result |
|---|---|---|---|
| Deployment time | Median time from an approved change to live in store systems, pilot stores vs. the same stores' previous 90 days | 40% faster | 61% faster |
| Rollback safety | Worst case across the 23 rollbacks run in the pilot, from rollback command to store config restored | Under 10 minutes | Under 4 minutes |
| Store-manager adoption | Share of the 60 store managers using the release view at least weekly in the first 30 days | 60% | 78% |

The go memo was theirs, and so was the credibility.

## Procurement: holding price, trading structure

In December my VP asked whether 15% off would get it signed by December 31. Probably yes. I said no. The committee hadn't asked for a discount, and one offered then would have become the price for years 2 and 3 too, $225K over the term. It would also have reset Harvestlane's view of what the product was worth. The deal slipped into Q1 2023. That was my own money: I was already past 100% for 2022, so a December signature would have paid at my accelerated rate. I'd make the same call.

In the three rounds of redlines I held price and traded structure:

- **A ramp instead of a discount:** $400K, $500K, $600K over the three years, the same $1.5M. Fennec's plan paid commission on average ACV only if every year was committed and no year fell below 80% of the average. $400K is exactly 80% of $500K. I set the ramp at the plan's line on purpose. I won't sign a customer ramp I can't get paid on.
- **Success criteria in the SOW,** the pilot's three, with service credits if deployment time fell below the 40% improvement for two quarters in a row.
- **A liability cap instead of unlimited:** 2× annual fees for data-breach claims, 1× for everything else. That closed Jorge L.'s ask.

**Priya S.'s TCO model.** I built it myself and walked it through with her analyst on a call. Status quo: about 11 FTE of manual deployment work at $150K loaded ($1.65M a year), plus store outages traced to bad deployments, which Harvestlane's own incident reviews put at about $1.25M a year in lost sales. Fennec: the $1.5M over three years plus about $350K of internal rollout labor in year 1. If it removed half of both costs, it paid back in about 6 months.

Priya struck the outage line: lost sales aren't budget. I agreed and reran it on labor alone. Half the labor cost is $825K a year against $750K of year-1 cost, so payback in about 11 months and about $625K net over three years. The model that survived her edit was the one she took to her CFO. She moved from "not yet" to signing.

## What I did vs. what Fennec did

- Me: the committee map, discovery for the first month, the pilot design and the decision to hand the verdict to the regions, the TCO model, every round of redlines, the ramp structure.
- The SE: technical depth from month 2 and the proof of concept.
- Fennec's security engineer: the remediation work with Robert K.
- Deal desk: approved the ramp and the cap.
- Fennec's CEO: held in reserve and never used.

## What went wrong, and what I changed

- **I underestimated Robert K. by six weeks.** I read him as a checkbox, and he was a voter. Cost: ten weeks of stall. Now security gets a named engagement in every deal's first month, not when they stall.
- **I underpriced the pilot by about $40K.** I offered $45K because I panicked at the no-vote. $85K was still under Teresa's signing authority and would have passed unchanged. I now price pilots against the committee's risk and the sponsor's signing limit, not against my own nerves.
- **Dan was my only decision path for too long.** I had other contacts from the start, but for the first five months only Dan could move money or paperwork. My multi-threading rule used to count contacts. Since Harvestlane it counts people who can each get the deal to a vote, and I want two of them by week 2.

## Numbers I can defend

- $1.5M TCV, $500K average ACV, ramped $400K / $500K / $600K. 14 months from first meeting (December 2021) to signature (January 27, 2023). Booked in Q1 2023.
- 9 stakeholders, a 60-store pilot at $45K for 90 days, 3 rounds of redlines, zero price concession, a 6–3 vote.
- Pilot: deployment time down 61%, rollback under 4 minutes, store-manager adoption 78% in 30 days. All measured by Teresa's ops leads, against thresholds they set.
- Renewed in January 2026 for 3 more years with a 22% expansion. I'd left Fennec by then; my successor on the account told me. The pilot's go memo is still cited inside Harvestlane, which is the compounding return on letting the customer own its own decision.

## What's still open

When I left Fennec at the end of 2024, the open item on this deal was its renewal, about a year away. It renewed in January 2026, so nothing on this deal is open now.
