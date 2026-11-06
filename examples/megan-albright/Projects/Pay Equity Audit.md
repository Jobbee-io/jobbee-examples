<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Pay equity audit: the first one, under privilege

Orrinvale Health, September 2023 to April 2024. On my resume this is one bullet with the before and after. The audit was run at the direction of outside counsel, so the model details and the results by job stay with the company. This file holds the method, my role, my mistakes, and the aggregate numbers the company itself shared with all employees in May 2024. No individual's pay appears here, and no group smaller than 10.

## The full story

By mid-2023 the leveling framework had given every employee a job and a level, so for the first time we could compare like with like. On that year's engagement survey, "I believe I'm paid fairly compared to my peers" was our lowest item, at 49%. My director and I proposed an audit. The CHRO and general counsel approved it in August 2023, and outside counsel directed it.

I built the dataset, which took 6 weeks, partly because I had to rebuild dates into level for about 300 employees from the company we acquired in 2021. I wrote the analysis plan and ran the models in R. Counsel's labor economist replicated my work and challenged it, and the turning point came from that challenge. My first model controlled for performance rating and put the gap at 1.4%. The economist asked whether the ratings themselves were unbiased. In 2 job families, women were rated "Exceeds" less often than men in the same jobs. With rating out of the main model, the adjusted gap was 2.3%. I should have asked that question myself. My director also caught a 7-person team in my first VP deck before it went out.

I proposed the flag rule and the budget, and reviewed every flagged case with the VPs. My director decided the remediation with the CHRO and CFO: 168 employees adjusted, $574K a year, effective April 1, 2024. Managers heard only 2 days before the letters, and a few called the raise a "gender fix". It wasn't, and my manager script came too late. In May 2024 the company shared the results with all employees: an adjusted gender gap of 0.4%.

Most of the cases that didn't come from the acquired company traced to promotions, which led to the promotion pay guideline. The model now reruns every merit cycle.

What's still open: the audit took ratings out of the main model; it didn't examine the ratings themselves. And the gap doesn't stay closed by itself. Going into the 2025 cycle it was 0.5%, and the proposals brought it back to 0.4%. Neither number was significant, but the rerun is the reason I know.

## Why we did it

Two reasons. The leveling framework (`Job Leveling Framework.md`) had just given every employee a job and a level, so for the first time we could compare like with like. And on the 2023 engagement survey, "I believe I'm paid fairly compared to my peers" was 49% favorable, the lowest item on the survey. My director and I proposed the audit; the CHRO and the general counsel approved it in August 2023.

## My role

I built the dataset, wrote the analysis plan and ran the models in R. Outside counsel directed the work. Counsel's labor economist replicated my models independently and challenged my choices; one of those challenges is below. My director owned the remediation decision with the CHRO and CFO. I proposed the flag rule and the budget, and I reviewed every flagged case with the VPs. HR leadership and counsel wrote the employee communication. I wrote the manager guide, too late.

## Method

- Population: 1,846 US employees as of September 30, 2023. The 14 executives were reviewed separately by counsel. Base salary only, annualized to full time.
- Dataset: 6 weeks of work. Pay, job, level, zone, hire date and date into current level came from Workday. For the company we acquired in 2021, dates into level didn't exist; I rebuilt them from job-change history for about 300 employees, and the economist checked a sample.
- Model: a regression of the log of base salary on job (job family by level), geographic pay zone, time in current level and company tenure. These are the factors that should legitimately explain pay. Gender and race/ethnicity are then added to measure how much pay still differs once those factors are accounted for.
- Groups: gender, for everyone. Race/ethnicity from self-identification; the 7% who hadn't disclosed were left out of that model.
- Flag rule: anyone paid more than 5% below what the model predicted for their job and situation, regardless of group. We fixed individual gaps, not group averages.

## Findings, as shared with employees

- Unadjusted: women's median base pay was 12.8% below men's. Most of that is job mix. Women were 71% of Revenue Cycle Operations and Support, where pay is lower, and 26% of Engineering.
- Adjusted for job, zone and time: a 2.3% gender gap, statistically significant.
- Race/ethnicity: an adjusted gap of 0.9% company-wide, not significant. In Engineering alone it was 3.1%, and significant.
- 214 employees met the flag rule. After review with the VPs, 46 had a documented reason, for example a move into a new job within the past 2 months with an increase already scheduled. 168 were adjusted.

## Remediation and root causes

- $574K a year, 0.32% of base payroll, an average adjustment of about 4%. Effective April 1, 2024, paid from its own budget line, not from merit.
- After remediation: adjusted gender gap 0.4%; Engineering race/ethnicity gap 0.8%. Neither significant.
- 41 of the 168 cases came from the acquired company, whose pay had never been brought in line with ours.
- Most of the rest traced to promotions. From 2020 to 2023, women's median promotion increase was 6.5% against 9.0% for men, because managers set the amount with no guideline. The fix was the promotion guideline (`Promotion Pay Guideline.md`).
- The model now reruns every merit cycle on the proposed salaries, before final approval (`Annual Merit Cycle.md`).

## What went wrong

- My first model included performance rating as a factor, and the gap came out at 1.4%. The economist asked whether the ratings themselves were unbiased. In 2 job families, women were rated "Exceeds" less often than men in the same jobs. Controlling for rating would have hidden part of the gap behind a number that might carry the same bias. We took rating out of the main model and kept it as a sensitivity check. I should have asked that question myself.
- A small group in a draft. My first VP deck broke results down by team, and one team had 7 people. My director caught it before it went out. With 7 people, a gap is a statement about specific people. Since then I don't show any group under 10, anywhere.
- Manager communication. Managers of adjusted employees heard 2 days before the letters. A few told their employees the raise was a "gender fix", which was wrong: adjustments were made on the individual gap, regardless of group. I wrote a manager script afterwards. It should have gone out with the list.

## What I'd do differently

- Agree the factor list with the economist before running anything, with one sentence per factor on why it's a legitimate reason for pay to differ.
- Brief managers a week before the letters, with the script.
- Fix the acquired company's pay first. 41 of the 168 cases came from a gap we already knew about in 2022.
