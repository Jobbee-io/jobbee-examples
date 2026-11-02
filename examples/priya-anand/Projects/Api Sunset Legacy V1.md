<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# API sunset — retiring legacy v1 with 4,000 dependent customers

Cassline, April 2023 to October 2024, with the last contractual extension closed in January 2025. I ran the program to retire v1 of the public API: 4,000 dependent customers, zero incidents at cutover, 94% migrated before the hard date. It also includes the one whale we nearly lost, because I segmented by the wrong measure and ran a relationship like a program. The versioning policy that came out of this program is in `Projects/Developer Api Platform.md`.

"Customers" here means billing accounts with at least one v1 call in the 90 days before the announcement. That count includes direct merchants who had integrated v1 themselves before the developer platform existed, not only platform partners. That's why it's larger than the partner count in the platform file.

## Why sunset v1 at all

v1 predated any versioning policy: no deprecation schedule, no dated paths, and a support stance of "basically forever." By 2023 it cost the platform team real money.

- **Dual-surface tax.** Every new feature shipped twice or not at all. We tagged platform tickets for two quarters in 2022: 31% of engineering capacity went to v1 parity work.
- **Risk concentration.** v1 lacked the idempotency contract v2 had. 7 of the 19 platform incident reviews in 2022 were retries on v1 write endpoints, mostly duplicate payouts caught by reconciliation.
- **Security posture.** v1's legacy key scheme had no granular scopes. It was the weakest finding in three yearly security audits in a row.

The pitch to the exec team was one line: every quarter we keep v1, we pay 30% of a platform team to maintain our past instead of building our future. The VP Engineering and I co-wrote the recommendation, and the CEO approved it in March 2023.

## Who pushed back, and how it was settled

- **Sales and account management** wanted the top accounts exempt indefinitely. Settled: no new exemptions. We honored only what pre-policy enterprise contracts already said, which in the end meant 36 accounts with negotiated extensions.
- **Security** wanted 12 months, not 18, because of the key scheme. Settled: 18 months with compensating controls. From month 6, every account still on v1 had to rotate its keys. From month 9, v1 keys only worked from allowlisted IP ranges.
- **Finance** worried about revenue at risk: v1 accounts carried about 45% of API revenue at announcement. I committed to keeping revenue lost to the sunset under 2% of API revenue. Actual: under 0.5%, counting the trailing 12-month revenue of every account that cancelled and named the migration as a reason.

## The program design

An 18-month runway, announced with a published schedule. Month 0 was April 2023. The hard date was October 1, 2024.

- **Months 0–3: announce and instrument.** `Sunset` and `Deprecation` headers on every v1 response, with a link to the migration guide. And the most valuable artifact of the program: a per-customer usage dashboard. We instrumented which v1 endpoints each account called, how often, and when last, so outreach could be specific ("you use 3 endpoints, here is the v2 mapping") instead of generic terror.
- **Months 3–9: migration tooling.** A v1-to-v2 request-translation proxy, opt-in, that let a customer run v2 semantics behind its existing integration while it migrated properly. It was a safety net, not a destination: capped at 50 requests per second per account, with a warning field in every response, and it shut off with v1. 3 engineers built it in 4 months; 410 accounts used it at the peak. Plus codemods for TypeScript/JavaScript, Python, Java and PHP, which covered 80% of SDK usage.
- **Months 9–15: segments and outreach waves.** Four segments by usage depth and account value, each with its own motion. Self-serve, about 3,300 accounts: docs, codemods, 3 email touches. Assisted, about 520: twice-weekly office hours with 4 integration engineers. Managed, about 150: a named migration plan with a CSM. Executive, 30: an executive sponsor on each side.
- **Months 15–18: the hard date.** From October 1, 2024, v1 returned structured 410s with the migration-guide link. A 6-month read-only fallback window existed in the plan and was never used. The 410s did the work.

One option I rejected: scheduled brownouts, the usual way to make a deadline real. A monthly settlement job would sleep straight through a 1-hour brownout, and a brownout that did hit a payout job would cause a real failed payout. Instead we shipped an opt-in "410 test mode": an account switched it on, v1 returned the 410 for 24 hours, and they saw exactly what broke on their side. 290 accounts used it.

