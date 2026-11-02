<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Release queue service

Fernbrook Systems, release tooling. March to April 2025: about 7 weeks at roughly 2 days a week, while I was leading 12 engineers. On my resume it's half a line ("wrote the release-tooling queue service (Go) that now handles ~2,400 deploys/week"). It's here because Staff loops ask what I've built with my own hands lately, and this is the answer.

## The problem

Deploys to our 4 shared pre-production lanes and production were serialized by a lock: a CI job wrote a lock file to object storage and deleted it when done. In February 2025, at about 1,600 deploys a week:

- A crashed job kept the lock until a 30-minute timeout. About 9 times a week someone deleted a stuck lock by hand.
- Nobody could see the queue, so people re-ran pipelines to "get back in line": about 120 duplicate deploys a week.
- Hotfixes waited behind routine deploys.
- Production-lane wait p90 was 34 minutes during business hours, measured from CI logs.

## Options

- **The CI system's built-in concurrency groups.** They queue or cancel within one pipeline, with no priority lane and no view across repos. Rejected.
- **A Redis lock.** One more stateful system for a 4-person team to run. Rejected.
- **Chosen: a small Go service on the platform's existing Postgres,** which already had backups and on-call. At about one enqueue every 2 minutes, load was never the question.

## The design

- One queue per lane. Workers claim the next entry with `SELECT ... FOR UPDATE SKIP LOCKED`.
- Leases instead of locks. The holder heartbeats every 15 seconds; a lease with no heartbeat for 60 seconds expires, so a crashed deploy frees the lane within a minute.
- A hotfix lane that jumps the queue. It requires an incident ID, and only one hotfix can be ahead at a time.
- Deduplication by service and commit: a re-run replaces its queued entry instead of adding another.
- An API (enqueue, heartbeat, release, status), a CLI, and a status page showing every lane's queue.
- About 1,900 lines of Go with tests. One release-tooling engineer reviewed every PR; she co-maintains it now.

## Results

Eight weeks after launch (May to June 2025) against February:

- Production-lane wait p90: 34 → 6 minutes.
- Stuck locks cleared by hand: about 9 a week → 0.
- Duplicate deploys: about 120 a week → almost none.

It now handles about 2,400 deploys a week. I still ship changes to it; the most recent fixed a lease-expiry metric.

## What went wrong

- **Day 3: one team starved everyone.** A deploy bot for a monorepo enqueued 40 deploys at once and held the staging lane for 50 minutes. Strict first-in, first-out was fair per deploy and unfair per team. Fix: round-robin between teams within a lane.
- **No runbook at launch.** The release-tooling on-call paged me directly twice in week 1 because I was the only one who knew the service. I wrote the runbook that week and made their on-call primary, with me as secondary.

## What I'd do differently

Simulate bursty enqueues before launch; the bot burst was predictable from CI history. And ship the runbook with the service, which is advice I've given other teams for years.
