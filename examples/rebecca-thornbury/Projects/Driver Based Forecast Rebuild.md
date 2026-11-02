<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Driver-based forecast rebuild

Quillfield Pet Foods, FP&A. Designed and built September 2022 – March 2023, live from the April 2023 forecast. On my resume this is one bullet with 3 numbers. It's the project I'd use to answer "how do you build a forecast", so this file has the whole model: the options I rejected, every driver and its definition, the data behind it, the parallel run and the 2 months when the new model did worse than the old one, who pushed back, and what still isn't solved.

## What it replaced, and why

When I joined in April 2022, the revenue forecast was a shared workbook with 41 tabs. Each of our 9 account managers typed a monthly dollar forecast for their customers, usually last year's number plus a growth rate. Finance added it up, and the VP of Sales made a top-level adjustment before it went to the CFO. It took 6 business days every month.

It was also biased. From April 2022 to March 2023 it over-forecast net revenue in 10 of 12 months, by 3.9% overall. Nobody was lying. A dollar forecast hides its assumptions, so there was nothing specific to argue about, and optimism won by default. The CFO's ask to my director was simple: a forecast we can argue with line by line.

## My role

I designed the driver tree, built the prototype in Excel, wrote the definitions document and the spec for the Anaplan build, ran the 3-month parallel run, and trained the account managers. Our planning systems analyst built the Anaplan modules from my spec. A data engineer built the daily loads of retailer point-of-sale data into Snowflake. My director sponsored the project, and the VP of Sales agreed to a parallel run before anything replaced his team's numbers. It took about 60% of my time from September 2022 to March 2023, next to the monthly commercial finance work.

## The options I tested first

In September 2022 I backtested the alternatives on the 24 months to August 2022: a 1-month-ahead forecast for each month, scored with the weighted MAPE defined below. Rebuilt from the archived workbooks, the old process scored 11.9% on that window.

- Keep the workbook and add a bias scorecard for each account manager. Cheapest, but the bias came from hidden assumptions. A scorecard would tell us someone was optimistic without telling us about what.
- A statistical forecast: exponential smoothing on shipment history for each of the 60 forecast cells, which I built in Python with statsmodels. It backtested at 9.8%. It can't see a new listing, a lost item or a planned promotion until it shows up in history, and an account manager can't argue with a smoothing constant. I kept it as a challenger line in the monthly pack, and it's still there.
- A demand-sensing tool. Our demand planning team had a quote of about $180K a year. It forecast units, not net revenue after trade, and we already paid for Anaplan.
- A driver-based model, which is what I built. The prototype backtested at 6.8%.

## How the model works

Revenue is built from drivers, not typed in. There are 3 blocks.

Retail, mass and pet specialty, about 73% of revenue:
- Distribution points: stores × items carried. A store-item counts if it sold at least 1 unit in 3 of the last 4 weeks.
- Velocity: units per distribution point per week, from point-of-sale data, with a 52-week seasonality index for each category.
- Consumption is distribution points × velocity.
- Shipments are consumption adjusted for the change in retailer inventory, where retailer inventory is weeks of supply × weekly consumption.
- Net revenue is shipments × list price × (1 − trade rate), plus promotion lift by event type. Lift is measured for 5 event types (price reduction, feature, display, feature with display, digital coupon) as event-week units divided by the average of the 4 unpromoted weeks before, from 2 years of point-of-sale data.

E-commerce marketplaces, about 18%: sell-through units and marketplace inventory weeks, with the same shipment logic. The data is weaker: sell-through arrives weekly and inventory only monthly.

Autoship, about 9%: active subscribers by monthly sign-up cohort × retention curve × orders per subscriber per month × average order value. Retention curves are fit by cohort from 3 years of subscription data. New subscribers come from the marketing plan. Failed payments are a separate driver, because involuntary churn moves with card processing, not with the product. In 2022 about 2.4% of renewal charges failed, and retries recovered about half within 7 days.

Point-of-sale data covered our 3 largest retailers, about 70% of retail revenue. For everyone else, velocity comes from shipment history, and every output says which method it used.

## From 31 drivers to 14

The first prototype, in November 2022, had 31 drivers. I tested them on the 2-year backtest by taking each one out and re-running. The 17 weakest together were worth 0.2 points of accuracy (6.6% with all 31, 6.8% with 14) and cost about 2 days a month to update. They included a competitor shelf-price index (mostly already inside velocity), weather, pet ownership trends from a market report, TV spend, shelf-space share and out-of-stock rate.

The 14 I kept: for retail, distribution points, velocity, seasonality, list price, trade rate, the promotion calendar and lift by event type; for marketplaces, sell-through units and inventory weeks; for autoship, new subscribers, retention by cohort, orders per subscriber, average order value and the failed-payment rate. Retailer weeks of supply became the 15th in March 2023.

