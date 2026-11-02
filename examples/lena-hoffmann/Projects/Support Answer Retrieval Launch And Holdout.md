<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Support answer retrieval: launch, holdout test and the deflection number

Companion file to `Support Answer Retrieval.md`, the overview. This one covers how the assistant reached customers and how we measured whether it helped: the pilot, the holdout design, the deflection definition and why it has that form, the 44% number I had to correct, and the 2026 re-run.

## The pilot (February to April 2024)

600 customer businesses opted in. The pilot was for finding failures, not for measuring impact: customers who opt in are more engaged than average, and there was no control group. Every week I read the complaints and thumbs-down answers with the 2 support specialists who label our eval set. We also tracked the decline rate, and ran the golden set before each change. The plan-tier problem came out of the first 40 complaints.

## Rollout and the holdout design

We rolled out to all customers in May 2024, except a holdout. Kofi A., our data scientist, designed the test and did the analysis. I owned the metric definitions and the data.

- Unit: the customer business, not the session or the user. People in one business share dispatchers and office staff, and the contact often comes from someone other than the person who searched. Randomizing by user would have leaked.
- Size: 10% of businesses, chosen by a hash of the account ID, kept the old search widget.
- Window: 8 weeks, June 3 to July 28, 2024, after the May ramp had finished. About 104,000 help sessions in the window, about 10% of them in the holdout.
- Analysis: the difference in deflection between the arms, with a 95% interval from a bootstrap that resamples businesses, not sessions, because sessions from one business aren't independent.

At week 4 a VP and support leadership wanted to end the holdout early. The numbers looked good, and holdout customers were getting worse help. Kofi and I wanted the full 8 weeks, to cover 2 month-ends, when invoicing questions spike. Ines R. decided: 8 weeks, with a stop rule written down in advance. We would end early only if the holdout was doing better.

## The deflection definition

Deflection is the share of in-app help sessions with no human support contact (chat, email or phone) from that user within 72 hours.

- A help session starts when the user opens the help widget and ends after 30 minutes without activity.
- A human contact is a chat, an email ticket, or a phone call matched to the user. Calls are matched by the caller's number on the user profile, or by the account number the caller gives the agent. About 85% of calls match. Unmatched calls make deflection look better in both arms by the same amount, so they don't change the difference.
- Why 72 hours: of the contacts that came within 14 days of a help session, about 80% came within 24 hours and 93% within 72. Later contacts are mostly about a new problem.

## The 44% number

In late June 2024 I built a dashboard on the help analytics pipeline I had built in 2022. It counted a session as deflected if no ticket appeared in the support tool within 24 hours. That missed phone calls, which live in a different system, and anyone who came back after a day. It also showed only the assistant arm. A VP put 44% on a slide at a July 2024 all-hands, next to the old widget's 17% from Kofi's pre-launch baseline: two different definitions side by side.

When Kofi and I added phone contacts and the 72-hour window, the assistant arm was 33%. Under my dashboard's definition the holdout would have been 25%. So the slide's 27-point gap was really 16 points. I wrote the correction within a week and sent it to the same all-hands audience, with both definitions next to each other. The dashboard now shows both arms under the agreed definition, and nothing else.

## The result

- Deflection: 33% in the assistant arm, 17% in the holdout. A difference of 16 points, with a 95% interval of about 14 to 18.
- The guardrail was delayed contacts. If the assistant only postponed contacts, they would show up after 72 hours. Contacts 3 to 14 days after a session: 6.1% in the assistant arm, 6.4% in the holdout. No sign that contacts were being postponed.
- About 8,000 fewer human-handled conversations a month by Q4 2024: the 16-point gap times about 50,000 help sessions a month in Q4, all of them on the assistant once the holdout ended. Summer is our peak; June and July ran about 56,000 sessions a month.
- That estimate assumes each session that isn't deflected leads to 1 conversation. The support team's raw count fell from about 62,000 conversations a month in 2023 to about 55,000 in 2025. I don't use the raw drop as evidence, because the customer base, the seasons and the product all changed at the same time. That's why the holdout exists.

## The April 2026 re-run

By 2026 most of the system had changed: the decline rule in code, a new model version, routing between 2 model sizes, and less context per answer. Finance asked whether the 2024 number still held before setting the next year's support budget. We repeated the test for 4 weeks in April 2026, again with 10% of businesses, in the web app only so it compares with 2024. The mobile app had no old widget to hold out to. The result was 35% against 18%, a difference of 17 points, with a 95% interval of about 14 to 20. The cost work hadn't cost us deflection.

## What I'd do differently

- Write the deflection definition down, agreed with support and finance, before the pilot.
- Build the dashboard with both arms from day 1, so no one can quote one arm alone.
- Plan the re-run at launch. A holdout number from 2024 says little about a 2026 system.

## What isn't solved

Deflection counts contacts avoided, not problems solved. A customer who gave up looks deflected. The delayed-contact guardrail and the thumbs-down rate are partial checks. A better one would follow the task itself: did a customer who asked how to send a batch of invoices then send one? We never built it.
