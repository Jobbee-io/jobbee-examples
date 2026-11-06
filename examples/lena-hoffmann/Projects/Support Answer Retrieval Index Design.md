<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Support answer retrieval: index and retrieval design

Companion file to `Support Answer Retrieval.md`, the overview. This one covers the retrieval side I owned: what goes into the index, how articles are chunked and tagged, how a question becomes the chunks the model sees, the decline rule, how the index stays fresh, and what broke.

## The full story

When the production build started in October 2023, in-app help still ran keyword search over our articles, on the service I had built in 2021, and showed a list of links. The assistant needed more: the right passage of the right article, for the customer's plan and product version, or a decline. That retrieval side was mine. Ines R. led the team, and another ML engineer owned the prompt and generation.

I had built the first ingestion and chunking on 20% time in 2023. In November 2023 I settled the basics with tests: chunks split on headings instead of fixed windows, the heading path at the start of each chunk, keyword and vector search together in the OpenSearch we already ran, and no separate vector database. Hybrid search reached 84% recall@8, and the reranker took it to 91% by launch. Support asked for its internal macros in the index; I said no, and Ines backed me.

The pilot, from February to April 2024, found what I hadn't designed for. Starter customers got Enterprise answers, because plan availability lived only in article prose. Support operations tagged about 1,900 articles by hand, I parsed the rest, and the plan and version filter went inside the search. Release notes crowded out how-to articles, so older ones are now down-weighted. We launched to all customers in May 2024.

Two later events changed the design. In August 2024 a stale article was cited in 212 answers; since September an article is re-indexed within 15 minutes of being published or unpublished. In February 2025 a new model version ignored the decline instruction in the prompt; since March 2025 the code declines on its own when retrieval is weak. And since October 2025 the number of chunks per answer follows the reranker's scores.

Today about 19% of questions get a decline, and a weekly check flags about 15 stale articles for support to fix or retire. Still open: follow-up questions, answers that need 2 articles, and articles that lean on screenshots.

## What goes in

- Only published, customer-facing help articles and release notes: 6,400 articles, about 38,000 chunks.
- Internal support macros stay out. Support asked for them, because macros would have raised recall on billing edge cases. I said no and Ines R. backed it: macros contain workarounds we don't promise customers and can withdraw, and an answer that cites one is worse than a decline.
- Articles come from the help content API, the service I moved out of the monolith in 2022. At launch the whole index was rebuilt every night, in about 40 minutes. Since September 2024, publish and unpublish events re-index the changed article within 15 minutes, and the nightly rebuild runs only as a check that the two agree.

## Chunking

Chunks split on the article's headings, not on fixed token windows. A numbered list is never split. A section over 1,000 tokens is split at paragraph breaks, and each piece repeats its heading. In my first test, in November 2023, 512-token windows with overlap cut 31% of numbered procedures into 2 chunks, and the model then answered with half a procedure. Heading chunks split 4%, all of them very long sections.

Each chunk's text starts with the article title and heading path, like "Invoicing > Batch invoices > Send a batch". That raised vector-only recall@8 from 72% to 76%, because a section's body often says "click Send" and only its headings say what is being sent.

The chunks the model sees average about 700 tokens. Retrieved chunks skew long, because procedures are long.

## Metadata, and the filter

Every chunk carries the article ID, the article type (how-to, troubleshooting, release note), the plans it applies to (Starter, Pro, Enterprise), the product version it applies to, and the date the article was last verified.

Product version means which generation of a module the customer's account runs. In 2024 the main split was invoicing: about 30% of accounts were still on the old invoicing module, which has different screens for the same tasks.

None of this metadata existed at launch. Plan availability lived in article prose, and the pilot found it: 9 of the first 40 complaints were Enterprise answers given to Starter customers. Support operations tagged about 1,900 articles by hand over 2 weeks. I parsed the rest from sentences like "Available on Pro and Enterprise", and support checked a random 200 of my parses: 6 were wrong, and we fixed them.

The filter runs inside the search, not after it. Filtering after the top 40 left Starter customers with few candidates, because Enterprise-only chunks filled the list.

