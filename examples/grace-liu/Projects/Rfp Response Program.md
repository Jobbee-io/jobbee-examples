<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# RFP and technical questionnaire program

Cairnwatch, Enterprise West region. Built from January to June 2024, run through 2025, still running. On my resume it's one bullet: median SE hours per RFP 35 to 13, turnaround 11 to 5 business days, about a quarter of RFPs now declined at triage. This file covers how it works, how each number is measured, and the parts that failed first.

## The full story

In 2023 our region answered all 43 RFPs it received, at a median of 35 SE hours each, mostly by copying answers out of old RFPs. At least 5 answers were wrong when we sent them, and one cost a pricing concession. We won 6.

In January 2024 I proposed a program to my SE manager. I built the triage scorecard and the answer library, and I ran the program. Each SE still leads the RFPs for their own AEs, AEs own the commercial sections, and PMs sign off roadmap answers. The first library failed: I imported about 900 old answers, they contradicted each other, and within 2 months SEs were back to searching old RFPs. I cut it to 540 answers, each with an owner and a 6-month expiry, and usage came back. In the first quarter I also turned off the RFP tool's keyword auto-fill for technical sections, because it kept picking old answers.

In Q2 2024 AEs overrode the triage 5 times, and all 5 lost. I took the hours they cost to our regional VP, and he made every override need his sign-off. In month 4 two RFPs went in late waiting on PMs, and product agreed a 48-hour turnaround. By June the program was built.

In 2025 we declined 12 of 44 RFPs at triage, the median dropped to 13 hours and turnaround to 5 business days, and we won 9 of 32. Most of that win-rate jump is better choices, not better answers. The program is still running, and the other SEs run it without me.

What's open: the library stays right only if owners do the quarterly sweep, and one wrong answer still got out in 2025. Security questionnaires stay outside the program, with our security team.

## Scope

RFPs and technical questionnaires: architecture, ingest limits, data retention, integrations, deployment options, support terms. Security questionnaires are out of scope. They go to our security team, who have their own process.

## Why it was needed

In 2023 the region received 43 RFPs and answered all 43. Each took one SE a median of 35 hours, measured from time logs I asked our 5 SEs to keep for one quarter. Answers were copied from whichever old RFP the SE could find. We know of 5 answers in 2023 that were wrong when submitted. One said default trace retention was 30 days, a year after it had changed to 15; the customer raised it in contract negotiation and we gave a pricing concession to keep the deal. We won 6 of the 43 (14%).

## My role

I proposed it to my SE manager, built the answer library and the triage scorecard, and ran the program. Each SE leads the RFPs for their own AEs. AEs own the commercial sections. Product managers sign off on any answer about the roadmap. Our regional VP made the triage binding, which I couldn't have done.

## How it works

1. Triage, about 2 hours. 6 questions, each scored 0 to 2: did we know about this deal before the RFP was published; can we name the evaluator; do we meet every mandatory requirement today; is there a POC stage; is the deal likely $150K or more; did a competitor help write the requirements (scored in reverse). Below 6 of 12 is a no-bid, with a short note to the AE saying why.
2. The answer library: 540 approved answers, each with an owner (a PM or an SE), a last-verified date and a 6-month expiry. An expired answer can't be used until its owner checks it again.
3. The roadmap rule: we never answer yes for something that isn't released. "Planned, no committed date" needs a PM's sign-off, and product agreed to a 48-hour turnaround on those.
4. Review: a second SE reads every technical section before submission.
5. Upkeep: a half-day sweep every quarter where owners re-verify expiring answers.

## The numbers, and their definitions

All comparisons are calendar 2023 (before) against calendar 2025 (first full year after). 2024 was the build year and is left out.

- RFPs received: 43 vs 44. Declined at triage: 0 vs 12 (27%). Submitted: 43 vs 32.
- Median SE hours per submitted RFP: 35 vs 13. The 2025 hours come from the program's tracking sheet.
- Total SE hours: about 1,500 vs about 440, counting 2 hours of triage for each declined RFP. The roughly 1,060 hours saved is a bit more than half of one SE's working year.
- Median turnaround, receipt to submission: 11 vs 5 business days.
- Won: 6 of 43 (14%) vs 9 of 32 (28%). Most of that jump is the triage choosing better RFPs to answer, not better answers, and I don't claim it as answer quality.
- Answers found wrong after submission: 5 vs 1.

## What went wrong

- The first library failed. I imported about 900 answers from old RFPs. Many were duplicates that disagreed with each other, nobody trusted it, and after 2 months SEs were back to searching old RFPs. I cut it to 540, gave every answer an owner and an expiry, and usage picked up within a month.
- AEs overrode the triage 5 times in Q2 2024, and all 5 RFPs lost. I took the 5 to our regional VP with the hours each one cost. After that, an override needed his sign-off.
- Our RFP tool's keyword auto-fill picked old answers in the first quarter. I turned it off for technical sections, so an SE picks each answer from the library by hand.
- I underestimated how long roadmap answers would wait on PMs. The 48-hour agreement with product came in month 4, after 2 RFPs went in late.

## What I'd do differently

- Start the library small, with owners from day one, instead of importing everything.
- Get the regional VP to make triage binding before launch, not after 5 losses.
- Agree the PM turnaround in the first week.

It's one bullet on my resume, but it's the clearest example I have of a process other SEs run without me.
