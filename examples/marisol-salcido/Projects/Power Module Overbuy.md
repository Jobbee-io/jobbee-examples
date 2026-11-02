<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The power module overbuy

Verdillo Power Systems, August 2022 – September 2024. The most expensive decision of my career, about $1.9M. On my resume it appears only under failures, not as an experience bullet, because it isn't an accomplishment. This file holds the decision, what I knew when I made it, the cost against a stated baseline, and the rules it produced.

## The decision

In August 2022 I was still the commodity manager for electronic components, and the microcontroller shortage (`Microcontroller Dual Sourcing.md`) was fresh. Our PCS used 2 IGBT power module part numbers from one manufacturer, Manufacturer C, 8 modules per unit. Lead time was 50 weeks. The price had gone from $168 in 2021 to $212.

Manufacturer C offered to secure 2023 capacity, but only against a 12-month non-cancellable, non-returnable (NCNR) order. Sales forecast 6,500 PCS units for 2023, which meant 52,000 modules. I recommended committing to all of it: 52,000 × $212 = $11.0M, NCNR. My director and the CFO approved it on my memo.

The memo had one scenario: the shortage continues. A week without modules would have stopped about $7M of PCS shipments, and that was the only risk I priced.

The recommendation, the quantity and the terms were mine. Sales owned the forecast, and I didn't question it. Planning wasn't asked.

## What happened

- In the first quarter of 2023, 2 large storage projects slipped to 2024 when the customers' grid connections and financing were delayed. We shipped 4,300 PCS units in 2023, which used 34,400 modules. Demand came in 34% below the forecast.
- Lead times fell to 16 weeks by mid-2023. New-contract quotes during 2023 averaged $186.
- That left 17,600 excess modules. I negotiated a deferral: Manufacturer C pushed 9,000 of them into the first half of 2024, at the original price, in exchange for an extra 2024 order of 12,000 modules at $178. The other 8,600 arrived on schedule and sat in our warehouse.
- In 2024 our PCS redesign moved to a new module. 1,400 of the excess were the old variant and were written off. The other 7,200 were used by September 2024.

## The cost, with definitions

I measure the cost against what we would have paid buying each module in the quarter we used it, on normal terms.

- Price premium on the 34,400 used in 2023: ($212 − $186) × 34,400 = $894K. $186 is the average of Manufacturer C's new-contract quotes during 2023.
- Price premium on the 16,200 used in 2024 (9,000 deferred, 7,200 from stock): ($212 − $178) × 16,200 = $551K.
- Write-off: 1,400 × $212 = $297K.
- Carrying cost: about $200K, using finance's 18% annual rate on the excess from the month it arrived to the month it was used.
- Total: about $1.9M. Units check: 34,400 + 16,200 + 1,400 = 52,000.

What it bought was certainty of supply in a year that turned out not to need it. If the shortage had continued, the same memo would look smart. I judge it on the process, not only the outcome, and the process had one scenario.

## What went wrong

- One scenario, no demand range. The 2022 PCS forecast had come in 22% high. I had that number on my own dashboard and didn't put it in the memo.
- I committed 100% of the forecast. Committing NCNR only up to a low case, and buying the rest on normal terms, would have cut the exposure by more than half.
- I didn't ask for quantity flex. Manufacturer C later told me they would have accepted ±15% flex for about 3% more on price.
- I priced in a shortage that was ending. Lead times on other power semiconductors had started falling in July 2022. I saw it and read it as noise.

## What changed

- My director made it policy: any NCNR or buffer commitment over $1M needs a demand range from planning (low, base, high) and the cost of the low case in the memo.
- I commit in layers now: NCNR only up to the low case, the rest on flexible terms.
- Flex by default. The IGBT agreements I signed for 2025–2026 have ±25% quantity flex at 90 days' notice, for about 2% more on price. In 2025 we used it once, cutting a third-quarter order by 18% when a customer project slipped.
- In March 2023 the VP of supply chain asked me to set up S&OP, so buying commitments get checked every month against one demand plan with a range (`Sales And Operations Planning.md`).

## What I'd do differently

Write the low case. The memo needed one more paragraph: "If 2023 demand is 20% under forecast, we hold about $2M of modules we can't cancel, at a price the market may not support by mid-year." I had the data for every number in that sentence. I left it out because the shortage felt permanent and the memo felt stronger without it.
