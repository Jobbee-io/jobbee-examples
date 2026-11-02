<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Inference cost and latency: from $0.30 to $0.11 a conversation

Gablewright Software, Applied AI team. September 2025 to February 2026. On my resume this is one bullet with 3 numbers. This file holds where the money and the time went, what each change saved, how we kept quality from sliding, the 2 changes that broke, and a readout I had to correct.

## Where we started (August 2025)

- About 96,000 assistant conversations a month, at about 2.1 turns each, in the web app and, since February 2025, the technicians' mobile app. On top of that, reply drafts for about 55,000 human-handled conversations a month.
- LLM API spend $41,000 a month: $29,000 for the assistant, $9,500 for reply drafts, $2,500 for offline jobs (nightly evals, re-embedding, ticket summaries).
- $0.30 per assistant conversation. Time to first token p50 1.6s, p95 3.1s. Full answer p95 8.4s.
- Every turn sent the top 12 chunks, about 8,400 tokens, to the larger model, whatever the question.

Before changing anything, Ines R., Rosa M. and I agreed on a quality budget: the whole project could raise the golden-set wrong-answer rate by at most 0.5 points.

## My role

I owned the project: the cost and latency breakdown, the design, most of the code and every rollout. Yusuf K. from the platform team built dynamic batching for the reranker. Kofi A. and I did the offline analysis for the routing classifier together.

## What we changed, in the order it shipped

1. Sending less context (September–October 2025). Instead of a fixed 12 chunks, the count now follows the reranker's score gap: 3 to 8 chunks, median 5. Input tokens fell 46% and the wrong-answer rate stayed at 2.0%. About $0.09 saved per conversation: the biggest single lever, and the least clever one.
2. Prompt-prefix caching (October 2025). I reordered the prompt so the fixed instructions (about 2,500 tokens) come first and everything that varies comes after. The hosted API's prompt caching then hits on about 88% of calls. About $0.02 per conversation, and 0.3s off time to first token.
3. An exact-match answer cache (November 2025). The key is the normalized question, the plan, the product version and the versions of the cited articles, so a change to any of those articles invalidates the entry. It hits on 11% of first turns and answers them in under 200ms. About $0.02 per conversation.
4. Routing between 2 model sizes (December 2025). A logistic-regression classifier on the question's embedding and retrieval features sends about 57% of turns to the smaller, cheaper model from the same hosted API. Multi-step troubleshooting, billing questions and low-confidence retrieval go to the larger model. About $0.06 per conversation. The wrong-answer rate went from 2.0% to 2.3%: inside the budget, and the only change in this project that cost quality, which I put in the readout.
5. Batching. Offline jobs moved to the API's batch endpoint at about half price: $2,500 → $1,100 a month. Yusuf's dynamic batching on the reranker GPUs (15ms maximum wait) raised throughput 3.4x, so we went from 4 GPUs to 2, and reranker p95 dropped from 180ms to 70ms.

## The numbers (February 2026), and their definitions

- Cost per assistant conversation: the LLM API cost of every call in a conversation, divided by conversations. It excludes GPUs and OpenSearch. $0.30 → $0.11.
- Monthly LLM API spend: $41,000 → $16,300 ($11,400 assistant, $3,800 reply drafts, $1,100 offline), while assistant volume grew about 8%, to 104,000 conversations. Reply drafts got the same context, caching and routing changes. That's $24,700 a month, about $296,000 a year.
- Latency at the server: time to first token p50 1.6s → 0.7s, p95 3.1s → 1.2s. Full answer p95 8.4s → 4.6s.
- Latency on the technicians' mobile app, measured on the phone: full answer p95 9.9s → 6.2s. Most of the rest is mobile networks on job sites.
- Quality: golden-set wrong-answer rate 2.0% → 2.3%. Deflection in the April 2026 holdout re-run was 35%, so the savings didn't cost us deflection.

## What went wrong

- The semantic cache. In October 2025 I tried a cache that matched questions by embedding similarity, for 2 days at 5% of traffic. A review of 61 cache hits found 3 wrong matches. The worst: "how do I deactivate a technician" got the steps to delete one, and deleting removes the technician's job history. We found no customer who followed those steps, which was luck. I turned it off the same day and kept exact matching only. The golden set had no near-duplicate question pairs that could have caught it; it has 40 now, and any cache that matches approximately has to pass them first.
- Routing drift. In January 2026 we launched recurring maintenance plans. The routing classifier was trained before the feature existed, scored the new questions as simple and sent them to the smaller model. In the first week's review, 7 of 31 answers about the feature were wrong. Now any question that retrieves an article less than 30 days old goes to the larger model. A classifier trained on last quarter's questions is wrong about next quarter's product, and I should have planned for that.
- I reported server latency first. On the mobile app the gain was smaller, and I corrected the readout with numbers measured on the phone. Device latency is in every readout now.

## What I'd do differently

Start from the token breakdown. Context size was the obvious lever from the first trace, but I spent the first 2 weeks designing caches because caching was more interesting.
