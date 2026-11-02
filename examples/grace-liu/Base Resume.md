<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Grace Liu

grace.liu@example.com · (555) 071-4826
linkedin.com/in/example-graceliu · github.com/example/graceliu
San Diego, CA

*The long record behind my one-page resume. Presales results are hard to show because SEs don't carry their own number, so I keep my own record, with the definitions written down. The project files in `Projects/` hold the full stories; this file points to them.*

---

## Summary

Senior Solutions Engineer with 5 years as a backend engineer before that. Since October 2021 I've been an enterprise SE at Cairnwatch, an observability platform, the same company where I built part of the ingest pipeline. I run technical discovery, demos and formal POCs for the 3 enterprise AEs I cover, and I write the tooling a POC needs instead of asking for it. Over 5 years in presales: a 57% win rate on the deals I was attached to against about 45% for my region, and 13 of 20 decided POCs closed-won. The record below includes one large technical loss, and what I changed because of it.

---

## Presales record, year by year

*"Attached" means I was the SE of record in the CRM from technical discovery to decision, and the deal reached the technical validation stage. "Decided" means closed-won or closed-lost that year, including no-decision losses; open and slipped deals are left out. Win rate is won divided by decided, by count. The region column is the same calculation for every SE-attached deal in Enterprise West. "POCs" are formal POCs with success criteria signed by the prospect.*

| Year | Attached, decided | Won | My win rate | Region win rate | POCs decided | POCs closed-won |
|---|---|---|---|---|---|---|
| 2022 | 24 | 12 | 50% | 44% | 4 | 2 |
| 2023 | 29 | 16 | 55% | 45% | 5 | 3 |
| 2024 | 31 | 18 | 58% | 46% | 4 | 3 |
| 2025 | 33 | 20 | 61% | 47% | 5 | 4 |
| 2026 (Jan–Sep) | 21 | 12 | 57% | 45% | 2 | 1 |
| Total | 138 | 78 | 57% | about 45% | 20 | 13 |

The gap to the region isn't all skill. AEs bring their best deals to the SE they trust most, so part of it is selection. Q4 2021 was my ramp quarter, as a co-SE on 3 deals, and isn't counted. One more POC is in procurement now.

---

## Experience

### Cairnwatch (observability platform) — Senior Solutions Engineer, Enterprise West
*Mar 2024 – present · San Diego, remote with travel*

