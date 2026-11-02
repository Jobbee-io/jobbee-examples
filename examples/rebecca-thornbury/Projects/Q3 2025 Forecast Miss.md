<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Q3 2025 forecast miss

Quillfield Pet Foods, July – October 2025. On my resume this is one bullet and the first entry under failures. This is the full account: the number, what I had in front of me when I made it, and what I changed.

## The miss

At the start of each quarter I lock a quarterly outlook. The CFO uses it in the board update and in our monthly reporting to the lender. I locked Q3 2025 on July 8.

- Revenue outlook $166.5M, actual $161.3M: 3.1% high.
- Adjusted EBITDA outlook $23.1M, actual $20.5M: $2.6M high.
- Monthly forecast error (weighted MAPE, defined in `Driver Based Forecast Rebuild.md`) was 9.6% for July – September, against 6.2% in the model's first year.

It was our biggest quarterly miss since the driver model went live. It didn't put our loan covenants at risk. It did cost the forecast some of the credibility I had spent 2 years building.

## Where the $5.2M went

- $4.5M: our largest retailer (about 24% of our revenue) cut its weeks of supply on our items from 5.5 to 4.0 during August and September. Consumption held up. Shipments didn't.
- $0.4M: autoship. A change to card processing in August raised failed payments for 3 weeks.
- $0.3M: small shortfalls across other customers.

## What I knew on July 8

The weeks-of-supply driver was in the model because of early 2023. The point-of-sale feed showed that retailer's on-hand inventory falling from 5.5 weeks to 4.9 over the 6 weeks before I locked. The account manager told me their inventory policy hadn't changed; the buyer had told him so in May. I kept 5.5 in the base case and gave a single number with no range.

By mid-July the data showed 4.7. I mentioned it to my director in our weekly meeting as something to watch. I didn't change the outlook and I didn't send a note. The CFO first heard about it with the August flash results in early September, 2 months into the quarter.

The $0.7M from autoship and the smaller customers I couldn't have seen. The $4.5M I could have.

## What I did after

I wrote the variance memo within 3 business days of the quarter close, split into knowable ($4.5M) and not knowable ($0.7M), with my own call in the first paragraph. I walked through it with my director and the CFO. The Q4 outlook went out with a low, base and high case. I proposed 3 changes, and the CFO made them the team standard:

- Ranges. Every outlook has a low, base and high case and names the 3 assumptions that move it most.
- Weekly tripwires. 6 indicators with thresholds: weeks of supply at our 3 largest retailers (more than 0.3 weeks off the assumption), point-of-sale velocity against forecast (more than 5% off for 3 weeks in a row), autoship failed-payment rate (above 3.5%), promotion lift against plan, marketplace inventory weeks, and fill rate on our top 10 items (below 95%). When one is crossed, my director and the CFO get a written note within 2 business days with a revised range.
- An assumptions log. Input from the account teams goes in with a name and a date, next to the data. If the data and the input disagree for 2 weeks, the data goes in the base case and the input becomes the high or low case.

## Since then (Q4 2025 – Q3 2026)

- Average absolute error on the quarterly revenue outlook: 1.1%.
- Actuals landed inside the stated range in 3 of 4 quarters. Q1 2026 came in 0.4% below the low end after a winter storm closed our Texas plant for 4 days in January. I count it as a miss anyway.
- The tripwires fired 7 times. 5 led to outlook changes. 2 were noise.

## What I'd do differently

The right move on July 8 cost one sentence: "The base case assumes the retailer holds 5.5 weeks of supply, per the account team; the data shows 4.9 and falling; at 4.0 the quarter is about $4.5M lower." I had every number in that sentence. I didn't write it because a range felt like hedging, and because the account manager was confident. A range isn't hedging. It is the forecast.
