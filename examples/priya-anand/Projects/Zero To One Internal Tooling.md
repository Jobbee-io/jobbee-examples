<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Zero-to-one internal tooling — the platform nobody had to adopt

Ferroline Systems, 2014–2017. I built the internal shipment-exception tool that went from one skeptical pilot team to company standard: 14 ops teams, the spreadsheets gone, and one heroic Access database unplugged. I started it as an evening project while I was a backend engineer, and finished it as Ferroline's first PM for internal products. The mechanics of adoption without authority matter more than the outcome, so they get most of this file.

## Timeline

- Early 2014: I start building it on evenings, still an integrations engineer.
- Mid-2014: pilot with the Montreal ops team.
- July 2015: 4 teams on it. At my mid-2015 review the company created a PM role for internal products and gave it to me. The tool was most of the case. My MBA capstone, a pricing analysis, was the written half.
- July 2015 to mid-2017: as PM, 4 teams to 14, and the Chicago Access database migrated in 2016.

## The problem I didn't have permission to solve

Ferroline's software ran freight operations. When shipments went wrong (weather, customs, carrier failures), ops teams worked exceptions. Every team had its own system: spreadsheets, three wiki-based trackers, and one Access database maintained by a single wizard in the Chicago office whose time off was a company risk.

Nobody owned this. Ops leadership's own 2014 time study put exceptions at 20% of ops labor, and they were on nobody's roadmap. I kept getting pinged because my webhook fan-out code was where exception events surfaced first.

What I built: a small Python and Postgres web app that consumed the same event stream my integration code already produced. Two engineering colleagues gave it their evenings. That was the whole team until I became PM.

## The wedge: pilot with one skeptical team

The usual internal-tool mistake is to build for everyone and launch to silence. I did the opposite.

- **I picked the most skeptical team on purpose.** The Montreal ops lead had said publicly that internal tools "always break in week three." If the tool survived her five-person team, it could survive anyone. If it didn't, I'd find out from people who had already told me the truth.
- **I built the boring 20%.** One exception queue, one state model (detected → triaged → action → resolved → verified), and a timeline of every event on the shipment. No dashboards. The pitch was one line: "the same queue your team already keeps, minus the copy-paste between systems."
- **It survived week three** because I'd built for what she predicted. Week three is when demo data gets replaced by real mess. Real data exposed three holes in the state model in the first 48 hours. I fixed them the same day, in front of her team, and said out loud that her team had found them. She became the tool's loudest advocate.

## The expansion mechanics

- **Proof over promotion.** Each new team joined after watching a neighboring team's queue, not after watching my slides.
- **The data model was the product.** Teams didn't adopt my tool; they adopted a shared exception taxonomy, and the tool was where it lived. The real product work was the fight over what counts as "resolved." My first version let ops mark an exception resolved on their own judgment. I lost that argument to the customer-service leads: the second version says "verified" needs a customer-visible confirmation, not an ops assumption. They were right.
- **Migrations were first-class work.** Every team's old system got an import path and a documented goodbye. The Chicago Access database got its own migration project and rollback plan. The wizard reviewed the import, said it was cleaner than hers, and became the Chicago team's power user. That was the day I knew the database was done.

## Influence without authority, itemized

I had no authority over any ops team. What I actually did:

- Answered exception pings with fixes, not pointers. The integrations team's trust was what bought me the two colleagues' evenings.
- Never escalated "teams should use this." The ask was always "would this fix the thing you complained about last Tuesday?" Small and specific.
- Let the spreadsheets die of neglect instead of banning them. Teams keep a parallel spreadsheet while they don't trust a tool. Once a month I asked each team lead when they last opened theirs. Montreal's answer went from "this morning" to "why would I" in nine weeks. Adoption is that answer, not a license count.
- Wrote everything down in public: state-model decisions, rejected designs, known gaps, in a doc anyone could comment on. When the VP of ops asked who was running this, the doc was the answer.

## Outcome

- 14 ops teams on the tool.
- Per-exception handling time down 31%. Ops analytics measured it, not me: median minutes from exception detected to verified-resolved, for each team, over the 3 months before and the 3 months after it adopted.
- The Access database unplugged, with the wizard present by choice.
- What it cost: about 18 months of evenings (early 2014 to mid-2015) and a standing 30 minutes a month with each team lead, which I kept for as long as I was there.

## What I'd do differently

- Get an ops-side owner named earlier. Until 2016 the tool's priorities lived in my head and my doc. When I left in 2017, the handover took two months because the ops VP had to find someone to inherit decisions I had made alone.
- Measure the baseline before the pilot, not after. Montreal's before-numbers were reconstructed from spreadsheet timestamps. They held up, but I'd rather not have had to defend a reconstruction.

## What's still open

When I left Ferroline in 2017, what was open was who would own the tool after me. The ops VP had to find someone to inherit decisions I had made alone, and that handover took two months.
