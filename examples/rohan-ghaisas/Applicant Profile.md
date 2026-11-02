<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Rohan Ghaisas

Facts about my search that the settings fields can't hold. I live in Pune and I'm staying in Pune. I want to work for a US or European company, remotely, and I've been doing the hard part of that (working across time zones with a US team) since 2022.

## What I'm looking for

- Senior or Staff Site Reliability Engineer, Platform Engineer, or Infrastructure Engineer. Individual contributor only. I'm a Senior SRE today; the step up I want is Staff-level scope, or Senior at a company with bigger scale than mine, paid against the role and not against an Indian salary band.
- About 9 years: Linux sysadmin (2017–2020), DevOps engineer (2020–2022), SRE and then Senior SRE (2022–now) at an Indian B2B SaaS company whose customers are all in the US.
- Location: Pune, India. Fully remote. No relocation, now or later.
- Current pay: ₹54 lakh fixed a year (about $62K at today's rate), plus up to ₹6 lakh variable (₹5.1 lakh paid last year), plus ESOPs in an unlisted company that I value at zero for planning.
- Target, as an employee through an employer of record (or the company's own Indian entity): base floor $90K a year, target $95K–$125K. Equity is welcome; I count it as a bonus, not as pay.
- Target, as an independent contractor working full time for one company: floor $60 an hour, target $62–$75 an hour (about $124K–$150K a year at 2,000 hours), invoiced monthly in USD, EUR or GBP.
- Notice period: 60 days by contract. My employer usually allows a buyout of up to 30 days, so the realistic start is 30 to 60 days after an offer.

## Working hours and overlap

India is UTC+5:30 and has no daylight saving, so the overlap moves when the US and Europe change their clocks. Here is the plain version.

- My default working day for a new role: 12:30–21:30 IST, Monday to Friday.
- US Eastern: 2 hours of overlap in winter (09:00–11:00 EST) and 3 hours in summer (09:00–12:00 EDT). I'll extend to 23:00 IST on up to 2 days a week for planned meetings.
- US Pacific: no natural overlap (09:00 Pacific is 22:30 IST in winter). Async work plus one late call a week is fine. A team that sits entirely on Pacific time and works synchronously is not a fit.
- Europe and the UK: a full working day of overlap. 12:30–21:30 IST is 08:00–17:00 in Berlin or Amsterdam in winter, 09:00–18:00 in summer.
- Setup: home office with two fibre lines from different providers and an inverter for power cuts. I've worked from home since 2020.

## Employee or contractor: the trade-offs as I see them

- Employer of record is my first choice. I get statutory benefits under Indian law, paid leave, health insurance for my family, and a clear notice period. The company gets a compliant hire without opening an Indian entity.
- Contracting is fine, priced honestly. As a contractor I pay for my own leave (about 25 days a year unpaid), family health insurance, an accountant, GST registration and advance tax, and I carry the risk of a 30-day termination clause. That is why the contractor floor sits about a third above the employee floor. The real gap for the company is smaller than it looks, because a contract saves them the employer of record's monthly fee and the employer-side statutory costs.
- What I won't do as a contractor: work through a staffing agency that bills me to the company and keeps a margin, or be placed at a client as "a resource." I want to be on the team: in its design reviews, its on-call rotation, and its postmortems.

## Where I have real depth

- Kubernetes operations at fleet level. 16 clusters, 6 of them production, about 3,600 production pods at peak. I ran a program that took all 16 from 1.24 to 1.28 with no customer-facing outage minutes, and set up the cadence that keeps them current.
- Incident command. I've been incident commander for 11 SEV-1 and SEV-2 incidents since mid-2023, including a cloud-region outage in October 2025 that ran 12 hours 48 minutes from first alert to failback.
- Working across India and US time zones. I designed my company's follow-the-sun on-call rotation between Pune and our US office, including the daylight-saving bug in my own schedule that left one hour a day uncovered for a week.
- Infrastructure as code. I cleaned up Terraform drift across our production accounts (1,940 drifted resources to 0) and the nightly drift check still runs.
- Observability and its cost. I cut our hosted logging bill from $46K to $19K a month without losing the logs support and audit actually use.
- Linux underneath all of it. Three years as a sysadmin on about 1,100 servers. I still reach for strace and tcpdump before I reach for a dashboard.

## Search constraints — please respect these

- Remote from Pune only. Roles that say "remote, US only" or require living in the US, the EU or the UK are out. I'm not authorized to work there and I'm not moving: my parents and my wife's work are here.
- No roles that expect full US business hours from India. That is a permanent night shift. I did 18 months of night shifts in a NOC early in my career and I won't do it again.
- On-call: yes as the India leg of a rotation (my day and evening). No standing primary on-call through the India night, 00:00–07:00 IST.
- Engagement: employer of record, the company's Indian entity, or a direct contract with the company. No staffing agencies or body-shop placements.
- Individual contributor only. No engineering manager roles, and no "SRE lead" roles that come with direct reports.
- Pay in USD, EUR or GBP, benchmarked to the role. If a company pays "local market rate" for India, tell me the number in the first message; if it's under my floor, I'll say no politely.
- No real-money gaming or betting platforms.

## How I work

- Async first. Design docs, decision records and handoff notes are where my work lives. I keep overlap hours for decisions and pairing, not status updates.
- I end every working day with a short written handoff, on call or not. With a 9.5 to 10.5 hour gap to the US, the note is the meeting.
- Numbers in everything I claim, with the definition next to the number.
- I've mentored 4 SREs in Pune (2 promoted). I'm happy to mentor; I don't want reports.

## Visa / Work Authorization

- Citizenship: India
- Residence: Pune, India; not relocating
- US work authorization: none. EU and UK work authorization: none
- Sponsorship need: none, because I'm not moving. I want remote work from India only, as an employee through an employer of record (or the company's Indian entity) or as an independent contractor
- Travel: valid Indian passport and a US B-1/B-2 visitor visa valid through 2033, used for two business visits to my current employer's US office. Visitor visas allow meetings and offsites, not working from the US. No Schengen visa today; getting one takes 3 to 6 weeks

## Clarifications

*(Questions Jobbee asked when two facts in my files pulled against each other. Log format: question, answer, newest last.)*

**Q:** Your profile says no standing primary on-call through the India night (00:00–07:00 IST), but your region-outage project has you working until 00:40 IST. Should roles that mention occasional overnight incident work be excluded?
**A:** No. The line is a standing overnight pager, not the odd late night. If I'm already running an incident, I stay until it's stable and handed off properly, which is what happened that night. A planned maintenance window late at night a few times a quarter is also fine. What I won't accept is a rotation that makes me primary from midnight to 7 am for a whole on-call week, every few weeks, as the normal design. Exclude that; keep the rest.
