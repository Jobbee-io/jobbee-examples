<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Redshift to an Iceberg lakehouse

Pennacott Home, data platform team. Design from October 2022, migration from January 2023, Redshift switched off on September 30, 2024. On my resume this is one bullet with the spend and the queue-wait numbers. This file holds the rest: the options and the cost model, who disagreed, the architecture and table standards, how we proved each wave before cutting over, the timeline, what each number means, the two mistakes that cost us 7 weeks and a bad morning for finance, and what was still open when I left.

## Why we moved

By 2022 our Redshift cluster had three problems, and cost was the smallest of them.

- Month-end. Finance close, merchandising and the analysts all hit the cluster in the same three days. The p95 wait in the query queue reached 25 minutes on close days, and finance started their close queries at 6 a.m. to get ahead of it.
- Clickstream history. Keeping clickstream in Redshift was expensive, so we kept 13 months. Data science wanted 3 years or more for seasonality models and was copying raw files out of S3 by hand.
- One engine for everything. Heavy batch transforms, dashboards and ad hoc SQL shared one cluster. One analyst's bad join slowed everyone.

Redshift cost about $720K a year, including concurrency scaling and Spectrum scans.

## The options (October to December 2022)

I wrote the options memo with a 3-year cost model, built from our 2022 usage and query history.

| Option | Estimated cost a year | Fixes month-end | 4 years of clickstream | Data science on the same tables |
|---|---|---|---|---|
| Bigger Redshift, plus a second cluster for finance through data sharing | about $1.0M | yes | expensive | no, still copying |
| Another vendor's managed warehouse | $560K–$680K | yes | expensive | only through exports |
| Iceberg on S3, Spark for heavy batch, Trino for queries | $390K–$470K | yes | cheap, it's S3 | yes |

We picked the lakehouse because it separated the three workloads, kept the data in our own S3 in an open format, and let data science read the same tables as everyone else. The trade we accepted: more moving parts to run.

I chose Iceberg as the table format because Spark and Trino could both read and write it, and because hidden partitioning and partition evolution meant analysts didn't need to know a table's layout to get a fast query.

Before the decision I ran a 2-week proof of concept in November 2022: the 3 heaviest month-end models and the 10 slowest dashboard queries, on Iceberg copies of the data. Trino was faster on 8 of the 10 queries. The 2 slower ones joined two very large tables, and I wrote that into the memo as a known risk.

## Who disagreed

A staff engineer on the platform team argued for the managed warehouse. His team would run EMR and Trino, and he didn't think a company our size should run 2 query engines. He was right that my first estimate left out operations. I added half of a platform engineer's time to the lakehouse cost (the range above includes it), and we agreed on a split: the platform team runs the clusters, my team owns everything above them. The VP of engineering decided with both arguments in the memo, and chose the lakehouse.

Finance's controller agreed on one condition: no finance changes between mid-November and the end of January, our peak season and year-end close. That condition shaped the wave plan.

## My role

I was the technical lead, as an IC. Four data engineers and one analytics engineer worked on it with me at different times. The platform team ran EMR, the Trino cluster and the networking. I wrote the options memo, the design doc, the table layout standards, the parallel-run checks and the cutover plan. I migrated the orders and finance models myself: about 180 of the 1,050 dbt models, the ones where a wrong number reaches the CFO.

## The architecture

- Raw data lands in S3 as before: nightly Postgres extracts, hourly clickstream files, and exports from SaaS tools.
- Iceberg tables in the Glue catalog, as Parquet files with zstd compression.
- Heavy batch, like clickstream sessionization and inventory snapshots: about 60 PySpark jobs on EMR, scheduled by Airflow. The heaviest joins orders to 4 years of clickstream for marketing attribution. It had 2 hot keys in the orders data: the placeholder customer ID used for guest checkout, and one large trade account. I salted both, and the job went from spilling to disk for 3 hours to finishing in 40 minutes.
- The dbt models run on Trino through the dbt-trino adapter. Incremental models use the merge strategy.
- Dashboards, ad hoc SQL and dbt all query Trino. The platform team scales the cluster up on a schedule for the 3 close days.
- Permissions moved from Redshift grants to Trino access rules per schema, kept in git and reviewed like code.

## Table standards

I wrote them before wave 1, and every migrated table had to meet them.

- Tables over about 10 GB that mostly take appends: hidden partitioning by day on event time, plus a sort order on the columns most filters use. The sort order did more for Trino query time than the partitioning did. Trino skips files using each column's min and max values, and sorting makes those ranges tight.
- Small dimension tables: no partitioning.
- Copy-on-write for tables read far more than they're updated, like orders. Merge-on-read only where small updates arrive all day, like inventory levels. I started with merge-on-read everywhere. The order tables' read times doubled within weeks, because every read had to merge delete files, and I moved them to copy-on-write.
- Target file size 256 MB. Compaction, snapshot expiry and orphan-file cleanup run as scheduled DAGs, outside the load windows: in wave 1 compaction collided with writers and Iceberg's commit retries ran out on 2 nights. Except for clickstream, which I come back to below.
- Snapshots kept 5 days, and 35 days on finance tables, so a month-end close can be re-run against the exact data it used.
- Partition evolution, used once: in 2024 the order history table moved from monthly to daily partitions without rewriting old data. Old files keep the monthly layout, new ones are daily, and queries didn't change.

