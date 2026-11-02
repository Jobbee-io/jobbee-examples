<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# AngularJS to React, one screen at a time

Crewloft, frontend team, August 2016 to March 2019. One bullet on my resume.

## What it was and why

Crewloft sells scheduling and dispatch software to trade contractors: HVAC, plumbing, electrical. Its main screen is the dispatch board, where an office dispatcher drags jobs onto technicians' days. In 2013 I was one of three engineers who built that board as an AngularJS single-page app, and I wrote the drag-and-drop schedule grid. So I was migrating off code I had written myself.

By 2016 the app had 214 AngularJS directives and components and 58 routes. Larger customers had 150 to 200 technicians on one board, and the board view carried about 2,000 watchers. Every drag ran a full digest cycle. In our performance harness, a drag on a 200-technician board took 2.8 seconds to re-render. Dispatchers at our biggest customers worked around it by splitting their crews across browser tabs.

Angular 2 was about to ship as a different framework, and AngularJS was headed for maintenance only. We had a performance problem now and a dead end later.

## The decision

I wrote the decision doc in July 2016 with three options: stay on AngularJS and optimize the board, move to Angular 2 through its upgrade module, or move to React with Redux. We spent two weeks on a branch with the upgrade module. It worked, but it meant running both frameworks' change detection for the whole migration, and the board was exactly where we couldn't afford that. React won because a React component could live inside an AngularJS directive through a thin bridge, so we could replace one piece at a time and still ship every week.

## My role

I co-led it with Gus H., the frontend tech lead. Gus owned the build: the move from Grunt to webpack and the test setup. I owned the bridge, the migration order, the board rewrite and a weekly migration report. Six frontend engineers did the work, the two of us included. Product kept shipping features the whole time.

## How it went

- The bridge. The version that lasted was 80 lines: an AngularJS directive that mounted a React root on its element, watched a declared list of inputs, re-rendered with them as plain props, and passed callbacks back through `$apply`. The first version was too clever. It tried to hand AngularJS scopes to React automatically and broke in ways nobody could debug.
- Leaves first. Small components with no shared state (job cards, technician badges, the time picker) moved first, to prove the bridge and the build.
- Then the board, in 2017, because that was the pain. The React board with Redux re-rendered only the rows that changed.
- Then the forms, through most of 2018. The AngularJS forms leaned on 31 custom validation directives, and each one carried business rules that weren't written down anywhere else.
- The router last, in January 2019. AngularJS left the bundle in March 2019.

## The numbers

- Board re-render on drag, 200 technicians: 2.8s to 0.35s, in our performance harness, on a profile matched to a mid-range 2016 laptop.
- JavaScript bundle: 2.1MB to 1.2MB minified.
- 41 customer-facing features shipped during the migration, with no feature freeze.
- 214 AngularJS directives and components down to zero, almost three years before AngularJS long-term support ended in December 2021.

## What went wrong

- Two owners for one piece of state. For several months the selected day on the board lived in both an AngularJS service and the Redux store, kept in sync by the bridge. In November 2017 a sync bug sent 14 jobs to the wrong day for 3 customers before a dispatcher noticed, and 14 technicians drove to the wrong job. After that we had a rule: every piece of state has one owner, and the other framework only reads it.
- The estimate. I said 12 months, and it took 31. The forms alone took 9 months, because I had ordered the work by visibility and left the parts with hidden business rules for last. Today I'd inventory the hidden rules first and order the work by risk.
- The weekly report counted components converted. That number climbed fast and said nothing about risk. By mid-2017 we were "60% done" with most of the hard work still ahead. I switched the report to risk retired: the board, the forms and the router, each with its own status. I'd report risk retired from day one.
