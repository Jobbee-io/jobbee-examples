<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Studio onboarding redesign: schedule first, payments last

Rosterwell, Studio Growth team, March to October 2022. My first big project there, as a mid-level Product Designer, and the work I was promoted to Senior on in April 2023. The resume holds the headline: activation 31.4% → 39.8% in a 6-week A/B test. This file holds the definition, the research, the decisions, the number I don't claim, and what broke after launch. It's also the first case study in my portfolio.

## The problem

New studios got a 14-day free trial. To use it, an owner went through a 9-step setup wizard, after a 6-screen product tour. Step 2 was payment verification: bank account and tax ID. In the six months before I joined, 41% of trial studios that reached that step didn't finish it the same day, and most of them never came back to the wizard. Pricing, class types, instructors and rooms came next. The schedule, the thing owners actually cared about, was step 7.

## The metric, defined before any design

I wrote the activation definition with Callum, the PM, and Wen, our analyst, in the first two weeks. A trial studio is activated if, within 14 days of signup, it has published at least 7 days of classes and taken at least one booking from someone who isn't on its staff list. We picked it because among 2021 trials, studios that did both converted to paid at 52%, and studios that didn't converted at 6%. That's a correlation, not proof, so we treated activation as a leading indicator and kept trial-to-paid as a secondary metric. Baseline activation over the previous six months: 31%.

## My role

I was the only designer on the team. I owned the research plan, all the design, the activation definition with Callum and Wen, and the test plan with Wen. Tessa, our UX researcher, reviewed my interview guide and sat in on the first three interviews. Callum owned priorities, and the 4 engineers owned how the import worked under the hood.

## Research

- 14 interviews with owners who had trialed in the past three months: 8 who converted and 6 who didn't.
- 40 recorded wizard sessions, watched end to end.
- Two days with support, reading about 150 trial-period tickets.

Owners set up late at night, after teaching. They wanted to see their schedule look real before they handed over bank details. Most kept their schedule in a spreadsheet or a paper planner. And inviting clients felt premature until they had a booking page they weren't embarrassed by.

## Decisions, and why

- Schedule first, payments last. Studios could take free bookings before payment verification; paid bookings still required it. The risk team agreed after a week of back and forth.
- A spreadsheet import for the schedule, plus "copy this week to the next 8 weeks".
- A preview of the studio's booking page, with its logo and real schedule, before anything goes live.
- The product tour went. In the recordings, nobody read past screen 2.
- A checklist in the dashboard instead of a forced linear wizard: 7 items in any order, 3 of them marked as needed for a first booking.

I rejected importing directly from competitors' tools (legal risk, and a maintenance cost that never ends) and a setup call for every trial, which sales wanted. We kept the call for studios with 3 or more locations.

## The test, and the numbers

50/50 split by new trial, July 11 to August 21, 2022, about 1,000 trials per arm. Primary metric: activation. Secondary: trial-to-paid at day 45. Guardrail: support tickets per trial.

- Activation: 31.4% → 39.8%, +8.4 points (95% CI +4.2 to +12.6).
- Median time from signup to activation, among activated studios: 6 days → 3 days.
- Trial-to-paid at day 45: 17.9% → 20.6%, +2.7 points (95% CI −0.7 to +6.1). Not significant. The test would have needed about 3.5 times the sample, roughly 5 months of trials, to say anything. We sized it for activation, so activation is the claim.
- Guardrail: support tickets per trial rose 9% in the new arm. That's the import story below.
- After full rollout on September 6, 2022, activation averaged about 39% for six months. Trial-to-paid rose too, but January is when new studios open, so I don't call that causal.

## What went wrong

- The import assumed one format. In interviews owners described one row per class, and that's what I designed for. About 30% of real uploads in the test were weekly grids with days as columns, and they failed. That's the 9%. We added the grid format three weeks after rollout, and tickets per trial were back to baseline by October. I had asked owners to describe their files. I should have asked them to send one.
- Free bookings got abused. In the first month after rollout the risk team found 11 fake studios using free bookings to collect members' emails and phone numbers. We capped free bookings at 20 before verification and required verification before a studio could message clients. Risk had seen this pattern before; I never asked them what abuse looked like.
- Owners skipped "invite your clients", the checklist item most tied to a first booking. In October I moved the share link into the preview step. That shipped without a test, so I have no clean number for it.

## What I'd do differently

- Collect real artifacts in research, not descriptions of them.
- Talk to the risk team in week 1 of any change that loosens a control.
- Decide before the test which claim it can support, and write that into the test plan.

## What's still open

Two things were still open when I moved to the Member App team in 2023. The share-link change from October 2022 had shipped without a test, so it had no clean number. And no test had shown that the redesign raised trial-to-paid, because ours was sized for activation.