A hard filter has a cost: a Starter customer asking how to use an Enterprise feature would get "I don't know". So the filter applies to procedures, and when the best match overall is a feature on a higher plan, the answer says which plans include it and links the article. About 3% of questions end that way.

## From question to chunks

1. Two searches in OpenSearch, 40 results each, both filtered by plan and version. One is BM25 over chunk text, with the synonym list from my 2021 search work ("WO" for work order, "tech" for technician). The other is k-NN over embeddings from an open-weights embedding model, 768 dimensions.
2. The two lists are merged with reciprocal rank fusion, keeping the top 40. I also tried a weighted sum of normalized scores. It came within 1 point of fusion on recall, but its weight needed retuning every time the embedding model changed. Rank fusion has nothing to tune.
3. An open-weights cross-encoder reranker scores the 40 question-and-chunk pairs.
4. At launch the top 12 went to the model. Since October 2025 the count follows the reranker's score gap, 3 to 8 chunks, median 5 (`Inference Cost And Latency.md`).

Why hybrid: the two searches miss different things. BM25 finds exact screen labels and our abbreviations, and the embedding model doesn't know that "WO" means work order. Vector search finds questions phrased nothing like the article: "my guy can't see tomorrow's jobs" should find the article on technician schedule visibility.

Recall@8 on the 640-question set at launch:

| Configuration | Recall@8 |
|---|---|
| Keyword (BM25) only | 71% |
| Vector only | 76% |
| Hybrid, rank fusion | 84% |
| Hybrid plus reranker | 91% |

Recall@40 for the hybrid candidates was 97%, which is the ceiling for the reranker. Most of the remaining misses are questions whose answer is spread over 2 articles.

Latency at launch, p95: about 90 ms for both searches together, and 180 ms for the reranker on 4 GPUs. Dynamic batching later took the reranker to 70 ms on 2 GPUs.

## A separate vector database: tested, not adopted

In November 2023 I tested a dedicated vector database against OpenSearch's k-NN, on the same embeddings. Recall was within 1 point and latency was similar. 38,000 vectors of 768 dimensions is about 120 MB, which fits in memory many times over. A dedicated store solves a scale problem we don't have, and it would have been another system on our pager. We already ran OpenSearch, with backups, dashboards and runbooks, from the 2021 search service.

## The decline rule

Every answer must cite at least 1 retrieved article. If the reranker's top score is below a threshold, the assistant declines and offers a person, and passes the question along so the customer doesn't have to repeat it.

At launch the code only marked low-confidence retrievals in the prompt, and the prompt told the model to decline on them. In February 2025 a new model version ignored that instruction often enough to more than double our wrong-answer rate (`Evaluation Harness.md`). Since March 2025, below the threshold the code declines without calling the model.

I set the threshold on the golden set: the highest score at which no more than 6% of answerable questions get declined. At that threshold 84% of the should-decline items decline. In production about 19% of questions get a decline. I re-check the threshold whenever the reranker or the embedding model changes.

## What broke, and the fix

- Plan-tier answers in the pilot, above.
- Release notes crowding out how-to articles. A release note mentions many features in a sentence each, and BM25 liked them. In the pilot they were 18% of top-1 results and almost never the gold article. Release notes older than 90 days are now down-weighted.
- The stale article. An August 2024 release removed a batch-invoicing setting, and its article stayed published for 6 days. The assistant cited it in 212 answers. The index was working; the content was wrong. Three changes came out of it. Release notes now list the articles each change affects. Unpublishing an article re-indexes it within 15 minutes. And a weekly job compares the product's current screen labels with article text and flags articles that mention labels the product no longer has. It flags about 15 articles a week, and support fixes or retires them.

## What isn't solved

- Follow-up questions. A follow-up is retrieved with the new message plus the previous question. It's crude, and the golden set has only single questions, so the weekly human review is the only check on follow-ups.
- Answers that need 2 articles. They are most of the remaining recall misses.
- Screenshots. About 1,100 articles lean on them ("click the gear icon"), and the index has only their text.
