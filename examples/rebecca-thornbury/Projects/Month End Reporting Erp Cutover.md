<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Month-end reporting through the ERP cutover

Velloway Air Systems, FP&A. January – December 2021; the new system went live in July 2021. On my resume this is one bullet, under a job I left in 2022. This file says which part of the ERP project was mine, which part wasn't, and how a plant controller caught a $1.3M mapping error before I did.

## The full story

In 2021 Velloway's private-equity owner required a new ERP. The company had run a heavily customized JD Edwards system for about 15 years, and the CFO and IT chose SAP S/4HANA with an outside implementation firm. The Controller led the finance workstream and I was its FP&A member. The management reporting pack was my part: 46 manual spreadsheet steps, a flash report on business day 8 and the full pack on day 10, with lender reporting due on day 15.

From January to March I mapped 2,400 legacy accounts to the new 610-account chart, in workshops with the Controller's team and both plant controllers. From April to June I built the pack in Power BI in the test environment and ran the April, May and June closes through both systems, reconciling each plant's P&L to within $5K a line. I also redesigned the flash around numbers that were final by day 3.

Go-live in July was rough. The first close took 11 business days for accounting and 14 for the pack, 1 day before the lender deadline. I had planned as if the pack would be ready on day 10 no matter what, with no buffer. In August a plant controller found $1.3M of inbound freight on the wrong product line, because I had mapped one cost center to the wrong line. My reconciliation had checked plants, where the error netted out, not product lines, where people made decisions. I added a product-line reconciliation and a monthly mapping check. I also kept a bridge spreadsheet from old accounts to new alive until December, and 2 people kept using it, so 2 versions of the numbers circulated for 5 months.

By the Q4 2021 closes the flash was out on day 4 and the pack on day 6, with 9 manual steps instead of 46. The Controller's team cut the accounting close from day 6 to day 4, and the pack depends on that. The bridge was turned off in December. Nothing on my list was still open when I left Velloway in March 2022, and I don't know how the pack has changed since.

## What it was

Velloway's private-equity owner required a new ERP. The company had run a heavily customized JD Edwards system for about 15 years. The CFO and IT chose SAP S/4HANA, with an outside implementation firm. The Controller led the finance workstream, and I was its FP&A member.

For FP&A, the stakes were the management reporting pack: P&L by plant and product line, variance to plan, and the operating metrics the CEO and the private-equity owner read every month. It was built from JD Edwards extracts with 46 manual spreadsheet steps. The flash report came out on business day 8 after month end and the full pack on day 10. Our lender reporting was due on day 15.

## My role

I owned the mapping of 2,400 legacy accounts to the new 610-account chart for management reporting, the rebuild of the pack in Power BI on the new system's data, a faster flash report, and the reconciliation of the pack between the old and new systems before go-live.

The accounting close and the design of the new chart of accounts belonged to the Controller's team. System configuration and data migration belonged to IT and the implementation firm.

## How it went

- January – March: mapping workshops with the Controller's team and both plant controllers. About 700 of the 2,400 accounts had no activity in 2 years and were dropped.
- April – June: built the reports in the test environment, then ran the April, May and June closes through both systems. I reconciled the P&L for each plant, line by line, old against new, to within $5K per line.
- July: go-live, and the first close in the new system.
- August – December: fixes, then turning the old things off.

The flash report is the design change I'm proudest of. The old flash waited for most of the close. The new one used shipments, standard margins and payroll, which were final by day 3, and flagged the 4 lines that usually moved after that.

## The numbers

Business days are counted after month end. By the Q4 2021 closes:

- Flash report: day 8 → day 4.
- Full management pack: day 10 → day 6.
- Manual spreadsheet steps in the pack: 46 → 9.
- The accounting close went from day 6 to day 4. That was the Controller's team's work, not mine. The pack depends on it.

## What went wrong

- The first close after go-live took 11 business days for accounting and 14 for the pack, 1 day before the lender deadline. I had planned as if the pack would be ready on day 10 no matter what, with no buffer.
- In the August review, a plant controller found $1.3M of inbound freight booked to the wrong product line, because one cost center was mapped to the wrong line. My reconciliation had checked the P&L by plant, where the error netted out. It didn't check by product line, which is where people made decisions. I added a product-line reconciliation and a monthly mapping check.
- I kept a spreadsheet bridge from old accounts to new ones alive until December, just in case. 2 people kept using it instead of the new reports, so 2 versions of the numbers circulated for 5 months. I should have set a turn-off date before go-live.

## What I'd do differently

- Reconcile at the level where decisions are made, not the level that's convenient.
- Plan the first 2 closes after go-live with a later pack date, and tell the lender in advance.
- Put the bridge's turn-off date in the project plan before go-live.