- Cover 3 enterprise AEs in a region of 14 AEs and 5 SEs. Typical first-year deal: $150K to $900K ARR. Current OTE $250K ($175K base, $75K variable on the region's new-ARR quota, paid quarterly, capped at 150%).
- 2025: $7.9M of new ARR on 20 closed-won deals where I was SE of record. The region closed $33.6M against a $30M quota (112%).
- Halverd Payments (2025): won a 6-week, three-vendor POC by meeting all 5 signed success criteria, including 184 of 200 alert rules migrated by a converter I wrote in Go. Closed at $820K first-year ARR, 3-year term. Full notes: `Projects/Halverd Competitive Poc.md`.
- Built the region's RFP and technical questionnaire program in 2024: median SE hours per RFP 35 to 13, turnaround 11 to 5 business days, and a go/no-go triage that now declines about a quarter of what comes in. Full notes: `Projects/Rfp Response Program.md`.
- Run the region's monthly POC review, where SEs walk through success criteria before they go to a prospect. Onboarding buddy for 2 new SEs in 2025.
- Offered the Enterprise West SE manager seat in 2025 and turned it down.

### Cairnwatch — Solutions Engineer, Enterprise West
*Oct 2021 – Feb 2024 · San Diego*

- Moved from the ingest engineering team to presales in October 2021, on a written ramp plan with a 6-month return path I didn't use. Starting OTE $210K ($147K base, $63K variable). First solo technical win in March 2022. Full notes: `Projects/Engineering To Presales Move.md`.
- Rebuilt the SE org's demo environment in 2023: a fictional grocery-delivery app of 22 services with 9 scripted failure scenarios, one copy per SE. Demos logged with an environment problem fell from 14% to 2%. Full notes: `Projects/Demo Environment Rebuild.md`.
- 2023: 16 wins on 29 decided deals. Promoted to Senior SE in March 2024 on a written case built from this record.

### Cairnwatch — Backend Engineer → Senior Backend Engineer, Ingest Pipeline
*May 2019 – Sep 2021 · San Diego · promoted to Senior in January 2021*

- Built the OTLP ingest endpoint (2020) so customers could send OpenTelemetry data without our proprietary agent. By September 2021 it carried 38% of all trace volume.
- Led the per-tenant backpressure redesign after a March 2020 incident where one tenant's burst delayed ingest for others by up to 9 minutes. Cross-tenant ingest delay has stayed under 20 seconds at p99 since. The ingest tier peaked around 2.3M spans per second.
- Took the customer escalation rotation 1 week in 6, and joined 14 prospect calls as the ingest expert when SEs asked. That's where the move to presales started.

### Saltpine Health (claims-processing SaaS for dental and vision insurers) — Backend Engineer
*Jul 2016 – Apr 2019 · San Diego*

- Built and ran the claims-intake pipeline (Java, Postgres, RabbitMQ), about 2.1M claims a month. Moving nightly batch steps onto a queue cut p95 intake-to-adjudication time from 40 minutes to 6.
- Ran the company's 2018 observability vendor evaluation from the buyer side: 3 vendors, 4-week trials, a scorecard I wrote. Cairnwatch won. Being the engineer on the other side of a POC is still the most useful thing I bring to one.
- Primary on-call 1 week in 5.

---

## Education

**BS Computer Science, Calder Point University, 2012–2016.** Systems-heavy: databases, networks, distributed systems. Senior project was a log-shipping agent, which in hindsight was a hint.

---

## Skills (honest)

- Strong: Go, OpenTelemetry (collector config, tail sampling, SDKs in Go, Java and Python), PromQL, log query languages, Kubernetes, Helm, Terraform, Kafka, cardinality and cost modeling.
- Working: Python, Postgres, Java (I wrote it for 3 years; I read it better than I write it now).
- Presales: technical discovery and sizing, POC design, demo building, executive demos (learned the hard way), RFP answers, competitive positioning.
- Not my strength: deep security and compliance reviews (I bring in our security team), Windows and .NET estates, mainframe.

---

## Numbers I can defend

- 138 attached deals decided since 2022, 78 won (57%), against about 45% for the region, with the selection caveat above.
- 20 decided formal POCs: 16 technical wins, 13 closed-won (65%). Of the 3 technical wins that didn't close, 2 lost on budget and 1 went to no decision after a reorg.
- 60 attached losses, by reason agreed in loss review: 22 no decision, 17 price or budget, 12 competitor relationship or other, 9 technical fit.
- Halverd: 5 of 5 criteria, 184 of 200 alert rules converted by tooling (92%), log search p95 3.1 seconds, $820K first-year ARR.
- RFPs, 2023 vs 2025: 43 received and 43 answered vs 44 received and 32 answered; won 6 vs 9; about 1,500 SE hours vs about 440.
- Demo environment: 61 of 436 logged demos with an environment problem in Q4 2022, 11 of 552 in the second half of 2023.

## Failures, indexed honestly

- Sandvane Telematics (2024): lost a $1.3M forecast deal on technical fit. I had the sizing math showing the gap in week 2 and ran a 5-week POC anyway. It's not a bullet above, and it changed how I qualify every deal. Full notes: `Projects/Sandvane Technical Loss Postmortem.md`.
- My first demo certification ran 41 minutes in a 25-minute slot. I failed it, and I passed the retake.
- In my first year I told a prospect "yes, we can do that" about per-index retention without checking. It needed a professional-services engagement, and the AE had to walk it back.
- The demo environment had one maintainer, me, for 5 months, and broke the week before a quarter-end.
