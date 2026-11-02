<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# On-call overhaul

Bluepeak Systems, Payments Platform org, and org-wide by the end. February 2024 to August 2024. Not a code project: a project about how the org carried its pager, and I led it.

## Starting state, measured

- About 900 pages a month across 7 rotations and 46 services. The median engineer got 11 pages a week.
- 340 alert rules. 141 had never fired. 63 fired more than once a week and never led to any action.
- Median MTTR 47 minutes. Most of it wasn't diagnosis but bad notifications: "CPU > 80% on host X", with no service, no customer impact, no runbook, no severity.
- Two engineers had asked to transfer off their rotation because of page load. The quarterly survey ranked on-call as the top stressor, above deadlines.
- Every incident had produced a "let's alert on that" ticket, and nobody deleted alerts. Alert count had grown 3.2× in two years while service count grew 1.4×.

## Who did what

I proposed it in January with three months of page data, wrote the principles, ran the audit sessions, built the page-rate dashboard and the CI check, and reported the numbers monthly. Each team's alert owners did their own triage and wrote their runbooks. Our SRE lead co-owned the rotation redesign.

## The principles I wrote first

1. A page must be actionable now. If the next business-day standup is soon enough, it's a ticket.
2. Every page says why me: the affected service, the customer impact (or "none"), and a runbook link that exists.
3. Every alert has an owner and a review date. An alert nobody owns is deleted. The default is deletion, not silencing.
4. Page rate is an SLO of the platform: at most 2 pages per engineer per week, measured monthly, reported like uptime.

## What we did

**The audit, 6 weeks.** Every rule went through a working session with its owning team: keep and tune, demote to a ticket, or delete. 178 deleted, 70 demoted to ticket-level notifications, 92 kept and tuned (static thresholds moved to burn-rate or multi-window conditions). The 141 dead rules were easy. The fights were over the 63 noisy ones, each with an incident behind it. My question in those sessions: "Name the incident it guards against, and tell me what you'd do at 3am if it fired tonight." If both answers were thin, it was demoted.

**SLO burn-rate alerts for the top 12 services,** fast and slow windows, replacing about 40 CPU, memory and disk rules. This removed more pages than any other change. The services scaled horizontally, and resource saturation lagged customer impact, so those alerts almost never needed a human at night. The pattern came from the ledger cutover in January, where we'd been running burn-rate alerts since day 1 (`Ledger Core Rewrite.md`).

**Runbooks as a gate.** Every pageable alert must link a runbook with what the alert means, the first three diagnostic commands and the escalation path. We wrote 61 in 8 weeks, in 90-minute paired sessions (the alert owner plus a rotating partner). Coverage for pageable rules went from 34% to 100%. A CI check now blocks any pageable rule without a runbook, which is what keeps this from rotting back.

**Rotations, 7 → 4,** aligned to real service ownership. Primary and secondary, with the secondary paged automatically after 10 minutes unacknowledged. A weekly written handoff replaced verbal handoffs; we found 3 recurring incidents whose workarounds existed only in one person's head. Follow-the-sun was evaluated and rejected: two engineers volunteered, then withdrew after doing the timezone math. Solo night shifts for a Seattle-centered org weren't humane and wouldn't have lasted.

**The page review.** Every page gets a 3-line note in a shared log: actionable? did the runbook help? should this alert exist? A 30-minute monthly review deletes rules continuously. The audit improved things once; this keeps them improved.

## Resistance

- **"Our alerts are different."** Three teams exempted themselves. I stopped pushing and published the pilot teams' before-and-after numbers with team names. Two of the three joined within a month, the third after its own bad quarter.
- **"Deleting alerts is dangerous."** Fair, so every deletion was reversible for 30 days (archived, not destroyed), and we counted "deleted alert we needed" events. There were 2 in the following year, both caught by the page review and restored within a day. That number ended the argument.
- **A senior engineer called it make-work** at the kickoff. Instead of arguing, I asked him to own the burn-rate migration for his own service, which had the worst page rate in the org. Its pages fell from 31 a month to 2, and he became the project's loudest advocate.

## Results, 12 months later

- Pages: about 900 a month → about 65. Per engineer: 11 a week → under 1.
- Alert rules: 340 → 92 pageable.
- MTTR: 47 → 19 minutes, mostly from better notifications and runbooks.
- Customer-impact incident rate: unchanged. That was the test: we removed noise, not signal. The 2 restored alerts were the only misses.
- Survey: on-call fell from top stressor to fifth. Both transfer requests were withdrawn.
- The alert-count graph stayed flat for the year. The CI check and the page review are why.

## What I'd tell someone starting this

- Start with the audit and the 3am question, not tooling. Tooling was maybe 10% of the effort.
- The unchanged customer-impact rate is the number that convinces people a quiet pager means the system works. Track it from day 1.
- Keep page rate as an SLO permanently, or you get one quiet season, not a system.
