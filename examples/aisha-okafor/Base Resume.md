<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Aisha Okafor

aisha.okafor@example.com · (555) 071-4468
github.com/example/aishaokafor · linkedin.com/in/example-aishaokafor
Atlanta, GA

*The long version of my resume. The one-pager says "security engineer"; this file shows how I got there from the help desk and the night shift, with the numbers, the certifications at real depth, and the mistakes. Longer stories live in `Projects/` and are linked from the bullet they belong to.*

---

## Summary

Security engineer, about 9 years in IT and security, currently Security Engineer II at Tillgrove, a small-business payroll and payments platform, where I've run application security since April 2024. I came up through IT support, systems administration and 3 years in a 24/7 SOC at a managed security provider, from tier 1 to tier 3 night lead. I review designs and code for a 170-engineer org, and I write detection and Semgrep rules as tested code. I've worked authorization bugs from both sides: one I found and disclosed in another company's API, and one our pentest found in my own company's admin API, which I then fixed at the root with a shared middleware. Looking for a senior AppSec or product security IC role at a larger company.

---

## Experience

### Tillgrove — Security Engineer I → Security Engineer II (Sep 2022 – present)

Small-business payroll and payments platform: ~38,000 business customers, ~650 employees, ~170 engineers in 14 product teams, Go and TypeScript on AWS. Security team of 6 when I joined. Hired into detection and response. Promoted to Security Engineer II in April 2024 with application security as my scope, after our only AppSec engineer left and the seat was frozen.

- Secure design and code review program (2024–present). Built it from nothing: 61 threat models through September 2026, 148 design findings (23 high), 85% fixed before launch; required security review on 12 sensitive code paths, median first response 0.6 business days; 27 custom Semgrep rules in CI on 38 repos, 92% true-positive rate on triaged findings. External pentest high/critical findings went 9 (2023) → 6 (2024) → 2 (2025). My first version made me the bottleneck; that's in the file too. Full notes: `Projects/Secure Review Program.md`.
- Authorization middleware for internal admin APIs (2025–2026). After the 2025 pentest found an IDOR in an internal admin API, I paired with a platform engineer on a shared Go middleware that denies by default and requires a policy per route. Now on 9 of 11 admin services, with a CI test that fails when a new admin route has no policy.
- Interim AppSec coverage (Jan – Mar 2024). Handled 46 code review requests while the AppSec seat was empty, on top of detection work. Wrote the program proposal in February 2024.
- Detection as code (2022–2024). 48 cloud detections over CloudTrail, GuardDuty and identity-provider logs, written in Python with unit tests in CI. Pages to security on-call went from ~30 a week to ~6 after tuning, with the same detections still firing in quarterly purple-team tests.
- Secrets in git (2023). Scanned the history of 38 repos: 212 findings, 31 live credentials, all 31 rotated within 2 weeks. Added pre-commit and CI secrets scanning to every repo.
- Annual external pentests (2024, 2025): scoped them, triaged the findings, tracked the fixes.
- Mentoring. Onboarded our associate AppSec engineer (May 2025). I run the quarterly 2-hour training for 11 security champions.

### Lanternwatch Security — SOC Analyst I → II → III (Jul 2019 – Aug 2022)

Managed security provider: 24/7 SOC monitoring ~85 client environments (mid-market healthcare, manufacturing, local government), ~140 employees. I worked nights the whole time: four 10-hour shifts a week, 21:00 to 07:00.

- Tier 1 (Jul 2019 – Jun 2020). Triaged ~55 alerts a shift across EDR, firewall, VPN and email-security sources.
- Tier 2 (Jul 2020 – Sep 2021). Wrote 34 rules for the shared detection library, 11 of them first built and tested in my homelab. Added a test folder and CI check to the library: every rule ships with a log sample that must fire and one that must not. Wrote a Python enrichment script used by ~22 analysts that cut median tier-1 triage time from 11 to 6 minutes per alert (4 weeks of tickets, before vs after).
- Tier 3, night shift lead (Oct 2021 – Aug 2022). Led a 3-person night crew and the response to 9 confirmed incidents. The largest was a ransomware intrusion at a manufacturing client, contained 44 minutes after the first encryption alert: 3 of 41 servers encrypted, no ransom paid. It's one bullet here. Full notes, including the suppression rule of mine that hid the early warning: `Projects/Ransomware Night Shift.md`.
- After that incident, led an audit of the library's 140 suppression rules: 23 over-broad, 9 removed, 14 narrowed. Every suppression now needs an expiry date, a second reviewer, and a test showing the malicious variant still fires.
- Mentored 6 tier-1 analysts; 4 moved up to tier 2 within a year.

### Sweetgum Valley Orthopedics — IT Support Specialist → Systems Administrator (Jul 2017 – Jun 2019)

Orthopedic and physical therapy practice, 11 clinics around metro Atlanta, ~600 staff. IT team of 4.

