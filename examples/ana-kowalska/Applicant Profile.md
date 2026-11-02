<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Ana Kowalska

Facts about my search that the settings fields can't hold. I've built Android apps for about 8 years, and I judge my own work by the numbers the store shows: crash-free users, ANR rate, cold-start time and store rating. My Base Resume says how I define each one.

## What I'm looking for

- Senior or Staff Android Engineer, individual contributor, native Android (Kotlin, Jetpack Compose). I'm aiming for Staff. At Migiem the IC ladder stops at Senior, and for two years I've done work that spans both of our apps (vitals, the release process, the Android guild) under a Senior title.
- About 8 years of Android: 2 years 9 months at a Warsaw software house, then 5 years 7 months at Migiem, a Polish grocery and meal delivery app. Customer app: about 1.5M monthly active Android users. Courier app: about 9,000 couriers a month, on their own phones.
- Location: Warsaw. First choice is remote within the EU, working from Warsaw (CET), for an EU product company. Second choice is relocating to Berlin or Amsterdam for the right role. No other cities. For remote roles I'm happy to travel to an EU office up to twice a month.
- Current pay: employment contract, 24,000 PLN gross a month (about €67,000 a year at 4.3 PLN to the euro), plus a bonus target of 8%. No equity.
- Target, base salary in EUR: Senior €85,000–€100,000, Staff €100,000–€125,000. Equity is welcome, but I count it as zero when I check an offer against my floor.
- My floor depends on the contract type, because in Poland the same number means different things:
  - Relocating, local employment contract: €85,000 in Berlin, €90,000 in Amsterdam (the Dutch 8% holiday allowance on top).
  - Remote from Warsaw on an employment contract (umowa o pracę), through a Polish entity or an employer of record: €78,000 gross a year, about 28,000 PLN a month.
  - Remote from Warsaw on a B2B contract, where I invoice as a sole trader: €95,000 a year, or €90,000 if the contract pays for 24 days off. On B2B I pay my own social security and health contributions, I get no paid leave or sick pay unless the contract says so, and a 1-month termination clause usually replaces the 3-month notice. About 20% more is what it takes to come out even.
  - I prefer an employment contract. B2B at the floor is fine.
- Notice period: 3 months. That's the statutory notice in Poland after 3 years with one employer, and it's common here, so please don't read it as a negotiating position. It ends on the last day of a month: if I resign in December 2026, my last day is 31 March 2027, so my earliest start is April 2027. Migiem can agree to shorten it, but I won't promise that.

## Where I have real depth

- Android vitals as product metrics. I led the program that took Migiem's customer app from above Google Play's ANR bad-behavior threshold (0.58% against 0.47%) to 0.19%, and crash-free users from 98.4% to 99.6%. I read ANR traces, and I rank problems by users affected, not by event count.
- App startup. Macrobenchmark, Baseline Profiles, deferred SDK initialization, time to initial display vs time to full display. I cut median cold start from 2.7s to 1.3s on a customer app that runs on a lot of 3 GB phones.
- Compose in a large View codebase. I proposed and drove Migiem's screen-by-screen migration: 91 of 104 screens over 27 months, with no big-bang rewrite and no feature freeze.
- Offline-first work on bad networks. A Room outbox, WorkManager, idempotency keys, device clocks that lie, and phone makers' battery savers that delay background work.
- Releases and the store. Staged rollouts with written gates, halts, hotfixes, review replies, and In-App Review timing within Google's guidelines. I've been the release captain on a bad release, and I rebuilt the process after it.

## Search constraints — please respect these

- IC roles only. No Engineering Manager, no Mobile Lead with reports, no Head of Mobile. Migiem offered me the Android Lead role (7 reports) in 2025 and I said no.
- Native Android only. No Flutter-only or React Native-only roles: my depth is in platform behavior (startup, ANRs, background work), and those frameworks put a layer over it. Kotlin Multiplatform for shared logic is fine.
- Product companies with their own app in the store. No software houses and no outsourcing placements at a client. I spent nearly 3 years handing apps over when a contract ended, and the numbers I care about take years of ownership.
- An Android team of at least 3 engineers. As the only Android engineer, "Staff" means doing everything alone, and I want peers who review my code.
- No gambling or betting apps, and no high-interest consumer lending. That's a personal line.
- EU roles only, CET plus or minus 1 hour for remote. No US roles, and no role that needs more than 2 hours a day of overlap with US time zones.

## How I work

- Before I write code, I pick the metric, its source and its window, and I write them down. Example: we take the ANR rate from Play Console, not Crashlytics, because Crashlytics only sees ANRs on Android 11 and up.
- Everything ships through a staged rollout with written gates. I'd rather halt a rollout at 1% than hotfix at 100%.
- Short design docs and small PRs. The runbook ships with the feature.
- I go and watch the people who use the thing. For the courier app, that meant three shifts riding along with couriers.
- I've mentored 3 engineers (two of them promoted from junior to mid-level), and I've run the Android guild across both apps since 2023.

## Visa / Work Authorization

- Citizenship: Poland (EU citizen)
- EU work authorization: unrestricted. I can live and work in any EU member state without a permit, including Germany and the Netherlands
- US work authorization: none. I'm not looking at US roles and not seeking sponsorship
- No sponsorship needed for any role in the EU

## Clarifications

*(Questions Jobbee asked when two facts in my files pulled against each other. Log format: question, answer, newest last.)*

**Q:** You target Staff roles, and you also give a floor for Senior roles (€85,000 in Berlin). Should a Senior role at €85,000 count as a full match, or only as a fallback behind Staff roles?
**A:** It depends on what sits above the title. A Senior role at a company with a real Staff IC track (a published ladder, and at least one Staff mobile engineer there today) is a full match at the floor, because it's a path. A Senior role where Senior is the top IC level is a fallback at most, and only from €95,000, because that's the situation I'm leaving: at Migiem the only step after Senior is managing, and I said no to it. A "Staff" title at a small company that would make me the only Android engineer still fails my team-size filter.
