<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Crash and ANR recovery on the customer app

Migiem, customer app, August 2023 to January 2024. The first program I started as a Senior, and the work I'd expect a Staff interview to spend the most time on. On my resume it's one bullet with three numbers.

## Where we were in July 2023

- User-perceived ANR rate (Play Console, 28-day average): 0.58%. Google's bad-behavior threshold is 0.47%. Above it, Play can show the app less in search and recommendations.
- User-perceived crash rate (Play Console, 28-day average): 0.94%, under the 1.09% threshold but close.
- Two low-end device models above Play's 8% per-device threshold, where Play can also show users of those phones a warning on the store listing.
- Crash-free users (Crashlytics, 4-week average of the 7-day figure): 98.4% at the end of July.

About 30% of our users were on Android 8 to 10, and many on phones with 2 or 3 GB of RAM.

## The case

Nobody had asked for a project. I wrote a one-page case to our engineering manager, Tomasz W.: the threshold, what it could do to our store traffic, and a plan for one quarter. The traffic argument was short. About 38% of our new installs came from Play search and browsing. If being above the threshold cut that visibility by even a tenth, we'd lose about 4% of new installs every month, more than a typical marketing experiment moved. I asked for two engineers at half time for August to October and got them. I kept going part-time until January.

## My role

I owned the program: the triage method, the metric definitions, the weekly report and the release gates. I fixed the two biggest ANR causes myself (the shared-preferences writes and the menu parsing). The other two engineers took the crash clusters. Our QA lead, Kasia L., set up a lab of three low-end phones (2 GB and 3 GB of RAM) that we tested every fix on.

## How we triaged

A small script pulled Play Console's ANR and crash clusters and Crashlytics' crash issues every morning into one table, keyed by cluster, with the number of distinct users affected per day. We ranked by that number and nothing else, after a bad first three weeks (below). Each cluster in the top 10 had one owner and a status in the weekly report.

Two rules about sources, written down in week 3:

- ANRs come from Play Console. Crashlytics reports ANRs only on Android 11 and up, so it couldn't see about 30% of our users.
- Crashes come from Crashlytics, which has better stack traces and our own custom keys. Play's crash rate is the number Google judges us on, so the report shows both and says which number came from where.

## What we found, and what we did

Five causes covered most of it.

1. 41% of ANRs: `SharedPreferences.apply()`. The main-thread stack in almost every one of these traces ended in `QueuedWork.waitToFinish`, called from `handleStopActivity`: when an activity stops, Android waits for pending preference writes to reach disk. We had 11 preference files, and one held a 400 KB JSON copy of the cart that was rewritten on every cart change. On a cheap phone's storage, that write could take seconds.
   The options were a stopgap, writing the cart with `commit()` on a background thread so the main thread never waits for it (about 2 days), or moving the cart to Room (about 3 weeks). I did both, in that order. The stopgap shipped in early September and did most of the work of getting us under the threshold. The Room move followed in November, because the stopgap still rewrote 400 KB on every tap, and two writers could still overwrite each other. The other settings moved to DataStore in December.
2. 17% of ANRs: a third-party SDK that did disk work on the main thread while it initialized in `Application.onCreate`. When a push notification started the process, its broadcast receiver timed out waiting behind that SDK. It wasn't our code. I sent the vendor traces from our three lab phones, and their next release, 5 weeks later, moved that work off the main thread. Until then we lived with it.
3. 12% of ANRs: the restaurant menu JSON (2–4 MB for big restaurants), parsed on the main thread when the screen opened. I asked the menu team to split the response by category. They had a rewrite of the menu service planned for 2024 and didn't want to change the old one, which was fair. So I moved parsing to a background dispatcher and cached the parsed copy.
4. The top crash: out-of-memory errors on 2 GB and 3 GB phones from full-size product photos in the grocery grid. Fixed by decoding images at the size they're shown and capping the image memory cache on low-RAM phones. This one was behind both device models above the 8% threshold.
5. Two smaller crashes: a fragment transaction committed after the state was saved, from a payment callback in checkout; and a native crash in the 3-D Secure screen on Android 8 phones with an old WebView. On those phones that step now opens in a Custom Tab.

