<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Price increase business case

Quillfield Pet Foods. Analysis June – August 2023, approved September 2023, effective January 2, 2024, results measured over FY2024. On my resume this is one bullet. This file has the options, the elasticity work, my recommendation, the one change the CFO made to it, and what actually happened, which was worse than my base case.

## Why we needed a decision

Input costs (proteins, fats, packaging, freight) had been rising for 2 years. A 5% list increase in March 2022, before I joined, recovered about half of it. Gross margin went from 34.6% in FY2021 to 31.2% in FY2022 and 30.4% in FY2023. The VP of Operations and the CFO started at 9% across the board. The VP of Sales wanted no increase: 2 big retailers had line reviews coming, and store brands were already taking share at the low end. My director asked me to build the case for the executive team.

## My role

I owned the analysis, the model and the recommendation memo. The sales ops analyst pulled 2 years of promotion history. An analyst on the data team reviewed my regression code. The VP of Sales and 2 account managers gave me retailer context, and the supply chain finance analyst gave me the cost outlook. The decision belonged to the CEO and the CFO.

## The analysis

- Elasticity. I estimated own-price elasticity by product line from 2 years of weekly point-of-sale data at our 3 largest retailers, with log-log regressions of units on net price, promotion flags and seasonality. Results: core dry food −0.45, wet food −0.6, treats −1.1, entry-price dry food −1.6. Most of the price variation in that data came from the March 2022 increase, and every major competitor followed it within 8 weeks. So these were elasticities for a market where competitors follow. I knew that, and I wrote it on page 6.
- Price gaps. Shelf-price gaps by product line to the 2 main national competitors and to store brands. Our entry-price line was within 15% of store brands at our largest retailer.
- Cost outlook: another 6% inflation in proteins and packaging in FY2024.
- Trade leakage. In 2022, account teams had given back about 0.3 points of the increase through extra promotions. I assumed the same.

## The options

Each is gross profit per year against no increase, on an FY2024 baseline of about $600M net revenue.

- A, no increase: gross profit falls about $9M against FY2023 as costs keep rising.
- B, 9% across the board: +$33M if we keep all our distribution. I put the chance of losing items at the 2 largest retailers at about 40%, mostly entry-price and treats. Risk-weighted, about +$19M, with the widest range of the 3.
- C, tiered by product line, my recommendation: core dry +7%, wet +5%, treats +3%, entry-price 0%. Weighted list increase 5.4%, modeled at +$22M, with a much narrower range.

I tiered by product line, not by customer, so every retailer saw the same list price for the same item.

## The decision

The executive team approved option C with 1 change: the CFO moved the entry-price line from 0% to 4%, because he wanted every line to move. That made the weighted list increase 5.8%. The approved case had realized price +5.5%, volume −3.4% and gross profit +$24M in the base case, with a downside case of +$16M that included losing 2 entry-price items at our largest retailer. I argued for 0% on that line in 1 meeting, then let it go.

## What happened in FY2024

Measured on the same items, from the FY2024 gross-profit bridge (price, volume, mix, cost):

- Realized price +5.1%, not +5.5%. Account teams gave back 0.7 points through extra promotions, more than double what I had assumed.
- Volume −4.6%, not −3.4%.
- Gross profit +$18M, not +$24M: closer to my downside case than to my base.
- Our largest retailer cut 2 entry-price items at its spring 2024 line review, effective in May. The buyer cited the price gap to their store brand. Those 2 items were about $4.8M a year in revenue. I can't prove the extra 4% caused it. On paper, that 4% was worth about $2.2M a year.
- 2 of our national competitors didn't follow the increase until autumn 2024. That, more than the delisting, explains the extra volume loss.
- Gross margin went from 30.4% (FY2023) to 33.1% (FY2024). About 1.9 points of that was price. The rest was input costs easing, which I don't claim.

## What went wrong

- Competitor response was the assumption that decided the answer, and it was on page 6. On page 1, with a "competitors don't follow" scenario next to it, the executive team would have seen the real range.
- I didn't put the entry-price risk in dollars. "Delisting risk" lost to "every line moves." "$2.2M of price against $4.8M of revenue at risk" might not have.
- I had no price realization tracker until April 2024. By then 3 months of extra promotions had been spent. The tracker now runs monthly: realized price by customer, list against net, from the same price and trade drivers as the forecast model.

## What I'd do differently

- Lead the memo with the 2 or 3 assumptions that decide the answer, each with its own scenario.
- Build the tracker before the increase goes live.
- When I lose an argument about a number, write the trade-off in dollars into the decision record, so the next decision starts with it.
