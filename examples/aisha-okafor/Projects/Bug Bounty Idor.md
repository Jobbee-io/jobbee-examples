<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Bug bounty: an IDOR in a lease-documents API

Keyvane, a property-management software company with a public bug bounty program. March 2025, on my own time. On my resume it's one line under "Outside work": the largest of my 7 valid reports to 5 programs since 2023. This file holds how I found it, the disclosure, the program rule I broke, and the sibling bug I missed.

## The program

I pick programs with a clear scope page, a published payout table, and rules that let researchers create their own test accounts. Keyvane had all three. Its product lets landlords manage leases, rent and documents, and lets tenants sign and upload paperwork. Landlords can sign up for free.

## The bug

`GET /api/v2/leases/{lease_id}/documents` returned the documents attached to a lease: the signed lease PDF and anything uploaded with it. Lease IDs were sequential integers. The server checked that the session belonged to a landlord account in good standing. It did not check that the lease belonged to that landlord's organization. Any free landlord account could list and download other landlords' lease documents: tenant names, addresses, phone numbers and rent amounts, and sometimes uploaded pay stubs.

## How I found it

I'd practiced for the Burp Suite certification in January and kept testing real apps the same way: two accounts, then swap the identifiers between them. I created two free landlord accounts, A and B, each with one test lease that listed me as the tenant. From account A I requested B's lease documents. It returned 200 and the PDF. That proved the bug using only my own data.

## The rule I broke

Then I wanted to show it reached real customers, so I requested 5 lease IDs just below my own. They returned real tenants' document lists. Keyvane's rules said to test only with your own accounts and never to access other users' data, and a program can ban a researcher for this. It wasn't even needed: my two test leases, created minutes apart, already had consecutive IDs. I stopped at those 5, opened no documents, and deleted the responses. In the report I listed the 5 IDs and timestamps, said plainly that this broke their rules, and said it wouldn't happen again. Keyvane's security lead thanked me for disclosing it up front and used the 5 IDs to check their access logs. I stop at my own accounts now, every time.

## Disclosure timeline

- Saturday, March 8, 2025: found it, and reported it the same evening.
- March 11: triaged and confirmed.
- March 18: fix deployed. The endpoint now checks lease ownership against the caller's organization.
- March 19: I re-tested with accounts A and B and confirmed the fix.
- April 2: paid $3,000.
- July 2025: published a writeup on my GitHub, with Keyvane's written approval and without the 5 IDs.

## Severity, and where I disagreed

Keyvane rated it High, not Critical. I asked once for a review, with one argument: free self-serve signup makes "authenticated" a very low bar. They held at High and explained their rubric: the exposed documents didn't include Social Security numbers or bank details. That was a fair reading of their own published rubric, so I accepted it.

## What else went wrong

- My first report was about 1,400 words, with the reproduction steps at the bottom. The triager asked me twice which account made which request. I rewrote it to about 350 words: summary, impact, 4 reproduction steps, the request and response pairs, and a suggested fix. That's my template now, for bounty reports and for findings at work.
- I missed the sibling bug. `GET /api/v2/leases/{lease_id}/payments` had the same missing check, and another researcher reported it 9 days after the fix. When I verified the fix, I tested the one endpoint I'd found instead of every route under the same lease. Authorization bugs come in families, so now I map every route on a resource before I write the report.

## Why it matters for the job I want

The family rule is how I review code at work: when I find a missing ownership check, I look for its siblings before I file anything. Seven months after this report, our own pentest at Tillgrove found the same class of bug in an internal admin API (`Secure Review Program.md`).

## What's still open

Nothing is open on my side: my bug was fixed, re-tested and paid, and the writeup is published. The sibling bug on the payments route was another researcher's report, so its follow-up was theirs and Keyvane's.
