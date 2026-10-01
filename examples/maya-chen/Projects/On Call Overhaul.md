<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# On-call overhaul

Bluepeak Systems, Payments Platform org (and by the end, org-wide). Feb 2024 – Aug 2024. Not a code project — a human-systems project, and I led it. I include it here because how a team carries its pager is load-bearing infrastructure; the org was paying more for alerting than for several services.

## Starting state (measured, not vibes)

- **~900 pages/month org-wide** across 7 on-call rotations and 46 services. Median engineer: 11 pages/week.
- **340 alert rules.** Audit found 141 of them had never fired (dead config), and 63 fired more than once a week with zero subsequent action (noise).
- **MTTR 47 minutes**, median. The biggest component wasn't diagnosis — it was *notification quality*: pages that said "CPU > 80% on host X" with no service context, no runbook link, no severity.
- **Attrition signal:** two engineers requested rotation transfers citing page fatigue; one threatened to. Our quarterly survey had "on-call" as the top stressor, above deadlines.
- The rot had a history: every incident spawned a "let's alert on that" ticket. Nobody ever deleted alerts. Alert count had grown 3.2× in two years while service count grew 1.4×.

## Design principles I wrote first

1. **A page must be actionable now** — if the next business-hours standup is an acceptable response, it's a ticket, not a page.
2. **Every page carries the "why me"**: affected service, customer impact (or explicit none), and a runbook link that exists.
3. **Alerts have owners and review dates.** An alert nobody owns gets deleted. Default is deletion, not silencing.
4. **Page rate is a managed SLO of the platform team.** We took ownership of the number: ≤ 2 pages/engineer/week, measured monthly, reported like uptime.

## What we did

**The audit (6 weeks).** Every alert rule triaged by its owning team in working sessions I ran: keep / tune / demote-to-ticket / delete. We deleted 178 rules, demoted 70 to ticket-level notifications, and tuned 92 down from static thresholds to burn-rate or multi-window conditions. The dead-141 were the easy part; the fights were the noisy-63, where each had a founding incident. My standard line in those sessions: "name the incident it guards against, and tell me what you'd do at 3am if it fired tonight." If both answers were thin, it got demoted. That question settled arguments faster than any data.

**SLO-based alerting for the top 12 services.** Burn-rate alerts (fast + slow windows) replaced ~40 CPU/memory/disk rules. This cut the most pages of any single change, because resource alerts almost never needed a human *at night* — the services were horizontal and the saturation signals lagged the customer-impact signals by design.

**Runbook coverage as a gate.** Pageable alerts must link a runbook with: what the alert means, first three diagnostic commands, escalation path. We wrote 61 runbooks in 8 weeks — paired writing, the alert owner + one rotating partner, 90-minute slots. Coverage went 34% → 100% for pageable rules. (A page without a runbook now can't merge, via the alerting CI check. That check is what keeps this from rotting back.)

**Rotation redesign.** 7 rotations → 4, aligned to real service ownership. Primary/secondary with a hard escalation rule (secondary auto-engaged after 10 minutes unacked). Weekly handoff doc instead of verbal handoff (verbal handoffs were silently losing context — we found 3 recurring incidents whose workarounds lived in one person's head). **Follow-the-sun was evaluated and rejected:** two engineers volunteered, then withdrew when they did the timezone math; night-shift solo paging for a Seattle-centered org wasn't humane and wouldn't have held.

**The page-review ritual.** Every page gets a 3-line note in a shared log: actionable? runbook helped? should it exist? Monthly review, 30 minutes, deletes rules continuously. This is the piece that maintains the number after I'm gone — the audit made it better once; the ritual keeps it better.

## Resistance, handled

- **"Our alerts are different."** Three teams initially exempted themselves. I stopped pushing and instead published the pilot teams' before/after numbers with names attached; two of the three joined within a month, the third after its own bad quarter. Volunteering-by-evidence beat mandating.
- **"Deleting alerts is dangerous."** Fair fear, so every deletion was reversible for 30 days (rule archived, not destroyed) and we tracked "deleted alert we needed" events: 2 in the year after, both caught by the page-review ritual and restored within a day. That number — 2 — is what ended the argument.
- **One senior engineer openly called it make-work** in the kickoff. Rather than argue, I made him owner of the SLO-burn-rate migration for his own service, which had the worst page rate in the org. It was either the best or luckiest assignment I made: his service's page count fell from 31/month to 2, and he became the overhaul's loudest internal advocate.

## Results (12-month follow-up, so this is durable, not a post-sprint high)

- Pages: ~900/month → **~65/month**. Per-engineer: 11/week → <1/week.
- MTTR 47 → **19 minutes**, mostly from notification quality and runbooks.
- Customer-impact incident rate: unchanged (the whole point — we deleted noise, not signal; the 2 restored alerts were the only misses).
- Survey: "on-call" fell from top stressor to 5th. Both rotation-transfer requests withdrawn, rescinded voluntarily.
- The alert-count graph stayed flat for a year afterward. The CI check and the ritual are why.

## What I'd tell anyone starting this

- Don't start with tooling. Start with the audit and the "what would you do at 3am" question. The tooling cost us maybe 10% of the effort.
- The hardest part is social, not technical: convincing people that a quiet pager is a sign the system works, not that they've been made expendable. Bring receipts (the unchanged incident rate is the receipt that matters).
- Manage page rate like an SLO forever, or you're buying a season of quiet, not a system.
