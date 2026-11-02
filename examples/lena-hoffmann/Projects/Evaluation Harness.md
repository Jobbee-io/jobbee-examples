<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Evaluation harness: offline evals, a human review loop, and the regression it caught

Gablewright Software, Applied AI team. First version November 2023, a merge gate since March 2024, still running. On my resume it's one bullet. This file holds the options I weighed, how the golden set is built and versioned, how the judge is checked against people, the statistics behind the gate, the weekly human review, the regression it caught in February 2025, my mistakes building it, and what it still can't see.

## Why

Before the harness, a prompt change was judged by reading about 20 answers. Different people could read the same 20 and disagree, and nobody could say whether a change made things worse for the questions they hadn't read. I wanted every change to the prompt, the model, the index or the retrieval code to come with a number on a fixed set, with an error bar.

## The options (October 2023)

- More human reading. Checking 400 answers against the articles takes a support specialist about 10 hours. We were making 10 to 15 changes a week, so that would have been 3 full-time people. We could afford people for a weekly review, not for every change.
- Word-overlap scores against a reference answer. Cheap, but on a 100-item check they disagreed with the specialists about whether an answer was wrong about 30% of the time. A correct answer worded differently scored low; a wrong step in fluent text scored high.
- A hosted evaluation product. It would have given us dashboards and run tracking, not the hard part: the questions, the reference facts, and a judge checked against our own specialists. We'd have built those ourselves anyway, and it would have been one more vendor holding customer questions.
- What I built: a golden set labeled by support specialists, an LLM judge checked against those specialists, code checks for whatever code can check, a merge gate, and a weekly human review of production answers as the check on all of it.

## My role

I designed and built it, and I own it. Bettina L. and Andre P., 2 senior support specialists, write the reference answers and do the weekly review. Rosa M. gave each of them 4 hours a week for it, written into their schedules, which is the main reason the loop has survived. Kofi A. reviewed the statistics. The rest of the team adds cases and runs it; the CI integration is mine.

## The golden set

- Source: real customer questions from tickets, with personal data removed. 240 items in November 2023, 640 at launch in May 2024, 980 by mid-2025, 1,180 now.
- Each item has the question as the customer wrote it, the plan and product version, the gold article or articles, a list of required facts, a list of forbidden claims, and a flag for questions the assistant should decline (about 14% of items).
- Required facts are what a correct answer must say, 2.6 per item on average: "the batch must be in Draft status", "Send batch is under Invoicing > Batches". Forbidden claims are wrong answers we've seen or expect, 1.3 per item: a step from the old invoicing module, or a feature from a higher plan.
- Labeling: Bettina and Andre write items from a 9-page guide. Every 10th item is labeled by both. If they disagree and can't settle it, Rosa decides; about 6% of double-labeled items need that.
- Composition: since Q3 2024 the set is stratified by ticket category, 14 categories, with quotas proportional to support volume and a floor of 40 items per category. Multi-step troubleshooting went from about 12% of items to about 30%.
- Versioning: the set gets a new version whenever items are added, about monthly. Every comparison runs both configurations on the same version, and production is re-measured on each new version. That's why "3.4% at launch, 2.3% now" isn't a like-for-like trend: the set got harder in between.
- Where new items come from: the weekly review (about 4 candidates a week), 160 hard multi-step cases from the fine-tune project (`Fine Tune That Lost.md`), 40 near-duplicate question pairs added after the cache failure (`Inference Cost And Latency.md`), and about 30 items for every new feature before it launches.

## What gets measured

On every run: recall@8, wrong-answer rate, how often should-decline items are declined, citation validity, and cost and latency per item.

- Wrong answer: an answer that contradicts the cited article or the product, includes a step that doesn't exist, or answers for the wrong plan or version. Correct but unhelpful answers, and declines, don't count.
- Citation validity is checked in code, not by the judge: the cited article is published and the quoted text appears in it.

## The judge

A larger model from the hosted LLM API, with its version pinned and temperature 0. It doesn't give one overall score. For each required fact it answers present, missing or contradicted, and for each forbidden claim present or absent, quoting the sentence it relied on. Code turns those verdicts into the label: any contradicted fact or present forbidden claim makes the answer wrong.

