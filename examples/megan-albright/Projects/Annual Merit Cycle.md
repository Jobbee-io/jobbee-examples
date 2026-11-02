<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Annual merit cycle: the 2025 cycle, start to finish

Orrinvale Health. Planning started in November 2024; increases took effect April 1, 2025. I've run the cycle 4 times (2023 through 2026). On my resume it's one bullet with 3 numbers. This file is the 2025 cycle in full: the budget negotiation, the matrix and how I costed it, the build, training, VP reviews, the 2 things that went wrong, and what changed for 2026. The last sections put the 4 cycles side by side and list what still isn't solved. All figures are aggregates; no individual's pay or rating appears here.

## What the cycle is

Once a year every eligible employee's base pay is reviewed. There are 3 pots of money: merit (pay for performance in the same job), promotions, and market adjustments (for jobs whose market rate moved faster than our ranges). In 2025, 1,912 employees hired before October 1, 2024 were eligible, with $198.6M of eligible base payroll. 236 managers entered recommendations, 11 VPs reviewed their organizations, and the CEO and CFO approved the total.

There's no equity in it. Orrinvale is private, and the leadership incentive pool (about 90 people) runs on its own calendar.

## My role

I owned the cycle end to end: the budget proposal, the merit matrix and guidelines, the requirements for the Workday build, manager training, the VP reviews, the final reconciliation and the letters. My director approved the guidelines and took the budget to the CFO with me. Our compensation analyst ran manager office hours and checked the letters. Our HRIS partner owned the system build. From November to April the cycle takes about half my time.

## Who sees what

- Managers see only their own team's pay, range and rating in the worksheet. VPs see their organization. My director, our analyst and I see the whole file.
- Every report I take to a VP review is at organization or job family level. Where a rating group has fewer than 10 people, I combine it with the next group instead of showing it.
- Letters go to managers, who deliver them in a conversation. Nobody learns their increase from an email.

## The budget (November)

I proposed 3.5% merit, 1.0% promotions and 0.4% market adjustments: 4.9% in total, $9.73M. The inputs:

- 2 salary-budget surveys. For companies like ours, median planned merit budgets for 2025 were 3.4% and 3.6%, and median range movement was about 3.0%. Merit at 3.5% with ranges moving 3.0% lets people progress through their range a little each year.
- Position in range across eligible employees: 18% below 0.90 of midpoint, 68% between 0.90 and 1.10, 14% above 1.10.
- Voluntary turnover by job family. 11.8% company-wide in 2024, above 15% in 6 families.
- Promotions. Under the promotion guideline that started in May 2024 (`Promotion Pay Guideline.md`), off-cycle promotions had run at a median of about 10%. 1.0% was about 200 promotions at that median.

Finance opened at 4.5%: keep merit and promotions, drop the market pot. Their objection was fair: a market pot without names turns into a second merit pot that managers spend on whoever asks loudest. We settled at 4.9% once I limited the market pot to 6 named job families. Each one had survey data showing its market had moved at least 5% more than our ranges over 2 years, and turnover above 15%. Implementation was one: its market had moved about 7% in 2 years, and its turnover was 19%. Proposal November 4, finance's counter November 18, agreed December 2.

## The matrix (December)

Guideline ranges by performance rating and position in range. Anyone above their range maximum gets the increase as a lump sum instead of base.

| Rating | Below 0.90 | 0.90 to 1.10 | Above 1.10 |
|---|---|---|---|
| Exceeds | 5.0–7.0% | 4.0–5.5% | 2.5–4.0% |
| Meets | 4.0–5.0% | 2.75–3.75% | 1.5–2.5% |
| Partially meets | 0–2.0% | 0–1.5% | 0% |
| Does not meet | 0% | 0% | 0% |

I costed it at the 2024 rating distribution (24% Exceeds, 68% Meets, 6% Partially meets, 2% Does not meet) and the position-in-range mix above. At the middle of each guideline, merit cost 3.4%. That left managers a little room under the 3.5% budget to go to the top of a range for some people.

Why this shape: 3 position bands, not 5, because a manager has to be able to explain the matrix in 2 sentences. The 4 rating levels come from the performance process, which isn't mine. The lump sum above maximum keeps a red-circled person's base from drifting further out of range, without telling them they get nothing.

## Build and training (January)

- Ranges moved up 3.0%.
- The worksheet opened pre-filled with each person's range, position in range, rating and guideline. No proration: the October 1 hire-date cutoff did that job. I wrote the requirements, the HRIS partner built it, and I tested 40 sample worksheets myself before launch.
- 4 manager trainings of 45 minutes. 197 of the 236 managers attended live, and the rest got the recording. A one-page guide, and office hours twice a week run by our analyst.

