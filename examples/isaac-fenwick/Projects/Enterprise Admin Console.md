<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Enterprise admin console: change once, apply to many

Rosterwell Enterprise team, February 2024 to June 2025. The resume gives 3 numbers: task times, task success, and how-do-I tickets. This is my main Staff-level case study and the second in my portfolio, so this file holds all of it, including the beta incident I designed my way into.

## What it was, and why

Rosterwell's Enterprise tier serves brands with many locations, from about 15 to about 400, some franchised and some company-owned. The admin console was built in 2019 as a single-location tool with a location switcher. A head-office admin who needed to change a price at 40 locations changed it 40 times. In Q4 2023, 61% of enterprise support tickets were "how do I" or "where is" questions.

## My role

Design lead. I owned the research plan, the interaction model, the benchmark, the design of everything except reporting and exports, and the rollout notes for customer success. Mina, a product designer, owned reporting and exports. Grant was the PM, and 7 engineers built it. Odette, the support lead, coded tickets with me. Tessa, our researcher, reviewed the benchmark protocol.

## Research (February–April 2024)

- We coded 400 enterprise tickets from Q4 2023 into 23 task categories. Five of them made up 58% of the tickets: staff roles across locations, price changes across locations, holiday and schedule templates, exports, and moving members between locations.
- Contextual inquiry with 9 head-office admins at 6 brands: remote screen-shares of their real work, plus two site visits in Orange County.
- The workarounds told the story. Admins renamed locations "SoCal - Irvine" to fake regions. One brand kept a 60-tab spreadsheet of prices per location. Another had an intern who spent two days a week on staff permissions.
- A baseline benchmark in March 2024: 5 timed tasks, 8 admins, moderated, on a test account with 40 locations.

The April readout set the scope: the 5 ticket categories, nothing else in version 1.

## 3 models, and why 2 lost (May–June 2024)

Before detailed design I prototyped 3 ways to make one change at many locations. I tested them with 6 head-office admins on 2 tasks: a price change for one region, and giving a person a role at 12 locations.

1. A bulk-edit grid: locations as rows, settings as columns, edited like a spreadsheet. Admins had asked for it, since they already lived in spreadsheets. It was fast for prices: 5 of 6 finished that task. It didn't fit roles, which are bundles of permissions, or schedules, which are calendars: 2 of 6 finished the role task. The engineering lead also estimated it as the largest build, because each type of setting needed its own grid editor.
2. Inheritance: a brand-level template that every location inherits, with local overrides, the way styles cascade. The engineering lead liked it; it's a clean data model. Admins couldn't predict what a change would do. Asked which locations a template edit would affect, 4 of 6 got it wrong.
3. Scope and preview: make the change once, choose where it applies (this location, a group, or all), and see a list of affected locations with before and after values before applying. 6 of 6 finished both tasks, and all 6 could say what would change before they applied it.

We built the third and kept inheritance under the hood. The data model stores brand values and local overrides; the interface shows them only through the scope choice and the preview. The grid won on the one task admins pictured when they asked for it, and lost on the rest.

## The model we built

- Objects: brand, location groups, locations. Groups became real objects instead of naming conventions, and a location can be in more than one (a region and "franchised", for example). Groups are fixed lists; groups defined by a rule were deferred.
- Every setting is one of 3 kinds: set by head office only, a brand default that locations can override, or local only.
- The change flow: edit a setting, choose the scope, see the preview (the count, the list, before and after values, and which local overrides will be kept), apply, and get an audit-log entry.
- Local overrides are shown, never hidden. Each brand decides once, per setting category, whether head-office changes keep or overwrite local overrides. The default is keep.
- Staff: 5 role templates (head-office admin, regional manager, location manager, front desk, instructor). A person gets a role at a scope: some locations, a group, or all.
- An audit log admins can see: who changed what, where, and when.

## The arguments, and how they were settled

- Local overrides. Head-office admins wanted their changes to overwrite everything. Franchise owners wanted their local prices protected. Both came up in the contextual inquiry, at different brands. Neither side was wrong, so Grant and I made it a policy each brand sets once. "Keep local overrides" is the default because overwriting a franchise owner's price without warning is the more expensive mistake. Customer success agreed to set the policy with each brand at onboarding.
- Scope. I cut a drag-and-drop schedule template builder: a lot of engineering for 6% of tickets. Sales wanted a custom report builder for a large prospect. Grant and I deferred it, and Mina fixed exports instead, which was the actual ticket category.
- Undo. It was on my list for the beta. The engineering lead estimated a general undo for bulk changes at about 3 weeks, because one change can touch hundreds of records. I agreed to move it after the beta. That was my call, and the incident below is what it cost.
- Preview speed. In early builds the preview took up to 12 seconds for a 400-location brand. Engineers moved it to a background job, and I changed the design to show the count at once and fill in the list as it loads.

