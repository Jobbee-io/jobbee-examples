<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Dual-sourcing a microcontroller during the shortage

Verdillo Power Systems, April 2021 – September 2022. I was the commodity manager for electronic components. On my resume this is one bullet with four numbers. This file holds the gap I had to cover, the options and their prices, the broker controls, the second-source agreement, the allocation rules, the timeline, who disagreed, how each number is defined, and the 7 weeks I lost at the start.

## The problem

One 32-bit microcontroller, from one manufacturer I'll call Manufacturer A, sat on 3 boards: the control board of our power conversion system (PCS) and the control boards of 2 UPS families. That's 11 products. Forecast demand for 2021 was 64,000 units at a contract price of $9.40. We bought it through A's franchised distributor.

On April 6, 2021 the distributor put it on allocation. Lead time went from 12 weeks to 52, then to "no date." Our allocation for the rest of 2021 was 45% of forecast. No pin-compatible alternate existed, so any second source meant a board re-spin and a firmware port.

The gap, as I put it to the VPs: April – December demand was about 48,000 units. Allocation covered about 21,600 and our stock in Tempe and Hermosillo another 7,400, about 6 weeks. That left about 19,000 units short in 2021 alone, and nobody would tell us when allocation would lift.

## My role, and the team's

I owned the supply side from start to finish: the gap model, the business case, the allocation rules, the broker purchases and their controls, and the supply agreement with the second manufacturer. Engineering chose the replacement part. A firmware lead and 2 hardware engineers did the port and the re-spin. Quality ran incoming inspection and the qualification tests. Our compliance engineer handled the safety certification update for the UPS families. I chaired a weekly allocation meeting with sales, planning and finance for 15 months, April 2021 – June 2022.

## The options, and what each would cost

In late May 2021, after the wait I describe below, I took a business case to the VPs of supply chain and engineering. It priced 3 paths on the same gap model:

1. Brokers only. Broker quotes that month ran from $45 to $120 a unit. If allocation stayed at 45% into mid-2022, we'd need about 35,000 broker units: roughly $2.5M of premium, counterfeit risk on every lot, and no end date. The only exit was the distributor's promise that allocation would ease.
2. Redesign only. Engineering estimated 18 to 22 weeks to production boards, plus about 6 weeks of certification for the UPS families. Stock and allocation would run out in August. Without brokers we'd miss most of the third and fourth quarters on 11 products.
3. Both. Brokers as a bridge until the new boards shipped, then taper broker buying to zero. My estimate was $1.3M–$1.6M of broker premium and about $500K of redesign.

I recommended path 3, and it was approved on June 4. The actuals came in at $1.47M and $520K, inside the estimate.

Two options didn't make it into the case:
- Manufacturer A offered direct allocation for 2022 if we placed a 12-month non-cancellable order at $14.80 a unit. It did nothing for 2021, which was the problem, and it tied us tighter to the single source. I turned it down. A year later I accepted a deal of the same shape for power modules, and that one went badly (`Power Module Overbuy.md`).
- A larger-memory part in the same family from Manufacturer A would have been an easier port. It was on the same allocation.

Engineering compared 3 microcontrollers from other manufacturers. My part was the supply data for each: distributor stock, quoted lead time and allocation status. Manufacturer B's part had a 26-week lead time and wasn't on allocation yet, and the firmware lead's team already knew its toolchain. Engineering chose it.

## The broker program

From June 2021 to March 2022 I bought 21,400 units from 5 brokers at an average of $78 a unit. The cheapest lot was $41 and the most expensive $126.

The first lot, 600 parts, I bought before any controls existed (see what went wrong). After it, every lot followed the same rules:
- Approved brokers only. I started with 9 names from other buyers and distributor contacts. 5 passed: certified to AS6081 (the counterfeit-avoidance standard for independent distributors), at least 3 years trading, references we could call, and willing to accept our inspection terms.
- An independent test lab saw every lot before our line did: visual inspection, X-ray, electrical test, and decapsulation on a sample to check the die markings. 40 lots, about $2,400 a lot, $96K in total.
- Payment on lab acceptance where the broker agreed to it, which 2 of the 5 did. The other 3 wanted payment up front, so I capped any prepaid lot at $150K.
- A price ceiling of $120 a unit. Above it, the VP of supply chain signed. He signed twice.

Finance first wanted a $50 ceiling. I showed that $50 would have covered about a third of the lots offered to us in June. We settled on $120 with the VP's signature above it, and I reported every week what we paid and for which orders.

The lab rejected 2 lots, 1,150 units, as suspect. One broker refunded in full; the other refunded all but $18K.

## The agreement with Manufacturer B

