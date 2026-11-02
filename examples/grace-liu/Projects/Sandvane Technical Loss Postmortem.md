<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Sandvane Telematics: the deal I lost on technical fit

Cairnwatch, Enterprise West. Discovery in June 2024, POC from July 15 to August 16, lost in September 2024. This deal isn't a bullet on my resume. It's one line in my failures list, and it's the loss I'm asked about most once an interviewer sees that list. It changed how I qualify every deal.

## What it was

Sandvane runs fleet telematics: about 3.2M connected vehicles reporting location, engine and driver data. They wanted one platform for application logs, traces and device metrics. The AE, Colin, forecast it at $1.3M first-year ARR, the largest deal in my book that year. Their budget was about $1.4M a year.

The hard requirement was the device metrics. About 12 metrics per vehicle across 3.2M vehicles is about 38M active time series, kept for 13 months, with dashboards querying 7- to 30-day windows. Cairnwatch's tested limit at the time was 10M active series per tenant, with p95 queries under 3 seconds. A beta high-cardinality mode had been tested internally to 20M.

## My role

I was SE of record. I ran discovery, did the sizing, wrote the success criteria with their platform director, who was also our champion, and ran the POC. Colin owned the deal strategy and the forecast. 2 of our metrics engineers spent about 60 hours tuning the beta during the POC. I logged about 210 hours over 3 months.

## What I knew, and when

- Week 2 of discovery, late June: I did the sizing math and saw the gap, 38M series against 10M tested and 20M for the beta. I raised it once, in our internal deal channel. The metrics PM said the beta would get there. Colin said the champion loved our logs and traces demo, which was true. I let those 2 answers outvote my own numbers. I didn't put the gap in writing to Colin and my manager, and I didn't tell the prospect.
- July 15: the POC started on 6 criteria I had agreed to: log search on 7 days of application logs at p95 under 5 seconds; trace-to-log correlation across their backend services; ingest at full cardinality, about 38M active series, with no dropped samples; 7-day dashboard queries at p95 of 5 seconds or less; 30-day queries at p95 of 15 seconds or less; and total cost at full volume within budget. 3 were about metrics at full cardinality, and the cost criterion depended on them too.
- Week 3, late July: the 7-day queries were already slow. I spent the week tuning the beta with our engineers instead of telling the champion.
- Week 4, early August: I told him. His first question was how long we had known.
- August 16: the POC ended. Colin took the deal out of his Q3 commit in the last week of August.
- September: they chose a competitor with a columnar metrics backend, for the whole deal.

## The numbers, and their definitions

- Criteria met: 2 of 6, log search and trace-to-log correlation.
- Metrics at 38M active series: 7-day dashboard queries ran at a p95 of 41 seconds, with 12% timing out. Most 30-day queries timed out. Ingest dropped samples at peak.
- Cost: at that volume, high-cardinality pricing came to about 1.8 times their budget.
- Time: about 210 hours of mine and about 60 of engineering.

## What the loss review told me

In the loss call, their platform director said that if we had told him in week 2, he would have scoped us to logs and traces, about $480K a year, and kept device metrics on their own pipeline. We lost that too. The technical gap cost us the metrics deal. My silence cost us the logs and traces deal.

## What I got wrong

- I had the right number in week 2 and treated it as a worry instead of a finding.
- I accepted a beta as a plan. Nobody in product had committed to 38M series or to a date.
- I agreed to success criteria that the product, as tested, could not meet.
- I spent week 3 tuning instead of talking to the customer.

## What I do differently now

1. A sizing worksheet of 8 questions, filled in during the first or second technical call and saved on the CRM record: active series, the highest-cardinality labels, ingest per day for each signal, retention for each signal, query windows, peak events per second, deployment region, and compliance needs.
2. A fit note within 48 hours. When a hard requirement goes past a tested limit, I write it to the AE and my SE manager with the numbers.
3. No POC on a requirement past a tested limit without a written product commitment, meaning a named feature and a date. A beta doesn't count.
4. Tell the prospect early, and offer the part of the deal that fits.
5. A loss report to product with the numbers, within a week. I sent the Sandvane one in September 2024. The high-cardinality work moved up in the next planning cycle, and the tested limit went to 25M active series in 2026. Sandvane's 38M still wouldn't fit. I don't claim more credit than the data I sent.

## Results since

From October 2024 to September 2026, the worksheet flagged 7 deals past a tested limit. 2 were qualified out before a POC, which saved an estimated 300 SE hours, using the Sandvane POC as the yardstick. 4 were scoped down to what fit, and 3 of those 4 won. 1 went to a POC on a regional VP override and lost. The worksheet also runs on deals that fit: on Halverd in 2025 every line came in under a limit, and that let me spend the POC on trust instead of fit (`Halverd Competitive Poc.md`).
