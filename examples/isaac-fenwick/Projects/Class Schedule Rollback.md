<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The class schedule redesign that lost, and the rollback

Rosterwell, Member App team, June to August 2023, with a follow-up shipped in December 2023. My first project as a Senior Product Designer. On the resume it's one bullet, plus a line each in the numbers and failures lists; it isn't in my portfolio. It changed how I test, and it's the reason the Thursday usability sessions exist.

## The design, and the evidence I had

The schedule screen is where members browse classes and book. The old design was a dense list (time, class name, instructor, length, spots left, a Book button), about 9 classes per phone screen. Two asks landed together: studios wanted their instructors' faces in the app, a top-10 studio request, and product wanted the member app to look more modern before a spring marketing push. I designed cards: a wide instructor photo, class name, time, a level tag and spots left, about 3 per screen, with a day picker and filter chips on top.

I led the design. Jules was the PM, Wen the analyst, and 5 engineers built it for iOS and Android. I chose the pre-launch research:

- 5 moderated sessions with members who had joined in the past 30 days, recruited through an in-app banner for new members because that was quick. All 5 preferred the cards.
- A preference survey of 214 members: 68% preferred the cards.

## The A/B test

50/50 by member, August 7 to 28, 2023. Primary metric: bookings per weekly active member. Secondary: median time from opening the schedule to a completed booking. Guardrail: late cancellations.

- Bookings per weekly active member: −3.8% (95% CI −4.6% to −3.0%).
- Median time to book: 19 seconds → 31 seconds.
- Regular members, meaning 4 or more bookings in the previous 30 days (about 35% of active members and about 70% of bookings): −5.9%.
- New members, in their first 30 days: +2.1% (95% CI −0.8% to +5.0%). Not significant.
- Late cancellations: unchanged.
- About 90 support tickets from studios passing on member complaints, mostly "I can't find my 6am class."

We rolled it back for everyone on August 30. Wen estimated about 40,000 fewer in-app bookings in the test arm over the 3 weeks. Some of them booked on the web or at the front desk instead, so the real loss was smaller, by an amount nobody can measure.

## Why it failed

- Regulars don't browse. They scan for a time. Cards cut the visible classes from 9 to 3, so the 6am regular scrolled past photos to find the class they book every week.
- I tested with the wrong people. Regulars carry the metric, and none were in my sessions. The segment split was in a dashboard I had never opened.
- Every question I asked was about preference; none timed a task. Preference is what my graphic design training taught me to read, and it's the wrong signal for a screen people use three times a week.
- The week-1 readout already showed −3.5%. We let the test run because the plan said 3 weeks. There was no stop rule for harm.

## The follow-up that worked

In October and November I designed a compact list at the old density, about 9 classes per screen, with a 32-pixel instructor photo on each row, a "your usual classes" row at the top for classes a member had booked twice or more in the past 4 weeks, and the studio's cover image only at the top of the screen. This time the sessions included regulars and timed tasks on a real studio's 40-class day. A/B test, November 6 to 27, 2023: bookings per weekly active member +1.2% (95% CI +0.4% to +2.0%), and +1.9% for regulars. It shipped in December: studios got their instructors' faces, and members kept their density.

## What changed in how I work

I start from the behavioral data (who books, how often, and how), recruit by segment, and time tasks on a full real schedule, not a 6-class mock-up. I ship to 10% first, with a stop rule in the test plan: if the primary metric is down more than 2% after one week, stop. The research habits became a team practice: `Thursday Usability Sessions.md`.

## What's still open

Nothing is open: the cards were rolled back on August 30, 2023, and the compact list that replaced them shipped in December 2023 with the instructor photos studios had asked for.
