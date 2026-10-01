<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Positioning-failure postmortem — the repositioning the market rejected

Verity Cloud, 2024. This is the failure I keep on the first page of my resume, because the win on Halyard Tools' repositioning (`Projects/Tier 1 Launch Api Platform.md` covers the launch; the reposition is its sibling) only means something next to it. I attempted to move Verity's legacy workflow product — Workflowline, a 2018-era pipeline orchestrator with 1,900 enterprise customers — into the "modern platform" narrative the Ledgerline launch had established. Two quarters later the market's answer was silence, one analyst note calling the story "unearned," and $1.1M of spend with nothing to show. What follows is the postmortem as I presented it internally, unchanged except for length.

## What I tried, and why it was reasonable-looking

The theory: Workflowline's actual capabilities had genuinely expanded (event-driven triggers, a declarative config surface) and its *perception* hadn't — buyers still filed it under "legacy batch orchestrator." The narrative gap was real and measured: in win/loss, Workflowline lost 7 of 10 evaluations with "felt like the previous decade" appearing verbatim in five write-ups. So I built the repositioning: new category framing ("continuous workflow platform"), a launch arc, refreshed demo, analyst briefings, a customers-to-the-new-story program.

The Halyard Tools playbook, in other words — where narrative led product by one quarter and the market followed. I had done this before. That's exactly what made the failure instructive.

## What actually happened

- **Q1: the launch quarter.** Briefings landed fine (analysts are contractually polite), the launch content shipped on time, the customer program enrolled 40 accounts. Pipeline response: +6% versus the prior comparable quarter — inside noise. Win/loss write-ups didn't change; "felt like the previous decade" kept appearing in losses *for the repositioned product itself*.
- **Q2: the correction quarter.** We tightened messaging, doubled content spend, added an AR push. Result: −3%, and the quarter's one unambiguous market signal arrived — a *Stackfield Report* category note that praised Ledgerline's positioning in one paragraph and described Workflowline's new story as "unearned by the product's operating model" in the next. Fifteen hundred practitioners read that sentence out loud in evals for the rest of the year.
- **Month 7: we stopped.** I wrote the recommendation myself. Not a rollback to the old story — a reversion to *accurate-scope* positioning: Workflowline as the dependable orchestration layer *alongside* the modern platform, with an explicit modernization path story instead of a modern-product story. The honest version finally matched what the product could demonstrate, and evaluation losses stabilized within two quarters.

## The cost, itemized

- ~$1.1M: content, AR program, event presence, and the customer-facing repositioning program.
- Two quarters of the Workflowline product-marketing pod's focus (three people), which delayed a successful compliance-story campaign that shipped in Q3 and performed immediately.
- Harder to price: the "unearned" analyst sentence did real damage to our credibility budget on *other* narratives. Credibility is one account, and the repositioning overdrew it.

## Why it failed — the actual mechanism

Halyard Tools' repositioning succeeded because **narrative led product by one quarter and the product could close the gap in that quarter.** The docs and quickstarts shipped first; the platform story followed within weeks. Narrative can run slightly ahead of reality because narrative creates attention, and attention gives product a window. What narrative cannot do is hold attention on a gap the product won't close — because the second demo is always the truth.

Workflowline's gap wasn't one quarter wide. The "modern platform" story implied an operating model — continuous, declarative, event-first — that the product's batch-oriented core contradicted in every hands-on eval. The market didn't reject the *copy*. It rejected the copy after touching the product, which is the only rejection that counts. My error was reading the Halyard Tools precedent as a law instead of as a bounded case: narrative can outrun product by the width of one quarter, and I tried to make it outrun by three years.

## What changed in how I work

- **The gap test, now a standing gate:** before any repositioning proposal, I write down what the product must demonstrably do for the story to survive a second demo, and the date by which it will. If the gap needs more than a quarter to close, the answer is a *product* investment case first, and marketing waits. I've killed two of my own repositioning proposals with this test since; both would have failed the same way.
- **Win/loss verbatims outrank positioning docs.** The "felt like the previous decade" line was in our own data from day one. I explained it away as a perception problem — which was technically true and completely useless. The perception *was* the data.
- **Analyst politeness is not market signal.** The briefings went well because briefings do. The first honest signal arrived as a category note and an eval write-up. I now weight silent quarters and eval verbatims over briefing sentiment by about ten to one.
- **One sentence for interviews:** positioning can change how a true thing is heard; it cannot make a false thing true. The craft is knowing which side of that line your product is on *before* you spend $1.1M finding out.
