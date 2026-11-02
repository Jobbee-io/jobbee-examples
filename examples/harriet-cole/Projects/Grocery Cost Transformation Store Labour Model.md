<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Grocery cost programme: the store labour model

Companion to `Grocery Cost Transformation.md`, the overview of this engagement. This file covers the model I built for the store labour workstream: its structure, the data, the time standards, how the opportunity was sized, how I validated it, why the pilot failed, and how I rebuilt it.

## What the model answers

For each of about 420 stores: how many hours a week the work should take at that store's volumes, task by task, compared with the hours the store actually paid for. I built it in March and April 2022, in Excel, with Alteryx preparing the data. The build was mine. The online picking hours came from the online fulfilment workstream's own model, run by another consultant, and went in as an input.

## Structure

7 task families, 34 tasks. Each variable task has a driver and a time standard, in hours per unit of driver.

- Replenishment: cases delivered, plus back-room work and date rotation. The biggest family, about 38% of modelled hours in large stores.
- Checkouts: staffed-till hours from transactions per hour and the share going through self-checkout, plus self-checkout supervision by the number of units.
- Online picking: taken from the online workstream's model.
- Counters and bakery: counter opening hours and bake batches.
- Cleaning: floor area and opening hours.
- Customer service and security: set by store format.
- Management and admin: a fixed amount per store, plus a small amount per colleague.

Fixed hours sit under all of it: at least 2 colleagues on the shop floor whenever the store trades (the client's lone-working rule), management cover, and opening and closing routines. Fixed hours were about 30% of modelled hours in convenience stores and about 12% in large stores. That's why convenience stores had less opportunity each, and why the opening-hours lever existed at all.

Variable tasks carry a 12% allowance for breaks and unavoidable delay, agreed with the client's work-study manager.

## Data

- 2 years of weekly data for all 420 stores, FY2020/21 and FY2021/22: till data by hour (transactions, items, self-checkout share), deliveries (cases per delivery and arrival time), rotas (scheduled hours by task code), and store attributes (format, floor area, back-room area, counters, refit date).
- Alteryx joined it into one store-week table of about 43,700 rows. The Excel model ran one calculation per store format.
- FY2020/21 was a pandemic year with unusual volumes. I used it only to fit the relationships between drivers and hours. The baseline is FY2021/22.
- Rota task codes were used loosely: about 40% of scheduled hours carried a generic code. So actual hours by task were estimates, and only store totals were solid. That's why the opportunity is measured on store totals, not task by task.

## Time standards

The operations director named 12 stores as the best-run in the estate. For each variable task, the standard was the median hours per unit of driver across those 12, from their rota, till and delivery data, checked against 3 days of observed timings in 4 of them.

All 12 had been refitted in the last 5 years. I didn't check that when I chose them.

## Sizing the opportunity

- Gap per store: FY2021/22 paid hours minus modelled hours, with a tolerance of 3% either way.
- 291 stores were more than 3% above the model: £17.1m of hours a year. 87 were more than 3% below: £3.1m of hours they needed. 42 were within 3%.
- Net, the "hours set by the model" lever was £14m. Why net and not gross is in the overview.

I sized the other levers on the same engine, in sequence, so they couldn't double-count: model hours first, then night-fill, then checkouts.

- Night-fill, £8m. In the time studies, night replenishment ran about 30% faster per case: no customers in the aisles and bigger crews. Night hours cost the client about 15% more. The lever applied only to the 96 large stores that met the back-room and delivery-time rules.
- Checkout staffing, £3m. The self-checkout share of transactions had gone from about 35% to about 48% in 2 years, and staffed-till hours hadn't moved. The model set staffed hours on a curve of transactions and self-checkout share.
- Self-checkout expansion in 60 stores, £3m, and shorter opening hours in 40 convenience stores, £3m.

## Validation, and why it didn't catch the problem

Before the business case went to the executive team, I tested the model on 30 stores the operations director named as well run. Modelled hours came within 5% of paid hours in 26 of them. But 24 of the 30 were refitted stores. The validation shared the bias of the sample, so it couldn't have caught a layout problem.

The store visits should have caught it. Store managers in 3 older stores told me their layouts were slower to fill. I wrote it in my notes and didn't change the standards.

## The pilot

The store operations planning team chose 8 pilot stores to represent a typical store. All 8 were older, and none had been refitted. In August 2022 we cut their replenishment hours by 14%, to the model.

Within 4 weeks, on-shelf availability fell from 96.1% to 94.3%, and complaints about empty shelves roughly doubled. Availability is the share of planogram lines found on the shelf in the client's daily 10:00 gap scan, averaged over the week.

The cause was layout. Older stores have smaller back rooms and narrower aisles, so filling takes more trips, and stock that doesn't fit on the shelf goes back to the back room and comes out again later. My standards had no time for that. We stopped the cut in week 4.

## The rebuild: 3 layout bands

I re-timed replenishment over 3 weeks in 6 older stores, 3 of them pilot stores, and split the estate into bands:

- Band A: refitted in the last 5 years, about 150 stores. Standards unchanged.
- Band B: older, with a standard back room, about 170 stores. Replenishment standards up 8%.
- Band C: older, with a small back room or narrow aisles, about 100 stores. Replenishment standards up 17%.

Then every store manager got 2 weeks in October 2022 to challenge their hours with evidence. 64 did. 23 challenges were upheld, almost all in bands B and C, mostly for unusual layouts such as a back room on a different floor. Those went into the standards.

The rebuilt standards, with the upheld challenges, were worth £2m less than the originals. The pilot stores were back to 96.0% availability by week 10. Wave 1 of the rollout, in November, was mostly band A stores.

## What I'd defend

- A task-based model instead of last year's hours. It's the only way to say what a store should need.
- Netting off the understaffed stores.
- Measuring the gap on store totals, given how unreliable the task codes were, even though it made the model harder to explain store by store.

## What I'd change

- Draw the standards from stores across all layouts from the start, not from the best stores.
- Validate on stores the standards didn't come from, and make sure old layouts are in that set.
- Ask store managers to challenge before the pilot, not after it.
- When a store manager tells me something the data can't show, test it that week.

## Still open at my handover

- Rotas still didn't record tasks reliably, so the model couldn't be checked task by task.
- 74 of about 170 large stores stayed on daytime replenishment, waiting for delivery times the distribution workstream hadn't fixed.
