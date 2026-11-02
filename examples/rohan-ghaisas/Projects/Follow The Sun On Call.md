<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Follow-the-sun on-call between Pune and Columbus

Larkspan Software. Designed September to December 2024, live 6 January 2025, measured through September 2025, and still running. On my resume it's one bullet with two numbers. For the roles I'm applying to, it's the most relevant thing I've built: a US or European company hiring an SRE in India is usually buying the India leg of a rotation like this one, and I built one from that side.

## The problem

All of our customers are in the US. Their working day, 09:00–18:00 Eastern, is 19:30–04:30 in Pune in winter. Until the end of 2024 the 10 Pune SREs carried a 24x7 primary rotation, one week in 10, with a Pune secondary. Our 3 SREs in Columbus were an escalation point during US business hours only.

So the pages followed the customers, and the customers were awake while we slept. In 2024 the Pune rotation took about 31 pages a month between 22:00 and 07:00 IST: about 7 night wake-ups in an on-call week. Two Pune SREs left that year, in March and August, and both named the nights in their exit interviews. I started the proposal after the second exit.

## What the pages said

Before proposing anything, I exported every page from 2024 out of our paging tool and looked at it by hour and by alert.

- Pages between 19:30 and 07:30 IST, the hours a US layer would cover: about 44 a month. 31 of those fell in the night window, 22:00–07:00.
- The busiest hour was 20:30–21:30 IST, the first hour of the US morning, when customers start uploading invoices.
- 23 alerts produced about half of the pages in that window, and almost none of those pages needed a human at night: a disk warning at 70%, a certificate-expiry warning 30 days out, a queue-depth alert that flapped every evening, and others like them.

That last finding changed the plan. Asking the US side to take 44 pages a month was a hard sell. Asking them to take about 20 was not.

## Options I compared

- Keep the 24x7 Pune rotation, raise the on-call allowance and add a comp day after each on-call week. The cheapest option, and it left 7 wake-ups a week in place. Money doesn't fix sleep, and the two people who left hadn't asked for money.
- Hire 3 more SREs in Columbus for a full US layer. About $500K a year in salary alone, and 6 months or more to hire. Laura M., the engineering director in Columbus, couldn't get that into the 2025 budget.
- A managed monitoring service to watch our alerts overnight, quoted at about $8K a month. They would only triage and escalate, so anything real would still wake someone in Pune.
- Pune covers until 23:00 IST and Columbus starts later. It moved the problem into Pune evenings without removing it.
- Two 12-hour layers, the Columbus one staffed by the 3 US SREs plus backend engineers who volunteer, paid an on-call stipend. Chosen. The stipends cost about $39K a year: $500 for a primary week and $250 for a secondary week, 52 weeks a year.

## My role

I did the page analysis, wrote the proposal, built the schedules and escalation policies in our paging tool, rewrote the runbooks, wrote the handoff template and the incident rule below, and ran the training for the US side. I went through the 23 noisy alerts with Greg H., the US SRE lead, and the owning teams; the teams made the changes. Greg recruited the Columbus volunteers and ran their shadow weeks. Vikram S. (our Head of Platform, Pune) and Laura approved the US on-call stipends that made it possible.

## The design

- Two layers of 12 hours. Pune: 07:30–19:30 IST. Columbus: 19:30–07:30 IST, which was 09:00–21:00 Eastern when we launched in January. That second sentence turned out to be the bug (see "What went wrong").
- The Columbus layer started with 6 people: the 3 SREs plus 3 backend engineers who volunteered. Each volunteer did 2 shadow weeks with a US SRE first, and I ran 6 recorded runbook walkthroughs at 19:30 IST, the start of their day. A volunteer is never primary and secondary at once: when a volunteer is primary, the secondary is one of the 3 US SREs.
- Each layer has its own primary and secondary on the same site. Inside a layer, the primary has 5 minutes to acknowledge, then the secondary is paged and has 10. Only a SEV-1 crosses sites at night, by also paging the other site's incident commander. The last level of the Columbus policies was Laura's phone; for Pune it was Vikram's.
- Runbooks. I rewrote the 27 runbooks behind the alerts that could still page at night, for someone who had never worked on the service. Each starts with what the customer sees and ends with when to wake Pune.
- Access. Volunteers got read access to production dashboards and logs, and the same 4-hour break-glass role SREs use for changes (`Terraform Drift Cleanup.md`).
- Boundaries. The 19:30 IST boundary gets a written note and a 15-minute call: it's the end of the Pune day and the start of the US day, so nobody is up late for it. The 07:30 IST boundary (21:00 Eastern) is written only.
- The handoff note has 5 fields and a 10-line limit: open incidents with an owner, changes in flight, silenced alerts with their expiry, known risks for the next 12 hours, and anything promised to a customer.
- The incident rule: the commander of an active SEV-1 or SEV-2 does not hand off at a boundary until the incident is stable and the handoff is written. I used that rule myself during the October 2025 region outage (`Region Outage Incident Command.md`).
- Alert cleanup before launch: of the 23 noisy alerts, 9 were deleted and 14 now open a ticket or have a threshold that means a human is needed.

## Timeline

