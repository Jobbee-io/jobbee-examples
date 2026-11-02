<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Secure design and code review program

Tillgrove, February 2024 to now. On my resume this is one bullet with a lot of numbers in it, plus a second bullet for the authorization middleware that grew out of it. This file holds the options I weighed before starting, how each part of the program works, the first version that made me the bottleneck, the pentest finding in a place my process didn't look, the middleware we built because of it, and what still isn't solved.

## Why it existed

In December 2023 Tillgrove's only application security engineer left. The company moves money for about 38,000 small businesses: payroll runs, tax payments, vendor payouts. Security review until then was informal. Teams asked for it when they remembered, and the annual external pentest found what nobody had asked about. The 2023 pentest of the customer web app and public API had 9 high or critical findings, and 7 of them were authorization or input-handling bugs that a design review would likely have caught.

In January 2024 a hiring freeze froze the AppSec seat. I was on detection and response, and I'd been reading code in my homelab for years. I took the review requests nobody was answering: 46 of them between January and March, about 15 a month on top of my detection work.

## The options (February 2024)

I wrote a 4-page proposal for my manager, the head of security. It compared 4 options.

- Wait for the seat. Nobody could say when the freeze would lift, the queue was growing, and the next pentest was 8 months away.
- Buy more testing: a second external pentest each year, at about $48,000 a test. It finds bugs after they ship and does nothing for design. I kept the one annual test and rejected the second.
- A commercial scanner with its default rules on every repo. I ran a 2-week trial on 5 repos and got 1,140 findings. I triaged a random 100: 14 were real, and 3 of those mattered. Nobody would read 1,140 findings, and our worst bugs depend on our own ownership model, which no default rule knows.
- A program one person could run, built to scale through engineers rather than security headcount: threat models for risky designs, required security review on the most sensitive code, a small set of our own Semgrep rules, and a security champion on each team. This is what I proposed.

My manager sponsored it and handled the conversations with engineering leadership. I was promoted to Security Engineer II in April 2024 with AppSec as my scope. In the same proposal I asked for a senior AppSec hire as soon as the freeze lifted. I lost that one: in early 2025 the company approved an associate role instead.

## My role

I designed the program, run the threat models, do most of the code reviews, wrote 22 of the 27 Semgrep rules, and train the champions. Since May 2025 our associate AppSec engineer, whom I onboarded, takes about a third of the review queue; the associate and the champions wrote the other 5 rules. The 11 champions do the rest of the work that matters: they bring designs early and approve low-risk changes on their own teams.

## How the program works

### Threat models

Any design that touches money movement, login or permissions, personal data, or a new outside integration gets one before code is written. Since November 2025, so does any internal tool that can read customer data. The team draws a 1-page data-flow diagram. Then we hold a 45-minute session: the tech lead, the team's champion and me. At every arrow that crosses a trust boundary we ask 5 questions: who can call this, how do we know it's them, what can they ask for that isn't theirs, what do we log, and what happens if the other side lies. I started from STRIDE and cut it to these 5 because engineers remembered them between sessions.

Findings become tickets with an owner and a rating. High means an attacker could move money or read another customer's data without an unusual precondition. Medium needs one, like an insider or a stolen session. Low is defense in depth. A high finding is fixed before launch unless the engineering director for that area signs a risk acceptance with a fix date.

### Required review on sensitive code

Security is a required reviewer, through the code-owners file, on 12 code paths: authorization code, session and API-token handling, password reset and MFA enrollment, payment initiation, bank-account changes, payout approval rules, crypto and signing helpers, webhook signature verification, document upload and storage, bulk data export, the tax-filing submission client, and the IAM and secrets modules in infrastructure code. Champions approve everything else with a 9-question checklist.

### Semgrep

Semgrep runs in CI on all 38 production repos with 27 custom rules, written mostly for our own past mistakes. Examples:

- A Go handler that takes a resource ID from the path and calls the data layer without an ownership check. Its false positives were handlers that leave the check to a service function, so the rule now knows the 4 service functions that do it.
- Raw SQL built with string formatting outside the query layer.
- Logging a full bank account or routing number.
- A token or signature compared with `==` instead of a constant-time compare.
- A webhook handler that never calls the signature-verification helper, added in 2025 (the story is under Champions).

Rules are code. Each one lives in a repo with test files that mark the lines that must match and the lines that must not, and `semgrep --test` runs in that repo's CI. 9 rules block the merge and 18 only comment on the PR. A new rule starts as comment-only and becomes blocking after a month above 90% true positives.

An engineer can suppress a finding with an inline comment, but a CI check fails any suppression without a ticket ID and an expiry date at most 90 days out. There are about 40 active suppressions at any time. That rule comes from a suppression of mine that hid an attack at my SOC job (`Ransomware Night Shift.md`).

### Champions

11 engineers on 9 of the 14 teams. Tech leads nominate volunteers, and each engineering director agreed to 2 hours a month of their time. I run a quarterly 2-hour training built from our own findings, redacted, and I answer questions in the champions channel within a business day.

Every month I sample 10 champion-approved changes. In 2025 that was 120 changes: 7 should have come to security, and 1 was a real bug, a new webhook endpoint that never called the signature-verification helper. The gate covered changes to the helper, not new code that forgot to call it. That gap became the webhook rule.

## Timeline and turning points

