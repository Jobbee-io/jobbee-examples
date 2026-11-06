<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Checkout internship: the payment-error state machine

Cartway, checkout team, June to August 2025 internship. About 1,400 checkouts a day hit a payment error and go through the code I wrote. I owned the state machine end to end. The team of 9 (my mentor Priya N., two other engineers, and the rest nearby) reviewed and shipped it with me.

## What I walked into

In week 1, reading the checkout service, I found payment failures handled by six error branches, written at different times by different people:

- `gateway_timeout`: retried immediately, with no limit.
- `card_declined`: terminal, but also caught by a retry wrapper upstream, so a declined card could be retried twice before giving up.
- `network_error`: sometimes retried, depending on which of two helper functions the call site used.
- Three more, each slightly different.

Nobody could draw the whole flow. My mentor's answer when I asked for a diagram: "If someone draws it, it'll be wrong by next quarter." Support had logs and experience, and whether a failed payment was safe to retry depended on who answered the ticket.

## What I designed

A typed state machine that every payment error enters, with explicit states and transitions. A transition is either allowed or it isn't. My mentor made me rewrite the week-2 design doc twice, and both rewrites were right.

The states: the entry state `attempting`, then 9 more. Seven error states: `gateway_timeout`, `network_error`, `card_declined`, `insufficient_funds`, `gateway_5xx`, `validation_error`, `retry_budget_exhausted`. Two terminal states: `failed_permanent` and `failed_retryable_deadline_passed`. The PR counted 9 states plus the entry state.

14 transitions, each with a rule. The ones that matter:

- Every retryable class has a retry budget (attempts and a wall-clock deadline) stored in the payment row, not in memory, so a checkout pod can die mid-retry and the budget survives.
- `card_declined` and `insufficient_funds` are terminal. No wrapper can retry them.
- `gateway_timeout` is retryable with a deadline. After 45 seconds in total it moves to `failed_retryable_deadline_passed`, and the only path forward is a support flow with the payment's history attached. (Version 1 got this wrong; see below.)
- Every transition writes an events row: payment ID, from-state, to-state, reason code, timestamp. That table is what support reads now.

## Timeline

- Week 1: reading the code. Week 2: design doc.
- Week 3: version 1 (error classes and retry budgets) shipped behind a flag. 100% of payment errors on it at the start of week 4.
- Week 4: the incident below, 3 days after full rollout.
- Weeks 6 to 9: events table, support view, and moving in-flight payments onto the new states (dual-write for one release cycle, then cutover).
- Week 10: the six old branches deleted.

## What I owned and what I had help with

Owned (my name on the code): the TypeScript state machine, about 2,400 lines with tests; the transition table; retry-budget persistence; the events table schema and the support view; the in-flight migration.

Help: I wrote the first retry wrapper and my mentor refactored it into the team's existing patterns. I learned more from her review comments than from anything else that summer. For load tests I wrote the chaos cases (a mock gateway returning malformed sequences); the team's staff engineer wrote the harness that runs them in CI.

## The bug I caused, and fixed

Version 1 treated `gateway_timeout` as terminal. My reasoning: "we don't know if the capture happened, so retrying risks a double charge." I'd taken that from a blog post about idempotency and applied it without checking whether this capture call was safe to retry.

Staging didn't catch it. The mock gateway timed out instantly and the same way every time, so the case that mattered (a slow timeout during a real incident) never happened.

In week 4 the real gateway had a 20-minute incident with slow timeouts. Every checkout that hit one was stranded: the customer saw an error, the payment row said `failed_permanent`, and the retry budget never got a chance. 312 checkouts were stranded. Support noticed from tickets before I did.

The fix:

1. A hotfix the same day: `gateway_timeout` became retryable with a deadline. That was safe because the team confirmed the capture call sends an idempotency key, which I hadn't checked. Checking that contract is now step 1 of my design checklist.
2. Regression tests that replay the real incident: slow-timeout sequences at every edge of the retry budget.
3. I wrote the incident note and presented it at the team review. My mentor's comment: "The bug is fine, it's Tuesday. Making a terminal-state decision without checking the idempotency contract is the thing to never do again."

All 312 recovered: 289 by the hotfix's automatic retry sweep and 23 by support by hand. Zero double charges. The idempotency key I hadn't verified is what made the retries safe.

## Results

- In the team's incident reviews for the three months after launch, payment errors during gateway incidents went from "page a human" to "recovers within the retry budget".
- Support answers "is this safe to retry?" from the events table instead of from memory.

## What I took from it

- Staging fails differently from production, and the difference is in the timing and order of failures. My chaos cases now reproduce incident timing, not only error types.
- Check what the downstream call guarantees before making an upstream safety decision.
- After the bug I asked for a mid-internship feedback session. My mentor told me my PR descriptions assumed the reader had my context. I've been fixing that since.

## What's still open

Nothing on the state machine was open when my internship ended in August 2025: in-flight payments had moved onto the new states, and the six old branches were deleted in week 10.
