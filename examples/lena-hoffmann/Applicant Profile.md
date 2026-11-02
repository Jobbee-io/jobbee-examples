<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Lena Hoffmann

Notes about my search that the settings fields can't hold. I build LLM features in production, a field with a lot of noise in it, so this file says what I built, how it was measured, and what I haven't done.

## What I'm looking for

- Staff Machine Learning Engineer roles, applied LLM or ML platform (evaluation, retrieval, inference). I'm a Senior ML Engineer today and Staff is the step I'm aiming for. I'd look at a Senior role only where the scope is clearly bigger than mine and the base clears my floor.
- About 8 years in production engineering: about 5 as a backend engineer, then 3 as an ML engineer on an applied LLM team, after an internal transfer at the same company. Python is my main language; I wrote Go at my first job.
- Location: Boston. Hybrid in Boston or Cambridge up to 3 days a week, or remote in the US with Eastern-time overlap. I'm not relocating.
- Compensation: current base $198K, a 10% bonus target, and private-company options worth about $35K a year at the last internal valuation. Looking for $235K–$265K base and $360K–$450K total comp. Base floor $230K. I value private-company options at a steep discount, so a private offer needs a base near the top of that range.
- Notice: currently employed. I'd give 4 weeks so my team gets a clean handoff.

## Where I have real depth

- Retrieval in production. I built the retrieval layer of a customer-facing help assistant: keyword and vector search together in OpenSearch, an open-weights reranker, plan and version filters, and a rule that every answer cites an article or says "I don't know." Recall@8 went from 71% (keyword only) to 91%. In a holdout test, 33% of help sessions ended without a human contact, against 17% for the old search.
- Evaluation. I built and own the eval harness: 1,180 real customer questions labeled with 2 support specialists, an LLM judge checked against those people (92% agreement; the 2 people agree with each other 94% of the time), a merge gate on every change, and a weekly review of 150 production answers. It stopped a model-version swap that would have taken our wrong-answer rate from 2.2% to 5.1%.
- Inference cost and latency. Cost per assistant conversation from $0.30 to $0.11, p95 time to first token from 3.1s to 1.2s, monthly LLM API spend from $41K to $16K. Mostly boring levers: sending less context, caching, batch jobs, and routing between 2 model sizes.
- Backend in production. About 5 years of services, Postgres, OpenSearch, queues and on-call before the ML work. That's why the ML work ran reliably: I already knew how to own a service.

## What I have not done

- No pretraining and no distributed training. Beyond small exercises, I've never trained a model from scratch.
- No research publications and no new model architectures.
- Exactly 1 fine-tune: LoRA on an open-weights 8B model with our support tickets. It lost to retrieval plus prompting on our evals and I killed it. That is the full extent of my training experience, and I say so in interviews.
- My PyTorch is working level, not expert.

## Search constraints — please respect these

- Individual contributor only. No manager or player-coach roles. I've led projects and mentored, and I want to keep doing the technical work.
- Production LLM work with real users and a habit of measuring. Skip roles where the job is demos, an "AI strategy," or a launch with no plan to measure quality. Measuring is my main skill and those roles wouldn't use it.
- No research scientist or pretraining roles. I'm not qualified for them and I'd rather not waste a team's interview loop.
- No ad targeting or engagement-maximizing feeds. For 3 years I've measured whether an answer actually helped someone; I don't want to optimize for time spent instead.
- Shared on-call is fine; I've carried a pager for 8 years. A solo pager for a model-serving stack is not.

## How I work

- Eval first. Before I change a prompt, a model or an index, I want the number it should move and the set it's measured on, with an error bar.
- I write a definition next to every metric, and I write the memo when a project should stop, including my own projects.
- I build with the people who do the work by hand. Support specialists wrote our reference answers and still review production answers every week.
- I keep my project files current as work ends, not when a search starts.

## Visa / Work Authorization

- Citizenship: Germany
- US status: permanent resident (green card) since 2024, employment-based; the process is complete and doesn't tie me to any employer
- US work authorization: unrestricted; no sponsorship needed now or later
- As a German citizen I can also work in the EU, but I'm not searching there

## Clarifications

*(Questions Jobbee asked when two facts in my files pulled against each other. Log format: question, answer, newest last.)*

**Q:** You target Staff Machine Learning Engineer roles, and your files also say you have never pretrained a model and your one fine-tune didn't ship. Many Staff ML Engineer postings list model training as a core requirement. Should those roles be in your search?
**A:** Some of them. Include a role if training is one tool among several and the core of the job is building products on top of models: retrieval, evaluation, inference, serving. Skip it if the first responsibilities on the posting are training runs, data mixtures or research. The test I use: if I'd spend most of my first year making a model behave well for users and proving it with numbers, I'm a strong fit. If I'd spend it training models, I'm the wrong hire, and we'd both find out in the first technical round. I'd rather the search find the first kind and leave the second alone.
