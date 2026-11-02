<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The fine-tuned model that lost, and why I stopped it

Gablewright Software, Applied AI team. June to August 2025, 11 weeks. This project is not in my resume's Experience section; it's one line in my failures index. It's my answer to "have you fine-tuned a model?": yes, once, and it lost. This file holds the bar I set before starting, the setup, the eval results, the decision to stop, and what I got wrong along the way.

## Why we tried it

In June 2025 our LLM API spend was about $37,000 a month and growing about 6% a month. A product VP wanted an "our own model" story for the board. And I proposed it partly because I wanted fine-tuning experience on my resume. I write that down because it's the honest reason I argued for a 10-week project instead of a 3-week test.

Before starting, Ines R. and I wrote the bar down. A LoRA fine-tune of an open-weights 8B instruct model, using our existing retrieval, would ship only if it came within 0.5 points of production's wrong-answer rate, at half of production's cost per conversation or less, with p95 time to first token under 1.5s. Decision at week 10.

## My role

I owned all of it: the data, the training runs, serving, the evaluation and the memo that stopped it. Kofi A. reviewed the comparison. Ines approved a $9,000 compute cap. The platform team lent us GPU quota.

## The setup

- Data: 41,000 resolved support conversations from 2022 to 2025, turned into question-and-answer pairs. A scrubbing step removed names, phone numbers, addresses and account IDs; on 500 hand-labeled conversations it caught 99.2% of them. Deduplicated and filtered down to 23,000 pairs.
- Training: PyTorch with LoRA adapters, 3 runs on rented GPUs. About $4,100 of compute in total: $2,900 for training, $1,200 for serving and load tests.
- Serving: vLLM on 2 GPUs.
- Evaluation: the same harness, on the full golden set as it was then, 980 items. Wrong answers and should-decline items are defined as in the harness (`Evaluation Harness.md`). Cost per conversation is what it costs to generate every answer in a conversation (API fees for production, GPU time for the self-hosted models), divided by conversations.

## The results (980 items)

| Configuration | Wrong answers | Should-decline items declined | Cost per conversation |
|---|---|---|---|
| Production: hosted API, retrieval, prompt | 2.0% | 84% | $0.30 |
| Open-weights 8B, not fine-tuned, same retrieval and prompt | 5.4% | 61% | $0.17 |
| Fine-tuned 8B with retrieval (run 2) | 4.3% | 38% | $0.17 |
| Fine-tuned 8B without retrieval | 11.6% | 9% | $0.15 |

That table decided it, for 2 reasons. Fine-tuning made answers better than the base model, but it made declining worse: the tickets taught the model that a support specialist always answers. And 29% of its wrong answers described screens that had changed since 2023, because old tickets described old screens.

The cost column is at our real traffic. About 80% of conversations happen between 7am and 6pm US time, so GPUs sized for the weekday peak averaged about 35% utilization. At full utilization the cost would have been about $0.07, and that is the number that got the project approved (below). Latency was the only bar it met: p95 time to first token 0.9s, against production's 3.1s.

## The decision

At week 10, run 2 missed the quality bar by almost 2 points and the cost bar by 2 cents. The VP asked for 1 more run with more data. I agreed to 1 week, with the bar unchanged and written in the thread. Run 3 used only 2024–2025 tickets from the current product version (14,000 pairs): 3.9% wrong answers, 44% of should-decline items declined. It missed again. I wrote a 1-page memo with the table first and the recommendation in the first sentence, and we stopped in week 11.

## What went wrong

- I built serving before I measured. I spent about 3 weeks on vLLM serving and a load test before running the first checkpoint through the harness. That eval, in week 2, would have shown the size of the gap.
- I trained on old tickets. The product's screens changed a lot in 2023 and 2024. Filtering by product version should have been the first run, not the last attempt.
- Motivated reasoning. In week 6 I called the 5.4% → 4.3% improvement "closing the gap" in standup. The gap to production was still more than double. Kofi said so, and he was right.
- The approval used the wrong cost. My first estimate assumed full GPU utilization ($0.07). I only computed the real-traffic number ($0.17) in week 5.

## What came out of it

- The cost goal was met anyway, by boring work: sending less context, caching and routing took production to $0.11 a conversation without a fine-tune (`Inference Cost And Latency.md`).
- 160 hard multi-step cases from the ticket data went into the golden set.
- The eval pipeline reuses the scrubbing step.
- I know the full workflow of fine-tuning 1 model: data preparation, LoRA training, serving, and evaluation against a production baseline. I don't claim more than that.

## What I'd do differently

- Run the cheapest comparison first: the base open-weights model with our retrieval, in week 1.
- Put the first decision point at week 3, not week 10.
