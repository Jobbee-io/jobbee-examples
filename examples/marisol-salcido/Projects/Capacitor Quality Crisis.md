<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The DC-link capacitor quality crisis

Verdillo Power Systems, February 2024 – January 2025. I was the Senior Strategic Sourcing Lead for power electronics, and film capacitors were one of my categories. On my resume this is one bullet. This file holds the timeline, what I owned and what quality and field service owned, the options at each decision, how the second source was chosen, the claim round by round, the cost and the recovery with their definitions, and the warning sign I read past 3 months earlier.

## What happened

In the first week of February 2024, 3 customer sites reported DC-link faults on our PCS units. At one site a capacitor vented inside a cabinet. There was no fire and nobody was hurt. Field data showed a failure rate of 0.9% on units shipped October – December 2023, against close to zero before.

The supplier was Penwarden Film Capacitors, our only source for these parts for 6 years, about $9.8M a year. Quality engineering and Penwarden worked the root cause through a formal 8D in 5 weeks. In September 2023 Penwarden had added a second polypropylene film maker for capacity. Our contract required 90 days' written notice before any material change. They didn't give it. Under our ripple current the new film ran hotter and aged faster. Affected date codes ran from September 2023 to January 2024. 412 PCS units in the field had affected capacitors.

## My role, and everyone else's

I owned the supplier side. I was the single point of contact with Penwarden's VP of operations and ran a daily call with them for the first 3 weeks. I owned containment at their plant, replacement supply, the claim and settlement, the second source, and the contract changes afterwards. Quality engineering owned the root cause and the 8D. Field service ran the retrofits of the 412 units over 5 months. Engineering reviewed derating on the new design. Legal reviewed the claim before it went out. The general manager of the energy storage business unit made the shipping decisions.

## Timeline

- November 2023: Penwarden's quarterly review, and the slide I read past.
- February 1 – 6, 2024: 3 sites report faults; the venting.
- February 7: PCS shipments stop. My daily call with Penwarden starts.
- February 7 – 14: date-code tracing by quality, and my screening detour.
- February 16: shipments restart with cleared capacitors.
- Early March: Penwarden's 4,000 rebuilt capacitors arrive.
- Mid-March: 8D root cause confirmed. Retrofits start. I start the second-source search.
- March 2024 – March 2025: Penwarden on probation, audited every quarter.
- July 2024: retrofits finish.
- August 2024: claim submitted.
- October 2024: second source approved; the 60/40 split starts.
- January 2025: settlement signed.

## Containment: the first 9 days

On February 7 the general manager had 3 options: keep shipping and retrofit later; stop until the 8D found the root cause, which quality expected to take 4 to 6 weeks at about $14M of PCS shipments a month; or stop until we could separate good stock from suspect stock, then restart with cleared parts. Quality recommended the third, and he took it. Shipping known-suspect parts into customer cabinets wasn't something anyone argued for after the venting.

My job was the supply picture: how many good capacitors existed, where, and how fast more could come. We quarantined 6,800 capacitors at our 2 plants and at Penwarden's warehouse. Quality traced which date codes used the new film from Penwarden's lot records. 1,900 capacitors from date codes before September 2023 were cleared. That was about 3 weeks of PCS builds, enough to restart on February 16 and bridge to the rebuilt parts.

For replacement supply, Penwarden rebuilt with the original film. I negotiated priority on their line: 4,000 capacitors in 3 weeks, at no charge. The capacitors for the retrofits came the same way, free.

## Keep or exit Penwarden

My director's first reaction was to exit them. I priced the 3 options:

- Exit. A new source needed about 7 months to qualify, so we'd depend on Penwarden in the meantime anyway. After that, we'd be single-sourced again, with a supplier we didn't know, at a higher price.
- Keep them as the only source, with audits. The cheapest option, and the same exposure that had just cost us $1.93M.
- Keep them at a reduced share, on probation, and qualify a second source. My recommendation.

The case for keeping them: a 6-year record, a cause in their sub-tier rather than their own process, and a solid corrective action. They locked our parts to the original film maker, put our part numbers on their change-control list, and named a quality contact for us. Quality agreed, and my director accepted it on 2 conditions: quarterly audits for a year, and a share cut to 40%. Our supplier quality engineer ran the 4 audits from April 2024 to March 2025, and I joined 2. They found 2 minor issues, both closed.

## Choosing the second source

In March 2024 I asked 3 film capacitor makers to quote our 4 part numbers:

