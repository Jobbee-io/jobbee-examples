<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Offline sync for couriers: eight weeks from requirements to production

Migiem, courier app, 3 February to 28 March 2025. A normal feature, and one bullet on my resume.

## The problem

About 9,000 couriers a month use the app on their own phones, mostly with 3 or 4 GB of RAM and Android 9 to 13. They tap "picked up", then "delivered", and take a proof-of-delivery photo for doorstep drops. Every step needed the network, and Warsaw's apartment blocks are full of stairwells, basements and garages with no signal. The button spun and failed, so couriers retried, called dispatch or confirmed later from the street. The customer still saw "on the way" and contacted support, and the next order waited.

Baseline, 4 weeks of January 2025: 3.9% of deliveries had a status lag (the "delivered" status reached our server more than 10 minutes after the courier's GPS put them at the address), and dispatch logged about 280 calls a week tagged "app won't confirm delivery".

## My role

I owned the Android side end to end, from requirements to the numbers afterwards. Paweł D., the courier-ops lead, owned what dispatch needed to see. Igor N., a backend engineer, made the status endpoint safe to call twice. Ola W. designed the offline states. The ops tools team changed the web dispatch board. The courier app's other two Android engineers reviewed my code.

## How it went

- Week 1: three evening ride-alongs, then requirements with Paweł and our PM. Every action works offline and is confirmed on the phone at once. Dispatch can tell "confirmed" from "done on the phone, not synced yet". No proof photo is lost. No event is applied twice. Written rules, not timing, settle conflicts between phone and server.
- Week 2: design doc and API contract with Igor.
- Weeks 3–5: build. Each action goes into a Room outbox table first, with an ID generated on the phone that the server uses to recognize a repeat. WorkManager sends the queue when the network returns. Photos follow their status event in a separate queue.
- Week 6 (10–16 March): pilot with 40 couriers in Warsaw.
- Weeks 7–8: 10% on 18 March, 50% on 24 March, 100% on 28 March.

The conflict rules took the most talking, and Paweł signed off on both before I wrote them. A cancellation from the server beats a "picked up" from the phone. A "delivered" from the phone beats a later "reassigned" from the server if it happened earlier.

## The numbers

April and May 2025, against the January baseline:

- Status lag over 10 minutes: 3.9% to 0.5% of deliveries.
- "App won't confirm delivery" calls: about 280 a week to about 35.
- About 1,900 repeated events a week turned away by the event ID; none applied twice.
- 12 proof photos lost in 8 weeks, all on phones that were reset or had the app removed before syncing. No "before" number: failed uploads weren't tracked.
- Crash-free users on the courier app stayed at 99.4% or higher through the rollout.
- The courier app's store rating went from 3.6 to 3.9 in Q2 2025. Per-delivery pay changed in the same quarter, so I don't claim it.

## What went wrong

- I assumed phone clocks were right. 3 of the 40 pilot phones were off by minutes to hours, because couriers had set the time by hand, and their events arrived out of order. Events now carry the time since boot plus the gap between phone and server time, measured at the last successful sync. Time since boot resets on a reboot, so events also carry a boot count, and events from before a reboot fall back to the phone clock with a flag.
- Pilot photos were stored at full size, 4 to 12 MB each, and two couriers' 16 GB phones ran out of storage. Photos are now compressed to under 400 KB when they're taken.
- Dispatchers read "pending sync" as couriers confirming deliveries before arriving: two days of friction until a one-page explainer and a legend on the board. Dispatch belonged in the requirements in week 1, not the pilot in week 6.
- On phones from three manufacturers, battery savers delayed WorkManager by 15 minutes or more after the signal came back. We added two triggers: connectivity returning while the app is open, and the courier opening their next order. Found in the pilot, not in the design.
- We tested on our own phones. Five used phones of the most common courier models, bought after the pilot, belonged in week 1.
