<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Logging cost cut: $46K to $19K a month

Larkspan Software, March to August 2025, with the bill measured through September. One bullet on my resume.

## The full story

In January 2025 our hosted logging bill was $46K for the month, with ingest growing about 5% a month. The bill had passed our whole compute spend for one production region, and finance asked platform for a plan. Nobody could say which logs anyone read.

I led the work from March. The first call was vendor or volume. I priced running our own stack, but every option charges by volume in the end, and we didn't know what our volume was for. So we kept the vendor, and I sampled one week of ingest by source and field before changing anything. Only about 30% of it was application logs people actually used.

The cuts went in roughly from safest to riskiest. First the noise: health-check logs dropped at the collector, debug logs off by default, duplicate file shipping removed. Then the audit logs: our compliance lead set their 400-day retention, and Aditya K. built the routing to object storage. Then the cuts that touched logs people read: searchable retention from 30 days to 14, and 10% sampling on the 6 highest-volume services. Each team chose what to cut in its own logs. The per-team budgets came last, and they should have come first.

Two of my changes hurt. My first sampling rule matched by service, not by log level. For 16 days it dropped 90% of the error lines from the vendor-payment file generator, and when a bank rejected one customer's payment file twice, we heard it from the customer. Errors and warnings are never sampled now, and CI tests the rules. And the 14-day retention cut off support, who use webhook delivery logs for up to 30 days. I had asked finance and engineering what to cut, not the people who read the logs. Three weeks later we put that stream back to 30 days.

By September the bill was $19K a month and ingest was down from 4.6 to 1.5 TB a day. The saving, net of the new object storage, is about $26K a month.

No task from the project is still open. The open risk is growth. The budgets open a ticket when a team runs over; they don't block anything. The number stays down only while teams act on those tickets, and if it climbs again, the vendor question comes back.

## Why

In January 2025 our hosted logging vendor billed us $46K for the month. Ingest was about 4.6 TB a day and growing about 5% a month, with 30 days of searchable retention on everything. Finance asked platform for a plan after the bill passed our whole compute spend for one production region. Nobody could say which logs anyone actually read.

## My role

I led it: the volume analysis, the plan, the collector configuration and the per-team budgets. Aditya K., a Pune SRE, built the routing to object storage. Each service team decided what to cut in its own logs, inside a budget I set with them. Our security and compliance lead decided the audit-log retention, not me.

## Vendor or volume

The first question was whether to leave the vendor. I priced running our own log stack on object storage: about $9K a month in infrastructure, about half an SRE to run it, and a migration of every dashboard and alert. Another vendor would have needed the same migration. But every option charges by volume in the end, in money or in hardware, and we didn't know what our volume was for. So we kept the vendor and cut volume first.

## Where the volume came from

I sampled one week of ingest by source and field before touching anything:

- 38%: health-check and access logs from the ingress controllers and sidecars. Every load-balancer probe, every few seconds, on every pod.
- 17%: debug-level logs left on in production in 11 services, some for over a year.
- 9%: duplicates. Some services wrote to stdout and to a file, and we shipped both.
- 6%: audit logs, which our SOC 2 controls say we keep for 400 days, but which are searched a few times a year.
- 30%: the application logs people actually use.

## What we did

- Dropped health-check logs at the OpenTelemetry Collector, before they reached the vendor. We kept a per-minute count of probe failures as a metric, which is the only thing anyone had ever used them for.
- Debug logs off by default in production, with a flag that turns them on for one service for up to 4 hours and then switches itself off.
- Removed the duplicate file shipping.
- Routed audit logs to object storage with 400-day retention and on-demand queries. Searching them takes minutes instead of seconds, which the compliance lead agreed was fine for a few searches a year.
- Searchable retention for application logs: 30 days to 14.
- Sampled info-level request logs at 10% for the 6 highest-volume services, keyed on trace ID, so a sampled request keeps all its lines and an unsampled one keeps none.
- Gave every team a monthly ingest budget in GB a day, set from its own usage after the cuts plus 10%, and a dashboard showing its share of the bill. Three days over budget opens a ticket for that team; nothing gets blocked. The budgets are what kept the number down after the project ended.

## The numbers

- Monthly bill: $46K (January 2025) to $19K (September 2025), same vendor, same contract rate.
- Ingest: about 4.6 TB a day to about 1.5 TB a day.
- New object storage for audit logs: about $700 a month. Net saving about $26K a month, roughly $315K a year at the September run rate.
- Incidents: apart from the first mistake below, no postmortem since has named a missing log as a cause. Median time to resolve didn't move either way, which is what I wanted.

## What went wrong

- I sampled away errors. The first sampling rule matched by service, not by log level. One of the services it covered was the vendor-payment file generator, which is low volume but important. For 16 days, 90% of its error lines were dropped. In that time a bank rejected one customer's payment file twice, and we found out from the customer, not from our logs. Since then errors and warnings are never sampled, and the sampling rules have tests in CI that fail if a rule can drop either.
- I asked finance and engineering what to cut, and forgot support, our biggest reader. Support uses webhook delivery logs to answer "did you send us that event?" for up to 30 days. When retention dropped to 14, they lost that answer for anything older than two weeks. Three weeks later we put that one stream back to 30 days. It costs about $400 a month and should never have been cut. I now ask the people who read the logs, not only the people who pay for them or write them.

## What I'd do differently

Put the per-team budgets in first. They did more to keep the bill down than any single cut, and they'd have made every team look at its own volume before I did.
