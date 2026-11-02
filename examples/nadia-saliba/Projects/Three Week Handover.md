<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The three-week handover

Pennacott Home, March 3 to March 24, 2026. In my base resume this is one bullet, and it isn't on my one-page resume at all. It's my specific answer to "tell me about the layoff" and "how do you hand over work?".

## What happened

On Tuesday, March 3, 2026, Pennacott cut about 22% of the company, roughly 140 of 640 people, in one reduction. The data platform team went from 6 engineers to 3. My manager's role was cut too, and the 3 who stayed moved under the analytics director. The company paid the 60-day notice period and asked those of us who owned systems to spend the first three weeks of it on handover. I said yes. The pay was the same either way, and I had built about half of what was being handed over.

## What needed handing over

On day 1 I listed what I owned or co-owned:

- the streaming orders pipeline (Debezium, Kafka, Spark, Iceberg);
- 11 scheduled maintenance jobs for the lakehouse: compaction, snapshot expiry, orphan-file cleanup;
- the data contracts CI checks and the dbt test generator;
- about 70 of the team's 236 Airflow DAGs;
- my place in the on-call rotation, which was going from 6 people to 3.

Then I ranked all of it by one question: if nobody touches this for 90 days, what breaks first? That gave me a dated list. The Kafka client certificate for the streaming job expired on June 12. Month-end close ran on March 31 and April 30. The quarterly orphan-file cleanup was next due in April.

## What I did

- Days 1–2: I wrote a 38-page handover document. On day 3 I asked Darnell, who was taking over the streaming pipeline, how far he'd got. Page 5. I stopped writing it.
- Days 3–12: 12 runbooks instead, one or two pages each: what this is, how you know it's broken, the first three things to check, how to roll back. The certificate rotation got its own, with the expiry date at the top.
- 6 recorded walkthroughs, 20 to 40 minutes each, stored next to the runbooks.
- 4 paired on-call shifts where the engineer taking over drove and I only watched.
- A drill. I stopped the streaming job in staging and asked the newest engineer on the team to recover it using only the runbook. It took her 52 minutes. I fixed the 3 steps where she got stuck, and the second run took 14.
- 19 DAGs proposed for retirement, each with no reader in 6 months according to query history. Owners approved 15 and we turned them off: 236 → 221 DAGs for 3 people to carry.
- On day 9 I searched for anything still running under my personal credentials and found 2 scheduled jobs. Both would have failed on March 25, when my access was removed. We moved them to service accounts that day.

## What I missed

- A month-end Airflow pool. Months earlier, during an incident, I had raised the slot count for the finance close pool in the Airflow UI and never put it in code. It wasn't in any runbook. On March 31 the close jobs ran 3 hours late. Darnell texted me and I told him the setting. A 2-minute fix behind a 3-hour delay. I keep a running list of every setting I change by hand now.
- The data contracts program had no one to take it. I documented it, but a document isn't an owner. As far as I know, it's paused.
- The two personal-credential jobs. Finding them was good. Creating them two years earlier wasn't.

## What I know about how it went

Only what former teammates have told me. Darnell told me the certificate runbook was used on June 10, two days before expiry. The streaming pipeline had one incident in April, a connector restart, recovered from the runbook in about 20 minutes. I don't know anything beyond that, and I don't claim to.

Next time I'd write the dated "what breaks first" list on day 1, before any document.
