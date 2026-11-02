<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Ana Kowalska

ana.kowalska@example.com
github.com/example/anakowalska · linkedin.com/in/example-anakowalska
Warsaw, Poland

*My resume's bigger sibling. The one-page version lists the outcomes; this file keeps the definitions, the windows, the context and the mistakes behind them. The longer stories live in `Projects/`, linked from the bullet they belong to.*

---

## Summary

Android engineer, about 8 years, currently Senior Android Engineer at Migiem, a Polish grocery and meal delivery app. I've worked on both sides of a delivery business: the customer app (about 1.5M monthly active Android users) and the courier app (about 9,000 couriers a month, mostly on low-end phones). My work is measured in the numbers the store shows: crash-free users, ANR rate, cold-start time and store rating. I led the recovery that took our ANR rate from above Google Play's bad-behavior threshold to well under it, cut median cold start in half, drove an incremental Compose migration, and built offline sync for couriers. I was also the release captain on our worst release, and the release process we use today is the one I wrote after it.

---

## How I define the numbers on this page

- **Crash-free users:** the share of users with at least one session in a 7-day window who had no crash, from Firebase Crashlytics. I report the 4-week average of the weekly figure, so one bad day doesn't make the number.
- **User-perceived ANR rate and crash rate:** Google Play Console Android vitals. The share of daily active users who had at least one ANR (or crash) while using the app, as a 28-day average. Google's bad-behavior thresholds are 0.47% for ANRs and 1.09% for crashes.
- **Cold-start time:** our own field trace from process start to the home screen showing real content (`reportFullyDrawn`, time to full display), launcher starts only, p50 and p90 over 28 days. Play's "slow cold start" figure is different: Google measures to the first frame and counts sessions of 5 seconds or more.
- **Store rating:** two numbers, never mixed up. The public rating on the Play listing, which Google weights toward recent ratings, and the average of new ratings received in a rolling 28-day window, from Play Console.

---

## Experience

### Migiem — Senior Android Engineer (Apr 2023 – present), Android Engineer (Apr 2021 – Mar 2023)

Grocery and meal delivery in 14 Polish cities, Warsaw headquarters, about 120 engineers. Two Android apps: the customer app (Android team of 5) and the courier app (Android team of 3). Senior is the top IC level here. I moved from the customer app to the courier app in January 2025.

Courier app, Senior (Jan 2025 – present):
- Built offline-first delivery status sync: deliveries whose status reached us more than 10 minutes late fell from 3.9% to 0.5%. Full notes: `Projects/Courier Offline Sync.md`.
- Ran the vitals playbook from the customer app on the courier app in H1 2026: crash-free users 99.4% → 99.7%, user-perceived ANR rate 0.33% → 0.16%.
- Cut battery use over an 8-hour shift from about 31% to about 19% (median of a scripted shift replay on 6 lab devices) by batching location uploads and lowering location accuracy between orders.

Customer app, Senior (Apr 2023 – Dec 2024):
- Led the crash and ANR recovery: user-perceived ANR rate 0.58% → 0.19% (the threshold is 0.47%), crash-free users 98.4% → 99.6%, and no device models left above Play's per-device threshold. Full notes: `Projects/Crash And Anr Recovery.md`.
- Was the release captain on version 8.12 (March 2024), which logged out about 140,000 users. Shipped the hotfix in 31 hours, then rebuilt the release process and the review-prompt timing. Public rating 4.5 → 4.1 → 4.5 in 14 weeks, and 4.6 since September 2024. Full notes: `Projects/Store Rating Recovery.md`.
- Cut cold start: p50 2.7s → 1.3s, p90 6.2s → 2.9s, Play "slow cold start" sessions 11.6% → 2.4%. Full notes: `Projects/Cold Start Cut.md`.
- Finished the Compose migration (91 of 104 screens by June 2024) and set up 340 screenshot tests.
- Wrote the staged-rollout gates used for both apps since April 2024: 93 releases, 7 halted at 1% or 5%, none past 5% with a blocking bug.
- Mentored 3 engineers, two promoted from junior to mid-level. Ran the Android guild (8 engineers, both apps) every two weeks from 2023. Interviewed about 45 Android candidates.

