<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Referral program

Slatebird, January – December 2025. On my resume this is a single bullet: 3.7% of new paid accounts against a 10% goal, about 40% of them incremental, kept in maintenance mode. This file holds where the goal came from, how I measured incrementality, the fraud I didn't plan for, and why the reward didn't motivate the people it was meant for.

## The full story

In a late-2024 in-app survey, 41% of workspace admins said they were likely to recommend Slatebird to another agency. We had no referral program, and leadership wanted a channel that didn't depend on Google. I proposed one, with a goal of 10% of new paid accounts within 2 quarters. That goal came from the survey, and that was my first mistake.

I made the case, wrote the test plan and the reward terms with finance, and wrote all the copy. Our designer did the entry points, and one engineer built the links, credits and discounts. The test ran from April 1 to September 30, 2025, with 10% of paid workspaces held out so I could measure what was really extra.

I launched with no fraud rules. In the first 5 weeks, 11% of credits went to self-referrals. Rules went in during week 5, and we reversed $3,100 in credits. The readout fell well short of the goal: referrals made 3.7% of new paid accounts, not 10%, and only about 40% of those were extra. When I interviewed 14 admins who had referred someone, 2 mentioned the reward. The free month credited the company's bill, not the person doing the referring.

I took the program out of the growth forecast and kept it live in maintenance mode. A test from October to December 2025 raised link shares by 38%, but paid referrals didn't move in a way I could measure. In 2026 it brings in about 50 paid accounts a month, still about 3.5% of the total.

What's still open: my 10% holdout was too small, so the extra share sits somewhere between 10% and 70%, and I never narrowed it. And a reward that would motivate someone, such as a better start for the new team instead of a credit, is still untested.

## Why

Agencies talk to other agencies. In a late-2024 in-app survey, 41% of workspace admins said they were likely to recommend Slatebird to another agency. Slatebird had no referral program, and leadership wanted a channel that didn't depend on Google. I proposed one, with a goal of 10% of new paid accounts within 2 quarters.

## Hypothesis, metric and design

- Hypothesis: a two-sided referral program raises new paid accounts from word of mouth enough to reach 10% of all new paid accounts within 6 months, at a cost per incremental paid account under $700 (half of non-brand paid CAC), because admins already recommend us and a reward plus a share link removes the friction.
- Rewards: the referring workspace gets 1 month free on its plan for each referred workspace that becomes paid. The new workspace gets 20% off its first 3 months.
- Primary metric: paid accounts from referral links or self-reported word of mouth ("a colleague or another company told me") per 1,000 eligible workspaces per month. Counting self-reported word of mouth in both arms matters: without the program, those people still exist, they just don't use a link.
- Design: about 24,000 paid workspaces, split at random. 90% saw the program (an entry point in settings and after sharing a schedule), 10% didn't. 6 months, April 1 – September 30, 2025.
- Secondary: activation and trial-to-paid of referred signups. Guardrail: reward cost per paid referral.

## My role

I made the case, wrote the hypothesis and the test plan, wrote the reward terms with finance, wrote all the copy, and did the readout. Our designer did the entry points. One engineer built the links, credits and discounts, about 6 engineer-weeks in total. Support handled reward questions; I wrote their help article.

## The result

- 1,380 signups came through referral links. 290 became paid, which is 21% against our usual 8.6%. That was 3.7% of the roughly 7,900 new paid accounts in those 6 months. The goal was 10%.
- Referred signups activated at 38%, against 19% overall.
- Incrementality: the program arm produced 2.9 paid accounts per 1,000 workspaces per month from referrals plus word of mouth. The holdout produced 2.0, all of it word of mouth. That's about 117 extra paid accounts over 6 months, roughly 40% of the 290. The holdout was small, so the range is wide: somewhere between 10% and 70%.
- Cost: $64K in rewards ($46K in credits, $18K in discounts). That's about $550 per incremental paid account on rewards alone, about $930 with the build time counted. Cheaper than paid search, but only about 20 extra accounts a month.

## What shipped

The program stayed live in maintenance mode: one dashboard, the fraud rules, no promotion. I took it out of the growth forecast. In October – December 2025 I tested moving the main entry point into the share-schedule flow. Link shares went up 38%. Paid referrals didn't move in a way I could measure. That version stayed, because it costs nothing to keep. In 2026 the program brings in about 50 paid accounts a month, still about 3.5% of the total.

## What went wrong

- The goal came from a survey. 41% said they'd recommend us; in practice, about 6% of eligible workspaces sent even one link. Saying you'd recommend something and doing it are different behaviors, and I forecast from the wrong one.
- The reward went to the wrong person. A free month credits the company's bill, and the admin who does the referring doesn't pay it. I interviewed 14 admins who had referred someone. 2 mentioned the credit. Most referred because a peer asked what they used.
- No fraud rules at launch. In the first 5 weeks, 11% of credits went to self-referrals: the same payment card or the same company email domain on both sides. Rules went in during week 5 and we reversed $3,100 in credits.
- The holdout was 10% because I didn't want to lose referrals. With volume this small, a 10% holdout gave a range from 10% to 70%. I would have learned more, and lost almost nothing, with a much bigger one.

## What I'd do differently

- Start with a cheap test of the behavior, not the survey: a share link with no reward for 4 weeks, to see how many people use it at all.
- Put the reward where it motivates someone. For B2B, that probably means the new team's experience, like a longer trial with a setup call, not a credit on someone else's invoice.
- Fraud rules on day 1, and a holdout big enough to answer the question.
