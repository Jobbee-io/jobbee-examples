<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Nadia Saliba

nadia.saliba@example.com · (555) 073-4416
github.com/example/nadiasaliba · linkedin.com/in/example-nadiasaliba
Chicago, IL

*The long version of my resume: every role, the numbers behind each line, the months since my layoff, and the mistakes. My one-page resume is cut from this file. The long stories live in `Projects/`, and each bullet below points to its file.*

---

## Summary

Data engineer, about 10 years in data. Most recently Senior Data Engineer on the data platform team at Pennacott Home, an online home goods retailer, until a company-wide layoff in March 2026. I started as an analyst writing SQL against a logistics company's warehouse, moved into BI, then into data engineering when I noticed I liked fixing the pipelines more than building the dashboards. At Pennacott I led the move from Redshift to an Iceberg lakehouse, built the streaming orders pipeline, and started a data contracts program with the teams that produce our data. Since the layoff I've built and run a public transit-data pipeline on my own and taken one short contract. I'm looking for a Staff role on a lakehouse or streaming platform.

---

## Experience

### Career break after a layoff — Chicago (Apr 2026 – present)

- Laid off on March 3, 2026, in a reduction of about 22% of Pennacott Home (roughly 140 of 640 people). Not performance-related. Last working day March 24, after a three-week handover I ran.
- April 2026: four weeks off, on purpose.
- May 2026 – present: built and run a pipeline on a city's open transit feed (GTFS static and GTFS-realtime): Python poller, Iceberg tables, dbt with DuckDB, Airflow 3. 146 days of data through October 31, about 147M vehicle positions, about $16 a month to run. Full notes: `Projects/Open Transit Feed Pipeline.md`.
- Aug 17 – Sep 18, 2026: 5-week paid contract for a 40-person regional food distributor (name under NDA). Moved 31 nightly reports off one cron server onto Airflow and dbt, with a runbook their IT lead now uses.
- Sep – Oct 2026: Flink DataStream and SQL APIs on toy jobs. Learning, not experience.

### Pennacott Home — Senior Data Engineer, Data Platform (Apr 2022 – Mar 2026)

Online home goods retailer, Chicago. About $520M net revenue in 2025, about 6M orders a year, two fulfillment centers. Data platform team of 6 engineers and a manager; a separate analytics engineering team of 4; about 140 people with SQL access.

- Led the move from Redshift to an Iceberg lakehouse on S3 (Jan 2023 – Sep 2024): Spark on EMR for heavy batch, Trino for queries, about 1,050 dbt models and 210 Airflow DAGs moved in 4 waves. Spend about $720K → $430K a year; month-end p95 query queue wait 25 minutes → under 1 minute. Finished 7 weeks late. Full notes: `Projects/Warehouse To Lakehouse Migration.md`.
- Built the streaming orders pipeline (Sep 2024 – Mar 2025): Postgres outbox → Debezium → Kafka → Spark Structured Streaming → Iceberg. Orders data freshness from up to 30 hours (nightly batch) to 4 minutes p95; nightly reconciliation against the orders database at 0.002% mismatch. Cyber Monday 2025 (1.1M events that day) without a page. Full notes: `Projects/Streaming Orders Pipeline.md`.
- Started and ran the data contracts program (Jun 2025 – Feb 2026): 31 contracts across 9 producer teams, 12 breaking changes blocked in producer CI before merge, incidents caused by upstream changes 7 in Q1 2025 → 2 in Q4 2025. Unfinished when I was laid off. Full notes: `Projects/Data Contracts Rollout.md`.
- Ran the three-week handover after the layoff notice: 12 runbooks, 6 recorded walkthroughs, 4 paired on-call shifts, 15 unused DAGs retired with owner sign-off. Full notes: `Projects/Three Week Handover.md`.
- Mentored two data engineers; one was promoted to Data Engineer II in 2025. Carried the pager in a rotation of 6 and wrote the team's on-call guide.

### Pennacott Home — Data Engineer, Data Platform (Aug 2019 – Mar 2022)

- Moved 74 cron scripts onto Airflow 1.10 (2019–2020), then did the data team's side of the 1.10 → 2.2 upgrade with the platform team in 2021.
- Brought in dbt in 2020: turned about 300 SQL scripts that ran inside Redshift into dbt models with tests. Added slim CI in 2021; CI time 40 minutes → 9 minutes.
- Built the clickstream load from S3 into Redshift: about 90M events a day by 2021, 13 months kept because of cost.
- On-call for data pipelines from 2020. Promoted to Senior in April 2022.

### Cardenwell Logistics — Data Analyst → BI Developer (Jun 2016 – Jul 2019)

Third-party logistics company in the Chicago area: warehousing and freight brokerage, about 900 employees. Data Analyst Jun 2016 – Dec 2017; BI Developer Jan 2018 – Jul 2019.

- Built the carrier on-time scorecard in SQL Server and Tableau, used in quarterly reviews with about 60 carriers.
- Replaced 40 weekly Excel reports with 12 Tableau dashboards. The operations team got back about a day a week of report work.
- Rewrote the nightly SSIS load from the warehouse management system from row-by-row to set-based SQL: 5 hours → 70 minutes. This is the job that made me want to be a data engineer.

---

## Education

BS Statistics, minor in Computer Science, Wexley State University, 2012–2016.

---

## Skills, with honest depth

- Deep: SQL; Spark (PySpark, Spark SQL, Structured Streaming); Iceberg table design and maintenance; dbt Core; Airflow 2.x; Kafka from the producer and consumer side, Schema Registry, Debezium.
- Working: Python, Trino, AWS (S3, EMR, MSK, Glue catalog, IAM), Terraform for the data team's own resources, Postgres, DuckDB.
- Learning or shallow: Flink, Airflow 3, Scala (read only), Databricks (never at work), Kafka broker operations (never).
- Earlier: SQL Server, SSIS, Tableau, Excel.

---

## Numbers I can defend

- Redshift → Iceberg: about 24 TB in Redshift, about 160 TB in S3 after (clickstream kept 4 years instead of 13 months); spend about $720K → $430K a year; 1,050 dbt models; 210 DAGs; 4 waves; 7 weeks late.
- Streaming orders: freshness up to 30 hours → 4 minutes p95; 0.002% nightly mismatch; 1.1M events on Cyber Monday 2025; bursts of 600 events a second.
- Data contracts: 31 contracts, 9 producer teams, 12 breaking changes blocked, upstream-caused incidents 7 → 2 a quarter, median time to detect 2.5 days → 35 minutes.
- Handover: 3 weeks, 12 runbooks, 15 DAGs retired (236 → 221).
- Transit pipeline: 146 days, about 147M positions, 98.9% of expected polls usable, about $16 a month.

## Failures, indexed honestly

- Lakehouse, wave 3: a time zone mismatch put $1.9M of revenue on the wrong day in the finance daily report for 2 days. I had cut a column-level time zone audit to save two weeks.
- Lakehouse cutover: I inventoried dashboards and models and missed about 600 saved ad hoc queries. That's most of the 7-week slip.
- Streaming: after a connector reset replayed 9.4M events, the fulfillment ops view double-counted orders for 50 minutes. The tables were idempotent; the aggregate wasn't.
- Data contracts: I wrote the first contract format alone, and the first two producer teams turned it down. I also turned on 1,400 tests at once, and people muted the channel.
- Handover: on day 9 I found 2 scheduled jobs running under my personal credentials. They should never have existed.
- Transit pipeline: for 3 weeks I counted stale feed snapshots as real data, which inflated my bunching numbers until I restated them.
