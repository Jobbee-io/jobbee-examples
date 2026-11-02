<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Accessibility remediation: 318 issues and a fixed date

Shelfwright, Web Platform team. October 2024 to June 2025, with a re-audit in August 2025. I led it as an IC across 6 product teams, an external audit firm and a legal date that didn't move. On my resume it's one bullet.

## Why there was a deadline

The European Accessibility Act applies to e-commerce from June 28, 2025. About 310 of Shelfwright's roughly 1,400 retailers sell into the EU, and several large ones added accessibility conformance clauses to their contracts at renewal. In October 2024 leadership commissioned an external audit against WCAG 2.1 AA, the level the EU standard points to, and asked me to lead the work that followed. Ruth K., the director of web engineering, was the sponsor. Our legal counsel owned the reading of the law; I owned the engineering.

## What the audit found

The report arrived in November 2024: 318 issues across 26 templates and flows (storefront pages, the 6 checkout steps, and account pages). On the firm's scale, critical means someone using assistive tech cannot finish the task: 47 issues. Serious means they can, with real difficulty or a workaround: 121. Moderate and minor: 150.

## The analysis that set the plan

Before planning anything, I mapped every issue to the code that caused it. That took me about two weeks. 194 of the 318 (61%) traced back to 9 shared components:

- dialog: 38
- form field and error messages: 34
- product image gallery: 24
- combobox: 22
- header navigation menu: 21
- variant swatch selector: 19
- tabs: 13
- date picker: 12
- toast notifications: 11

The other 124 were spread across templates: heading structure, link text, missing labels on one-off controls, contrast in specific places, and content problems such as product images without alt text.

I also measured what automation could find. We ran axe-core against the unfixed build of all 26 flows and matched its results to the audit, issue by issue. It flagged 104 of the 318 (33%). A person had to find the rest.

That changed the plan in two ways. We'd fix each shared component once and re-test every surface that used it, instead of six teams fixing the same bug six ways. And manual testing would be the main cost of the program, not a final check.

## Options

- Fix by surface: each team works through its own issues in severity order. Easy to staff, and it would have given us six different dialogs.
- Fix only the critical issues by the date and list the rest. Ruth and counsel rejected it: the retailers' contracts asked for conformance, not a list.
- An accessibility overlay. In December 2024 sales asked whether a widget that sits on top of the page would cover us. I wrote a two-page memo against it: an overlay doesn't fix the underlying markup, it often gets in the way of screen reader users' own settings, and it would not have made us conform. The vendor's quote was about $90K a year. Leadership agreed, and we didn't buy one.
- Components first, then surfaces. Chosen.

## My role

I triaged and mapped the issues, wrote the plan and the weekly burn-down, fixed the 9 shared components with one other engineer (Hollis T.), and wrote the testing guide every team used. Six product teams fixed the issues in their own surfaces, and I reviewed every fix against the guide. The external firm re-tested.

## How it ran

- Shared components first, January to March 2025, with Hollis and me on them full time: dialog focus management, the combobox, form error announcements, the variant swatch selector, the date picker, then the rest.
- Surfaces next, March to June, by the 6 teams at about 15% of their capacity each, checkout first.
- "Fixed" meant three things: a passing manual test script, my review against the guide, and the external firm's re-test. Only the re-test closed an issue in the burn-down. The firm re-tested in 4 batches, one a month from March to June.
- Automated checks: axe-core runs in Playwright against all 26 flows on every merge. It guards the third it can see against regressions.
- Manual testing: a written script per flow, 20 to 40 steps each, run on 6 setups: keyboard only, NVDA with Firefox, NVDA with Chrome, VoiceOver with Safari on macOS, VoiceOver with Safari on iOS, and TalkBack on Android. The 6 checkout steps also got JAWS with Chrome, because two large retailers' contracts named it. Every fix needed a passing script run, not just a passing axe check. A full manual pass of all 26 flows took 2 people about 3 days, and we did 4.
- Users: two rounds of paid sessions, in February and May 2025, with 5 disabled users: 4 screen reader users and 1 switch-access user. The May round found 9 issues that neither the audit nor our scripts had caught, 2 of them in checkout: the mobile order summary toggle didn't say whether it was open, and TalkBack didn't announce how many address suggestions had appeared.
- Merchant themes. The theme editor has blocked low-contrast token choices since 2022, but merchants' custom CSS bypassed it. We added a contrast warning to the custom CSS editor and sent each affected merchant a report. 212 merchants had at least one failing color pair; 170 had fixed theirs by the deadline.
- Merchant content. The admin now asks for alt text when a merchant uploads a product image, with "decorative" as an explicit choice, and merchants got a report of existing images without it.
- The weekly burn-down went to Ruth and the 6 team leads: open critical, serious and moderate issues by team, with re-test status.