I negotiated a 24-month agreement with B's franchised distributor, signed in August 2021:
- A committed allocation of 9,000 units a quarter at $11.20 a unit, fixed for 24 months. List price at the time was $12.60.
- In return, a rolling 24-month forecast we would stand behind. The next 2 quarters were firm orders. Quarters 3 to 8 were a forecast with no liability. The distributor's first draft made 4 quarters firm. I held out for 2: a firm order a year out is a bet on our demand, not a fix for their supply.
- First deliveries in November 2021, for January board builds.

The committed allocation was the point. B's part wasn't on allocation in mid-2021, and I wanted us protected if it went there.

## The allocation meeting

Every Tuesday, sales, planning, finance and I decided which customer orders got the parts we had. I started with margin as the first rule. Four weeks in, that pushed out a large customer's order that carried a late-delivery penalty. Sales escalated, and we paid an $85K credit. The order of rules became:
1. Orders with late-delivery penalties.
2. Orders with a firm date already promised to the customer.
3. Margin.

Sales and finance signed the new rules, and the VP of supply chain made them binding. Sales could challenge a call in the meeting, not after it. There were no more penalty payments from allocation for the rest of the shortage.

## Timeline

- April 6, 2021: allocation notice. The weekly allocation meeting starts.
- April – late May: the 7 weeks I waited. In early May, the allocation rules were rewritten after the $85K credit.
- June 4: business case approved. Mid-June: the first broker lot, and the X-ray that caught it. From late June, every lot went through the lab.
- June – October: re-spin and firmware port, 19 weeks.
- August: agreement with B's distributor signed.
- November – December: quality's qualification tests; first deliveries of B's part.
- January 2022: first PCS boards with B's part ship.
- March 2022: UPS boards ship after the 6-week certification update. Last broker purchase.
- June 2022: last allocation meeting.
- September 2022: B carries 55% of the volume.

## Who disagreed, and how it was settled

- The hardware lead argued in May for waiting. The re-spin pulled 3 engineers off the 2022 PCS roadmap. The business case put the cost of waiting next to the cost of the re-spin, and the VP of engineering approved it and moved one roadmap feature back a quarter.
- Finance, on the broker ceiling. Settled at $120 with a signature above it.
- Sales, on allocating by margin. Sales was right.

## The numbers, with definitions

- Broker premium: the price paid above the $9.40 contract price, times units. ($78 − $9.40) × 21,400 = $1.47M. Lab testing added $96K.
- Redesign, one-time: $520K. Engineering time at loaded rates $410K, re-spin and prototypes $46K, certification $64K.
- Ongoing: Manufacturer B's part costs $1.80 more, about $63K a year at 35,000 units. That's the standing price of having a second source, and I report it as a cost.
- Losses on top of the plan: $41K scrap and rework on the first lot, $18K a broker never refunded, and the $85K late-delivery credit. $144K in total.
- Revenue shipped on schedule: $148M. The selling price of finished systems that shipped in the quarter promised and contained at least one broker or second-source part, June 2021 – September 2022. This is finance's measure, and the one our CFO used.
- Revenue at real risk: $31M, my estimate. Sales and I went through every open order in the window and kept the ones with a late-delivery penalty or a competing bid on the table. The $148M overstates what we would have lost, because most customers would have waited. When someone asks what this saved, I give $31M and explain the $148M.
- None of this is savings. We spent about $2.1M to protect revenue, and I never put it in a savings column.

## What went wrong

- I waited 7 weeks. The distributor said allocation would ease by the third quarter, and I believed it because I wanted to. I started the business case in late May instead of mid-April. At the rate we were buying from brokers, those 7 weeks cost about $250K of the premium.
- I bought the first broker lot, 600 parts, from a broker another buyer had used, before the test plan existed. The date codes had been re-marked. 120 parts were on boards before our incoming X-ray caught it. The broker refunded the 480 unused parts, and we never bought from it again.
- Allocating by margin first, without agreeing the rules with sales. That's the $85K.

## What it left behind

- Both parts are still qualified, and we still buy both. Every firmware release is now built and tested for 2 boards. Engineering puts that at about 2 extra engineer-weeks a release, a cost that never shows up in my category numbers.
- A list of single-source critical parts, built in 2023–2024 with engineering: 214 single-source parts reviewed, 37 rated critical, and 26 of those have a qualified alternate as of October 2026.
- A bias I had to unlearn. In August 2022 the shortage still felt permanent to me, and I bought power modules as if it were (`Power Module Overbuy.md`).
- One thing that isn't solved. Our 2024 sub-tier mapping (`Capacitor Quality Crisis.md`) showed that both microcontrollers come from fabs in the same region. The dual source protects us from one manufacturer's allocation. It doesn't protect us from a disruption in that region, and at our volume I don't have an answer for that yet.

## What I'd do differently

- Start the second-source design at the first allocation notice. A re-spin you don't need costs less than a broker premium you didn't have to pay.
- Write the broker controls before buying the first broker part.
- Agree the allocation rules with sales and finance in writing, in week 1.