## The release gates

Part of the program was a gate on every staged rollout. At each step, the new version's crash-free users and ANR rate could be no worse than the previous version's by more than a set margin, or the rollout stopped. The gates halted 2 releases in the following months. They also had a blind spot I didn't see until March 2024: they only watched crashes and ANRs, and release 8.12 logged out about 140,000 users without crashing once (`Store Rating Recovery.md`).

## Timeline and turning points

- August 2023, weeks 1–3: we ranked by event count and spent a week on the wrong crash.
- Week 3: we switched to users affected and found the Crashlytics blind spot. The cart ANR went from fourth place to first.
- Early September: the stopgap for the cart write.
- 19 September: the 28-day ANR rate went under 0.47%, 7 weeks in.
- September and October: the menu parsing fix and the out-of-memory fix. Both device models came under 8% in October.
- End of October: the two engineers went back to feature work. I continued part-time.
- November: the cart move to Room, and the migration bug below.
- December: DataStore for the remaining settings, the vendor's SDK fix, and the Custom Tab change.
- January 2024: ANR rate 0.19%, crash-free users 99.6%.

## The numbers

- User-perceived ANR rate (Play Console, 28-day average): 0.58% in July 2023 to 0.19% in January 2024.
- User-perceived crash rate (Play Console, 28-day average): 0.94% to 0.31%.
- Crash-free users (Crashlytics, 4-week average of the 7-day figure): 98.4% to 99.6%. It stayed between 99.5% and 99.7% through 2024.
- Device models above Play's 8% per-device threshold: 2 to 0.

What I don't claim: an effect on store traffic. Installs from Play search rose in the last quarter of 2023, but marketing ran a campaign in the same quarter, and I can't separate the two.

## What went wrong

- For the first three weeks I ranked crash clusters by event count. One crash loop on about 400 phones produced more events than anything else, so we spent a week on it while the out-of-memory crash, which hit far more people, waited. Since then I rank by users affected and nothing else.
- I trusted Crashlytics for ANRs at the start. Because it can't see Android 8 to 10, the cart ANR looked smaller than it was.
- The cart migration. The Room move ran at the first start after the update: copy the cart out of the old preferences file, write it to Room, delete the file. The copy ran in a coroutine, and the delete didn't wait for it, so anyone with items in the cart when they updated could lose them. About 2,100 users lost their cart in the first 48 hours of a 10% rollout. Support tickets about empty carts came in on the first day, and we halted at 10%. The cart lived only on the phone, so we couldn't restore anyone's. The fix: copy, check that Room holds the same number of items, then delete, with a flag so a half-finished migration resumes on the next start. And a migration test that runs the upgrade with a live cart in the old format. I had tested fresh installs only.

## Who disagreed

- Product, about the time. Two engineers at half time was a real cost to the feature roadmap. The one-quarter limit and the weekly report were the deal, and when the quarter ended the engineers went back.
- The menu team, about splitting the menu response (above). They were right not to change a service they were about to replace; the client-side fix was enough.

## Second-order effects, and what isn't solved

- The playbook moved with me. On the courier app in the first half of 2026, the same triage and gates took crash-free users from 99.4% to 99.7% and the ANR rate from 0.33% to 0.16%.
- The weekly report's habit of naming the source of every number became how our Android guild reports any metric.
- Not solved: ANRs on Android 8 to 10 are still visible only in Play Console, with less detail than Crashlytics gives on newer versions. The cheapest phones still have an ANR rate about 2 to 3 times the app's average. And three lab phones stand in for thousands of models.

## What I'd do differently

- Write down the source and window for every metric on day one, before the first fix.
- Test data migrations as upgrades, with real data in the old format, not as fresh installs.
- Ask for the low-end device lab first. Most of our real problems only showed up on 2 GB and 3 GB phones.
