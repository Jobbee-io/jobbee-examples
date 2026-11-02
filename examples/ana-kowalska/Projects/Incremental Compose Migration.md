<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Incremental Compose migration

Migiem, customer app, March 2022 to June 2024: 27 months, the longest piece of work I've driven. I proposed it as an Android Engineer and finished it as a Senior. On my resume it's two bullets: the proposal with the first 24 design-system components, and the finish with 91 of 104 screens and 340 screenshot tests.

## Where we started

In early 2022 the customer app had 96 screens (navigation destinations), all built with XML layouts: about 41,000 lines of layout XML and 38 custom views, many of them copies of each other with small differences. Our designer, Marta S., kept finding the same button in four slightly different shades. New screens took long to build, and UI code was where most of our review comments went.

## Options

- A full rewrite in Compose. It was suggested twice, with an estimate of 9 months and feature work frozen. In a delivery business that competes on features every month, that was never going to happen, and it shouldn't have.
- Stay on Views and build a proper View-based design system: merge the 38 custom views into about 20 and clean up styles and themes. About 3 months, the cheapest option. I rejected it because Compose was where Android UI was going, the candidates we interviewed wanted to work in it, and a View design system would have needed its own migration later.
- Compose, with a dedicated migration team of 2 of our 5 engineers for about a year. That's 40% of the team off features, and migrators who don't own the screens they change. Our engineering manager said no, and I agreed with him.
- Compose, migrated through feature work, design system first. Chosen.

Before writing the proposal I spent 2 weeks rebuilding one real screen, order history, in Compose. Two findings from that spike went into the proposal. Compose added about 1.6 MB to the download. And Compose in a debug build is far slower than in a release build: my first demo ran on a debug build, stuttered on a 3 GB phone, and nearly ended the proposal in the room. The release build scrolled at about the same frame rate as the View version.

## My role

I wrote the proposal in March 2022, built 14 of the first 24 design-system components (two teammates built the rest), wrote the migration guide, and reviewed most Compose pull requests in the first year, about 260 of them. I ran a weekly office hour for anyone stuck on interop. The 5 engineers on the customer app migrated screens as part of their feature work. From April 2023, as a Senior, I tracked progress and decided what stayed on Views.

## The plan

1. Design system first (May to August 2022). 24 components in Compose, in their own Gradle module, each also usable inside the old XML screens through a `ComposeView` wrapper. The old screens started to look consistent before a single one was migrated.
2. New screens in Compose only, from September 2022.
3. Existing screens migrated when a feature touched them. The first rule was "touch it, migrate it". From February 2023 it became "migrate when the feature work on that screen is 2 days or more".
4. A written list of screens that stay on Views until there's a reason to move them: the map screen, the checkout steps that wrap our payment provider's views, and settings screens nobody changes.

## Architecture decisions

- Fragments stayed. Every migrated screen is still a Fragment that hosts a `ComposeView`, and navigation stayed on the Navigation component with its XML graph. One engineer argued for moving to Navigation Compose as we went. I said no: deep links, the back stack and our analytics screen names all hung off the navigation graph, and they worked. Changing them would have put risk into every screen migration for no gain a user could see. I'd make the same call again.
- ViewModels didn't change. Each screen's ViewModel already exposed one UI state object, so a migration replaced the layout and the binding code and left the logic alone. That's what made a screen migration a job of days instead of a rewrite.
- Stable UI state. Early on, the cart screen recomposed every row when any one item changed, because its state held a plain `List`, which the Compose compiler treats as unstable. The rule since then: UI state classes use immutable collections, and the Compose compiler's stability report runs in CI and fails on any new unstable class in UI state.
- Screenshot tests from the first component. Every design-system component and every migrated screen got JVM screenshot tests with Paparazzi, in light and dark theme and at two font scales. 340 tests by June 2024, run on every pull request in about 4 minutes.
- One theme generated from tokens, which came later than it should have (below).

## Progress

A screen counts as Compose when it renders entirely in Compose: a Fragment hosting a `ComposeView`, with no XML inflated. A weekly script counted them from the navigation graph.

- December 2022: 19 of 99.
- June 2023: 48 of 101.
- December 2023: 77 of 103.
- June 2024: 91 of 104.

## The numbers

- Screens in Compose: 91 of 104 by June 2024 (the app grew from 96 screens while we migrated). 13 stay on Views: the map, 5 checkout steps and 7 settings screens.
- Layout XML: about 41,000 lines to about 7,800.
- Screenshot tests: 0 to 340, on every pull request.
- Download size: 18.4 MB to 20.7 MB. R8 full mode later took 1.1 MB back (`Cold Start Cut.md`).
- Time to build a standard list-and-detail screen, from first commit to merge: median about 6 developer-days on Views (2021–2022) against about 3.5 on Compose (2023–2024), across 9 comparable screens. Different people built them, and the later ones had a mature design system, so I treat this as direction, not proof.

What it didn't do: it had no measurable effect on crash-free users or on the store rating, and I don't claim it did. Its value was speed and consistency for the team, not a store number.

## What went wrong

- `ComposeView` inside RecyclerView rows. In autumn 2022 we put Compose rows into the grocery list's RecyclerView. With the default composition strategy, each row's composition was thrown away when the row scrolled off and rebuilt when it came back. On a 3 GB phone about 18% of frames were janky while scrolling, against about 5% on the View version (frame timing from a Macrobenchmark scroll test). Changing the strategy so a row kept its composition while it sat in RecyclerView's pool brought it to about 7%. Moving the whole list to `LazyColumn` brought it to about 4%. I should have tested scrolling on a low-end phone before the guide recommended the pattern.
- "Touch it, migrate it" turned 1-day bug fixes into 3-day migrations. After 4 months our product manager pushed back, and she was right. The 2-day rule kept the migration moving without taxing small fixes.
- Two themes by hand for 14 months, the XML theme and the Compose theme. They drifted, and we logged 23 dark-mode color bugs. Generating both from one token file with a Gradle task fixed it in a week, in July 2023. That should have been step 1.
- Nobody watched startup. The home screen moved to Compose in November 2023 without a Baseline Profile, so its code ran interpreted on first launch. Median cold start went from 2.1s to 2.7s by June 2024, with three new SDKs adding to it. I fixed it in the cold-start project, but a nightly startup benchmark from the start would have caught it the week it happened.

## Who disagreed, and how it was settled

- The product manager, on "touch it, migrate it". She was right, and the 2-day rule came from her pushback.
- One engineer, on Navigation Compose (above). Settled by keeping Fragments and writing down why.
- Our growth team, on download size. About 2.3 MB more matters when many users have little free storage. We agreed to accept it and to find the size elsewhere, which R8 full mode later did for half of it.

## What still isn't solved

- 13 screens on Views. The payment provider's views are the reason for 5 of them, and those move when the provider ships Compose components, not before.
- Fragments are still the containers. Moving to Navigation Compose is still open, and it gets more expensive the longer it waits.
- Compose upgrades cost about 2 days a quarter, mostly screenshot-test churn from small rendering changes.
- The Baseline Profile has to stay in the build. The cold-start project added the CI check that guards it.

## What I'd do differently

Generate the theme from tokens in week 1, test every recommended pattern on a 3 GB phone before it goes into the guide, and put startup and scrolling benchmarks in CI before migrating the first screen.
