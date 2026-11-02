<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Ledger core rewrite: the cutover

Companion to `Ledger Core Rewrite.md`. This file covers the switch on January 14, 2024, the three weeks of reverse shadow after it, what broke, and the decommission in February and March. I wrote the runbook and was the cutover lead.

## Options for the switch

- **Move accounts in cohorts.** The usual way to de-risk a migration, and wrong for a ledger. About 60% of entries touch a shared internal account, and book transfers between two Bluepeak customers would cross ledgers whenever the two accounts sat in different cohorts. We'd have needed cross-ledger transactions for weeks. Rejected.
- **Big bang in a maintenance window.** Stop all money movement for about 2 hours. Card authorizations run all day and night, and 2 hours in the card processor's stand-in mode was beyond the limits the card program had agreed. Rejected.
- **Chosen: flip which ledger is authoritative, with a short write pause.** The parallel run had shown the new ledger reaching the same state at every commit. So the switch only had to pause writes, let the new ledger catch up to the old one's last commit, verify, swap authority and resume. Target pause: 90 seconds or less. Abort if it reached 5 minutes.

## Rehearsals

Three rehearsals in staging and one dry run in production that stopped just before the swap. The production dry run found the step that mattered: putting card authorizations into stand-in was a manual change on the card processor's side and took 4 minutes. The card team scripted it with the processor, and it took 20 seconds on the night.

## The procedure

A 23-step runbook. The steps that carried the risk:

1. **T−60 minutes:** deploy freeze on the 14 services that write to the ledger; confirm the diff green for the last 24 hours.
2. **T−0, Sunday January 14, 04:00 Pacific.** The quietest hour of the week, outside ACH processing windows, at about 140 TPS. The gateway started holding synchronous write requests for up to 90 seconds (clients time out at 120). Kafka input consumers paused.
3. Card authorizations moved to stand-in.
4. Wait for the change feed and the new ledger's commit-order lag to reach zero.
5. Write the cutover checkpoint and compare balances for every account touched in the last 24 hours plus all internal accounts: about 1.3M accounts, 19 seconds. The person from the controller's office confirmed the result on the call.
6. Flip the authority flag, a versioned config value read by the gateway and the consumers. The new ledger's outbox relay switched from the mirror topics to the real output topics, and the old ledger's relay switched to the mirrors, so downstream consumers changed nothing. The old ledger moved to reverse shadow: it now consumed the new ledger's commit order.
7. Release the gateway queue, resume consumers, bring cards back from stand-in. Authorizations approved in stand-in were posted through the normal advice flow.

Roles on the call: me as lead, the SRE on Postgres, the card team, the controller's office, and our manager on communications.

## How it went

- Write pause: 41 seconds.
- About 5,700 requests were held and released. 9 timed out on the client side and were retried with the same idempotency key, so there were no duplicates.
- About 1,200 card authorizations were approved in stand-in and all posted within 6 minutes of resume.
- Error rate after resume stayed under the abort line (0.1% for 10 minutes) the whole time.

## Rollback plan, never used

For three weeks the old ledger ran in reverse shadow and the diff ran in the other direction. Rollback was the same procedure with the roles swapped, rehearsed once in staging. Abort triggers: pause over 5 minutes, any mismatch in the step-5 comparison, or the error-rate line.

## What broke

**January 17: a reader nobody had listed.** The fraud-scoring service read 30-day balance history straight from the old ledger's read replica instead of through the ledger API. In reverse shadow the old ledger ran up to 2 minutes behind, so fraud scores used stale balances. The fraud team's manual-review queue grew 35% for 2 days before they asked us why. We moved the service to the ledger read API that afternoon. Then I audited every client of the old database from its connection and per-role query statistics, not from the architecture diagram. That found 4 more direct readers: 2 reporting jobs, a data-warehouse extract and an admin tool. All 4 moved before the old path went read-only.

**January 31: the first month-end on the new path.** p99 rose to 95 ms for about 40 minutes. Autovacuum started on the current month's postings partition in the middle of the peak; with default settings on a partition of about 1.3B rows, it kicked in at the worst time. Fix: per-partition autovacuum settings (scale factor 0 with a fixed threshold), a scheduled vacuum of the previous month's partition right after close, and next month's partition created 7 days early. February's month-end p99 was 61 ms.

## Decommission

- **February 5:** old path read-only; diff off.
- **March 2024:** old database archived as a cold backup under the 7-year record-retention policy; the Java service and its 24 VMs deleted.

## What I'd do differently

- Run the database-client audit two months before the parallel run. It took one afternoon. Doing it late cost the fraud team 2 days of extra reviews.
- Do the production dry run a month earlier. The 4-minute stand-in step was the riskiest part of the night and we found it 10 days before.
- Put the month-end vacuum work into the cutover plan. We knew month-end was the ledger's hardest day; we tested it under load in the parallel run but not under a full month of partition growth.
