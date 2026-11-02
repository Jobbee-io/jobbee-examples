<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Job Applicant — Aisha Okafor

Facts about my search that don't fit in the settings fields. I came into security through the help desk and the night shift, so part of this file explains how to read that history.

## What I'm looking for

- Senior Application Security Engineer or Senior Product Security Engineer, individual contributor. Titles I'd count as the same job: Senior Security Engineer (AppSec), Security Engineer III where that is the senior level, Product Security Engineer at senior level. Not Staff; I'm not there yet.
- About 9 years in IT and security: 2 in IT support and systems administration, 3 in a 24/7 SOC at a managed security provider (tier 1 to tier 3), and 4 as a security engineer at a payroll and payments company, where I've run application security since April 2024.
- A larger company, ideally with at least 3 people doing AppSec. My hard size filter is below. I've been the most senior AppSec person at Tillgrove for 2.5 years. I want peers who are better than me at this.
- Location: Atlanta. Remote (US) or hybrid in Atlanta, up to 2 office days a week. I won't relocate; my partner's job and my mother are here.
- Compensation: today $152K base plus a 10% target bonus and private-company options I count as zero. Looking for $190K–$220K base and $260K–$330K total comp (base, bonus, and RSUs vesting over 4 years). My floor is $180K base. If your remote bands are tiered by location and Atlanta lands in a lower tier, that's fine as long as the base clears $180K.
- Notice: currently employed. 3 weeks, so I can hand the review program to our associate AppSec engineer and the champions properly.

## How to read my SOC years

Two of my three employers would file me under operations. This is how that work maps onto an engineering job, and where it doesn't.

- Detection rules are code. At Lanternwatch I wrote 34 rules for the shared detection library, and I added the test folder and CI check it didn't have: every rule ships with a sample log that must fire and one that must not. At Tillgrove I wrote 48 cloud detections in Python with unit tests. Writing a Semgrep rule today is the same skill pointed at source code instead of logs.
- I've read attacks from the receiving end: 3 years of nights, about 55 alerts a shift as a tier 1, and 9 confirmed incidents I led as a tier 3. That's why I rank findings by what an attacker would actually do with them, not by a scanner's severity label.
- Incident command is triage under pressure. The ransomware night (`Projects/Ransomware Night Shift.md`) was 44 minutes of choosing what to contain first. Triaging a review queue is the calm version of that.
- Where it doesn't map: I have never shipped a product feature. My code is tooling, rules, tests and one shared Go authorization middleware. I read Go and TypeScript well enough to find bugs in them; I write Python every day.

## Where I have real depth

- Authorization bugs, from both sides: an IDOR I found and disclosed in another company's API (`Projects/Bug Bounty Idor.md`), and the authorization middleware I co-wrote at Tillgrove after our own pentest found one in an internal admin API.
- Running a security review program with one and a half people: 61 threat models, a review queue with a median first response under 1 business day, 27 custom Semgrep rules (`Projects/Secure Review Program.md`).
- Detection engineering and incident response, at an MSSP and in AWS.
- Certifications: Security+ (2018, lapsed), GCIH (2021, renewed 2025), OSCP (2023, second attempt), Burp Suite Certified Practitioner (2025). What each one actually tested is in my resume. No CISSP, by choice.

## Search constraints — please respect these

- Individual contributor only. No manager or team-lead roles. I mentor and I run programs; I don't want to manage people.
- No SOC analyst, MDR or "security operations" roles, even senior ones. I did 3 years of nights and I'm proud of it; I'm not going back to shift work. A shared incident on-call rotation of 1 week in 5 or lighter is fine.
- No GRC- or compliance-led roles where the work is questionnaires and audits. If the job asks for CISSP and never mentions code, it isn't my job.
- No pentest consulting or billable-hours firms, and nothing over 20% travel.
- No cleared or on-site-only defense roles. I hold no clearance, and those roles rule out remote.
- Companies of roughly 1,000+ employees, or a security team of 15+. Fintech, payments and developer platforms are where my threat models transfer fastest, but I'm open on industry.

## How I work

- Every finding I write has the request, the response, the fix I'd suggest and the test that proves the fix. Engineers shouldn't have to reverse-engineer my report.
- I'd rather fix a class of bug with a library than review every instance of it. The Go middleware exists because I got tired of finding the same missing check.
- I treat rules as code: version control, tests, review, and an expiry date on every suppression. That last one I learned the hard way.
- I teach. I mentored 6 tier-1 analysts at Lanternwatch, and I run the champions training at Tillgrove.

## Visa / Work Authorization

- Citizenship: United States
- US work authorization: unrestricted (citizen; no sponsorship required)
- No visa constraints for any US location
- Security clearance: none held

## Clarifications

*(Questions Jobbee asked when two facts in my files pulled against each other. Question, answer, newest last.)*

**Q:** You target Senior Application Security Engineer, but your title is Security Engineer II and your AppSec-specific time is about 2.5 years. Should we include mid-level AppSec roles, or only senior?
**A:** Senior is the target, and I'm not inflating anything to say that. For 2.5 years I've run AppSec at a 170-engineer company with nobody senior above me in the function: design reviews, the code review queue, pentest scoping, an associate engineer to onboard. My title is mid-level because the company had one AppSec seat and a hiring freeze, not because the scope was mid-level. So: search Senior and the equivalent levels. Include a mid-level AppSec role only if the base is at least $180K and the AppSec team has 5 or more people, because then the level is a calibration conversation I'm happy to have after a loop. Don't send me Staff.