None of the original 31 was retailer inventory. In the 2 years I tested on, shipments to the 3 big retailers had tracked their consumption within about 2% a month, so I treated them as the same thing. The data engineer hadn't loaded the retailers' on-hand inventory files, and I didn't ask for them.

## The data

- Point-of-sale: weekly units and dollars by store and item from the 3 largest retailers, loaded daily into Snowflake. On-hand inventory was added in March 2023.
- List price and trade: SAP S/4HANA. The trade rate is accrued trade spend divided by gross sales, by customer and category, over the trailing 3 months.
- Autoship: a daily export from the subscription platform.
- The promotion calendar: the sales ops analyst's trade promotion plan.

## How accuracy is defined

I agreed these with my director and the VP of Sales before the parallel run, so nobody could pick a flattering measure afterwards.

- Forecast: the 1-month-ahead forecast, locked in month M−1 for month M.
- Level: net revenue for 12 customer groups × 5 product categories, 60 cells.
- Error: weighted MAPE, the sum of |forecast − actual| across the 60 cells divided by the sum of actuals.
- Bias: (sum of forecast − sum of actual) ÷ sum of actual, over 12 months.
- Before means April 2022 – March 2023 (old process). After means April 2023 – March 2024 (new model).

## The parallel run

From January to March 2023 the old workbook and my Excel prototype each locked a forecast every month, scored on the same 60 cells. The planning systems analyst built the Anaplan version from my spec at the same time.

- January: new model 9.1%, old workbook 8.7%.
- February: new model 8.8%, old workbook 8.4%.
- March, with the weeks-of-supply driver added: new model 6.9%, old workbook 12.6%.

In January and February our largest retailer was cutting inventory across the pet aisle. Consumption held up and shipments fell. My model assumed shipments follow consumption, so it over-forecast that retailer by 6–7%, and that was enough to lose both months overall. 2 account managers had heard about the cut from the retailer's buyer. That was the VP of Sales' best argument at the end-of-March review: keep his team's numbers as the official forecast and use the model as a check.

The CFO decided. The model became the official forecast from April 2023, with an override column: anyone can change a number, but they have to give a reason, and a monthly scorecard shows whether overrides helped. The VP of Sales accepted on one condition, that his team saw the scorecard before anyone else did. That was fair, and I agreed.

## The numbers

- Weighted MAPE: 11.4% → 6.2%. In the second year, April 2024 – March 2025, it was 6.5%.
- Bias: +3.9% → +0.4%. Months over-forecast: 10 of 12 → 6 of 12.
- Company-total monthly error (absolute, averaged over 12 months): 4.6% → 1.9%.
- Forecast cycle: 6 → 3 business days.
- From late 2023, the demand planning team used our forecast as one of their inputs. They had never used the old one.

## What went wrong

- The missing inventory driver, above. I added weeks of supply in March 2023. I came back to this exact driver in 2025, the hard way (`Q3 2025 Forecast Miss.md`).
- I won finance over before I won sales over. For 4 months after go-live the account managers kept their own spreadsheet and sent it to the VP of Sales anyway. The override column and the scorecard ended it. An override counts as helping if it moved the cell closer to the actual. In 2023, overrides helped 38% of the time and hurt 62% of the time, and they fell from about 90 a month to about 25 by December 2023.
- I built 31 drivers before testing which ones mattered. That was about 2 months of work on drivers I later deleted.

## What it changed downstream

- The annual plan's revenue build has run on the model since FY2025. Sales owns the assumptions (new stores, velocity, promotions), not dollar totals (`Annual Operating Plan Cycle.md`).
- The price realization tracker I built in April 2024 reads list price and trade rate from the same model (`Price Increase Business Case.md`).
- In Q3 2025 the weeks-of-supply driver showed our largest retailer's inventory falling, and I kept the account team's number instead. The model was right and my override wasn't.

## What still isn't solved

- The 30% of retail revenue without point-of-sale data uses shipment history for velocity. Its error in the second year was about 9.5%, against about 5.1% for the cells with point-of-sale data. Two more retailers' feeds would cost money we haven't approved.
- The marketplace block still gets inventory only monthly.
- Accuracy is defined 1 month ahead. The quarterly outlook and the plan use longer horizons, and I didn't measure those until after the Q3 2025 miss.
- The definitions document is mine. One of the 2 analysts I mentor, the one promoted to Senior FP&A Analyst in 2025, ran the monthly cycle on her own for the first time that year, and that's the only test of whether it runs without me.

## What I'd do differently

- Put 2 account managers on the design from week 1, not in the training in month 7.
- Model retailer inventory from the start. Shipments are not consumption, and retailers change their inventory targets without telling you.
- Test which drivers explain the variance before building any of them.
