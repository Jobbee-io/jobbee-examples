<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Startup acquisition integration: the engineering side

Grousemont Systems, February 2020 to March 2021. I led the engineering side of integrating Cinderpeak Labs, where I had been Head of Platform (45 engineers, a developer-tools product), into Grousemont, an enterprise software company of about 4,000 engineers. Keep, rewrite or sunset decisions for 60+ services, and 39 of 45 acquired engineers still at Grousemont 12 months after close. I'm prouder of that retention number than of any technical artifact from the year.

## The full story

Grousemont closed on Cinderpeak in February 2020. I had been Cinderpeak's Head of Platform, and I became the person between two sides: an acquirer that wanted to sell the product to its enterprise customers within a year, and 45 engineers who expected the usual pattern, where the product starves and the team leaves.

In the first 90 days we inventoried 60+ services. Each got a recommendation doc, and Grousemont's division architects decided them with me in review. I put my own multi-tenant control plane through first: load tests showed it degrading past about 1,200 tenants, and I wrote the rewrite recommendation for it myself. In the end we kept 23, rewrote 9 and sunset 28. The acquired engineers did most of the compliance rewrites, by design. The sunsets caused three bugs, including double-charging on trial conversions, all caught in canary and fixed in the open.

On the people side, I blocked Grousemont HR's plan to re-interview every acquired engineer, and we mapped titles and pay at close with the formula shown. The acquired team kept its own roadmap, and the product went live with Grousemont's enterprise customers in month 9.

My mistake was one-way traffic. I spent the year bringing Cinderpeak habits into Grousemont and didn't teach our engineers Grousemont's release governance, support tiers and sales assistance. Three of the six who left in year one left over process nobody had explained to them. I proposed a two-way exchange in month 10; month 2 would have been right.

By month 12 the estate was down to 32 services, and 39 of 45 engineers were still there. Early in 2021 I moved on to the division's build consolidation. By month 24, 35 of 45 were still at Grousemont.

What stayed open: the exchange I proposed came too late to help the people who left in year one. The habits I brought took hold only where a respected local engineer sponsored them, and in teams without one they still hadn't taken hold when I moved to the build work.

## What each side wanted

Grousemont had bought a product and a team, in that order of conviction. Its goals: sell Cinderpeak's product to its enterprise customers within a year, adopt whatever was good in the startup's engineering practice, and keep the people. The diligence report named retention targets.

We, the Cinderpeak side, wanted the product to matter at scale, and feared the usual pattern: the acquirer starves the product, the team leaves, the technology dies in a spreadsheet. Our leverage was real but short-lived. The retention cliff started at 12 months, and our best people had options.

I sat between them. The acquired engineers trusted me because I was one of them; the acquirer found me credible because I could read its org. My job was to say to each side what they weren't hearing from the other.

## Keep, rewrite or sunset

In the first 90 days we inventoried all 60+ services. The startup had split into too many services, as well-funded startups do, and I'd approved that architecture. Each service got a recommendation doc, decided in review with Grousemont's division architects, against three questions: does it serve the product roadmap, will its design survive enterprise scale, and does anyone besides its authors understand it?

**Kept as-is: 23.** The pipeline engine, the deploy agent, the scheduler: the core of the product, working and understood. Leaving them untouched was also a signal. The acquired engineers read every decision for evidence that the product was about to be starved.

**Rewrote: 9.**
- 4 were Cinderpeak's own code, including one I had designed: the original multi-tenant control plane. Our tenancy model assumed 340 customers; Grousemont's sales pipeline assumed thousands, each with compliance isolation. Load testing showed the control plane degrading past about 1,200 tenants. I wrote the recommendation for my own control plane myself, with that number attached. If the lead's own code doesn't go through the process first and honestly, nobody believes the process.
- 5 were enterprise-compliance rewrites: auth flows, audit logging, data-residency hooks, none of which our mid-market product had needed. The acquired engineers did most of this, by design. It was career-building work, it brought Grousemont's knowledge in, and it kept our best people on systems they knew.

**Sunset: 28.** 14 handled fewer than 5 calls a day. 9 duplicated Grousemont platform services (single sign-on, billing, observability), which were older and already enterprise-hardened. 5 were experiments that never shipped. Cutting them nearly halved the service count, and the remaining teams stopped paying the operating overhead of 28 services, which sped up product work. Each sunset doc named where the functionality went. The cost of moving fast was three bugs in those moves, including double-charging on trial conversions, all caught in canary and fixed in the open.

## The people side

- **No re-interviews.** Grousemont's HR wanted a role-fit assessment for every acquired engineer. I blocked it with data from comparable acquisitions (attrition roughly doubles when acquired engineers are re-interviewed for jobs they already hold) and my own credibility: "Re-interview them and you'll be re-recruiting them, at market, from competitors." It was the most important meeting of the year.
- **Titles and pay mapped at close, with the formula shown.** A messy spreadsheet where everyone could see their own row, plus two out-of-band fixes for people the formula would have insulted. A process people saw as fair mattered more than an elegant formula.
- **The acquired team kept its own roadmap for 12 months.** The product shipped to new enterprise customers in month 9, on the original architecture, built by the original team plus the compliance rewrites.

## What I got wrong

I exported practice in one direction only. I spent the year bringing Cinderpeak habits into Grousemont (the postmortem habit, the design-doc culture) and under-invested in teaching our engineers Grousemont's enterprise rhythm: release governance, support tiers, sales assistance. Three of the six engineers who left in year one were people who drowned in process nobody explained to them, and read it as bureaucracy rather than craft. I proposed a two-way exchange program in month 10. It should have been month 2.

## Outcome

- Product live with Grousemont's enterprise customers in month 9. About 11,000 pipelines a day at acquisition grew to about 19,000 by month 18.
- Services: 60+ → 32 by month 12. Operating cost of the acquired estate down 44%.
- Retention: 39 of 45 at 12 months, 35 of 45 at 24 months. Grousemont's own M&A baseline was about 60% at 12 months; that's their number, which is the only reason I quote it.
- 4 of the 9 rewrites were led by acquired engineers. Two of them were promoted on Grousemont's ladder within 18 months, which did more for retention than any bonus.
- The postmortem and design-doc habits I brought spread only where a respected local engineer sponsored them and had early wins to show. A memo didn't move anyone. I used that lesson again when I built the postmortem program at Fernbrook (`Incident Postmortem Program.md`).

## What transfers

1. Put your own code through the triage first, in writing, hardest case first.
2. Leave the core visibly untouched, rewrite for changed requirements rather than taste, and sunset loudly with named destinations.
3. Retention is decided in months 0 to 3 (re-interviews, pay formula, roadmap ownership), not by the bonus at month 12.
4. Practice has to flow both ways, or the acquired team pays for it in attrition.