## Worksheets and VP reviews (January 27 – February 28)

Worksheets were open January 27 to February 14. VP reviews ran February 17 to 28, one per organization. Each VP got a pack with:

- spend against budget, by pot;
- the share of increases outside their guideline range, each with the manager's one-line reason;
- outliers: any increase more than twice its guideline midpoint;
- promotions: count and median increase.

In 2025, 6.1% of merit increases were outside the guideline range, against 11% in 2024. 4 of the 11 VPs changed something in their organization after review.

## Approval and letters (March)

Before final approval on March 10, I reran the pay equity model on the proposed salaries (method in `Pay Equity Audit.md`). The adjusted gender gap was 0.5% going in and 0.4% after the proposals, neither statistically significant. Letters were generated in Workday, and our analyst checked every one against my final file. They went to managers on March 24, and increases took effect April 1.

## The numbers, with their definitions

- Budget: 4.9% of eligible base payroll ($9.73M). Spent: 4.82% ($9.57M). Merit 3.47%, promotions 0.96%, market adjustments 0.39%.
- Promotions: 201, with a median increase of 10.0%. The median was 10.0% for women and 10.2% for men. Before the promotion guideline, that gap was 2.5 points.
- Letter corrections: letters changed after release because a number was wrong. 3 out of 1,912 in 2025.
- Manager survey, "I understood the guidelines well enough to explain them": 84% agreed in 2025.

## What went wrong

- The rating distribution. Company-wide, 24% of employees were rated "Exceeds". In Engineering, about 430 eligible employees, it was 38%. I saw it in the data in January and decided it was a performance question, not mine. It became mine at VP review: Engineering's merit spend came in at 3.9% of its payroll against a 3.5% guideline, about $240K over. The CFO approved covering it from other organizations' underspend, and 2 VPs were rightly unhappy that their savings paid for someone else's ratings. I should have raised it before worksheets opened, while it was still a conversation and not a budget fight.
- The range load. The 3.0% range refresh loaded correctly for 12 job families. For Implementation and Customer Success (241 employees), job profiles had been restructured in December, and the old ranges loaded. For 4 days those managers saw position-in-range numbers about 3% too high. My day-3 check (position-in-range distribution by family, compared with last year) caught it. 19 managers had already submitted. We reopened their worksheets, and I wrote to each of them with what changed and why.

## What changed for 2026

- A rating distribution check before worksheets open. Any job family above 30% "Exceeds" gets a calibration conversation with its VP before money is involved. In 2026 Engineering came in at 29%.
- A reconciliation before launch: every range in Workday compared with my range file, 100% match required to open. 0 mismatches in 2026.
- The pay equity rerun stays at the same step. It's cheap, and it's the check that tells me the cycle didn't undo the audit.

## The 4 cycles side by side

| Cycle (effective April 1) | Eligible | Budget | Spent | Letter corrections | Managers who could explain the guidelines |
|---|---|---|---|---|---|
| 2023 | 1,652 | 4.6% | 4.55% | 19 | 57% |
| 2024 | 1,781 | 4.4% | 4.36% | 8 | 71% |
| 2025 | 1,912 | 4.9% | 4.82% | 3 | 84% |
| 2026 | 1,948 | 4.5% | 4.47% | 2 | 86% |

- 2023, my first, ran before the leveling framework existed (`Job Leveling Framework.md`). About 45% of jobs had no range, so for those the guideline was by rating only. The worksheets were in Workday, but the letters were a mail merge from an Excel export, and most of the 19 corrections came from one column where a lump sum was read as a base increase.
- 2024 was the first cycle on the new structure, with the rating-by-position matrix and letters generated in Workday. Promotions still had no guideline; the audit hadn't finished.
- 2025 added the promotion guideline, the named-family market pot and the pay equity rerun.
- 2026 added the rating distribution check and the range reconciliation. The budget was 3.3% merit, 1.0% promotions and 0.2% market.

## What's still open

- Rating inflation. The 30% check moves the conversation earlier. It doesn't settle what "Exceeds" means; that belongs to the performance process, owned by the talent team.
- The 14% of managers who still can't explain the guidelines are mostly in their first cycle. In 2026 I added a 20-minute session just for them; it's too early to say it worked.
- Ranges are refreshed once a year from survey data that's 6 to 12 months old. For fast-moving families, the market pot does the catching up, and Implementation has needed it 2 years running. That's a sign its range is wrong, not that its people need a yearly top-up.
- Lump sums above maximum. About 40 employees a year get their increase as a lump sum, and some are on their third year without a base increase. Reviewing the red-circle policy is on my list for 2027.
