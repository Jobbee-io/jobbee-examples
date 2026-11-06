<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Positioning-failure postmortem: the repositioning the market rejected

Verity Cloud, January to August 2024. I tried to move Workflowline, Verity's legacy workflow product, into the "modern platform" story the Ledgerline launch had set up. Workflowline is a pipeline orchestrator from 2018 with 1,900 enterprise customers. Two quarters later the market had answered with silence, an analyst note calling the story "unearned," and $1.1M of spend with nothing to show. I keep this failure on the first page of my resume, because my one successful repositioning, at Halyard Tools in 2019, only means something next to it. This is the postmortem as I presented it internally, shortened.

## The full story

By late 2023 the Ledgerline launch had given Verity a "modern platform" story, and Workflowline sat outside it. The product had grown event triggers and a declarative config surface, but buyers still filed it as a legacy batch scheduler, and it had lost 7 of its last 10 evaluations. The product line's general manager asked for a repositioning. I agreed and I led it, so the call is mine.

I built the plan: the new category frame, the launch arc, the refreshed demo, the analyst briefings and the customer program. The three-person Workflowline product-marketing team carried most of the execution, which is why the cost includes two quarters of their focus. The warning that mattered came from the Workflowline engineering lead during planning: the event triggers ran on a batch scheduler, and any latency test would show it. I heard it as a demo problem.

We launched in Q1 2024. The briefings were polite, the content shipped, 40 accounts joined the customer program, and the loss write-ups didn't change. In Q2 we tightened the messaging and spent more. Pipeline came in 3% down, and *The Stackfield Report* called the story "unearned." In month 7 I wrote the recommendation to stop, and to position Workflowline as the dependable orchestration layer next to the modern platform, with an explicit modernization path. Evaluation losses stabilized within two quarters.

What it cost: about $1.1M, a delayed compliance campaign, and a sentence buyers quoted back at other Verity products for the rest of the year. What came out of it is the gap test, which I've since used to kill two of my own repositioning proposals.

What's still open is the product gap itself. Closing it is a product decision and a product investment, not a marketing one. Until it closes, the narrower story is the honest one.

## What I tried, and why it looked reasonable

Workflowline's capabilities had grown: it now had event-driven triggers and a declarative config surface. Its perception hadn't moved. Buyers still filed it under "legacy batch orchestrator." The gap showed up in our own data. Workflowline lost 7 of its last 10 evaluations, and "felt like the previous decade" appeared word for word in 5 loss write-ups.

The product line's general manager wanted a repositioning. I agreed, and I led it, so the call is mine. I built the full plan:
- a new category frame, "continuous workflow platform";
- a launch arc and a refreshed demo;
- analyst briefings;
- a program to move existing customers onto the new story.

In other words, it was the Halyard playbook, where the story ran one quarter ahead of the product and the market followed. I'd done this before. That's what makes the failure useful.

One warning came early, and I misread it. In planning, the Workflowline engineering lead told me the event triggers were built on top of a batch scheduler, and that this would show in any latency test. I treated it as a problem for the demo script. It was a problem for the story.

## What happened

- **Q1, the launch quarter.** The analyst briefings went fine; analysts are paid to be polite. The content shipped on time, and 40 accounts joined the customer program. Pipeline was +6% against the prior comparable quarter, which is inside the noise. The loss write-ups didn't change: "felt like the previous decade" kept appearing for the repositioned product itself.
- **Q2, the correction quarter.** We tightened the messaging, doubled content spend and added an analyst-relations push. Pipeline came in at −3%. Then *The Stackfield Report* published a category note. One paragraph praised Ledgerline's positioning. The next called Workflowline's new story "unearned by the product's operating model." Buyers quoted that sentence back to our sellers in evaluations for the rest of the year.
- **Month 7: we stopped.** I wrote the recommendation myself. It wasn't a rollback to the old story. It was positioning that matched what the product could show: Workflowline as the dependable orchestration layer alongside the modern platform, with an explicit modernization path. Evaluation losses stabilized within two quarters.

## The cost

- About $1.1M across content, the analyst program, event presence and the customer program.
- Two quarters of the three-person Workflowline product-marketing team's focus. That delayed a compliance campaign, which shipped in Q3 and performed straight away.
- Credibility on our other stories. The "unearned" sentence was quoted in evaluations of other Verity products too. Credibility is one account, and this overdrew it.

## Why it failed

At Halyard the story ran one quarter ahead of the product, and the product closed the gap within that quarter. A story can run a little ahead of reality, because it buys attention, and attention gives the product a window. It cannot hold attention on a gap the product won't close, because the second demo always tells the truth.

Workflowline's gap wasn't one quarter wide. "Modern platform" implied an operating model, continuous, declarative and event-first, that the batch core contradicted in every hands-on evaluation. The market didn't reject the copy. It rejected the copy after touching the product. My error was treating the Halyard case as a law instead of a bounded example. The story could outrun the product by one quarter; I tried to make it outrun by about three years.

## What changed in how I work

- **The gap test, now a standing gate.** Before any repositioning proposal, I write down what the product must demonstrably do for the story to survive a second demo, and by what date. If the gap needs more than a quarter to close, the first step is a product investment case, and marketing waits. Since then I've used this test to kill two of my own repositioning proposals.
- **Win/loss verbatims outrank positioning docs.** "Felt like the previous decade" was in our own data from day one. I explained it away as a perception problem. The perception was the data.
- **Analyst politeness is not market signal.** I now weight quiet quarters and evaluation verbatims far above briefing sentiment, about ten to one.

Positioning can change how a true thing is heard. It can't make a false thing true. The job is knowing which side of that line the product is on before spending $1.1M to find out.
