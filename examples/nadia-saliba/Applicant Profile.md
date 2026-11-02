<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Nadia Saliba

Facts about my search that the settings fields can't hold. I was laid off in March 2026. This file says what I want next, then says plainly what happened and what I've done since.

## What I'm looking for

- Staff Data Engineer, individual contributor, on a lakehouse or streaming data platform. I was a Senior Data Engineer for 4 years. I want the next role to own platform-level decisions, not one pipeline at a time. A Senior title at a larger company works if the scope is platform-wide and the pay clears my floor below.
- About 10 years in data: 3 years as a data analyst and BI developer, then 6 and a half as a data engineer (August 2019 to March 2026), the last 4 as senior.
- Location: Chicago. Remote within the US is my first choice. Hybrid in Chicago works, up to 3 days a week. I'm not relocating.
- Compensation: my last pay was $178K base, a 10% target bonus, and stock options in a private company that I value at zero. For Staff I'm looking for $200K–$230K base and $270K–$340K total compensation, depending on how much of the equity is liquid. For a Senior title my base floor is $185K.
- The gap hasn't changed my floor. It changes my timeline, not my level.
- Start date: I'm available now and can start two weeks after an offer.

## The gap, plainly

- On March 3, 2026, Pennacott Home cut about 22% of the company, roughly 140 of 640 people, in one reduction. It was a cost decision, not a performance one. Half of the data platform team went, me included.
- The company paid the 60-day notice period and asked me to work the first three weeks of it to hand over my systems. My last working day was March 24. I ran that handover: `Projects/Three Week Handover.md`.
- April: four weeks off, on purpose. Paperwork, rest, and helping my father move into a smaller apartment.
- May to now: I built a pipeline on a city's open transit feed, alone and end to end, and I still run it: `Projects/Open Transit Feed Pipeline.md`.
- August 17 to September 18: one paid 5-week contract for a 40-person regional food distributor (name under NDA). I moved their 31 nightly reports off a single cron server onto Airflow and dbt.
- September and October: I worked through Flink's DataStream and SQL APIs on toy jobs. I can discuss Flink. I won't claim it.
- I applied to 26 roles in May and June with my old resume and got 3 recruiter screens and no onsites. I stopped, rewrote how I describe my work (these files), and started again in October.

## Where I have real depth

The tools, and how far into each one I actually went:

- Spark: batch jobs in PySpark and Spark SQL on EMR, and Structured Streaming with `foreachBatch` writing to Iceberg. I tune from the Spark UI: shuffle partitions, adaptive query execution, skewed joins (I salted the two hot keys in our orders data), spill. I haven't written Scala in production and I've never run Spark on Kubernetes at scale.
- Iceberg and Trino: I designed the table layouts for our lakehouse (partition specs, sort orders, partition evolution) and ran the maintenance: compaction, snapshot expiry, orphan-file cleanup. I know copy-on-write from merge-on-read because I picked the wrong one once. Trino I used and tuned as a consumer; the platform team ran the cluster.
- dbt Core (not dbt Cloud): about 1,050 models. Incremental models with the merge strategy, snapshots for slowly changing dimensions, custom generic tests, macros, slim CI with `state:modified+`. I haven't used the semantic layer.
- Airflow: 2.x on Kubernetes, 236 DAGs at the peak. Pools, deferrable sensors, dataset-driven scheduling, a DAG lint test in CI, the 1.10 → 2.2 upgrade and the smaller ones after it up to 2.8. Airflow 3 only on my personal project.
- Kafka: the producer, consumer and schema side, on a managed cluster (MSK). Topic and key design, consumer lag, Schema Registry compatibility modes, Debezium CDC from a Postgres outbox. I've never operated brokers.
- SQL is my strongest language. Python is solid. Scala I can read.
- Shallow, so nobody has to find out the hard way: Flink (toy jobs), Kafka Streams (never), Databricks (never at work), low-latency serving stores.

## Search constraints — please respect these

- Individual contributor only. I've led projects and mentored two engineers, and I don't want to manage people. A "lead" role that is half people management is a no.
- Data engineering, not dashboard building. I did BI work for three years and it was good training. A "data engineer" role that is mostly report requests is a step back.
- Full-time W-2 only, with benefits. The summer contract was a bridge, not a direction.
- No seed or Series A startups. I want a business that already earns its revenue. Right after a layoff, I don't want runway risk on top.
- No sports betting or gambling companies. It's a personal line, not a judgment of the people who work there.
- On-call is fine in a rotation of at least 5 people. I've carried a pager for data pipelines since 2020.

## How I work

- I run old and new side by side and compare the numbers before any cutover. Every migration I've led had a parallel run with a written pass condition.
- I write while the work is happening: design docs, runbooks, short decision notes. The handover worked because most of the writing already existed.
- I define every metric before I report it, including what it doesn't count.
- I like working with analysts and finance people. Most of the data bugs I've found were found with someone who knew what the number should be.

## Visa / Work Authorization

- Citizenship: United States
- US work authorization: unrestricted (citizen; no sponsorship required)
- No visa constraints for any US employer or location

## Clarifications

*(Questions Jobbee asked when two facts in my files pulled against each other. Log format: question, answer, newest last.)*

**Q:** Your constraints say full-time W-2 only, but your resume lists a 5-week contract in August and September 2026. Should contract or contract-to-hire roles be in your search?
**A:** No. The contract was a bridge I took on purpose: short, fixed scope, and it kept me working in a real company's Airflow and dbt while I searched. For my next role I want full-time W-2 with benefits from the first day. I'm on COBRA now, and contract-to-hire usually means another three to six months without employer health coverage and with an end date I don't control. Keep contract roles out of the search.