- A US maker: 11% above Penwarden, with a good life-test record.
- An Asian maker: 2% below Penwarden, but it needed a different can size. That meant a board layout change and about 12 months.
- A larger European manufacturer: 4% above Penwarden at a 60% share, 7% above at 40%. It could build to our existing footprint, and it makes its own film.

I recommended the European manufacturer. The film was the deciding point: our failure came from a sub-tier film change, and this supplier has no sub-tier film supplier to change. The price break decided the split. 60% to the new supplier also meant it proved itself at volume while Penwarden was on probation.

Quality engineering and I ran the qualification: samples, thermal cycling, a 2,000-hour life test at rated temperature and ripple current (12 weeks by itself), first-article inspection, and a trial lot of 500 built in Hermosillo. It took 7 months. Since October 2024 the split has been 60% new supplier, 40% Penwarden.

## The claim

I submitted the claim in August 2024, once the retrofit costs were final: $1.93M. Legal's view was that our contract excluded consequential damages, that the field labor and the customer credits would probably count as consequential if it ever went to court, and that the notice breach was clear but didn't remove the exclusion. I claimed the full cost anyway. The claim was the record of what the breach cost us; the settlement was a negotiation.

1. September: Penwarden offered $380K, covering screening, freight and part of the customer credits, and cited the exclusion.
2. My counter: $1.6M. I put the 2025 volume on the table in writing: a settlement under $1M would make their 40% share hard to defend inside Verdillo.
3. November: $900K in cash.
4. January 2025: $1.21M, as $640K in cash and a $570K credit against purchases.

Penwarden preferred the credit, because it cost them margin rather than cash. I accepted it because a credit only has value if we keep buying, which matched the decision we'd already made. We used up the credit during 2025.

## The numbers, with definitions

- Failure rate: PCS units with a confirmed DC-link capacitor fault, divided by PCS units shipped October – December 2023, as of the end of February 2024. 0.9%.
- Cost of the crisis to Verdillo: $1.93M. Field retrofit labor and travel $1.38M, screening and quarantine labor $142K, expedited freight $96K, and late-delivery credits to 2 customers $310K.
- Not in that number: the replacement capacitors (free from Penwarden, about $455K at our price), and $14.2M of PCS shipments that moved from February into March. I count those shipments as delayed, not lost, because every order shipped.
- Recovered: $1.21M of the $1.93M claimed, 63%. The leverage was the clear notice breach and the business Penwarden wanted to keep.
- Cost of the second source: the new supplier is 4% more expensive. At a 60% share of $9.8M annual capacitor spend, that's about $235K a year. I report it as a risk premium, a cost, not something to bury.
- Since the retrofits finished in July 2024: zero confirmed DC-link capacitor failures through October 2026.

## What went wrong

- I missed the warning. At our November 2023 quarterly review, Penwarden showed a slide that said "new film partner added for capacity." I read it as good news about capacity. I didn't ask whether it was a material change that needed our qualification. The notice clause was in a contract I had negotiated, and I had never checked whether anyone complied with it.
- In week 1 I pushed for 100% electrical screening at incoming, because I wanted to show customers we were acting. The quality engineer told me it wouldn't separate good film from bad. I pushed anyway. It took a week and about $60K of the screening labor, and found nothing. Date-code tracing did the job.

## What changed

- A sub-tier map for our 37 critical parts: who makes the key material for each one. 11 of the 37 depend on a single sub-tier source. Every new or renewed agreement on those parts now has a clause requiring notice of any sub-tier change.
- A yearly audit of change-notice compliance for our top 20 suppliers. The first one, in 2025, found 3 changes nobody had told us about: a plating line move, a new resin supplier and new test equipment. None had touched field quality. All 3 are now documented and qualified.
- A standing question on every quarterly review agenda, answered in writing: any changes to materials, sites, sub-tier suppliers or processes since the last review?
- I don't overrule quality engineering on a technical call.

## What's still open

- The 2027 capacitor renewal closes December 11, 2026. Penwarden has had no confirmed field failures since the retrofits, and the question is whether to move to 50/50. The new supplier's 4% premium holds only at a 60% share; its quote at 50% is 5.5% above Penwarden. I haven't decided.
- Change-notice compliance still depends on suppliers telling us. The audit samples; it doesn't see everything. The written question turns a quiet omission into a false written answer, and that's the strongest control I've found.
- The $235K a year premium is permanent for as long as we keep 2 sources.

## What I'd do differently

Ask the one question at the November review. It would have cost a sentence, and the 9-day stop, the 412 retrofits and most of the $1.93M were on the other side of it.
