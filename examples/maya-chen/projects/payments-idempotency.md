<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Payments idempotency rebuild

Cartway, marketplace payments. May 2019 – Dec 2019. I owned the capture path before the incident and led the rebuild after it.

## The incident

May 2019, a Tuesday. We got a payment gateway status-page note about elevated timeouts. What we didn't know was that our own capture endpoint had two compounding problems, and the gateway's retries turned them into a money bug.

**What the capture path looked like.** One Ruby service (`captured` in the logs), three instances behind a load balancer. The flow: read the payment intent from Postgres, call the gateway's capture API, write `captures` row, mark intent captured.

**Problem 1: the endpoint wasn't idempotent.** If the gateway call succeeded but our write-back timed out (connection reset after the response left the gateway), our service returned a 5xx. Retry semantics then meant calling capture again on an intent that was already captured. The gateway, to its credit, rejected duplicates on *its* idempotency key — but we weren't sending one consistently. The retry was a second, fresh capture.

**Problem 2: the "protection" we had was worse than nothing.** Someone before me (a name I never learned; the commit predates the monorepo import) added in-memory dedupe: a hash set of intent IDs per process, "recently captured." With three load-balanced instances, a retry had a 2-in-3 chance of landing on an instance that had never seen the intent. It also died on every deploy. The code even had a comment saying "temporary until real idempotency." It had been temporary for eleven months.

**The trigger.** The gateway's status incident caused timeouts at exactly the rate that made both problems collide: real timeouts (harmless), and success-after-reset (poison). Over ~50 minutes: 1,912 duplicate captures, $486K, on 1,784 distinct payment intents (some charged three times). Our reconciliation job — the one I'd built two months earlier — flagged the imbalance at 04:12, which is the only reason the number wasn't worse.

**Response.** Gateway-side refunds were straightforward; 100% of affected customers were refunded within 40 hours. We paused capture for 25 minutes (drained the queue rather than risk more), wrote the customer comms, and I started the RCA that evening.

## Root cause, in one line

The capture endpoint's contract with its caller was "at-most-once" while every layer around it — gateway retries, LB retries, our own retry queue — was "at-least-once." The dedupe set was a patch pretending to be a contract.

## The rebuild

Six months, me leading, two engineers assisting, one PM part-time.

**Design.** End-to-end idempotency keys on every mutation:
- Client (our own checkout service) generates the key, sends it on create and every retry.
- Key stored in Postgres with a unique constraint, written in the same transaction as the state change. `INSERT ... ON CONFLICT DO NOTHING` returning zero rows means "already handled, return the recorded response."
- Recorded responses cached per key for 72 hours, so retries after success return the original result, not a fresh attempt.
- Gateway calls wrapped in an outbox pattern: write intent-to-capture into an outbox table in the same transaction, relay worker executes and marks it. A crashed worker leaves the row; recovery replays it under the same key.

**Key-value store choice.** We evaluated three homes for the idempotency keys:
- *Redis with TTL* — fast, but we had already been burned by treating Redis as a source of truth (the dedupe set trauma). Losing Redis means losing the guarantee. Rejected.
- *DynamoDB conditional writes* — purpose-built for this, but it was a second datastore in the hot path with its own consistency story and on-call surface. We were a 20-engineer company. Rejected.
- *Postgres, unique constraint, same transaction* — no new system, the guarantee inherits the ledger's transactionality, and we could prove correctness by reading one query. Slower than Redis by ~4ms p99. Chosen.

The trade-off, stated plainly: we paid ~4ms and some table growth (keys pruned after 30 days) to buy a guarantee that shares fate with the money. For a payments path, that's the right trade. I'd make it again.

**Migration without a big bang.** New capture service deployed shadow-first for three weeks (read traffic, no writes), then dual-wrote, then old path made read-only, then deleted. Each step had a rollback. Total elapsed customer-visible time: zero downtime.

**Numbers at launch (Dec 2019):** capture p99 210ms (was 190ms — we accepted the 20ms for the outbox), duplicate captures detected by reconciliation: zero for the next 14 months, keys table ~180M rows at steady state, pruning working.

## What I'd say if you ask "what did *you* do"

- Wrote the RCA. My name is on the doc.
- Designed the idempotency contract and the outbox relay; made the Postgres-vs-Redis call and wrote the one-page justification.
- Ran the shadow/dual-write cutover plan.
- Testified in the post-incident review with the merchant team, which is where I learned that "we refunded everyone" is not the same as "we kept their trust."

## What still bothers me

- The `capture` service returned 5xx on *post-write* timeout because we conflated "I don't know if it happened" with "it failed." Fixing that distinction is what made idempotency necessary; we should have had it before the incident.
- The dedupe set survived eleven months because nothing tested multi-instance behavior. Our integration tests were single-instance. The test-lane fix (multi-replica integration job) shipped with the rebuild and is the piece I'd keep if I could only keep one thing.