I also wrote a one-page Redshift-to-Trino SQL guide for the analysts: `NVL` and `DATEADD` (Trino has neither), `AVG` of an integer column (Redshift returns a whole number), and time zones. It was the most-read page in our wiki in 2024.

## How we proved each wave

We moved by consumer, not by table, in 4 waves: data science first (most tolerant, most eager), then marketing, then finance and orders, then everything left.

Each wave had a parallel run. Old and new pipelines both ran every day, and a Python job ran the same checks on both engines for every table in the wave: row counts, null counts, the min and max of every column, and a checksum per column computed from the values cast to text. At the peak it compared about 1,300 tables a night. A wave cut over after 10 straight days with zero unexplained differences. "Explained" meant a written note for each type of difference, like floating-point sums that differ in the 12th digit, or rows that arrived between the two runs.

At cutover, dashboards were repointed in the BI tool's data source settings, and dbt consumers through a source switch. Redshift kept loading until the last wave, so any consumer could be switched back within an hour. We used that once (below).

The parallel runs roughly doubled pipeline compute while a wave ran. That cost sits in 2023 and 2024, not in the run rate below.

## Timeline

- October to December 2022: options memo, cost model, proof of concept, table standards.
- January to March 2023: the platform team built EMR, Trino and the Glue catalog. My team built the parallel-run job and loaded 4 years of clickstream history from the raw files in S3.
- Wave 1, data science: cut over in June 2023.
- Wave 2, marketing: cut over in October 2023.
- Mid-November 2023 to January 2024: the finance freeze. We used it for the SQL guide and for rebuilding slow dashboards on pre-aggregated tables.
- Wave 3, finance and orders: parallel run from February 2024, the time zone incident in March, cutover in May 2024 after the audit.
- Wave 4, everything left: planned for August 12, 2024, done on September 30, 2024, the day Redshift was switched off. We kept a final Redshift snapshot for 12 months and deleted it in October 2025.

## The numbers, with definitions

- Spend: about $720K a year on Redshift (2022) → about $430K a year for the lakehouse (EMR, the Trino cluster, S3, the Glue catalog), from the AWS bill's data platform tags at the 2025 monthly run rate. It excludes engineers' time. The project took about 4 engineer-years over 21 months, and the savings pay that back in about 3 years. Cost was a reason, not the reason.
- Month-end p95 query queue wait: 25 minutes → under 1 minute. Queue time per query from query history, on the 3 close days, over the last 3 closes before the move and the first 3 after.
- Top 50 dashboards by views, p95 load time: 11 seconds → 7 seconds, from the BI tool's logs. 9 dashboards got slower, including the 2 joins the proof of concept had flagged; we rebuilt them on pre-aggregated tables.
- Daily batch done by 07:40 before, by 05:50 after: the time the nightly dbt run finished, median over a month.
- Data: about 24 TB in Redshift; about 160 TB in S3 after, most of it 4 years of clickstream we used to drop after 13 months.

## What went wrong

- Time zones. Redshift `TIMESTAMP` columns carry no time zone, and ours held UTC in some tables and Chicago time in others. Our load jobs wrote all of them into Iceberg as UTC. In wave 3, two order models read Chicago time as UTC, and the finance daily report put $1.9M of revenue on the wrong day for 2 days. Finance caught it before anything left the company. The parallel run missed it because it compared each column as text, and the text matched: the same clock time on both sides. The shift only appeared when the report converted to Chicago time to group by day. Our checks covered tables, not the reports built on them. We switched the finance report back to Redshift that morning, fixed the 2 models, and added the daily totals of the top 20 finance reports to the parallel run. I had planned a column-level time zone audit and cut it to save two weeks. We did it after the incident: all 1,050 models, 3 weeks, and 46 columns relabeled.
- The long tail of consumers. I inventoried dashboards and dbt models. I didn't inventory the roughly 600 saved ad hoc queries that 140 people ran against Redshift, many with Redshift-only syntax. They broke in wave 4. We pulled them from query history after the fact. 130 hadn't run in 90 days and were archived with their owners' agreement. An open-source SQL translator rewrote about 310. The last 160 were fixed by hand in office hours, 3 times a week for 5 weeks. Those 5 weeks are most of our 7-week slip; the time zone audit is most of the rest.
- Small files. Clickstream arrived hourly, and without compaction the table grew by about 40,000 files a day. Planning a one-week clickstream query took 30 seconds before Trino read any data. Daily compaction fixed it. I should have scheduled it on day one, as I had for the other tables.

## What was still open in March 2026

- The month-end Trino scale-up is a schedule, not autoscaling. Twice in 2025 a close ran late and outlasted it.
- The 9 rebuilt dashboards run on pre-aggregated tables that need their own maintenance.
- Column-level masking of customer data is done with views. The access rules work per schema, not per column.

## What I'd defend, and what I'd do differently

I'd defend moving by consumer, with a written pass condition for each wave. 10 clean days caught every table-level problem we had.

I'd do these differently:

- Run the time zone audit first, before any table moves.
- Pull 3 months of query history in month one and inventory every consumer, not only the ones with a dashboard.
- Put the reports, not only the tables, in the parallel run.
- Make table maintenance part of the definition of done for every table.
