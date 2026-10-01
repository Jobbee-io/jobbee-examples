<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Zero-to-one internal tooling — the platform nobody had to adopt

Ferroline Systems, 2015–2017. I built the internal shipment-exception tool that went from one skeptical pilot team to company standard: 14 ops teams, spreadsheets dead, and one heroic Access database ceremonially unplugged. This is the influence-without-authority story in full, because the mechanics matter more than the outcome.

## The problem I didn't have permission to solve

Ferroline moved freight; when shipments went wrong (weather, customs, carrier failures), ops teams worked exceptions. Every team had its own system: spreadsheets, three Notion-ish tools of the era, and one Access database maintained by a single wizard in the Chicago office whose PTO was a company risk factor.

Nobody owned this. Exceptions were 20% of ops labor and 0% of anyone's roadmap. I was a backend engineer on the integrations team who kept getting pinged because my webhook fan-out code was where exception events surfaced first.

## The wedge: pilot with one skeptical team

The mistake every internal tool makes: build for everyone, launch to silence. I did the opposite.

- **Picked the most skeptical team on purpose** — the Montreal ops team, whose lead had publicly said internal tools "always break in week three." If it survived her, it could survive anyone; if it didn't, I'd find out while the blast radius was five people who'd already told me the truth.
- **Built the boring 20%:** a single exception queue with one canonical state model (detected → triaged → action → resolved → verified) and a timeline of every event. No dashboards, no AI, no "vision." The pitch was one line: *"the same queue your team already keeps, minus the copy-paste between systems."*
- **Survived week three** because I'd built the thing she actually predicted: week three is when the demo data gets replaced by real messiness. Real data exposed three state-model holes in the first 48 hours; I fixed them same-day, in front of her team, and said out loud that her team found them. The Montreal lead became the tool's most aggressive advocate — skeptical converts evangelize harder than the choir.

## The expansion mechanics

Adoption spread team-by-team, and the mechanics were deliberate:

- **Proof over promotion:** each new team joined after watching a *neighboring team's* exception queue, not after watching my slides. Social proof from peers, not from the builder.
- **The data model was the product.** Teams didn't adopt my tool; they adopted a shared exception taxonomy — and the tool was just where the taxonomy lived. The fight over "what counts as resolved" (I lost the first version: verification required a customer-visible confirmation, not an ops assumption; the second version won) was the actual product work.
- **Migrations as first-class work:** every team's old system got a data-import path and a documented goodbye. The Chicago Access database got its own migration project, its own rollback plan, and — after the wizard reviewed the import and said "huh, cleaner than mine" — its blessing. The wizard became the Chicago team's power user, which was the day I knew it was over for the database.

## Influence-without-authority, itemized

I had no org authority over any ops team. What I actually did:

- **Answered pings about exception events with fixes, not pointers** — the integrations team's trust was the currency that bought me engineering time from two colleagues who thought the tool was worth their evenings.
- **Never once escalated "teams should use this."** The ask was always "would this fix the thing you complained about last Tuesday?" — small, specific, deniable.
- **Let the spreadsheet die of neglect instead of banning it.** Teams keep parallel spreadsheets while they don't trust a tool. I checked (politely, monthly) when they last opened theirs. The Montreal team's answer went from "this morning" to "why would I" in nine weeks; adoption is measured in that answer, not in license counts.
- **Wrote things down in public.** The state-model decisions, the rejected designs, the known gaps — in a doc anyone could comment on. When the VP of ops eventually asked "who's running this," the doc was the answer, and the honest one was: nobody, everybody, come see.

## Outcome

- 14 ops teams on the exception tool; per-exception handling time down 31% (ops-measured, not me-measured).
- The Access database unplugged in a small office ceremony that the wizard attended voluntarily.
- What it cost me: about 18 months of evenings and a standing 30 minutes with each team lead, monthly, forever.
- What it made me: at my next review, the company created a PM role for internal products and asked me to take it. The tool was the application; the role was the acceptance letter. I've been a PM since — and I still believe the best product training is building something nobody was assigned to want.
