<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Behavioral onboarding program

Dispatchwell, March – December 2021. My first project after moving from paid acquisition into lifecycle. On my resume this is one bullet under Dispatchwell with 3 numbers. This file holds where the trials were stalling, the hypothesis, the test design, the result, what went wrong in week 1, and what shipped.

## The full story

In March 2021 I moved from paid acquisition into lifecycle at Dispatchwell. Every trial got the same 7 emails, written by an agency in 2018, whatever the account had done. I pulled 3 months of trials and found that 85% of the stalled ones stopped at one of 2 steps: they never scheduled a real job, or never got one onto a technician's phone.

I wrote the hypothesis and the test plan, wrote 9 emails in 3 branches by crew size, and built them in HubSpot. An engineer added the 4 product events I needed. I had guessed 3 days; it took 2 sprints, so the test started 3 weeks late, on April 12. A designer made the template, and the inside-sales lead reviewed the branch for crews of 6 or more.

Week 1 went wrong. Crew size was optional at signup, I had sent the blanks to the 2-to-5 branch, and one-person businesses got emails asking them to add their technicians. In week 2 we made crew size a required one-click question in both arms.

Enrollment closed on June 6. Activation rose from 19.2% to 23.1%, and trial-to-paid from 11.0% to 12.4%. The program went to 95% of trials in June. Our VP asked whether the lift would last, so I kept 5% on the old drip for 6 months. That holdout wasn't in my plan, and it should have been. The gap held through December.

The test closed when the holdout ended. One question stayed open: the in-app setup checklist that product tested in October came in at +1.1 points, not significant, and shipped anyway, so its effect was never shown. I left Dispatchwell in July 2022 and can't speak to how the program has done since.

## Why

Dispatchwell sells scheduling, dispatch and invoicing software to small trades businesses: HVAC, plumbing and electrical, 1 to 20 technicians. The trial was 14 days, no card, about 4,800 signups a month. Every trial got the same 7 emails on days 0, 1, 3, 5, 7, 10 and 13, written by an agency in 2018. The day 3 email was about invoicing, whether or not the account had scheduled anything.

I pulled 3 months of trials, about 14,000 accounts. 19% activated (defined below). Of the ones that didn't, 46% never scheduled a real job, and 39% scheduled jobs but never got one onto a technician's phone. So 85% of stalled trials stalled at one of two steps, and the drip didn't know which.

## Hypothesis, metric and design

- Hypothesis: if we replace the time-based drip with emails triggered by the next missing setup step, 14-day activation rises by at least 2.5 points, because most stalled trials stall at one of two known steps and the old emails talked past both.
- Primary metric: 14-day activation. A trial account that schedules at least 3 jobs and dispatches at least 1 of them to a technician's phone (which can be the owner's own) within 14 days of signup. Accounts that activated converted at about 4 times the rate of those that didn't, which is why I trusted it as a leading metric.
- Secondary: trial-to-paid within 45 days of signup. Guardrails: unsubscribes per email (limit 0.6%) and spam complaints (limit 0.05%).
- Design: 50/50 random split at signup, by account. Sized for a 2.5-point change at 80% power and a two-sided 5% test: about 4,050 accounts per arm, so 8 weeks of enrollment (April 12 – June 6, 2021). 9,420 trials in total. The inside-sales process stayed the same in both arms.
- Treatment: 9 emails in 3 branches by crew size (solo, 2 to 5, 6 or more). Each email asks for the next missing step and stops as soon as that step is done. At most 1 email a day, plain text, signed by the support lead.

## My role

I did the stall analysis, wrote the hypothesis and the test plan, wrote all 9 emails, built the branches in HubSpot, and wrote the readout. One engineer added the 4 product events I needed (crew member added, job scheduled, job dispatched, invoice sent). A designer made the template. The inside-sales lead reviewed the 6+ branch, because those accounts also got a call. The in-app setup checklist came later, built by product and tested separately in October 2021.

## The result

- 14-day activation: 19.2% control, 23.1% treatment. +3.9 points, 95% CI +2.2 to +5.6.
- Trial-to-paid within 45 days: 11.0% control, 12.4% treatment. +1.4 points, 95% CI +0.1 to +2.7. Real, but only just, and it was the secondary metric, so I didn't lean on it until the holdout agreed.
- Guardrails: unsubscribes per email 0.31% → 0.44%, under the limit. Spam complaints 0.02% in both arms.

## What shipped

The new program went to 95% of trials in June 2021. I kept 5% on the old drip for 6 months. From June to December the activation gap held at +3.6 points and the trial-to-paid gap at +1.2. At 4,800 signups a month, that's about 58 extra paid accounts a month, as an estimate. The October checklist test added +1.1 points of activation, not significant. It shipped anyway because it didn't hurt and support liked it.

## What went wrong

- The solo branch. Crew size was optional at signup and 31% of trials left it blank. I defaulted blanks to the 2-to-5 branch, so in week 1 one-person businesses got emails asking them to add their technicians. About 40 replied "it's just me", and that branch's unsubscribe rate hit 0.9%. In week 2 we made crew size a required one-click question at signup for both arms and gave blanks a neutral branch. I also reported weeks 3–8 on their own: +4.1 points, close to the full result.
- The events took 2 sprints, not the 3 days I'd guessed, and the test started 3 weeks late.
- The holdout wasn't in my plan. I added it at rollout because our VP asked whether the lift would last. It should have been there from the start.

## What I'd do differently

- Ask the segmenting question before building branches on it.
- Put the long-term holdout in the test plan, with its end date.
- Run the old drip for 2 weeks with the new events in place first, to get a clean baseline before changing anything.
