<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Lead time cleanup

Mirrowood Electronics, November 2017 – February 2018, about 14 weeks alongside my normal buying. I was a buyer when it started and a senior buyer when it ended. On my resume it's one bullet: expedite fees and premium freight on my part numbers fell from $214K in 2017 to $78K in 2018. It's small, and it's the first time I fixed a cause instead of paying for a symptom.

## What I found

In October 2017 I pulled every expedite fee and premium freight charge on my part numbers for the first 9 months of the year: $161K, on pace for about $215K. I matched each charge to its purchase order. On 71% of the expedited lines, the planned lead time in our ERP was shorter than the lead time the supplier had quoted when we placed the order. The median gap was 4 weeks. MRP released those orders 4 weeks late, and I paid to make up the time.

Nobody owned the lead time field. Most values were set when a part was first loaded, some as far back as 2012, and never touched again.

## What I did

- Scope. I bought about 1,900 part numbers, too many to fix by hand in a quarter. I took the 640 with demand in the next 26 weeks, about 85% of my spend. A wrong lead time on a part with no demand costs nothing until it has demand.
- I sent each of 19 suppliers and distributors a list of their parts with our planned lead time, and asked for their current lead time in writing. Getting every answer took 6 weeks; 2 distributors needed 3 reminders.
- 410 of the 640 changed: 318 went up, by a median of 3 weeks, and 92 went down. My manager approved the change, and I made the updates myself.
- I added a "last confirmed" date to each part's record, with a rule: the top 200 parts by spend are reconfirmed every quarter, the rest every year. I kept it running until I left in April 2019.

## The numbers, with definitions

- Expedite fees plus premium freight on my part numbers, from supplier invoices and freight bills charged to my purchase orders, by calendar year: $214K in 2017, $78K in 2018. My spend was about $24M in both years.
- Part of the drop overlaps with the bare-board consolidation I ran in 2018 (7 suppliers to 4). Most of the 2017 charges were on passives and connectors, where the supplier base didn't change, so I believe most of the drop is the lead times. I can't split it exactly, and I say so.

## What went wrong

I loaded all 318 increases in one afternoon in January 2018. The next MRP run treated the earlier order dates as already missed and created about $1.1M of purchase requisitions marked past due. I placed most of them within 2 weeks. My raw material inventory rose about $600K over the quarter, and finance asked why before I'd told them. It was back to normal by June. I should have loaded the increases in weekly batches by supplier, and warned planning and finance first.

## What I kept from it

When expedite costs rise, the first thing I check is the lead time data, before I blame the supplier.
