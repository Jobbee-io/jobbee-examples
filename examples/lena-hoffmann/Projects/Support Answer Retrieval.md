<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Support answer retrieval: the help assistant in production

Gablewright Software, Applied AI team. Built from October 2023, live for all customers in May 2024, improved through 2025. On my resume this is one bullet with the recall, deflection and support-volume numbers. This overview holds why we built it, what I owned, the timeline, the main decisions, how each number is defined, and what went wrong. Companion files: `Support Answer Retrieval Index Design.md` (what's in the index, chunking, metadata filters, hybrid search, the reranker and the decline rule) and `Support Answer Retrieval Launch And Holdout.md` (the pilot, the holdout test, the deflection definition and the number I had to correct). The evaluation harness that gates every change has its own file, `Evaluation Harness.md`.

## What it was, and why

Gablewright sells scheduling, dispatch and invoicing software to trade contractors: about 31,000 HVAC, plumbing and electrical businesses. In 2023 support handled about 62,000 conversations a month, and roughly 40% were "how do I" questions that a help article already answered. The in-app help widget ran keyword search over our articles, on the search service I had built in 2021 as a backend engineer. It returned a list of links, and 17% of help sessions ended without a human contact.

The goal was to answer those questions inside the app, in a sentence or a few numbered steps, grounded in our own articles and linking to them. When the articles don't cover a question, the assistant says "I don't know" and offers a person.

## My role

I was the tech lead for retrieval and evaluation, as an individual contributor. I owned ingestion and chunking, the hybrid index, the reranker service, the plan and version filters, the cite-or-decline rule, and the metric definitions. Ines R. led the team and owned the roadmap. Another ML engineer owned the prompt and generation. Kofi A., our data scientist, designed and analyzed the holdout test. The web team built the widget. Rosa M. in support operations owned article fixes and gave us labeling time.

## Timeline

- March to July 2023: on 20% time from the search team, I built ingestion, chunking and a 240-question test set for the Applied AI team's first prototype (`Backend To Ml Transfer.md`).
- October 2023: the production build started, a month after my transfer.
- November 2023: hybrid search reached 84% recall@8 on the 240-question set. I tested a separate vector database and didn't adopt it.
- February to April 2024: pilot with 600 customer businesses who opted in. It surfaced the plan-tier problem.
- May 2024: all customers, except a 10% holdout. The golden set had 640 questions.
- June and July 2024: the 8-week holdout test, 33% deflection against 17%. The 44% dashboard number, and its correction.
- August 2024: the stale-article incident. Event-driven re-indexing from September.
- January 2025: reply drafts for human support specialists, on the same retrieval layer.
- February 2025: the assistant reached the technicians' mobile app. The harness stopped a model-version swap.
- March 2025: the decline rule moved from the prompt into code.
- September 2025 to February 2026: cost and latency work (`Inference Cost And Latency.md`).
- April 2026: a 4-week holdout re-run, 35% against 18%.

## The main decisions

- Only published, customer-facing articles and release notes go in: 6,400 articles, about 38,000 chunks. Internal support macros stay out, because they contain workarounds we don't promise customers.
- Chunks split on headings, so a numbered procedure stays in 1 chunk.
- Keyword (BM25) and vector search, both in the OpenSearch we already ran, merged and then reranked by an open-weights cross-encoder on 4 GPUs. A separate vector database came within 1 point of recall and would have been another system on our pager.
- Every chunk carries plan and product version, and retrieval filters on both.
- Every answer must cite at least 1 retrieved article. Below a reranker-score threshold, the assistant declines and offers a person. Since March 2025 that rule lives in code, not in the prompt.
- A pilot first, then a holdout randomized by customer business, so the impact number has a control group.

The reasons behind each, with the numbers, are in the 2 companion files.

## The numbers, and their definitions

- Recall@8: the share of eval questions where a gold article appears in the top 8 chunks. Keyword only 71%, vector only 76%, hybrid 84%, hybrid plus reranker 91%, all on the 640-question set at launch.
- Deflection: the share of in-app help sessions with no human support contact (chat, email or phone) from that user within 72 hours. 33% vs 17% for the old search in an 8-week holdout in June and July 2024, about 104,000 sessions. 35% vs 18% in a 4-week re-run in April 2026.
- About 8,000 fewer human-handled conversations a month by Q4 2024: the 16-point gap times about 50,000 help sessions a month.
- Wrong answer: an answer that contradicts the cited article or the product, includes a step that doesn't exist, or answers for the wrong plan or version. Correct but unhelpful answers, and declines, don't count. On the golden set: 3.4% at launch, 2.3% now. The set has grown and got harder since launch, so I compare configurations only on the same version of the set.
- Declines: about 19% of questions get "I don't know" and a handoff to a person.

## What went wrong

- Plan-tier answers. 9 of the first 40 pilot complaints were answers that described Enterprise-plan features to customers on the Starter plan. Plan availability lived in article prose, not in metadata, and I had never read the articles the way a Starter customer would. The fix is in `Support Answer Retrieval Index Design.md`.
- The 44% number. My first dashboard missed phone calls and anyone who came back after a day. A VP quoted 44% at a July 2024 all-hands; the honest number was 33%, and I sent the correction to the same audience within a week. The full story is in `Support Answer Retrieval Launch And Holdout.md`.
- A stale article. A release removed a setting, its article stayed published for 6 days, and the assistant cited it in 212 answers. The index was working; the content was wrong. Fixed with release-note links, fast re-indexing and a weekly stale-label check (`Support Answer Retrieval Index Design.md`).

## What it changed beyond the widget

- The retrieval layer became shared. Reply drafts for human specialists (January 2025) reuse it: I owned retrieval, another engineer owned the drafting and the UI. Specialists used a draft in 46% of conversations, and median handle time went from 14.2 to 12.6 minutes.
- The assistant became the main source of article bug reports. Between the weekly answer review and the stale-label job, support fixed or retired about 600 articles in 2025.
- Support operations planned 2025 on the holdout number, not the dashboard number.

## What isn't solved

- Follow-up questions are retrieved crudely, and the golden set has no multi-turn items to measure them.
- Deflection counts contacts avoided, not problems solved. A customer who gave up looks deflected.

## What I'd do differently

- Agree on the deflection definition with support and finance before the pilot, not after the first chart.
- Treat article metadata (plan, version, last verified) as part of the system from day 1.
- Put the decline threshold in code from the first release.
