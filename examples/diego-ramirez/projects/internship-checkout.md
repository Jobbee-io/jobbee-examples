<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Checkout internship — the payment-error state machine

Cartway, checkout team, Jun–Aug 2025 internship. ~1,400 checkouts/day through this path. I owned the state machine end-to-end; the team of 9 (my mentor Priya N., two other engineers, everyone else adjacent) reviewed and shipped it with me.

## What I walked into

Week 1, reading the checkout service: payment failures were handled by **six ad-hoc error branches**, each written at a different time by different people. The pattern I kept finding:

- `gateway_timeout` → retried immediately, unbounded (a retry loop with no budget).
- `card_declined` → terminal, but *also* caught by the timeout retry wrapper upstream, so a declined card could get retried twice before giving up (once by the handler, once by the wrapper that "helpfully" wrapped everything).
- `network_error` → sometimes retried, depending on which of two helper functions the call site used.
- Three more variants, each subtly different. Nobody could draw the whole flow. My mentor's honest answer when I asked for the diagram: "If someone draws it, it'll be wrong by next quarter."

Support's view was worse: when a checkout failed, they had logs and vibes. Whether a failed payment was safe to retry was a question each support person answered from experience.

## What I designed

A **typed state machine** for payment errors. The pitch I wrote in week 2 (my mentor made me rewrite it twice, which was correct of her): every payment failure enters one state machine with explicit states and transitions, and every transition is either allowed or not — no helper-function vibes.

**9 states:**
`attempting` → `gateway_timeout` | `network_error` | `card_declined` | `insufficient_funds` | `gateway_5xx` | `validation_error` | `retry_budget_exhausted` → terminal states: `failed_permanent` | `failed_retryable_deadline_passed`

(Okay, that's 10 with `attempting` — the file that went into the PR says 9 states + the entry state, and I've argued about this at lunch. The PR comment settled it: entry doesn't count.)

**14 transitions**, each with a rule attached. The load-bearing ones:
- Every retryable class carries a **retry budget** (attempts *and* a wall-clock deadline), tracked in the payment row, not in memory — the checkout pod can die mid-retry and the budget survives.
- `card_declined` and `insufficient_funds` are terminal, full stop. No wrapper can retry them. (This was the bug fix, below.)
- `gateway_timeout` → retryable *with a deadline*: after 45 seconds total, the state becomes `failed_retryable_deadline_passed` and the only path forward is a human-support flow with the payment's audit trail attached.
- Every transition writes an **events row** (payment_id, from_state, to_state, reason code, timestamp). That table is what support reads — it replaced "logs and vibes."

## What I owned vs. assisted

**Owned (wrote, and my name is on the blame):**
- The state machine itself: type definitions in TypeScript (~2,400 lines with tests), the transition table, the retry-budget persistence.
- The events table schema and the support-facing view on top of it.
- The migration that moved existing in-flight payments onto the new states (dual-write for one release cycle, then cutover).

**Assisted (my work, their steering):**
- The service-level wiring: I wrote the first version of the retry wrapper; my mentor refactored it into the team's existing patterns. I learned more from her diff comments than from anything else that summer.
- Load-test scenarios: I wrote the chaos cases (mock gateway returning malformed sequences), the staff engineer wrote the harness that ran them in CI.

## The bug I caused, and fixed (week 4)

The one I'll tell interviewers about before they find it themselves.

**What I built:** v1 of the state machine treated `gateway_timeout` as **terminal**. My reasoning, which felt airtight: "we don't know if the capture happened, so we must not retry — retrying risks a double charge." I was pattern-matching from a blog post about idempotency I'd read, applied to a system where I hadn't checked whether the capture call was safe to retry.

**What happened in staging:** nothing. Because in staging, the mock gateway never timed out *mid-incident* — it timed out instantly and deterministically. The distinction that mattered (timeout-after-success vs. timeout-before-sent) never occurred.

**What happened in prod:** week 4, the real gateway had a 20-minute incident with slow timeouts. My terminal classification meant every checkout that hit a slow timeout was **stranded**: the customer saw an error, the payment row said `failed_permanent`, and the retry budget that was supposed to save us never got a chance. 312 in-progress checkouts stranded. Support noticed before I did — tickets came in while I was reading the dashboard going "huh."

**The fix, and the part I'm actually proud of:**
1. Hotfix within the day: reclassify `gateway_timeout` as retryable-with-deadline, safe because the team confirmed the capture call sent an idempotency key (which I hadn't checked — that check is now step 1 of my design checklist, permanently).
2. Root-cause my *design process*, not just the code: I had made a safety decision (don't retry = don't double-charge) without tracing what the downstream call actually guaranteed. In the fix PR I added the regression tests that encode the real incident: slow-timeout sequences at every retry-budget edge.
3. Wrote the incident note myself and presented it at the team's review. My mentor's comment, which I've kept: "the bug is fine, it's Tuesday; not checking the idempotency contract before making a terminal-state decision is the thing to never do again."

**Numbers for honesty's sake:** 312 stranded checkouts, all recovered either by the hotfix's automatic retry sweep (289) or manual support recovery (23), zero double charges (the idempotency key held — the thing I hadn't verified was, accidentally, the thing that saved us).

## What the three months taught me, compressed

- **Staging environments fail differently than prod**, and the difference is always in the *timing and sequence* of failures, never the happy path. My chaos cases in CI after this reproduce incident timing, not just incident types.
- **Check the downstream contract before making an upstream safety decision.** One sentence; cost me one incident to learn it.
- **Design docs get better when someone makes you rewrite them twice.**
- I asked for and got a mid-internship feedback session after the bug. Best career decision I've made so far: my mentor told me my PR descriptions assumed the reader had my context, and I've been fixing that since.
