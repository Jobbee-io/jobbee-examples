<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Grocery cost programme: the savings tracker

Companion to `Grocery Cost Transformation.md`, the overview of this engagement. This file covers how the store labour savings were counted: the definitions, the baseline, the weekly tracker, the switch from scheduled to paid hours, and the walk from £31m identified to £21m realised, lever by lever.

## Why it needed its own rules

Cost programmes get quoted at the business-case figure, but finance only sees what reaches the ledger. I ran the store labour tracker with the client's finance business partner from June 2022 to February 2023. She signed off every realised number, and nothing reached the realised column without her.

## Definitions, agreed with finance in June 2022

- Baseline: paid hours by store for FY2021/22 (March 2021 – February 2022), and each store's FY2021/22 average hourly cost including employer on-costs.
- Saving: (baseline hours adjusted to current volume − actual paid hours) × baseline hourly cost.
- Constant volume: if a store's volumes grew 4%, its baseline hours went up by the model's hours for that 4%. Growth can't eat a saving, and falling volume can't create one.
- Baseline hourly cost: the 2022 and 2023 wage rises don't count as cost increases or as savings. The programme changed hours, not pay rates.
- Run-rate: annualised at the end of the period.
- The 4 stages. Identified: in the business case. Approved: signed off by the executive team. Implemented: the store's new rota is live. Realised: visible in paid hours from payroll against the baseline, and signed off by finance.

## The weekly tracker

- One row per store, lever and week, in Excel, fed by Alteryx.
- June and July 2022: scheduled hours from the rota system, available the Monday after each week.
- From August: paid hours from payroll, which arrive about 2 weeks after the week. From then on the tracker ran 2 weeks behind.
- A weekly review with the finance business partner, and a monthly report to the programme board.

## The switch from scheduled to paid hours

The first lever to move, from June, was not backfilling vacancies in stores above the model. The rotas showed hours falling. I used scheduled hours because they arrived 2 weeks sooner than payroll and the first board report was due in July.

In early August I switched to paid hours. In about 30 stores, managers had covered the unfilled vacancies with overtime that the rotas didn't show. The reported savings fell by £1.4m in one week.

The finance director asked why the July number had been wrong. My answer was that it measured the rota, not the cost, and that I should have started with payroll. From then on the tracker used paid hours only, and area managers got a weekly overtime report by store.

The report didn't fix it. Overtime needed no approval, and the same 30 or so stores still had the £1.4m in FY2023/24.

## Implemented and realised, side by side

The programme's board pack called rota changes "delivered". In October 2022 I asked for 2 columns instead, implemented and realised, and the finance director agreed. At my handover at the end of February 2023, implemented was £23m and realised run-rate was £16.2m, because the wave 3 stores had only 2 to 4 weeks of payroll behind them.

## From £31m to £21m, lever by lever

| Lever | Identified | Approved | Implemented | Realised FY2023/24 |
|---|---|---|---|---|
| Hours set by the model | £14m | £14m | £12m | £10.6m |
| Night-fill in large stores | £8m | £8m | £8m | £7.4m |
| Checkout staffing | £3m | £3m | £3m | £3m |
| Self-checkout expansion, 60 stores | £3m | £3m | — | not counted |
| Shorter opening hours, 40 convenience stores | £3m | — | — | — |
| Total | £31m | £28m | £23m | £21m |

- Hours set by the model: £2m went back into hours after the pilot, when the standards were rebuilt in layout bands (`Grocery Cost Transformation Store Labour Model.md`). Then £1.4m of overtime kept it from being fully realised.
- Night-fill: 7 of the 96 stores moved replenishment back to daytime, mostly because they couldn't recruit or keep night colleagues. That cost £0.6m.
- Checkout staffing: the cleanest lever. The hours followed a curve already visible in the till data, and store managers could see why.
- Self-checkout expansion: approved, then moved to the next year by the November 2022 capex freeze. The client installed the units in 2024 under its own capex plan, and its report tracks them on a separate line. I don't count them.
- Opening hours: identified, not approved.

£21m is about 3.4% of the roughly £610m store labour cost.

## How I know the £21m

The client's year-end programme report came to Corriemoor in April 2024 with a request for follow-on work. It showed FY2023/24 paid hours against the baseline at constant volume, signed off by client finance. I checked it with my former counterpart, the finance business partner. I haven't seen the ledger myself, and I have nothing after FY2023/24.

## What is still weak about the method

- The volume adjustment uses the same model that set the hours. If the standards are too generous, the adjusted baseline rises and the saving looks bigger. Finance accepted the method, and we agreed client finance would recompute 20 stores a quarter by hand from payroll and till data. I don't know whether they kept doing it after I left.
- Holding the hourly cost at the baseline means the pound figure understates the cash saved after 2 wage rises. I'd still count it this way, because it measures what the programme changed and nothing else.
- The tracker counted hours, not availability. The pilot showed that hours can come out while service gets worse, and the tracker would never have shown it.

## What I'd do differently

- Paid hours from day 1, agreed with finance before the first report.
- Implemented and realised as separate columns in the first board report.
- An overtime approval rule as part of the lever, so hours that leave the rota can't come back as overtime.
- On-shelf availability in the same weekly report as the savings, store by store.