- Help desk (Jul 2017 – Sep 2018): ~30 tickets a day. Wrote a PowerShell onboarding script that cut account setup from 45 to 6 minutes per hire, about 140 hires a year.
- Systems administrator (Oct 2018 – Jun 2019): Active Directory and Microsoft 365 for ~650 accounts. Monthly patch compliance on 380 endpoints went from 62% to 96% after I set up staged update rings.
- In August 2018 I noticed impossible-travel sign-ins on a front-desk mailbox and traced a phishing wave to 14 compromised accounts. I reset them, wrote it up, and pushed for MFA on email, which was on for every account by June 2019. That week is why I moved into security.

---

## Outside work

- Homelab detection lab (2020–present): a Proxmox host, a small Windows domain, Sysmon into Elastic and Wazuh, 58 Sigma rules tested against Atomic Red Team plus hand-written variants, and since 2024 a web tier for AppSec practice. On the one-pager this is one line. Full notes: `Projects/Homelab Detection Lab.md`.
- Captain of Kudzu Overflow, a 9-person CTF team (co-founded 2020, captain since January 2022). Best result: 11th of ~900 teams in a 48-hour online jeopardy CTF (2024). Full notes: `Projects/Ctf Team Captain.md`.
- Bug bounty, part-time since 2023: 7 valid reports to 5 programs, $5,450 total. Largest: an IDOR in a property-management company's lease-documents API, $3,000, fixed 10 days after my report. Full notes: `Projects/Bug Bounty Idor.md`.

---

## Certifications, and what each one actually tested

- CompTIA Security+ (Nov 2018, self-paid, lapsed 2021). Up to 90 questions in 90 minutes, mostly multiple choice plus a few simulations. It tested vocabulary: ports, crypto terms, attack names, frameworks. It got my resume past the filter for SOC tier 1. It proved nothing hands-on, and I let it lapse once GCIH covered the same ground.
- GIAC Certified Incident Handler, GCIH (Jun 2021, renewed 2025; course and exam paid by Lanternwatch). 106 questions in 4 hours, open book, with about 10 hands-on questions in a lab VM. It tests the incident-handling process and how common attacks work and get detected: password attacks, web attacks, lateral movement. I'd been doing that for 2 years on nights; the exam made me structure it.
- OffSec Certified Professional, OSCP (Aug 2023, second attempt). A 24-hour hands-on exam against a small network that includes an Active Directory set, then 24 hours to write a professional report; 70 points to pass. First attempt in May 2023: 60 points, the AD set and one standalone machine. Second attempt: 80. It tests enumeration discipline and stamina. It is not an AppSec cert: it taught me attacker workflow, not code review.
- Burp Suite Certified Practitioner (Jan 2025). 4 hours, two web applications, three stages each: get into a user account, escalate to admin, then read a file off the server. The closest cert to the job I want: finding and chaining web vulnerabilities under time pressure. It does not test fixing, code review or threat modeling. For those, the evidence is my program file, not a certificate.
- No CISSP. I have the years for it now; I've chosen hands-on certs instead.

---

## Education

BS Biology, Wrenfield State University, 2013–2017. Worked the campus IT help desk 15 hours a week for my last two years. That job, not the degree, got me hired at Sweetgum Valley.

---

## Skills (honest)

- Strong: web application security testing (Burp Suite), threat modeling, secure code review in Go and TypeScript, Semgrep rule writing, Python, detection engineering (Sigma, SIEM queries), incident response.
- Working: Go (I write middleware and tests, not product features), AWS security (IAM, CloudTrail, GuardDuty), CI security tooling, Active Directory attacks.
- Reading only: Java, Kotlin. Not at all: mobile app security, cryptography design, hardware.

---

## Numbers I can defend

- 61 threat models, 148 design findings, 23 high, 85% fixed before launch (Tillgrove, Apr 2024 – Sep 2026).
- Pentest high/critical: 9 → 6 → 2 (2023 → 2025), same external firm, same customer-facing scope, with internal admin APIs added in 2025.
- Median first response on required security reviews: 4 business days (Sep 2024, my first version) → 0.6 (Q2 2026).
- 44 minutes from first encryption alert to containment; 3 of 41 servers encrypted; 31 hours to restore (the ransomware night).
- 34 library detection rules; median tier-1 triage time 11 → 6 minutes (Lanternwatch).
- $3,000 bounty, report to fix in 10 days; $5,450 across 7 valid reports since 2023.

## Failures, indexed honestly

- An over-broad suppression rule I wrote in January 2022 auto-closed the first warning of the ransomware intrusion, almost 2 hours before encryption started.
- My first review gate covered 41 code paths and made me the bottleneck: a 4-business-day median wait, and 17 PRs split to dodge it.
- Our threat models covered external APIs and skipped internal admin tools. The 2025 pentest found an IDOR in exactly that gap, 7 months after I'd reported the same class of bug to another company.
- In the bug bounty, after proving the bug with my own test accounts, I requested 5 other tenants' records. That broke the program's rules. I stopped there and listed all 5 in my report.
- I failed OSCP on the first attempt, by 10 points.
