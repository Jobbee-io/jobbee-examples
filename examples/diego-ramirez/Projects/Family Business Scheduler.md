<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# A scheduling app for my family's landscaping business

Personal project: nobody assigned it, graded it or paid me for it. Built over winter break 2023–24, in use since the March 2024 season. The users are my dad, my uncle (who runs the second crew) and my mom, who does the invoicing. It isn't on my one-page resume, but it's the only thing I've built where I chose the problem, the users weren't classmates or coworkers, and I've kept it running for three seasons.

## The full story

I worked my family's crews every summer from 2021 to 2023 and led a weekend crew by the last one. Every week I saw the same problems: a visit missed because a customer's text reached one crew lead and not my dad's paper calendar, quotes written by hand at night, and invoices waiting for my mom's free evenings. Nobody asked me to fix it. Over winter break 2023–24 I built the app myself, with tools I could maintain alone from a dorm room.

It went live for the March 2024 season and broke on the first Monday: 46 customers got a 2 AM text, because I'd stored send times without a timezone. I fixed it that morning, and my mom wrote the apology. Six weeks in, a maintenance notice from the server provider showed me that everything lived in one file with no backup, so I added nightly backups and tested a restore. I also spent a weekend on route optimization nobody wanted. My dad still orders the day himself, and now I ask him before I build.

The code is all mine. The business is theirs: my dad and my uncle run the crews from the day view, my mom invoices from the paid/unpaid board, and how they work decides what I build.

By the end of the 2024 season, missed visits were down from about 5 a month to about 1, and payment came in about 9 days after a job instead of 23. The numbers in this file are from that season. The app is in its third season now, with about 140 recurring customers, used daily by both crews and by my mom.

Still open: most of the visits we still miss come from gate codes nobody wrote down, which is a habit to fix, not code. And I'm the only person who can maintain the app, so I'll keep doing that remotely from wherever I work next.

## The problem

I worked the crews every summer from 2021 to 2023 and led a weekend crew by 2023. The business ran on my dad's paper calendar and his phone.

- **Missed or double-booked visits:** about 5 a month in 2023. A customer's text would reach one crew lead but not the calendar.
- **Quotes took days.** My dad wrote them by hand in the evenings.
- **Getting paid was slow.** Invoices went out in batches when my mom had a free evening: about 23 days from a finished job to payment.

## What I built

Python, Flask and SQLite on a $6-a-month virtual server. Boring tools on purpose, since I'd be maintaining it alone, mostly from a dorm room.

- A day view per crew that works on a phone in a truck: today's jobs in order, address, gate notes, the work to do.
- Recurring visits (weekly and biweekly mowing) generated from one customer record, so a change happens in one place.
- Text reminders the evening before a visit, and a "job done, here's your invoice" text when the crew marks a job finished, through a pay-per-message SMS service.
- Quote templates by yard size and service.
- A paid/unpaid board for my mom.

About 140 recurring customers were on it by mid-2024.

## The numbers, 2024 season against 2023

- Missed or double-booked visits: about 5 a month → about 1. Most of the rest were gate codes nobody wrote down.
- Days to get paid: about 23 → about 9, mainly from same-day invoice texts.
- Running cost: about $11 a month for the server and texts.
- My dad's count: about three evenings a week back from quotes and invoices.

## What went wrong

- **The 2 AM texts.** On the first Monday, 46 customers got their "your crew is coming today" text at 2 AM. The server ran on UTC and I'd stored the send time as "7:00" with no timezone. Two customers called my dad. I fixed it that morning: every time is stored with its timezone, and the scheduler has a fake-clock test that covers daylight-saving changes. My mom wrote the apology text, and it was better than mine.
- **No backups for six weeks.** Everything lived in one SQLite file on one server. Nothing was lost, but a maintenance notice from the provider made me realize a disk failure would take everything. I added nightly encrypted backups to a second provider and tested a restore.
- **A feature nobody asked for.** I spent most of a weekend on route optimization. My dad still orders jobs his own way, because he knows which customers want the crew early. Now I ask him first.

## What I'd do differently

- Watch a full week of how the business runs before writing code, instead of relying on my memory of summers.
- Do timezones and backups first.
- Keep a short changelog for my family, so they hear about changes from me and not from a customer.