Customer app, Android Engineer (Apr 2021 – Mar 2023):
- Proposed the incremental Compose migration and built 14 of the first 24 design-system components, with our designer and two teammates. Full notes: `Projects/Incremental Compose Migration.md`.
- Built the Android side of grocery substitutions (when an item is out of stock, the customer picks a replacement or a refund in the app). Orders still waiting on a substitution answer at picking time fell from 31% to 12% in the 3 months after launch (November 2021).

### Mossgate Software — Android Developer (Jan 2020 – Mar 2021), Junior Android Developer (Jul 2018 – Dec 2019)

Warsaw software house, about 70 people, building apps for clients. Summer intern in 2017.

- City parking-payments app for a mid-sized Polish city, about 300,000 installs. Owned the Android releases from October 2019. The contract had a crash-free-users target of 99%; I took it from 97.1% to 99.2% (Crashlytics, 30-day) in 5 months. That was the first time a store metric was my job.
- Claims app for a regional insurer: photo capture of car damage that worked offline, with drafts saved on the device. My first offline-first work.
- Moved a retail loyalty app from Java to Kotlin: about 60% of 85,000 lines over 9 months in 2020, without a feature freeze.

---

## Education

- **MSc Computer Science, Narew University of Technology, 2017–2018.** Thesis: the battery cost of 4 background sync strategies, measured on 6 Android phones.
- **BEng Computer Science, Narew University of Technology, 2013–2017.**

## Skills (honest)

- Strong: Kotlin, coroutines and Flow, Jetpack Compose, Android Views, Room, WorkManager, DataStore, Hilt, Retrofit and OkHttp, Macrobenchmark, Baseline Profiles, Perfetto, Play Console, Crashlytics, Gradle.
- Working: Java (legacy code), RxJava (I maintain it, I don't write new code in it), Kotlin Multiplatform (one evaluation spike, not shipped).
- Not: iOS (I read Swift in reviews of shared logic, nothing more), Flutter or React Native, backend beyond reading the Kotlin services we call.
- Languages: Polish (native), English (C1, my working language for docs and code review), German (A2, learning).

## Numbers I can defend

- ANR rate 0.58% → 0.19%, crash rate 0.94% → 0.31%, crash-free users 98.4% → 99.6% (customer app, July 2023 → January 2024).
- Cold start p50 2.7s → 1.3s, p90 6.2s → 2.9s; slow cold starts 11.6% → 2.4% (June → October 2024).
- Public rating 4.5 → 4.1 → 4.5 after release 8.12; 28-day average of new ratings 4.4 → 3.1 → 4.6 (February → June 2024).
- Deliveries with a status lag over 10 minutes 3.9% → 0.5%; "app won't confirm delivery" calls from couriers about 280 → about 35 a week (January → April–May 2025).
- Compose: 91 of 104 screens, layout XML 41,000 → 7,800 lines, 340 screenshot tests.

## Failures, indexed honestly

- Release 8.12: I approved the step from 20% to 100% after one day. About 140,000 users were logged out. `Projects/Store Rating Recovery.md`.
- The Compose migration caused about half of a cold-start regression (p50 2.1s → 2.7s), because nobody, me included, was watching startup while we migrated. `Projects/Incremental Compose Migration.md`.
- A cart storage migration I wrote emptied about 2,100 users' carts during a 10% rollout. `Projects/Crash And Anr Recovery.md`.
- Deferring SDK startup broke install attribution for 2 days, and marketing found it before I did. `Projects/Cold Start Cut.md`.
- I assumed couriers' phone clocks were right. In the pilot, 3 of 40 weren't. `Projects/Courier Offline Sync.md`.
