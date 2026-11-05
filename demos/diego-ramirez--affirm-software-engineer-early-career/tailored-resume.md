> The text of [tailored-resume.pdf](tailored-resume.pdf), the resume Jobbee delivered, for reading and search. See [README.md](README.md) for the job and what to compare.

```text
Diego Ramirez                                                                                        Software Engineer, Early Career
diego.ramirez@example.com · (555) 014-7788 · Austin, TX · Work authorization: F-1 OPT through mid-2027 (STEM extension through
2029)
Key Technical Impact
     Payments & Checkout: payment-error state machine (9 states / 14 transitions) handling ~1,400 checkout errors/day.
     Well-Tested Systems: Raft KV store in Go (~5,600 lines) — 1,200-scenario suite + 40 chaos soaks, zero write loss.
     Debugging Others' Code: rebuilt a 6-year-old autograder for ~400 students/semester — grading 45 min → 4 min.

Projects
Distributed KV Store with Raft — Senior Capstone (CS 4900)                                                               Jan 2026 – May 2026
   Implemented leader election, log replication, snapshotting behind a copy-on-write layer, and a linearizable get/put/delete/cas API on a 3–
   5-node Go cluster (~5,600 lines with tests), built from the Raft paper with no consensus library.
   Designed a fault-injection harness — random node kills every 2–8 s across 30-minute soaks, 40 runs — plus a committed-write verifier;
   zero acknowledged writes lost, and every bug it surfaced became a regression scenario.
   Chose ReadIndex reads over leases and justified the choice with measurement (11,500 vs 1,900 reads/s median); wrote the known
   limits (no client sessions, single-machine snapshot tests) into the report.
   Selected top 8 of 96 teams to demo at the capstone showcase, killing the leader live while the client kept writing.
Scheduling App for a 140-Customer Landscaping Business                                                                     Dec 2023 – Present
   Built and operate a Python/Flask + SQLite scheduling and invoicing app used daily by two crews for three seasons: missed or double-
   booked visits fell from ~5 to ~1 a month and days-to-payment from ~23 to ~9.
   Fixed the week-one timezone bug that texted 46 customers at 2 AM the same morning — every timestamp now stores its timezone
   behind fake-clock DST tests, with nightly encrypted, restore-tested backups.
Hackathons — Longhorn Dev Days 2025 · Atl-Sea Hacks 2024                                                                           2024 – 2025
  2nd of 41 teams with "receipt-splits" (photo-a-receipt bill splitter): built the Tesseract OCR-to-ledger pipeline and API in Go in a 30-hour
  weekend; earlier finalist at Atl-Sea Hacks 2024 with a campus lost-and-found service.
Professional Experience
Cartway — Software Engineering Intern, Checkout                                                                           Jun 2025 – Aug 2025
  Owned the payment-error state machine end-to-end (TypeScript on Node.js, ~2,400 lines with tests), replacing six ad-hoc error branches
  with 9 typed states, 14 transitions, per-class retry budgets persisted per payment, and terminal states that block retry.
  Gave support real visibility: every transition writes an events row (payment ID, from/to state, reason code, timestamp) that support now
  reads instead of deciding retry-safety from memory.
  Caused, traced, and fixed the week-4 incident — timeouts wrongly marked terminal stranded 312 in-progress checkouts; the hotfix made
  them retryable with a deadline once I verified the capture call's idempotency contract.
  Added regression tests replaying the incident's slow-timeout sequences and chaos cases (mock gateway) that the team's staff engineer
  wired into CI; all 312 checkouts recovered with zero double charges.
  Shipped through the team's Git/PR workflow; my mentor's code reviews (she refactored my retry wrapper into team patterns) and a
  requested mid-internship feedback session reshaped how I write PR descriptions.
Harborlight Software — Software Engineering Intern, Platform Tools                                                        May 2024 – Aug 2024
  Built the client-project dashboard (Flask + PostgreSQL + React), replacing a hand-updated spreadsheet — adopted by 6 leads.
  Wrote the dashboard's Docker/compose deployment scripts; fixed the hardcoded laptop-only path that broke my first deploy.
  Closed ~60 small fixes across inherited internal tools, learning to read unfamiliar code fast and leave it tidier.
Alder Ridge University — Teaching Assistant, CS Courses                                    Jan 2023 – May 2026 (part-time during semesters)
   Led weekly lab sections of 30 in Distributed Systems; designed 4 lab exercises including the failure-injection lab students rated most
   useful; graded design docs, ran office hours, and wrote ~9,000 pieces of feedback over 6 semesters.
   Rebuilt the 6-year-old CS 2310 autograder for ~400 students/semester: a Postgres queue with SELECT … FOR UPDATE SKIP
   LOCKED and 8 workers (measured — 16 saturated the host) cut deadline-burst grading from 45 minutes to ~4.
   Graded query results as relations, not text diffs — order-insensitive by default, ORDER BY only where staff flagged it — dropping hand
   re-grades from ~60 to 3 a semester; presented the structured-feedback format at a department teaching seminar.
Ramirez & Sons Landscaping — Weekend Crew Lead                                                         Summers 2021 – 2023 (part-time)
  Led 4-person weekend crews across 12–16 residential jobs a week — quoting, scheduling, and collecting payment.
Skills
Languages: TypeScript/Node.js · Python · Go · SQL                  Web & Data: React · Flask · PostgreSQL · SQLite
Practices & Tools: Git & PR code reviews · Docker · CI pipelines · Systems: Chaos & fault-injection testing · Raft/consensus
Unit, property & regression testing
Education
Alder Ridge University — BS, Computer Science                                                                       Aug 2022 – May 2026
   3.8 GPA · systems focus: distributed systems, databases, networks, operating systems · Dean's List every semester.
```
