<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# From backend engineer to ML engineer: the internal transfer

Gablewright Software, March 2023 to October 2024: from asking for 20% of my time on the new Applied AI team to being re-leveled as a Senior ML Engineer. On my resume it's a title change and one line under my backend role. The question behind it in interviews is whether my ML experience is real or only my title changed. This file is the answer.

## Where I started

I was a Senior Software Engineer on the Search & Help Platform team, a team of 6. I had built our help-center search service on OpenSearch in 2021, so I knew BM25, our 6,400 help articles, and how customers phrase questions. I knew nothing about embeddings or model evaluation, and my statistics stopped at the single machine learning course in my master's, where I got a B.

## How I earned it

- In March 2023 the company formed an Applied AI team: Ines R. as lead, 2 ML engineers hired from outside, and Kofi A. as data scientist. Their first prototype needed our help content. My manager, Gareth W., gave me 20% of my time to build the ingestion, for a quarter and then through July.
- In that time I shipped ingestion from our content API, heading-based chunking, and a first test set of 240 real questions labeled with 2 support specialists, which became the golden set (`Evaluation Harness.md`).
- In June 2023 I wrote a 1-page transfer proposal: what I'd bring (production ownership, search relevance, the content, on-call), what I lacked (ML basics, statistics, PyTorch), and a learning plan with dates.
- Ines, Gareth and I agreed on a 90-day trial with written criteria: own the pilot's retrieval layer, reach recall@8 of 80% or better on the test set, and give an eval readout Kofi would sign off on. I moved in September 2023, 6 months after my first ask, and met all 3 in November. Hybrid search reached 84%.

## What I traded

My title went from Senior Software Engineer to Machine Learning Engineer, 1 level down on the ML ladder. My base salary stayed the same, with a written commitment to review my level after 12 months. I left the search on-call rotation for the Applied AI one. I was re-leveled to Senior Machine Learning Engineer in October 2024, after 13 months, on the results of the assistant's launch.

## What I had to learn

- Statistics for evaluation: confidence intervals, paired comparisons, sample sizes. My first readout, in October 2023, said hybrid search beat vector search by 3 points on 240 questions. Kofi showed me the 95% interval was about ±5 points. I stopped claiming it until the set reached 640 items in spring 2024, when the gap held at 8 points (84% vs 76%).
- ML basics, in the evenings: a 14-week machine learning course through a university extension program in fall 2023, and small PyTorch exercises at home, like a ticket-category classifier that never left my laptop.
- Labeling as a discipline: writing guidelines, labeling the same items twice, and measuring agreement.
- Planning experiments. I estimated ML work like backend tickets, in days, and experiments don't finish on schedule. I switched to timeboxes with a decision point written in advance. That habit is what later let me stop the fine-tune (`Fine Tune That Lost.md`).

What carried over without effort: owning a service in production (timeouts, retries, on-call, cost), search tuning, knowing the content, and the help analytics pipeline I had built in 2022, which is what made deflection measurable.

## What went wrong

- I didn't make my backfill a condition of moving. The search team didn't hire my replacement until January 2024, 4 months later. For my first 2 months on the new team I stayed on the search pager informally and got paged 11 times for a service I no longer worked on. It cost my old team goodwill and cost me sleep.
- I over-built the ingestion: a connector framework for 6 content sources when the pilot needed 2. That was about 3 weeks of my 20% time.
- The 3-point claim above: I presented a result before I knew how to check it.

In 2025 I mentored a backend engineer through the same transfer, with 4 rules taken from mine: ship something the ML team lacks before you ask, get the trial criteria in writing, ask for statistics help on day 1, and make your backfill a condition. He moved in 4 months; it took me 6.

## What's still open

Nothing about the move itself is open: the search team hired my replacement in January 2024, and I was re-leveled in October 2024. What's still open is one gap I named in my proposal: my PyTorch is working level, not expert.
