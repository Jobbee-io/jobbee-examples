<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Mobile service booking for an auto shop chain, from 7 steps to 4

Orchard Row, for the client Corbel Auto Care, July 2020 to January 2021; launched November 16, 2020. On my resume this is one bullet under the agency. It's my third portfolio case study, and the client approved it in 2021, including its name and the rates below. It's also the project that showed me the limits of agency work: I can tell you what happened in the first 8 weeks, and nothing after.

## What it was, and why

Corbel runs 72 auto service shops in Southern California and Arizona: oil changes, brakes, tires, and diagnostics. In 2020, 68% of visits to its booking page came from phones. The booking form had been built for desktop, and only 19% of mobile visitors who started a booking finished it. Everyone else called. With the pandemic, customers wanted to drop the car off without waiting inside, and the shop phones were overloaded.

## My role

I was the lead UX designer on the flow. The agency team was an account lead, a PM, me, a visual designer, and 2 front-end developers. Corbel's own IT team built the connection to the shops' scheduling system. Dalia, the agency's research lead, coached me through my first research plan and reviewed my synthesis. The flow, the research, and the testing were mine; the visual layer was shared with the visual designer.

## Research

- Three shop visits in August 2020, watching service writers take phone bookings.
- 9 remote interviews with recent customers: 5 who booked online and 4 who called.
- Step-by-step drop-off in the old flow. The biggest loss was the account step: 41% of the mobile users who reached it left there. The second was the service list, 46 items in mechanics' words.
- A one-week call log at 4 shops: 212 calls, 54% of them bookings or rebookings. The questions callers asked most were "how long will it take?" and "can I wait there?"

## Decisions, and why

- Guest booking. A phone number was required, since the shops send updates by text anyway, but an account was not. Corbel's marketing team wanted accounts for their customer database. The compromise was a one-tap account offer after confirmation, with the details already filled in.
- Six plain-language service groups instead of 46 items: oil change, brakes, tires, check engine light, scheduled maintenance, and "Not sure, something's wrong", which books a 30-minute inspection. That last one was the most argued over, because Corbel worried about low-value bookings. It became 14% of online bookings.
- "Wait or drop off?" asked up front, because it sets the length of the slot and which times are offered.
- The next available times first ("Today, 2:30 PM"), with a "more times" link instead of a calendar.
- Vehicle details made optional; the shop can ask at the counter.

The old 7 steps (location, account, vehicle, service, date, time, confirm) became 4: location, service, time, and contact-and-confirm. Two rounds of moderated testing on phones, 5 people each, came before build. Round 1 showed that "wait or drop off" as a toggle confused people, so it became two large buttons, each with a time estimate.

## The numbers

Corbel's data, shared with us: the 8 weeks after launch against the 8 weeks before.

- Mobile booking completion: 19% → 37%.
- Online bookings as a share of all bookings: 22% → 34%.
- Calls to shops: −16%, from Corbel's call tracking.
- No-shows on online bookings: 9% → 13%. Guest booking made booking easy, and it made not showing up easy too.

This was before-and-after, not an A/B test. Both windows were in a pandemic year, the after window ran into the holidays, and I couldn't query the data myself. The engagement ended in January 2021. Corbel's digital manager later told me that a text reminder 2 hours before the appointment brought no-shows back to about 10%, but I never saw that data, so it isn't on my resume.

## What went wrong

- Slot availability came from each shop's capacity settings, and 19 of the 72 shops hadn't updated theirs in months. In the first two weeks 6 shops were double-booked, and the service writers were rightly angry. Within a week we designed a weekly "confirm your capacity" check for shop managers. I should have checked that data during research.
- I ignored the shop side. Online bookings arrived in the shops' system as free-text notes, and the service writers retyped them. The shop software wasn't in our scope. I flagged it in a memo and didn't push further, and they were still retyping months later.
- I didn't predict the no-show increase at all.

## What I'd do differently, and what changed

- Audit the data a design depends on before designing on top of it.
- Design both sides of a two-sided flow, even when only one side is in the contract.
- Write the metrics readout into the contract. I pushed for a 90-day readout in Orchard Row's standard statement of work, and it was adopted in June 2021. This project is also why I went in-house to a two-sided product in 2022.
