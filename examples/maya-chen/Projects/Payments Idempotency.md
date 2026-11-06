<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Payments idempotency rebuild

Cartway, marketplace payments. May 2019 to December 2019. I owned the capture path before the incident, wrote the root-cause analysis after it, and led the six-month rebuild.

## The incident

May 2019, a Tuesday. The payment gateway's status page reported elevated timeouts. Our own capture endpoint had two problems that the gateway's retries turned into a money bug.

The capture path was one Ruby service (`captured` in the logs), three instances behind a load balancer. The flow: read the payment intent from Postgres, call the gateway's capture API, write a `captures` row, mark the intent captured.

**Problem 1: the endpoint wasn't idempotent.** If the gateway call succeeded but our write-back failed (connection reset after the gateway had responded), we returned a 5xx. The caller retried, and we called capture again on an intent that was already captured. The gateway rejects duplicates that carry its idempotency key, but we didn't send one consistently. So the retry was a fresh second capture.

**Problem 2: the dedupe we had was worse than nothing.** Someone before me had added an in-memory set of recently captured intent IDs, per process. With three load-balanced instances, a retry had a 2-in-3 chance of reaching an instance that had never seen the intent, and every deploy emptied the set. The code comment said "temporary until real idempotency". It had been there eleven months.

**What happened.** The gateway incident produced two kinds of timeout: real ones (harmless) and success-then-reset (the bad kind). Over about 50 minutes overnight: 1,912 duplicate captures, $486K, on 1,784 distinct payment intents; some were charged three times. The nightly reconciliation job I'd built two months earlier flagged the imbalance at 04:12 (`Payouts Reconciliation.md`). That alert is why the number wasn't larger.

**Response.** We paused capture for 25 minutes and drained the queue rather than risk more. Every affected customer was refunded within 40 hours, through the gateway. I started the RCA that evening.

## Root cause

The endpoint behaved as "at most once" while every layer around it (gateway retries, load-balancer retries, our own retry queue) was "at least once". The dedupe set was a patch pretending to be a contract. Underneath that: we returned an error on a post-write timeout, treating "I don't know if it happened" as "it failed".

## The rebuild

Six months: me leading, two engineers, a PM part-time.

**The contract.** End-to-end idempotency keys on every mutation:
- The client (our checkout service) generates the key and sends it on the first call and every retry.
- The key is stored in Postgres under a unique constraint, in the same transaction as the state change. `INSERT ... ON CONFLICT DO NOTHING` returning zero rows means "already handled": return the recorded response.
- Recorded responses are kept per key for 72 hours, so a retry after success returns the original result. Keys are pruned after 30 days.
- Gateway calls go through an outbox: the intent to capture is written to an outbox table in the same transaction, and a relay worker executes it and marks it done. A crashed worker leaves the row, and recovery replays it under the same key.

**Where to store the keys.** We evaluated three options:
- Redis with a TTL: fast, but losing Redis means losing the guarantee, and we'd just been burned by treating process memory as a source of truth. Rejected.
- DynamoDB conditional writes: built for this, but a second datastore in the hot path, with its own consistency model and on-call load, at a 20-engineer company. Rejected.
- Postgres, unique constraint, same transaction: no new system, the guarantee shares fate with the money, and correctness can be shown by reading one query. About 4 ms slower than Redis at p99. Chosen.

I'd make the same trade today: 4 ms and some table growth for a guarantee that can't drift from the ledger.

**Migration with no downtime.** The new capture service ran in shadow for three weeks (reading traffic, no writes), then dual-wrote, then the old path went read-only, then it was deleted. Each step had a rollback.

## The numbers

- Capture p99 at launch (December 2019): 210 ms, up from 190 ms. We accepted the 20 ms for the outbox.
- Duplicate captures found by reconciliation: zero in the 8 months from launch until I left Cartway in August 2020.
- Idempotency-key table: about 180M rows at steady state, with pruning working.

## What I did, specifically

- Wrote the RCA; my name is on it.
- Designed the idempotency contract and the outbox relay, and wrote the one-page Postgres-versus-Redis justification.
- Planned and ran the shadow and dual-write cutover.
- Presented in the post-incident review with the merchant team. Refunding everyone in 40 hours didn't settle it for them; they wanted to know what would stop a repeat, which is what the rebuild answered.

## What I'd change

- The 5xx-on-unknown behavior should have been fixed before the incident. Separating "failed" from "unknown" is what made idempotency necessary, and it was visible in the code.
- The dedupe set survived eleven months because our integration tests ran a single instance. The multi-replica integration job we added with the rebuild is the piece I'd keep if I could keep only one.

## What's still open

Nothing was open on this work when I left Cartway in August 2020. The old capture path had been deleted, key pruning was working, and reconciliation had found zero duplicate captures since launch.