## The migration curve

"Migrated" means no v1 traffic for 30 consecutive days, with v2 traffic present. Share of the 4,000:

| Month | Migrated |
|---|---|
| 3 | 9% |
| 7 | 37% (about 1,500 accounts, the data behind the 18-month version policy) |
| 12 | 66% |
| 15 | 85% |
| 18 (hard date) | 94% |

The curve was flat for the first three months. Self-serve accounts didn't move until the codemods existed.

## The numbers

- 4,000 dependent customers at announcement.
- 94% (3,760) migrated before the hard date.
- 5.1% (204) had no live v1 traffic at the hard date and hadn't migrated: dormant accounts we'd contacted three times, plus 31 accounts that cancelled during the runway, 12 of which named the migration as a reason.
- 0.9% (36) took negotiated extensions under pre-policy enterprise contracts. They kept v1 access through an allowlist until their contract dates; the last one migrated in January 2025.
- Zero incidents at cutover, meaning no Sev-1 or Sev-2 incident attributed to the v1 shutdown in the 30 days after the hard date. Cutover week brought 58 support tickets about v1, all answered with the guide or an office-hours slot. Nobody was surprised on the day. The boring metric was the whole point.
- After: v1 parity work went from 31% of platform capacity to zero. Three features that had waited on parity shipped within two quarters, on the normal two-week release train.

## The angry whale

Our largest customer still on v1 was a marketplace processor with 40% of their integration on v1 endpoints that my dashboard ranked "low usage" by call count. Call count was a lie. Their low-frequency endpoints ran monthly settlement and reconciliation jobs that moved eight figures. By call count they sat in the assisted segment, getting program emails.

In January 2024 one of their engineers spotted the `Sunset` header while debugging something else. Their VP of engineering learned about the sunset from our response header, not from us. The call was not friendly. Two things went wrong, both mine to own:

1. **I segmented by call count, not by blast radius.** Monthly-but-massive is not "low usage." My dashboard's definition of usage encoded a program metric, not a customer-reality metric.
2. **The program ran outreach; the account ran the relationship.** Their CSM was our trust channel, and I'd routed the sunset through email sequences instead of through the person who had earned the right to have that conversation.

The recovery: I called, not emailed, within the hour of the escalation. Over three weeks we co-wrote their migration plan with their two integration engineers. We staged it by job type: daily jobs first, monthly settlement last, and one full month-end cycle run in parallel on v2 and reconciled to the cent before we switched it. Their migration landed in early August 2024, two months before the hard date. The read-only fallback window, which I'd have been right to offer up front, went into the co-written plan instead. There it worked as a commitment device, not an escape hatch. They renewed in 2025.

## The postmortem I wrote for ourselves

It changed two things permanently:

- **Segmentation has a blast-radius axis**, reviewed with account teams. Blast radius means: does the endpoint move money, settle, or reconcile, and what is the monthly value of the flows it touches, whatever its call frequency. Usage dashboards are audited against "what would break if this stopped tomorrow," not call counts. Re-segmenting this way in February 2024 moved 37 accounts up a segment, 9 of them into executive.
- **Every top-50 account gets a named human owner** in any sunset. Programs support the relationship; they don't replace it.

## What I'd do differently

- Build the blast-radius axis in month 0, not month 10.
- For the top 50 accounts, a CSM call before the headers go live, not after.
- Start the codemods in month 1. Three flat months on the curve were the cost of starting them late.

## What I'd defend

- 18 months, not 12 or 24. The curve says 12 cuts off the accounts with the most at stake, and 24 would have paid the 31% tax for six more months with no sign of more migration.
- A hard date with 410s, no brownouts, and no new exemptions. The trust cost of a forced migration is real. The trust cost of an API that never dies is worse.
- Every tool in the program (the dashboard, the proxy, the codemods, the 410 test mode, the co-written whale plan) was there to make "yes" easier than "no". 94% voluntary migration came from that, not from a clever schedule.
