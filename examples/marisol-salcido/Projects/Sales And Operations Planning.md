<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Setting up sales and operations planning

Verdillo Power Systems, energy storage business unit, April 2023 – June 2024. I designed the process and ran it for 14 monthly cycles, alongside my sourcing job, then handed it to the planning manager. On my resume it's one bullet. This file holds why it existed, who owned what, how a cycle worked, the numbers with their definitions and the parts I don't claim, and the 4 months it took to stop being a data review.

## The full story

Before April 2023 the energy storage business unit ran on 3 forecasts. Sales ops kept one, planning ran MRP from a copy of it, and finance had its own. Sourcing bought from whatever MRP said. My power module overbuy came out of the gaps between them, and in March 2023 the VP of supply chain asked me to fix it.

I designed the process: the charter, the monthly calendar, the templates and the commitment register. I chaired the supply review and the pre-S&OP, and facilitated the executive meeting, which the general manager chaired and where he made the decisions. Sales ops owned the base forecast, planning owned the range and the supply plan, and finance owned the financial view. A BI analyst built the dashboard to my spec.

The first months didn't work. For 3 cycles the executive meeting was 2 hours over 40 slides, a data review, and the CFO's delegate twice sent an analyst instead. In cycle 4 I cut it to 6 pages of decisions. For 4 cycles I also chased one agreed number, and the sales ops lead felt we were auditing his forecast. In cycle 5 we switched to a range and gave sales the demand review agenda, and the arguing stopped within 2 cycles. In cycle 6 my hand-kept register missed a $600K capacitor buffer order, and planning automated it from the ERP. By cycle 8, in November 2023, the register was doing its job: it showed our new magnetics agreement sat above the low case for early 2024, and the general manager used the agreement's flex to cut first-quarter orders by 15%.

After 14 cycles, in June 2024, I handed the process to the planning manager, who runs it now. Forecast accuracy had gone from 58% to 74%, and raw-material days of supply from 112 to 74. Running it took about a day a week on top of my categories, and my magnetics renewal ran 3 weeks late because of it.

What's still open is the measurement. Inventory fell $23M and expedite costs by more than half over the same months, but the end of the shortage and lower demand explain part of both. I can't split them cleanly. I don't claim the $23M of inventory, and when I quote the expedite drop, I say the end of the shortage explains part of it.

## Why it existed

Before this, the business unit had 3 forecasts. Sales ops kept one in a spreadsheet and updated it each quarter. Planning ran our MRP from a copy of it. Finance had its own. Sourcing bought from whatever MRP said. Nobody owned the gaps between them.

My power module overbuy came straight out of that gap (`Power Module Overbuy.md`). In March 2023 the VP of supply chain asked me to fix it. I think he picked me partly because I had the most expensive reason to care.

## My role, and the team's

I designed the process: the charter, the monthly calendar, the templates and the commitment register. I chaired the supply review and the pre-S&OP meeting, and facilitated the executive meeting for all 14 cycles. The sales ops lead owned the base demand forecast. The planning manager owned the demand range and the supply plan. Finance owned the financial view. A BI analyst built the Power BI dashboard from our ERP data to my spec. The business unit's general manager chaired the executive meeting and made the decisions.

## How it worked

A monthly cycle in 5 steps, counted in workdays (WD) after month end, on an 18-month horizon:

1. WD3: data close. Shipments, orders, inventory and open commitments frozen for the month.
2. WD6: demand review. Sales ops, product management and finance agree the base forecast by product family.
3. WD9: supply review, which I chaired. Planning, sourcing and manufacturing check capacity, material constraints and the commitment register against the demand range.
4. WD12: pre-S&OP. The gaps that need a decision, each with options and their cost.
5. WD15: executive S&OP, 60 minutes. Decisions only.

Two pieces did most of the work. Demand is a range, not a number: sales owns the base case, and planning sets the low and high cases from the last 12 months of forecast error. And the commitment register lists every open NCNR order, long-term agreement and buffer buy, set against the low case. Anything above the low case gets a named owner and an exit date.

A typical decision: in cycle 8 (November 2023), the low case for the first half of 2024 sat about 20% under the volumes in our new magnetics agreement. The register flagged it, the pre-S&OP put 2 options on one page, and the general manager approved using the agreement's quantity flex to cut first-quarter magnetics orders by 15%. Before S&OP, nobody would have looked at that agreement until the parts arrived.

## The numbers, with definitions

- Forecast accuracy: 1 minus weighted MAPE (mean absolute percentage error), by product family, at a 3-month lag, weighted by revenue. 58% before (October 2022 – March 2023, rebuilt from the old forecasts) and 74% after (January – June 2024 average).
- Raw-material days of supply: raw material inventory at standard cost, divided by average daily material use over the next 90 days of the plan. 112 days in March 2023, 74 in June 2024.
- Inventory: the business unit's inventory went from $94M to $71M over the same period. I don't claim the $23M. About $9M of it was shortage-era buffers in semiconductors and passives being used up, which would have happened anyway. The rest moved with lower demand too, and I can't split it cleanly.
- Expedite costs, meaning premium freight plus supplier expedite fees: $1.12M in the 12 months to March 2023, $460K in the 12 months to June 2024. The end of the shortage explains part of that, and I say so when I quote it.

## What went wrong

- For the first 3 cycles the executive meeting ran 2 hours over 40 slides, and it was a data review. The CFO's delegate sent an analyst twice. In cycle 4 I cut it to 6 pages: the 3 biggest gaps, each with options, costs and a recommendation.
- For 4 cycles I chased one consensus number. The sales ops lead felt the process was supply chain auditing his forecast, and he wasn't wrong about how it looked. In cycle 5 we switched to the range, and I gave sales ownership of the demand review agenda. The arguing stopped within 2 cycles.
- The commitment register started as a spreadsheet I kept by hand. In cycle 6 it missed a $600K capacitor buffer order a buyer had placed. Planning then automated it from open orders and agreement data in the ERP.

## What I'd do differently

- Start with the range and the register. The meeting is the least important part.
- Give sales the demand review from the first cycle.
- Plan the handoff on day 1. Running it took about a day a week for 14 months on top of my categories, and my magnetics renewal ran 3 weeks later than I'd planned because of it.