## Timeline and turning points

- October 2024: audit commissioned.
- November: the report arrives, and I map it to components.
- December: plan approved, overlay memo, testing guide. Two teams start fixing focus trapping in their own copies of the dialog (below).
- January to March 2025: the 9 shared components. The swatch selector, estimated at 3 days, takes 3 weeks. February: the first user round.
- March to June: surface fixes and the monthly re-test batches. April: the checkout payment dialog fixed for the second time.
- May: the second user round and its 9 new issues.
- June 20: the last re-test batch. Every critical and serious issue closed.
- June 28: the EAA date. Our public accessibility statement listed the 19 open moderate and minor issues, each with a date.
- August: re-audit by the same firm.
- October 2025: the last of the 19 closed.

## The numbers

- By June 20, 2025: all 47 critical and all 121 serious issues fixed and re-tested by the external firm, and 131 of the 150 moderate and minor issues fixed.
- The remaining 19 were listed in the public accessibility statement, each with a date. All 19 were closed by October 2025.
- Re-audit in August 2025, same firm: 6 new issues, none critical, 2 serious. Both serious ones were fixed within 2 weeks.
- Issues automation could detect: 104 of 318 (33%), measured as described above.
- Merchants with a failing color pair in custom CSS: 212, of which 170 fixed by the deadline.

## Who disagreed, and how it was settled

- Sales, on the overlay. Settled by the memo and by leadership.
- Counsel asked whether the statement had to list the moderate and minor items at all. I argued for listing every open one with a date: a retailer's own auditor would find them anyway, and an unlisted issue looks hidden. She agreed.
- The merchant admin's product manager didn't want to require a text label on every color swatch, because it adds work for merchants at upload. We settled on labels generated from the variant's option name (for example "Color: Navy"), which merchants can edit, and a required label only on new swatches.
- Two teams wanted to fix their own surfaces right away instead of waiting for the shared components. I let them, and it cost us.

## What went wrong

- I estimated by issue count, not by component. The variant swatch selector was estimated at 3 days and took 3 weeks. It was a set of buttons pretending to be a radio group, and about 40% of the color swatches in the catalog had no text label at all. The real fix was a real radio group with real labels, plus the merchant admin change above.
- Two teams fixed focus trapping in their own copies of the dialog before the shared fix landed, and both had to undo it. I should have frozen fixes on anything built from a shared component until that component shipped.
- Checkout's payment dialog got its focus handling fixed twice. My first fix passed with VoiceOver on macOS and failed with NVDA. The dialog's label pointed at a heading that rendered a moment after focus moved, so NVDA announced a dialog with no name. I had tested my own fix on my own setup. Moving focus after the heading rendered fixed it, and since then nobody signs off their own fix on their own machine.
- Three of the serious issues were in the combobox I built in 2022 (`Design System Rebuild.md`), and I fixed those myself, first. Arrow keys moved through the options, but the reference to the active option pointed at an id that changed on every render, so NVDA announced nothing. The number of results was never announced. And the clear button had no accessible name. It had passed axe.
- The first user round was in February. It should have been in November, before the plan.

## Second-order effects

- Manual screen reader testing is now part of every component's definition of done, and the 26 flow scripts are re-run every quarter by a rotation across the 6 teams.
- Sales now sends the accessibility statement and the re-audit summary with procurement questionnaires. A compliance cost became something sales uses.
- Fixing once in shared components worked because most UI comes from the design system. It also means one bad shared component reaches every surface, which is why the component-level definition of done matters more than any audit.

## What still isn't solved

- Merchant custom CSS. 42 merchants still had a failing color pair at the deadline, and 31 in October 2025. It's their CSS: we warn, we don't block.
- Merchant content: images without alt text, product videos without captions. We can prompt; we can't write it for them.
- WCAG 2.2. The audit and the EU standard use 2.1. We fixed the one 2.2 issue we know of (checkout's sticky footer hid the focused field on small screens), but we haven't audited against 2.2.
- The cost of manual testing doesn't go away. Automation still sees about a third.

## What I'd do differently

- Map issues to components on day one of any audit, and estimate from the components.
- Book the user sessions before the audit report lands.
- Freeze local fixes on anything built from a shared component until the shared fix ships.