To check it, both specialists labeled the same 400 items. They agreed with each other on 94%, and the judge agreed with them on 92% (Cohen's kappa 0.81). We repeat that check whenever the judge's model version changes. That has happened twice, in October 2024 and July 2025, and agreement stayed between 91% and 93%.

Where it still errs: it's strict about screen labels written another way ("Billing settings" for "Settings > Billing"). A list of accepted label variants goes into the judge prompt.

## The statistics, and the gate

- Error bars are 95% bootstrap intervals. At 1,180 items and about 2% wrong answers, the interval on a single rate is roughly ±0.8 points, so nobody argues about a 0.3-point move.
- Comparisons are paired: both configurations answer the same items, and I bootstrap the difference. Most items get the same verdict both times, so the paired interval is much narrower than two separate ones.
- Run-to-run noise: the same configuration run twice differs by about 0.2 points, from the generator, not the judge.
- The gate: CI runs a 400-item subset, stratified by category and by the decline flag, on every change to the prompt, the model, the index or the retrieval code. It takes about 9 minutes and costs about $4. A merge is blocked if the wrong-answer rate rises more than 1.0 point or citation validity drops below 99%. The full set runs nightly and before every release.
- On 400 items, 1 point is 4 answers, so the gate is noisy on purpose. Since March 2024 it has blocked 61 merges. 9 of them passed when re-run on the full set, which is the allowed override. I'd rather look at 9 false alarms than miss a real regression.

## The human review loop

Every week the specialists review 150 production answers: 50 random, 50 with the lowest retrieval confidence, and 50 with a thumbs-down. It takes each of them about 2 hours. Every wrong answer gets a cause. In 2025: about 38% retrieval misses, 27% stale or wrong articles, 21% generation errors, and 14% plan or version mismatches. Article causes go to Rosa's team as fixes. The rest become golden-set candidates or tickets for us, and we add the candidates that test something the set doesn't already cover.

More than 18,000 answers have been reviewed since launch. The random 50 is our estimate of the production wrong-answer rate; it averaged 2.6% in 2025. One week's 50 is too small to read alone, since 1 wrong answer is 2 points, so I report a 4-week rolling rate over 200 answers.

## The regression it caught

In February 2025 the hosted API released a newer model version: faster, and 31% cheaper per token. The plan was to switch on a Friday after reading 20 answers, and all 20 looked fine. The harness disagreed. The wrong-answer rate went from 2.2% to 5.1%, and should-decline items were declined 52% of the time instead of 81%. When retrieval was weak, the new version answered anyway from general knowledge, with invoicing steps from some other product. The 20 hand-read answers were all common questions with strong retrieval, so none of them could have shown it.

A VP wanted to ship it and fix forward, for the price. Ines R. held the rule that nothing ships while the gate fails. I moved the decline threshold out of the prompt and into code, so a low-confidence question never reaches the model, and the ML engineer who owns generation rewrote the prompt. Re-run: 2.0% wrong answers, 84% of should-decline items declined. We shipped the new version in March 2025 at the lower price, about 3 weeks later than planned.

## What went wrong

- Contamination. In December 2023, while tuning the prompt, I copied 37 golden-set questions into it as examples. Our scores were inflated by about 0.6 points for 4 months, until an overlap check I added in April 2024 found them. CI now fails if any prompt example overlaps the golden set, exactly or as a near-duplicate.
- A lenient judge. The first calibration, in January 2024, gave 81% judge-to-human agreement. The judge passed long, hedged answers that contained 1 wrong step. Grading required facts and forbidden claims separately brought agreement to 92%.
- An easy set. The first 640 items came from tickets that were resolved fast, so they were mostly 1-step questions. The weekly review showed a wrong-answer rate on multi-step troubleshooting about twice the golden set's. In Q3 2024 we rebalanced the set by ticket category. The golden-set number went up, which was the point.

## What it still can't see

- Conversations. The set is single questions. Follow-ups are checked only by the weekly review.
- Shared blind spots. The judge and the generator come from the same hosted API, so an error they both make would pass the judge. The weekly human review is the check on that, and the reason it can't be dropped to save money.
- Helpfulness. The harness measures wrong, not unhelpful. A correct answer that misses the customer's real problem passes. The thumbs-down rate is the only signal for that, and it's a rough one.

## What I'd do differently

- Add the overlap check on day 1, before anyone tunes a prompt.
- Calibrate the judge against people before trusting a single score from it.
- Sample the set by ticket category from the start, not by what was easy to label.