- April to June 2024: pilot with 3 teams (payroll runs, payments, identity). The payments director objected to a required reviewer 3 weeks before a payouts launch. We settled it with a promise from me: a first response within 1 business day for that launch. I kept it, and the gate stayed after the launch.
- July 2024: rollout began, with the review gate on 41 paths.
- September 2024: the median wait for my first response was 4 business days. I also found 17 PRs that had been split so the sensitive part landed in a smaller PR that didn't match a path. I found the first by accident in a follow-up review, then searched the merge history for the pattern. Nobody was being malicious; they were being blocked by me.
- October 2024: the pentest found 6 high or critical issues, down from 9.
- November 2024: I cut the gate to the 12 paths where a bug moves money or exposes data, and gave champions the checklist for the rest. The queue settled at about 25 required reviews a week.
- January 2025: I changed the headline metric. For 2 quarters I'd reported threat models completed, which rewarded finishing models, not fixing what they found. From then on it was findings fixed before launch.
- March 2025: all 14 teams in.
- May 2025: the associate started.
- October 2025: the pentest found 2 high or critical issues. One was a server-side request forgery in the service that renders pay stubs to PDF, built in 2021 and unchanged since, so no threat model had ever looked at it. The other was in a place my process didn't look at all (below).
- November 2025 to now: the authorization middleware.

## The numbers, with definitions

- 61 threat models from April 2024 through September 2026.
- 148 design findings from them, 23 rated high. 126 of the 148 (85%) were fixed before launch, meaning the ticket was closed and security verified the fix before the feature reached all customers. 21 of the 23 highs were fixed before launch. The other 2 shipped with a compensating control and a director's signature, and both were fixed within 30 days. The remaining 20 unfixed findings are medium or low, with dated tickets.
- Median first response on required reviews: 4 business days in September 2024, 0.6 in Q2 2026. "First response" means approve, request changes, or ask a question, measured in business hours from the review request.
- Semgrep true-positive rate: of the findings a person triaged, 71% were real in Q1 2025 and 92% in Q2 2026. Between those, I deleted 3 of the 8 noisiest rules and rewrote the other 5.
- External pentest, same firm every year, high or critical findings: 9 in 2023, 6 in 2024, 2 in 2025. The 2023 and 2024 tests covered the customer web app and public API. The 2025 test added internal admin APIs, so the count fell while the scope grew.

## The admin-API finding, and the middleware

Our threat-model trigger covered outside integrations and personal data in customer-facing flows. Internal admin tools didn't trigger it. In October 2025 the pentest found an IDOR in an internal support-tool API: it took a business ID and returned payroll details. It checked that the caller was a support agent, but not that the agent was assigned to that business. Seven months earlier I had reported the same class of bug to another company (`Bug Bounty Idor.md`). I found it there and missed it at home, because my own process didn't look.

The support-tool team fixed that route in 2 days. The associate and I then read every route in all 11 admin services: 214 routes, 37 with no object-level check, 6 of those returning payroll or bank data. The 6 were fixed within 2 weeks and the rest within 6. I widened the threat-model trigger to internal tools.

Then the class of bug. The options:

- A Semgrep rule plus review of every new admin route. That's finding instances, which I already knew didn't scale.
- A check at the API gateway. The gateway knows who the caller is, not which businesses they're assigned to.
- A central policy service. Another network call on every admin request and another system for a small team to run, for 11 services.
- A shared Go middleware library, which is what we built.

I paired with a platform engineer. He owned the router integration and the performance work; I owned the policy model, the tests and the rollout. The design:

- Every admin route registers a policy when the router is built. A route without one fails the service's startup, and a CI test fails the build before it gets that far.
- Deny by default. A policy is a Go function that receives the caller, the route and the loaded resource, and returns allow or deny with a reason.
- Support assignments are read from the assignment table and cached for 60 seconds, which adds about 3 ms at p99.
- Every decision is logged with the caller, route, resource and reason.
- Break-glass access exists for incidents. It needs a ticket ID, and security reviews every use weekly.

Each service ran in audit mode for 2 weeks before enforcing: the middleware logged what it would have denied and allowed it anyway. In the support tool that showed about 1,300 would-be denials in 2 weeks, nearly all of them tier 2 agents working escalations for businesses they weren't assigned to. Enforcing on day 1 would have broken escalations. The policy now also allows agents on the escalation queue for that business's open tickets.

It's on 9 of the 11 admin services. The other 2 are a read-only legacy reporting service, due to be retired in Q1 2027 and reachable only over the VPN from an IP allowlist, and the internal data-export tool, which its team is rewriting on the middleware from the first commit.

## What went wrong

- The 41-path gate. I designed for coverage and got a bottleneck and a workaround. Champions should have come first and the gate second.
- The admin-API gap. I scoped threat models by who the user is, when the right scope is what data and money the code can reach.
- The metric: 2 quarters of counting threat models instead of fixes.
- The gate sees changes to sensitive code, not new code that should have called it. The webhook miss showed that. A Semgrep rule per case is my answer so far, and it isn't a complete one.

## What isn't solved

- 5 of the 14 teams have no champion, so all their changes wait for security.
- Threat models only see new designs. Code like the 2021 PDF service is covered only by Semgrep and the annual pentest.
- Customer-facing routes still do ownership checks in each handler, guarded by the Semgrep rule. Moving their roughly 600 routes to per-route policies like the admin services is the next step I'd propose, and the biggest.
- 2 admin services aren't on the middleware yet.
- The program is 1.5 people. My 3-week notice period is for handing it to the associate and the champions properly.

## What I'd do differently

- Start with champions and paved-road libraries, and add a gate only where a library can't help.
- Scope threat models by the data and money involved from day 1.
- Pick "fixed before launch" as the metric on day 1.

This is the work that makes me an AppSec engineer rather than a SOC analyst who learned Burp, and it's my case for the senior level: I've run the whole function at a 170-engineer company for 2.5 years, and I can say which of my own designs failed and why.
