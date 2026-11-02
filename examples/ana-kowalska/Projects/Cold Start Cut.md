<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Cutting cold start in half

Migiem, customer app, July to October 2024. One bullet on my resume.

## Why it mattered, and why it had got worse

Cold start is the first thing every customer sees, and most of our customers open the app when they're hungry or out of something. Median cold start had been 2.1s in the third quarter of 2023 and was 2.7s by June 2024. About half of that came from the Compose migration: the home screen moved to Compose in November 2023 without a Baseline Profile, so its code ran interpreted on first launch (`Incremental Compose Migration.md`). The rest came from three SDKs added in 2024. Nobody had been watching startup, me included.

## The definitions I agreed with the team first

- Field cold start: our own trace from process start to `reportFullyDrawn`, called when the first page of the home feed is on screen with real content. Launcher starts only, so starts caused by a push notification don't count. p50 and p90 over 28 days.
- Play "slow cold start": the share of daily sessions with a cold start of 5 seconds or more. Google measures to the first frame, not to real content, so it's a different number and I report it separately.
- Lab: Macrobenchmark on a 2021 entry-level phone with 3 GB of RAM, close to our median user's device. Median of 15 runs, time to first frame.

## My role

I owned the project: the measurement, the plan, and most of the changes. One engineer on the team did the dependency-injection changes. Our product analyst set up and read the A/B test.

## Where the time went

On the lab phone, first frame took 1,840 ms. `Application.onCreate` took 690 ms of that, because 14 SDKs initialized there one after another. The Compose home screen without a Baseline Profile cost about 420 ms more. Eagerly built singletons in our dependency graph cost about 180 ms. In the field there was a bigger problem the lab couldn't show: the home feed waited for a remote config fetch over the network before it rendered anything. On a slow connection that alone was 1.5 seconds or more, and it was most of our p90.

## What we changed

1. Generated a Baseline Profile and a startup profile with Macrobenchmark, in CI, for every release branch. About 420 ms off in the lab.
2. Deferred 9 of the 14 SDKs to first use or to after the first frame. The 5 that stayed are the ones that must run before anything else: crash reporting, logging, the dependency-injection graph, the local feature-flag store and the push SDK. `Application.onCreate` went from 690 ms to 140 ms.
3. The home screen renders from the cached feed and the cached config, then refreshes in the background. This is what fixed p90.
4. Made 12 eager dependencies lazy. About 100 ms off.
5. Turned on R8 full mode. Small for startup, but it took 1.1 MB off the download.

## The numbers

- Field, 28 days ending 31 October 2024 against 28 days ending 30 June: p50 2.7s to 1.3s, p90 6.2s to 2.9s.
- Play slow cold start: 11.6% to 2.4% of sessions.
- Lab, time to first frame: 1,840 ms to 790 ms.
- A/B test on the cached-first home screen, September 2024, 3 weeks, 50/50: sessions that ended within 10 seconds of home appearing, without a tap, went from 7.9% to 5.2%. Orders per active user went up 0.6%, but the 95% interval was −0.3% to +1.5%. That's not a result, and I don't claim an order lift.

## What went wrong

- In week 1 I measured on my own phone, a recent flagship. First frame came in around 600 ms and it looked like there was nothing to fix. Our users don't own that phone.
- One deferred SDK was the install-attribution SDK, which needs to see the first app open. For 2 days in August, attribution was lost for about 6% of new installs. Marketing found it, not me. I moved that SDK to the first activity, still off the critical path. I should have asked each SDK's owner what it needs to see at startup before deferring any of them.
- In December 2024 a build-tool upgrade silently stopped packaging the Baseline Profile. For 3 weeks the field p50 crept from 1.3s back to 1.6s, and I only noticed in my monthly look at the dashboard. We added a CI check that the release build contains the profile, and a nightly startup benchmark that fails on a 10% regression.

## What I'd do differently

Put the nightly startup benchmark in place before the Compose migration, not after the cold-start project. The cheapest startup work is the regression you never ship.
