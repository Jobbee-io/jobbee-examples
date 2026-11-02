<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Incident command during a cloud-region outage

Larkspan Software, Tuesday 14 October 2025, 11:52 IST to 00:40 IST: 12 hours 48 minutes. One bullet on my resume. Times are IST; US Eastern was 9.5 hours behind.

Our cloud provider's primary US East region began returning errors from object storage and its message queue. Our database and compute there stayed healthy, so only invoice ingestion broke (uploaded files go to storage, and a queue feeds the workers that read them). Approvals, payments and search kept working.

I was the incident commander for the Pune layer: in command 12:06–20:15, then deputy to Greg H., the US SRE lead, for the failback. Shruti P. led operations and Aditya K. moved the workers; I didn't type the failover commands. I made the calls, kept the timeline, ran customer communication with Neha D., our support lead, and wrote the postmortem.

## Timeline and decisions

- 11:52 (02:22 Eastern). Upload errors and queue-consumer errors.
- 12:06. SEV-1, with three roles: operations (Shruti), communications (Neha), command (me).
- 12:12. Our dashboards showed the provider's storage and queue failing in all three of our zones in the region.
- 12:31. First public status update. 12:40. The provider's status page acknowledged the errors.
- 12:52. Decision: move ingestion only (upload API, storage, queue, workers) to US West, and keep the database primary in East. Writes from West to the East database cost about 65 ms each, fine for ingestion. A full region failover would have lost a few seconds of invoice and approval data and needed a day to fail back, for a database that wasn't broken. Waiting had no end date anyone could give us.
- 13:31. Ingestion running in West; upload success back above 99%.
- 13:45. A legacy email-ingest hostname had a 3,600-second DNS TTL instead of 60, so email-forwarded invoices kept reaching East for up to an hour.
- 18:40 (09:10 Eastern). The provider reported recovery; our own checks agreed by 19:05.
- 19:30. The normal handoff time. Our rule keeps an active SEV-1 with its commander until it's stable and the handoff is written (`Follow The Sun On Call.md`). There was no failback plan yet, so I kept command.
- 20:15 (10:45 Eastern). Written handoff to Greg: state, open risks, the failback plan, who was on what.
- 22:30–00:40. Failback to East, and a drain of 212,000 documents stuck in the East queue since the morning.

## The numbers

- Failing uploads for 1 hour 39 minutes, peak 39%. Decision to ingestion running in West: 39 minutes.
- About 300 customers' email-forwarded invoices delayed by up to 2 hours 10 minutes, none lost.
- No data lost, no duplicate payments. 1,870 duplicate invoices across 64 customers, all voided within 2 business days.
- Postmortem: 11 action items, 9 done by January 2026 and the last 2 by April 2026.

## What went wrong

- I waited 40 minutes for the provider's status page when our own data had the answer at 12:12. Waiting made the decision later, not safer. The runbook now says: decide by minute 15 from our own telemetry.
- The first update took 39 minutes. US support owns the status page in the US daytime; at noon in Pune nobody did, and Neha was on a customer call when I paged her. Communications is now a named role on the commander rotation, filled in the first 5 minutes, with prepared templates.
- The 3,600-second TTL dated from 2020 and was missed when every other public hostname went to 60 seconds. A DNS audit afterwards found 4 more.
- The duplicate invoices were mine. That morning customers had re-uploaded failed files, which went to West, and my drain of the East queue didn't check for them. Our duplicate check flags matching invoices for review, so nothing was paid twice, but 1,870 landed in approval queues and customer success spent two days on calls. Replays now skip any file whose content hash already exists. And before any replay I ask what customers did while we were down: they re-upload, retry and forward by email.

## What I'd keep

Moving only the broken part. A full failover would have turned a 1 hour 39 minute ingestion problem into a day of database work. A quarterly game day now moves ingestion to West on purpose; in July 2026 it took 11 minutes.
