<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Ledger core rewrite: the parallel run

Companion to `Ledger Core Rewrite.md`. This file covers the nine weeks, November 6, 2023 to January 7, 2024, when the old and new ledgers ran side by side and a continuous diff compared them. I designed the diff's matching logic, ran the daily triage and wrote the exit criteria.

## What "equivalent" had to mean

For every journal entry, both ledgers had to:

1. make the same decision (accept, or reject with the same reason, such as insufficient funds);
2. write the same postings (account, amount in minor units, direction, currency);
3. leave each touched account with the same balance and the same per-account sequence number.

Plus, every night, every account balance in both ledgers had to match.

## The ordering problem, and the feed we chose

Two ledgers fed the same requests in a different order will disagree honestly. If two debits race for the last $500 in an account, whichever arrives first wins.

- **Tee requests at the front door to both ledgers.** We built this first and spent 2 weeks on it. A 2-day trial in staging showed about 1 mismatch in 3,000 entries from ordering alone. That noise would have buried real bugs. Dropped.
- **Replay the old ledger's committed postings into the new one.** No ordering noise, but the new ledger would never make a decision. It would only copy. Rejected.
- **Chosen: the original requests, in the old ledger's commit order.** We read the old ledger's commits from Postgres logical decoding and published, for each committed operation, the original request into a commit-order feed. The new ledger consumed that feed and decided on its own. It never saw the old ledger's decision. The diff compared the two.

The commit-order feed carried entries and also hold placements and releases, because holds change the available balance. The new ledger wrote to its own production-size Postgres cluster and published to a mirror set of output topics.

## The 1.4B events a day

The resume number is the whole Kafka footprint of the run:

- 64 upstream input topics read by the old ledger: about 390M events a day. Only about 45M of those became journal entries; the rest were holds and status events.
- 16 commit-order topics feeding the new ledger: about 95M a day.
- 72 output topics for each ledger, 144 in total: about 840M a day. Each entry produces several events (postings, balance changes, holds).
- 16 diff topics (match results, mismatch records, balance checkpoints): about 75M a day.

That's 240 topics and about 1.4B events a day.

## How the diff worked

- A Go service, consumer groups keyed by account ID. It matched each entry across the two output streams by idempotency key and compared the decision, the postings and the per-account balance and sequence.
- An entry still unmatched after a settle window counted as a "missing" mismatch. The window started at 2 minutes and went to 15 after week 1, because consumer rebalances alone could delay one side by several minutes.
- Every night, both ledgers wrote a checkpoint marker into commit order at 00:00 UTC. The full balance comparison of all about 9.6M customer ledger accounts and 1,900 internal accounts ran at that marker. So it compared the same logical point, not the same clock time.
- Every mismatch class got a root cause, one of four labels (new-path bug, old-path behavior to copy, old-path bug not to copy, diff-tool bug) and a named sign-off. Anything that touched an amount needed a sign-off from the controller's office.
- Triage was 30 minutes every morning: me, one engineer on a weekly rotation, and from week 2, someone from the controller's office twice a week.

## Week by week

**Week 1: 1 mismatch in 40,000 entries,** about 1,100 a day. About 70% were diff-tool timing (the 2-minute window), about 20% interest rounding and about 10% two real bugs in the new path.

**The rounding finding.** The old path rounded each day's interest accrual to the cent, half-up, per account. The product spec, and our new path, accrued at 6 decimal places and rounded once at the monthly posting. Differences were at most a few cents per account per month: about $3,100 a month in total across about 410,000 interest-bearing accounts, in both directions. The finance lead wanted the new path to keep the spec ("we're touching it anyway"). I argued for copying the old behavior exactly during the migration. If we changed the math and migrated at the same time, every later mismatch would be ambiguous: rewrite bug or rounding change? The controller agreed. We copied the old behavior, and the spec fix shipped in April 2024 as its own announced change.

**Week 2, the two new-path bugs.**
- Chargeback reversals that referenced an entry from an earlier month were rejected with "original not found". The new path looked up the original only in the current month's partition. 37 reversals failed in the shadow; none in production, because the old ledger was authoritative. Fix: a small unpartitioned index from entry ID to partition month.
- My bug. Payroll entries with more than 8 postings overflowed a fixed-size buffer in the batch assembler and were split across two transactions. 214 entries were posted partially in the shadow. Fix: a batch now closes early when the next entry doesn't fit, so an entry is never split. I also added the deferred constraint trigger that rejects any transaction where an entry's postings don't sum to zero. It would have caught this on day 1.

**Weeks 3 to 4: down to 1 in 2M.** The remaining noise was hold expiry. Holds expire on the clock, and the two ledgers expired them a few seconds apart. Fix: during the run, the old ledger's expiry commits went into the commit-order feed and the new ledger stopped expiring holds on its own clock. That meant the run didn't test our expiry timer, so we tested it separately with a replay of 30 days of holds.

**November 30, the first month-end.** Both ledgers held the 2,600 TPS peak. The diff fell 3 hours 10 minutes behind. It was keyed by account ID, so the hot internal accounts made hot partitions in the diff, the same problem the rewrite had removed from the ledger. Fix: the diff compared internal-account postings by entry ID and checked internal balances only at checkpoints, and the diff topics went from 24 to 96 partitions. The lag cleared in 5 hours. Nothing was lost; lag only delayed the comparison.

**Weeks 5 to 7, December.** No new-path bugs. One more old-path behavior: a floating-point comparison in the old Java code let a debit take an account 1 cent past its overdraft limit, about 6 times a week. We did not copy this one. The new path rejects those debits. The controller's office and the product owner signed off, and the mismatch class was allowed under exact criteria (only that overdraft-limit case, only a 1-cent difference) so it couldn't hide anything else.

**Week 8, year-end.** The year-end close (interest, fee summaries, annual statement data) ran through both ledgers. Zero unexplained mismatches.

**Week 9.** Exit criteria met on January 5. Go decision January 8; cutover January 14. The new ledger and the diff kept running in shadow until the cutover, so the two stayed in step.

## Exit criteria, written in October before the run

1. Zero unexplained mismatches for 14 consecutive days, including a month-end. Met December 23 to January 5.
2. Every explained mismatch class has a root cause, a label and a named sign-off.
3. The nightly full balance comparison equal for 14 consecutive nights.
4. The new path holds at least 3 times the observed month-end peak. We re-ran the soak on the shadow cluster in December: 11,000 TPS for 4 hours.

## The numbers

- About 2.8B journal entries compared over 63 days.
- 7 mismatch classes in total: 3 diff-tool (settle window, hold expiry, month-end lag), 2 new-path bugs (reversal lookup, entry split), 2 old-path behaviors (rounding copied, overdraft check not copied).
- Mismatch rate: 1 in 40,000 in week 1, 1 in 2M by week 4, zero unexplained for the final 14 days.

## The evidence package

Daily diff summaries, the mismatch-class log with sign-offs, the nightly balance comparisons (with a hash of each night's compared balances) and the load-test report. Internal audit accepted it as the change-management evidence for the ledger. The external auditors sampled 25 entries from the log during the year-end audit and raised no findings. I wrote the package so someone who had never seen the code could follow each mismatch from detection to sign-off.

## What I'd do differently

- Decide on commit-order replay before building anything. The 2 weeks on the tee approach were spent learning what a whiteboard could have shown.
- Build the diff for month-end volume from the start, keyed the way the data is hot, not the way it's convenient.
- Bring the controller's office into triage on day 1, not week 2. The rounding question sat for 4 days waiting for the right person.