- March and August 2024: the two exits.
- September: page analysis and proposal.
- October: stipends approved. Greg recruits 3 volunteers.
- November: alert cleanup, runbooks, walkthroughs.
- December: shadow weeks.
- 6 January 2025: live.
- February: the 5-field note template replaces free text.
- 9 March: US clocks move forward. 11 March: an incident waits 26 minutes for an acknowledgement. 17 March: I find the gap. 18 March: both layers redefined in UTC.
- End of March: the weekly coverage check goes live.
- April: one volunteer drops out, and the 3-month review of the boundary call.
- May: 2 more volunteers join.
- July: Laura's 6-month review of the volunteer model. She kept it.
- October: the coverage check catches an empty Diwali morning. 14 October: the region outage.
- 2 November 2025: US clocks go back, the first change under the UTC schedule. Nothing happened, which was the point.

## Who disagreed, and how it was settled

- Laura was against putting backend engineers on a pager for services they hadn't built. We settled on volunteers only, 2 shadow weeks each, a US SRE always as secondary behind a volunteer, and the stipend. She also asked for a 6-month review with the right to end the volunteer part.
- Greg thought a daily handoff call was overhead. I thought a written note alone would fail at the busiest boundary. We agreed on a 15-minute call at 19:30 IST only, reviewed after 3 months. At the review, the Columbus engineers asked to keep it.
- Two Pune SREs worried that their on-call allowance would shrink with the night hours. Vikram kept it at the same rate per on-call week.

## The numbers

Monthly averages for February to September 2025 against the 2024 monthly average. January 2025 is left out as the launch month. Source: the paging tool's export, with the recipient's site.

- Pages to Pune engineers between 22:00 and 07:00 IST: about 31 a month to about 2, all of them SEV-1 escalations across sites.
- Median time to acknowledge a page in that window: 9 minutes to 3. The person holding the pager was awake.
- Pages in the whole Columbus window (19:30–07:30 IST): about 44 a month to about 21. About 19 go to the Columbus layer, about 80% of them during US working hours, plus the 2 that cross to Pune. The drop beyond the layer change is the alert cleanup.
- The Pune layer takes about 9 pages a month, because 07:30–19:30 IST is the US night.
- Incidents that crossed a handoff: 14. In 12 of them the incoming engineer carried on without calling the outgoing one. In the other 2, the note was missing a change in flight.
- Handoff notes: about 480 boundaries, 11 without a note, all at the written-only 07:30 boundary.
- No Pune SRE left in 2025. I don't claim the rotation is the only reason.

## What went wrong

- The daylight-saving gap. I defined the Pune layer in IST and the Columbus layer in US Eastern local time, 09:00–21:00. India has no daylight saving. When the US clocks moved forward on 9 March 2025, the Columbus layer started covering 18:30–06:30 IST: an hour of overlap every evening and an empty hour, 06:30–07:30 IST, every morning. Pages with no primary went to the last level of the escalation policy, which was Laura's phone. On 11 March at 06:52 IST, invoice exports began failing for a group of customers. Laura was off duty and acknowledged after 26 minutes. I found the cause on 17 March, while preparing the postmortem for that export failure. By then the gap had been open every morning for a week. I'd checked the schedule in January and never thought about March.
- The first month of handoff notes was free text. They averaged about 600 words, and nobody read them to the end. The 5-field, 10-line template came in February.
- One backend volunteer dropped out in April. With 6 people, every sixth week on call, on top of his normal job, was more than he'd signed up for. Greg recruited 2 more in May, so the Columbus layer is 7 people now. I had counted volunteers without asking what frequency they could sustain.

## The fixes that stuck

- Both layers are defined in UTC, with boundaries at 02:00 and 14:00 UTC. The Columbus team agreed that their window is 09:00–21:00 in winter and 10:00–22:00 in summer.
- A weekly coverage check: a small Python script that reads the next 60 days of schedule from the paging tool's API and fails if any minute has no primary. It posts to the team channel. In October 2025 it caught an empty Pune morning created by a Diwali shift swap, 9 days before it would have happened.
- If a European site ever joins, its clocks change on different dates from the US. That's why the boundaries live in UTC and not in anyone's local time.
- The rule spread: our maintenance windows and scheduled jobs are written in UTC now too.

## Second-order effects, and what isn't solved

- The handoff notes became our best record of what happened when. Postmortems now take their timelines from them.
- The load is uneven. Columbus takes about 19 pages a month across 7 people, each on call every seventh week. Pune takes about 9 across 10, every tenth week. The volunteers are the fragile part: if two of them leave, the layer drops to 5 people and an on-call week every fifth week, more often than the rate at which the first volunteer quit.
- A SEV-1 at night still wakes Pune about twice a month. That's by design, and with one US office I don't think it can reach zero.

## What I'd do differently

- Write every schedule in UTC from day one, and put the coverage check in before launch, not after the first gap.
- Ask volunteers what frequency they can sustain before counting them.

## What I'd check first as the India leg of someone else's rotation

Are the layer boundaries written in UTC? Does anything test coverage ahead of time? Is there a short, fixed handoff note? Does an active SEV-1 stay with its commander across a boundary? And which of the overnight pages actually need a human?
