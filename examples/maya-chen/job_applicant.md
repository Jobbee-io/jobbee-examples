<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Maya Chen

Notes about my search for anything the workspace settings can't hold. Plain facts, updated as things change.

## What I'm looking for

- Staff or Principal Software Engineer roles, backend / platform / infrastructure. I'm a staff-track senior today; I want the next scope to be real, not a title re-grade.
- About 9 years of experience, all backend. Go is my strongest language (since 2018). Postgres, Kafka, and Kubernetes are the systems I've run in production, not just deployed.
- Work authorization: US citizen. No visa constraints anywhere in the US. No relocation paperwork either.
- Location: Seattle is home. Remote-first is my preference. I'll do hybrid in Seattle, Portland, or Denver. I'd consider the Bay Area for an exceptional fit, not for a normal offer.
- Compensation: current base $215K plus equity. Looking for $240K–$270K base; total comp $350K–$420K depending on equity quality. Tell me the band up front and I'll tell you honestly whether it works.
- Notice: currently employed. I'd need about four weeks.

## Where I have real depth

- **Payments and ledgers.** I've built payment capture paths, idempotency, and reconciliation at marketplace scale (2,500 TPS peak at Cartway) and now lead a ledger core that sustains ~11,000 TPS at Bluepeak. I have a double-charge incident in my history and I can walk every minute of it.
- **Distributed systems in production.** Event streaming at 40K events/sec, queue migrations under live traffic, consumer-lag triage. I've read Raft papers but my scars are operational: rebalance storms, transaction-timeout latency, dual-write parity.
- **Postgres at scale.** Partitioned multi-TB ledgers, replication, failover drills, the active-active evaluation I led and argued *against* (see my project file on it).
- **Kubernetes as an operator.** ~900 pods on my current platform. I've done the migration of VM-hosted services onto k8s, capacity planning, and the on-call that follows.
- **On-call and operational maturity.** I led an alert-audit and rotation redesign that took an org from ~900 pages a month to ~65 without changing customer-impact rates. I ask pointed questions about on-call in interviews because I've seen both ends.

## Search constraints — please respect these

- No defense or defense-adjacent work, including subcontractors.
- No crypto exchanges. Legitimate payments and fintech infrastructure are exactly what I want; speculative trading platforms are not.
- I filter hard on on-call maturity: if the rotation is a death march, I'll pass no matter the comp. Ask me what I look for and I'll give you the checklist.
- Industries where I have depth: payments/fintech infrastructure, logistics and supply chain, developer platforms.

## How I work

- Writing-first: I design in short docs, review small PRs, and put numbers in everything I claim.
- I take on-call as a participant, not a manager-of-on-call. Pages should be rare and actionable; I've built that and will maintain it.
- I keep project notes current — the detailed project files in this workspace are how I think, and they stay up to date as work ends, not when a search starts.

## Clarifications

*(Questions Jobbee asked when something in my files was ambiguous. Log format: question, answer, newest last. Notably, Jobbee never asked me a visa question — my citizenship is stated plainly above, so that gate had nothing to do. The one thing it did catch was a real contradiction I'd been living with:)*

**Q:** You list target TC $350–420K and also "remote-first is my preference." Those pull against each other: would you take $340K for a fully-remote staff role, or is $350K a floor?
**A:** Honest answer, because the contradiction was real and I'm glad it got named: **$350K is a floor for hybrid.** My current setup is hybrid and $350K–$420K was priced against that world. For a *fully-remote* staff role I'd accept **$335K — but only if the on-call maturity is exceptional** (the kind of rotation I describe liking above: pages rare and actionable, a real audit culture, someone who can show me the last three months of page data and not wince). The trade I'm actually making: remote returns me 10+ hours a week and my best deep-work hours, and I'll pay real money for that — but I won't pay it *and* accept a death-march rotation, because that combination is how good engineers burn out, and I've rebuilt myself from exactly one of those. Fully-remote at $335K with a mediocre on-call culture: no. Fully-remote at $335K with genuinely excellent operational maturity: yes, and I'd say so plainly rather than negotiate to a number neither of us believes. Hybrid roles keep the $350K floor as written.
