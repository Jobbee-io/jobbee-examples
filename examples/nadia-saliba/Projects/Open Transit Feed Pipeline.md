<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Open transit feed pipeline

Personal project, May 2026 to now, built during the gap after my layoff, alone and on my own money. In my base resume it sits under the career break. The data is a mid-sized US city's open transit feed. I don't name the city, because the project is about the pipeline, not about grading anyone's buses. The code is at github.com/example/nadiasaliba-transit (poller, dbt models, Airflow DAGs).

## The full story

I was laid off in March 2026 and took April off on purpose. In May I started this, alone and on my own money. My work code had stayed with my employer, and I wanted something I could show. I also wanted a source I can't talk to. At Pennacott I could always sit with the team that produced the data. Here nobody answers.

The poller started on June 8, 2026. It saves every raw response unchanged, and that choice is what let me fix my first mistake. For the first 3 weeks I counted stale snapshots as real data, which made bunching look worse by about 1.5 percentage points. When I caught it, I added the header-timestamp check, rebuilt everything from the raw files, and restated the numbers in the weekly summary with a note.

In mid-July the static feed changed its trip IDs, and my joins broke for a day. Only then did I start storing each schedule version and joining on the one active that day. In August the VM's disk filled with logs, and the poller stopped for 31 hours. I found out the next morning. Log rotation and an alert for missing files came after.

Every part of it is mine: the poller, the tables, the dbt models, the Airflow 3 DAGs, and the mistakes. Nobody reviews it, which is why the weekly summary says what changed and why.

By October 31 it had 146 days of data, about 147M vehicle positions and 98.9% of expected polls usable, for about $16 a month. On the 10 most frequent routes, 7.8% of scheduled headways had a bunching event, worst between 3 and 6 p.m.

It's still running, and two things are open. The feed can still change without notice, and my checks find a change after it lands, not before. And the poller is one process on one small VM. The alert makes an outage shorter, but a missed poll is data I can't get back.

## Why I built it

My work code stayed with my employer, and I wanted to keep my hands on the tools in a way I can show. I also wanted a data source I can't talk to. At Pennacott I could sit with the team that produced the data. A public feed changes without notice, and nobody answers email about it: a fair test of data contracts when the other side never signs.

The question it answers: how often do buses on frequent routes bunch, meaning two buses on the same route arrive within 2 minutes of each other when they're scheduled 10 or more minutes apart? And how does schedule adherence vary by route and hour?

## What it is

- The feed: GTFS static (the published schedule, updated about monthly) and GTFS-realtime (vehicle positions and trip updates, protobuf, refreshed about every 30 seconds).
- A Python poller on a small cloud VM fetches the realtime feed every 30 seconds and writes each raw response, unchanged, to object storage. Raw files are never edited, so I can always rebuild everything from them.
- Every 5 minutes a job decodes the new files and appends them to Iceberg tables with PyIceberg. Each version of the static schedule is stored with its start date.
- dbt with DuckDB builds the models: positions matched to scheduled trips, arrivals at stops, headways, bunching events, on-time performance.
- Airflow 3 runs it, on purpose: I wanted to learn what changed since 2.8, like asset-based scheduling and the new UI. For a one-person project, cron would have been enough.
- No Kafka. Polling every 30 seconds into files doesn't need it.

## The decisions that took real thought

- Stale snapshots. The feed has a header timestamp, and sometimes it serves the same snapshot for 10 to 40 minutes. I drop any poll whose header timestamp hasn't moved and count those minutes as feed outages, not as buses standing still.
- Service days. GTFS schedules allow times past midnight, like 25:10:00, which belong to the previous service day. Joining late-night realtime data to the schedule needs the service date, not the calendar date.
- Schedule versions. Every model joins on the schedule version that was active on that service date. I learned this one the hard way (below).

## The numbers

- Polling since June 8, 2026: 146 days of data through October 31.
- About 147M vehicle positions: about 6 GB of Parquet in the Iceberg tables, plus about 14 GB of compressed raw responses.
- Usable polls: 98.9% of expected. The losses are my own 31-hour outage (below) and the feed's stale periods.
- Cost: about $16 a month for the VM, storage, and a small Postgres database that holds the Iceberg catalog.
- The finding I trust most: on the 10 most frequent routes, 7.8% of scheduled headways had a bunching event, worst between 3 and 6 p.m.

## What went wrong

- For the first 3 weeks I counted stale snapshots as real data. Buses that looked parked made bunching look worse by about 1.5 percentage points. I fixed the check, rebuilt from the raw files, and put the restated numbers in the project's weekly summary with a note saying what changed. I should have checked the header timestamp from the first poll.
- In August the VM's disk filled with logs I hadn't rotated, and the poller stopped for 31 hours. I found out the next morning. Now there's log rotation and an alert to my phone if no new file lands for 10 minutes. That alert should have existed on day 1, before the first model.
- In mid-July the static feed changed its trip IDs and my joins broke for a day. I had assumed the IDs were stable because they had been for 6 weeks, and I only started versioning the schedule after that break. Assuming stability in a feed you don't control is the mistake I built data contracts at work to prevent.

It's also my only Airflow 3 experience, and I say so.
