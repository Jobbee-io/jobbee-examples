<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The template onboarding win that wasn't

Slatebird, October 2024 – March 2025. On my resume this is one bullet under Slatebird and the first line under failures. I ran a test, read +7.5 points of activation, shipped it and announced it. Two months later I found that the treatment was creating part of its own result. The real effect was +0.8 points, not significant. This file holds the test, how the bug was found, the retraction, and what changed in how I run tests.

## The full story

In fall 2024 the empty schedule was our biggest drop-off: 52% of new workspaces never added a single assignment. I designed a test that let new workspaces start from an industry template with 3 sample assignments. Our designer made the templates, and our growth PM owned the build. It ran for 4 weeks in October.

I read +7.5 points of activation and sent the readout the day after the test ended. The templates shipped to everyone on November 5, and the result went into the Q4 board update.

Then the numbers stopped agreeing. Our Google Ads bidding learns from activated trials. After November 5 it saw 31% more of them while paid accounts stayed flat, and non-brand CAC climbed. I flagged it in early December. On December 27 the test's 60-day trial-to-paid came in flat. On January 6, 2025 the analyst and I found the cause: the sample assignments fired the same event as real ones, so the templates were creating part of their own result. The real effect was +0.8 points, not significant.

On January 10 I sent a retraction to the same people who got the original readout, and our CEO corrected the board slide. The analyst and I rewrote the activation definition, the event now records who created each assignment, and bidding moved to the new definition. Non-brand CAC was back to about $1,390 by March 2025. The templates stayed, logged as flat.

What's still open is the problem I started with. Templates didn't move real activation, so they didn't fix the blank schedule, and this test doesn't tell me what will.

## The test

New workspaces opened on an empty schedule, and our funnel data showed the empty state was the biggest drop-off: 52% of new workspaces never added a single assignment.

- Hypothesis: if new workspaces can start from an industry template (agency, architecture, consulting) instead of an empty schedule, 7-day activation rises by at least 2 points, because a blank schedule is the hardest moment in setup.
- Primary metric: 7-day activation, as defined in 2024: a new workspace with at least 5 assignments created within 7 days of signup.
- Design: 50/50 at workspace creation, 4 weeks (October 1 – 28, 2024), about 14,000 new workspaces, sized for a 2-point change.
- Each template came with 3 sample assignments, so the schedule wasn't empty. 42% of workspaces in the treatment loaded a template.

## My role

I wrote the hypothesis, designed the test and wrote the readout. Our designer made the templates and our growth PM owned the build. Later, the analyst and I traced the bug together, and I wrote the retraction.

## What I reported

Activation 24.3% → 31.8%, +7.5 points (95% CI +6.0 to +9.0). I sent the readout the day after the test ended. The templates went to everyone on November 5, and the result went into the Q4 board update as an example of the growth pod's work.

## How it was found

- The Google Ads account caught it first. Since 2023 our Google Ads bidding has learned from activated trials (`Paid Acquisition Restructure.md`). After November 5 it reported 31% more activated trials, while paid accounts from paid clicks stayed flat. Bidding read the extra conversions as cheaper results and pushed into broader searches. Non-brand paid CAC went from about $1,390 in Q3 to $1,560 in November and December. I flagged it in the weekly paid review in early December.
- On December 27 the test cohort's 60-day trial-to-paid came in: 8.6% in control, 8.7% with templates. A 7.5-point activation lift with no change in paid conversion didn't add up.
- On January 6, 2025 the analyst and I found it. The template's 3 sample assignments fired the same "assignment created" event as real ones, with nothing to tell them apart. A workspace that loaded a template and then added 2 assignments of its own counted as 5, and activated.

## The corrected numbers

- Counting only assignments created by people (the database flags sample ones, even though the event didn't): 24.3% → 25.1%, +0.8 points, 95% CI −0.6 to +2.2. Not significant.
- 60-day trial-to-paid: 8.6% against 8.7%. No difference.
- Cost: about $50K of paid spend bought at a worse CAC over 2 months, by my estimate, and a number in a board update that wasn't true.

## The retraction

On January 10, 2025 I sent a correction to the same channel and the same leadership group as the original readout: the claim, the error, the corrected number, and the changes below. Our CEO corrected the slide in the Q1 board update. In the experiment log, the test went from win to flat.

## What went wrong

- The effect was more than 3 times our biggest onboarding win before it (+2.4 points). That size should have made me suspicious, not excited.
- The treatment could create the primary metric by itself, and nobody checked. We never compared the event stream of the two arms before launch.
- I announced an activation result without waiting for paid conversion, because waiting meant 60 days.

## What changed

- The "assignment created" event now says who created it: a person, a template or an import.
- I rewrote the activation definition in January 2025 with the analyst: at least 5 assignments created by people, not by templates or imports, and at least 2 people active, within 7 days. The 2-people part came from the trial-length segment (`Trial Length Experiment.md`). Activated workspaces convert at 31% against 3.3% for the rest. The baseline under the new definition is 19%.
- The Google Ads conversion upload moved to the new definition. Bidding relearned for about 3 weeks, and non-brand paid CAC was back to about $1,390 by March 2025.
- Before launch, both arms run in staging and we compare their event streams. A metric the treatment can generate by itself can't be the primary metric unless it's filtered by source.
- An activation result goes to the company channel only after 60-day trial-to-paid agrees. Any effect more than twice our biggest previous win gets an audit before anyone reports it.
- An A/A test runs every quarter on the event pipeline.

The templates stayed. They didn't hurt, support liked them, and they're logged as what they are: flat.

## What I'd do differently

- Treat a surprisingly large effect as a possible bug until it's checked. The audit that would have caught this took the analyst and me one afternoon in January.
- Wait for the downstream metric before announcing anything, even when that means 60 days. A slower good result costs less than a fast wrong one.
