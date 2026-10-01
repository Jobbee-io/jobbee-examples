<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Startup acquisition integration — the engineering side

Feb 2020 – Mar 2021, Grousemont Systems. I led the engineering side of integrating Cinderpeak Labs (my company, where I'd been Head of Platform; 45 engineers, developer-tools product) into Grousemont, a ~4,000-engineer enterprise software company. Kept/rewrote/sunset across 60+ services; 39 of 45 acquired engineers still at Grousemont 12 months post-close — a retention number I'm prouder of than any technical artifact from that year. This is the record of what we kept, what we rewrote (including my own team's code), what we killed, and how the people part actually worked.

## What each side wanted (the honest version)

**Grousemont** had bought a product and a team, in that order of conviction. Their stated goals: ship Cinderpeak's product to Grousemont's enterprise customers within a year; adopt "whatever's good" from the startup's engineering practice; keep the talent (their diligence report named retention targets explicitly).

**Cinderpeak** — us — wanted our product to matter at scale and feared, correctly, the classic pattern: acquirer sandbags the product, strips the team, and the technology dies in a spreadsheet. Our leverage was real but perishable: retention cliff starts at 12 months, and our best people had liquid motivations.

I sat in the middle, which is the actual job description of the integration lead: trusted by the acquired (I was them) and credible to the acquirer (I could read their org). Neither side ever got full honesty from the other directly. From me, they did, because I was structurally forced to be the one person who could afford it.

## The triage: keep / rewrite / sunset

First 90 days: a full inventory of our 60+ services (the startup had over-microserviced, as startups flush with funding do — I say this as the person who approved the architecture). Each service got a recommendation doc, decided in review with Grousemont's division architects, with three questions: does it serve the product roadmap, does its design survive enterprise scale, and does anyone outside its authors understand it?

**Kept as-is: 23 services.** The core pipeline engine, the deploy agent, the scheduler — the crown jewels, and the pieces that *worked* and were understood. Keeping them untouched was a signal as much as a decision: "we're not here to re-litigate your code." Signal mattered; the acquired engineers were reading every decision for evidence of the sandbag scenario.

**Rewrote: 9 services.** The interesting cases:
- **4 were Cinderpeak's own code, including one I'd designed** (the original multi-tenant control plane). The reasons were scale-shaped: our tenancy model assumed 340 customers; Grousemont's enterprise sales pipeline assumed thousands, with per-customer compliance isolation. The rewrite wasn't a quality judgment — our code was *good at what it was built for* — it was a change of what it was built for. I wrote the keep/kill doc for my own control plane personally, with the measured capacity cliff attached (testing showed degradation past ~1,200 tenants), because if the lead's own code isn't first through the honest process, the process is theater and everyone knows it.
- **5 were enterprise-compliance rewrites:** auth flows, audit logging, data-residency hooks — features our mid-market product had never needed. The acquired engineers did most of this work, by design: it's career-building work, it's the acquirer's knowledge pouring in, and it kept our best people on the parts of the system they knew.

**Sunset: 28 services.** The over-microserviced long tail: 14 had fewer than 5 calls/day, 9 duplicated Grousemont platform capabilities (their SSO, their billing, their observability — all older, all enterprise-hardened), 5 were experiments that had never shipped. Consolidation reduced the fleet by nearly half, and — counterintuitively — *increased* the velocity of the product work, because the remaining teams stopped paying the 28-service operational tax. The sunset docs each named what functionality moved where; three legit bugs in that migration (double-charging trial conversions, caught in canary) were the cost of speed, paid in the open.

## The people part (where integrations actually fail)

- **No re-interviews.** The acquirer's HR wanted "role-fit assessment." I blocked it with the retention data from comparable acquisitions (attrition roughly doubles when acquired engineers are re-interviewed for jobs they already hold) and put my own credibility on the line: "Re-interview them and you can re-recruit them, at market, from competitors." Won that argument; it was the single highest-leverage meeting of the year.
- **Titles and comp mapped at close, publicly, with the formula shown.** Messy spreadsheet, everyone could see their own row, two genuine out-of-band fixes for people the formula would have insulted. The perception of a fair process mattered more than the formula's elegance.
- **The acquired team kept a real roadmap for 12 months.** The product shipped *to new enterprise customers* in month 9, on the original architecture, by the original team, plus the compliance rewrites. Nothing kills acquired-team retention like watching your product assigned to a "synergy" roadmap owned by strangers.
- **What I'd do differently: the culture export got one direction.** I spent the year exporting Cinderpeak practices inward — the postmortem habit, design-doc culture (which later seeded the Fernbrook-scale version of this program, but that's a later chapter). I under-invested in the reverse: teaching *our* people Grousemont's enterprise rhythm — release governance, support tiers, sales-assist. Three of the six regretted attritions in year one were engineers who drowned in process they were never taught and read as bureaucracy rather than craft. A two-way exchange program was the fix I proposed at month 10 and should have proposed at month 2.

## Outcome

- Product live with Grousemont's enterprise customers at month 9; ~11,000 pipelines/day grew to ~19,000 by month 18.
- Fleet: 60+ services → 32 by month 12; operational cost of the acquired estate down 44%.
- **Retention: 39/45 at 12 months; 35/45 at 24 months** (vs. the acquirer's own M&A baseline of ~60% at 12 — their number, not mine, which is the only reason I cite it).
- 4 of the 9 rewrites were led by acquired engineers; two of those engineers got promoted *inside* Grousemont's ladder within 18 months, which did more for the "stay" math than any retention bonus.
- The postmortem and design-doc practices I brought became seed stock for what I later built at division scale — the integration taught me that importing practice works only when the imported practice arrives with a respected local sponsor and its first dozen wins, not as a memo.

## What transfers

1. Triage your own code first, in writing, hardest case first — the process's credibility is set by whether the lead's own artifacts survive it.
2. Keep the crown jewels visibly untouched; rewrite for *changed requirements*, not taste; sunset loudly with named destinations.
3. Retention is decided in months 0–3 (re-interviews, comp formula, roadmap ownership), not by the retention bonus at month 12.
4. Culture flows both directions or it's colonization, and colonization has a measurable attrition rate.
5. The sunset bug cost (three, caught in canary) is the honest price of decommissioning speed — budget for it and say so upfront.
