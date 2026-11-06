<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Payouts reconciliation: nine weeks from a finance request to production

Cartway, marketplace payments. Requirements in early January 2019, in production March 11, 2019. On my resume it's one line: "Built nightly reconciliation for marketplace payouts; unexplained balance days went from ~6/month to zero." This file is what's behind that line, because "how did you build something for people who aren't engineers" comes up in almost every loop.

## The request

In December 2018 a seller complained that a weekly payout was $1,140 short. It took finance three weeks to explain: a refund had settled at the gateway a day after our ledger recorded it, across a payout boundary. In January the payouts operations lead asked my manager for one thing: "tell us every morning whether yesterday's money adds up, and if it doesn't, show us where."

Before this, two analysts exported the gateway's settlement report every Friday and matched it against a ledger extract in a spreadsheet: about 10 analyst-hours a week. They averaged six unexplained balance days a month, meaning days that closed with a ledger-versus-gateway difference nobody could account for. Each one took about half a day to chase, often weeks later.

## What I owned

The whole feature: requirements, design doc, build, rollout and running it afterwards. One senior engineer reviewed the design and code. The payouts operations lead owned the rules for what counts as an acceptable difference. I wrote that split into the design doc: the rules are finance's, the code is mine.

## How the nine weeks went

1. **Week 1, requirements.** I sat with both analysts for two afternoons during a Friday reconciliation and read three months of their spreadsheets. That gave me the real categories of difference: settlement timing, fee rounding, and chargebacks still in dispute.
2. **Week 2, design.** Compare totals per seller per day first, and drill down to single transactions only where totals disagree; with a few million ledger entries a day, one-by-one comparison would have been slow and noisy. In the design review an analyst asked what happens with partial refunds. My draft matched on amount and time window, which breaks on them quietly. I switched to matching on the gateway's transaction ID before writing any code. Since then I do requirements with the people who do the work by hand, not only with their manager.
3. **Weeks 3 to 6, build.** A Ruby job (payments code was still mostly Ruby) reading ledger totals from a Postgres replica, the gateway's settlement file and its capture records. Each run's results are stored append-only by date and run, so finance can re-run any past day at month-end and get the same answer. The run starts at 04:00 and checks ledger captures against the gateway's capture records up to that moment; the settlement file closes the previous day when it lands.
4. **Weeks 7 to 8, shadow run** next to the analysts' spreadsheet, compared every Friday.
5. **Week 9, cutover.** The spreadsheet stopped; the morning report went to the finance team's channel at 06:00.

## The numbers

- Unexplained balance days: about 6 a month → 0 for the twelve months after launch.
- The weekly spreadsheet retired: about 10 analyst-hours a week back to finance.
- Support got a per-seller view of the same results, so "why is my payout short" became something support could answer without escalating to finance.
- In May 2019 the 04:00 run flagged an imbalance at 04:12: duplicate captures during a gateway incident. That alert started our incident response, and every cent was traced by morning (`Payments Idempotency.md`).

## What went wrong

- **The first shadow run flagged everything.** Version one reported every difference down to the cent: about 1,300 a night, almost all fee rounding. By day three the analysts had stopped reading it: the same alert fatigue I later took out of on-call at Bluepeak (`On Call Overhaul.md`). Fix: written tolerance rules agreed with finance (rounding up to $0.01 per transaction, settlement timing up to two days), each rule shown in the report so nothing was hidden. Differences dropped to a handful a night, each one needing a human.
- **The gateway changed its file format.** In week 6 the settlement file's column order changed without notice. The parser failed loudly, which was right, but there was no runbook. I added schema checks with a clear error and a one-page runbook finance could follow without paging me.

## What I'd do differently

Both fixes above belonged in the first release: tolerance rules agreed in week 1, file checks and runbook shipped with the job. And I'd name one analyst as co-owner from the start; in practice one of them became that anyway.

## What's still open

Nothing was open on this when I left Cartway in August 2020. The job was in production, finance owned the tolerance rules, and the schema checks and runbook covered the kind of file-format change that stopped the parser in week 6.