## Timeline and turning points

- February–April 2024: ticket coding, contextual inquiry, and the baseline benchmark in March. April readout sets the scope; the template builder is cut.
- May–June: 3 models prototyped and tested; scope and preview chosen.
- July–September: detailed design, tested with enterprise admins on the one Thursday a month our usability sessions reserve for them (`Thursday Usability Sessions.md`).
- October–November: beta with 5 brands. The 84-location incident.
- December 2024–March 2025: phased rollout, brand by brand. Planned to finish in late January; finished 7 weeks late, because the permissions model took longer to build than planned. Location managers' tickets rose in December; their home screen came back in January.
- February 2025: benchmark round 2.
- June 2025: the old console switched off.
- Q3 2025: the ticket measurement, a quarter later than planned because of the late rollout.

## The numbers, and how they were measured

Benchmark medians, March 2024 against February 2025:

- Give a new instructor the instructor role at 12 locations: 14m 20s → 2m 50s (−80%).
- Change the price of a 10-class pack at every location in one region: 22m 10s → 3m 30s (−84%).
- Apply a holiday schedule to 30 locations: 31m 00s → 4m 10s (−87%).
- Export last month's bookings by location: 6m 40s → 1m 40s (−75%).
- Move a member's membership to another location: 9m 50s → 3m 05s (−69%).
- All 5 combined: 84 minutes → about 15. Task success: 28 of 40 attempts (70%) → 38 of 40 (95%).

How: moderated remote sessions on the same 40-location test account, with the same scripted tasks in both rounds. Time runs from reading the task to the moderator confirming the end state. Success means the right end state with no help. Times are medians of successful attempts. That flatters round 1, because its failures were the slow attempts, so if anything the real gap is larger.

The caveats, stated plainly: 8 admins per round, medians, no significance test. Round 2 used different admins, from brands already on the new console. They'd had a few weeks with it; round 1's admins had years with the old one. The bias runs both ways, and the gaps are large enough that I'm comfortable with the direction.

Tickets: support codes every enterprise ticket into the 23 categories Odette and I built. "How do I" and "where is" are two of them. The rate is tickets in those 2 categories per 100 enterprise locations per month, averaged over the quarter. It went from 10.3 in Q4 2023 to 4.0 in Q3 2025, −61%. All enterprise tickets per 100 locations went from 16.8 to 10.6, −37%. Support also published 30 new help articles in that period, and I can't separate their effect from ours.

Use: in Q3 2025, from the audit log, about 3 of every 5 price changes on enterprise accounts were made once for more than one location.

## What went wrong

- No undo in the beta. An admin meant to change a price for one region and applied it to all 84 of the brand's locations. The button said "Apply." I had designed the preview and assumed people read it. The wrong prices were live for about 3 hours, until a location manager called head office, and support restored the other locations by hand from the audit log. Within two days we shipped a button that names the count ("Apply to 84 locations"), a confirm step for anything over 10 locations, and a 24-hour revert from the audit log. The general undo had been estimated at 3 weeks. This narrower revert replays the before values the audit log already stored, so it took 2 days.
- I designed for head-office admins and forgot location managers, who are about 80% of console users. Version 1 took away their quick home screen for their own location, and their tickets rose about 40% in the first month of rollout, from a small base. We restored a "my location" home in January 2025, and their ticket rate was back to its pre-rollout level by March. Round 1 of the benchmark had no location managers at all. It should have had some.
- The rollout finished 7 weeks late, which pushed the ticket measurement back a quarter.

## Second-order effects

- The scope picker and the preview list went into Rosterwell's design system in 2025 as components I contributed. The Studio Settings team uses them for studios with 2 to 14 locations, below the Enterprise tier.
- Customer success now sets each brand's override policy at onboarding.
- Mina took over the console when I moved to lead design across Member App and Studio Settings in July 2025.

## What isn't solved

- Groups defined by a rule, such as every franchised location in one state kept up to date automatically, were deferred. Admins still maintain group lists by hand.
- Schedule templates are still 6% of tickets.
- The custom report builder is still deferred. Exports cover most needs, not all.
- No benchmark round has included location managers. The next one should, weighted by how many of them there are.

## What I'd do differently

- Design undo before bulk apply, not after the first incident.
- Benchmark every user type, weighted by how many of them there are.
- Agree with support up front about help articles, so the ticket number can be read cleanly.
