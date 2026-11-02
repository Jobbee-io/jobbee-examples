<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Lena Hoffmann

lena.hoffmann@example.com · (555) 083-5162
github.com/example/lenahoffmann · linkedin.com/in/example-lenahoffmann
Boston, MA

*The long version of my resume. The one-pager says what I built; this file holds the scope, the definition behind every number, what I haven't done, and the work that failed. The full stories live in `Projects/`.*

---

## Summary

Senior Machine Learning Engineer, about 8 years in production engineering: 5 as a backend engineer, then 3 on an applied LLM team at Gablewright Software after an internal transfer. I build LLM features that real customers use, and I measure them: a support-answer system with hybrid retrieval and a cite-or-decline rule, the evaluation harness that gates every change to it, and the cost and latency work that cut its cost per conversation by 63%. I haven't pretrained a model or published research. My one fine-tune lost to retrieval plus prompting, and it's in this file too.

---

## Experience

### Gablewright Software — Senior Machine Learning Engineer, Applied AI (Oct 2024 – present); Machine Learning Engineer (Sep 2023 – Sep 2024)

Field-service software (scheduling, dispatch, invoicing) for trade contractors, about 31,000 customer businesses, Boston. The Applied AI team was 5 people when I joined and is 9 now. I'm the tech lead, as an IC, for the help assistant's retrieval and evaluation.

- Help assistant retrieval (all customers since May 2024). Built ingestion, heading-based chunking of 6,400 articles, keyword and vector search in OpenSearch, an open-weights reranker, plan and version filters, and the rule that every answer cites an article or declines. Recall@8 71% (keyword only) → 91%. Deflection 33% vs 17% for the old search in an 8-week holdout test; about 8,000 fewer human-handled support conversations a month by Q4 2024. Full notes: `Projects/Support Answer Retrieval.md`.
- Evaluation harness (Nov 2023 – present). Golden set of 1,180 real questions labeled with 2 support specialists; an LLM judge checked against them (92% agreement, Cohen's kappa 0.81); a merge gate on every prompt, model, index or retrieval change; a weekly human review of 150 production answers. Wrong-answer rate 3.4% at launch, 2.3% now. In Feb 2025 it stopped a model-version swap that would have raised it from 2.2% to 5.1%. Full notes: `Projects/Evaluation Harness.md`.
- Cut cost per assistant conversation from $0.30 to $0.11 and p95 time to first token from 3.1s to 1.2s (Sep 2025 – Feb 2026) by sending less context, caching, moving offline jobs to batch, and routing between 2 model sizes. Monthly LLM API spend $41K → $16K at higher volume; wrong-answer rate +0.3 points, inside an agreed budget. Full notes: `Projects/Inference Cost And Latency.md`.
- Reply drafts (Jan 2025). Reused the retrieval layer to draft replies for human support specialists. I owned retrieval; another engineer owned the drafting and the UI. Specialists used a draft in 46% of conversations; median handle time 14.2 → 12.6 minutes.
- Mentored a backend engineer through the same internal transfer in 2025. Interviewed about 35 ML engineer candidates and wrote the team's evaluation-design interview question.
- Era tech: Python, OpenSearch (BM25 and k-NN), hosted LLM APIs, an open-weights embedding model and reranker, PyTorch, vLLM, Postgres, Kubernetes.

### Gablewright Software — Senior Software Engineer (Feb 2022 – Aug 2023); Software Engineer (Mar 2020 – Jan 2022), Search & Help Platform

Team of 6 owning help-center search, the help content API and in-app help.

- Help-center search service (2021). Replaced a vendor-hosted site search with our own service on OpenSearch, about 2.1M queries a month across web and app. First-page click-through 41% → 58%. Zero-result rate 14% → 4%, mostly from a synonym list built from 18 months of ticket vocabulary ("WO" for work order, "tech" for technician).
- Help content API (2022). Moved it out of the monolith into a Python service; p99 1.4s → 220ms.
- Help analytics events (2022). Built the pipeline that sends in-app help events to the data warehouse. In 2024 it's what made deflection measurable.
- On-call for 4 services on a 1-in-6 rotation.
- Spent 20% of my time on the Applied AI team's first prototype (Mar – Jul 2023), then transferred to that team in Sep 2023, 1 level down on the ML ladder; re-leveled 13 months later. Full notes: `Projects/Backend To Ml Transfer.md`.

### Bargewell — Backend Engineer (Jul 2018 – Feb 2020)

Freight-quoting startup in Boston, about 60 people. Go, Postgres, RabbitMQ.

- Rate-quote API: p95 900ms → 240ms by caching carrier rate tables and calling carriers in parallel; about 35,000 quotes a day.
- Carrier integrations: 14 carriers, each tested against recorded responses, so a carrier's format change failed in CI instead of in production.
- On-call from month 4. Left in Feb 2020 after layoffs folded my team into another one.

---

## Education

- MS Computer Science, Teversham University, Boston, 2016–2018. Databases, distributed systems, information retrieval (where I first met BM25), and 1 machine learning course, where I got a B.
- BSc Informatik (computer science), Hochschule Lindenbruck, Germany, 2012–2016.
- Fall 2023: a 14-week evening machine learning course through a university extension program, taken for the transfer.

---

## Skills (honest)

- Daily: Python, SQL, retrieval design (BM25, vector, hybrid, reranking), evaluation design and LLM-judge calibration, prompt and context design, hosted LLM APIs, OpenSearch, Postgres, on-call.
- Working level: PyTorch, LoRA fine-tuning (1 project), vLLM serving (1 project), Kubernetes deploys, Go (2018–2020, rusty).
- Not done: pretraining, distributed training, research publications, RLHF, model architecture work, computer vision.

---

## Numbers I can defend

- Recall@8 on our eval set: keyword 71%, vector 76%, hybrid 84%, hybrid plus reranker 91%.
- Deflection 33% vs 17% (8-week holdout, mid-2024); 35% vs 18% (4-week re-run, April 2026).
- Wrong-answer rate on the golden set: 3.4% at launch, 2.3% now. The random sample in the weekly production review averaged 2.6% in 2025.
- Judge-to-human agreement 92% (kappa 0.81) on 400 double-labeled items; human-to-human 94%.
- The Feb 2025 model-version regression: 2.2% → 5.1% wrong answers, caught before it shipped.
- The fine-tune: best run 3.9% wrong answers against 2.0% for production; stopped in week 11.
- $0.30 → $0.11 per conversation; p95 time to first token 3.1s → 1.2s; LLM API spend $41K → $16.3K a month.
- Search, backend era: click-through 41% → 58%, zero-result rate 14% → 4%.

## Failures, indexed honestly

- The 44% deflection number I put on a dashboard in July 2024. A VP quoted it at an all-hands; the honest number was 33%, and I sent the correction to the same audience. `Projects/Support Answer Retrieval.md`
- I copied 37 golden-set questions into the prompt as examples, which inflated our scores for 4 months until my own overlap check found them. `Projects/Evaluation Harness.md`
- A fine-tuned open-weights model that I proposed, partly because I wanted fine-tuning on my resume. It lost on our evals and I stopped it after 11 weeks. It isn't in my Experience section; this line is its only place on the resume. Full notes: `Projects/Fine Tune That Lost.md`
- A semantic cache that, for 2 days at 5% of traffic, answered "how do I deactivate a technician" with the steps to delete one. `Projects/Inference Cost And Latency.md`
- I moved teams without making my backfill a condition, and stayed on my old team's pager for 2 months. `Projects/Backend To Ml Transfer.md`
