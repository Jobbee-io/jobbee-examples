<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Diego Ramirez

diego.ramirez@example.com · (555) 014-7788
Austin, TX

*This is my resume's bigger sibling — everything that didn't fit on one page, with the numbers and the "what I actually did" behind every line. A one-pager is what you print; this is what I actually know. The project files in `Projects/` hold the full stories.*

---

## Summary

New-grad software engineer (BS CS, May 2026, Alder Ridge University, 3.8 GPA). Two internships on production teams, one shipped payment-error state machine, one distributed-systems capstone (Raft KV store) I can defend line by line. F-1 → OPT through mid-2027, STEM extension through spring 2029; will need H-1B sponsorship inside that window — stated up front, happy to walk through the process. I'm applying for my first full-time role and I'm optimizing for the team I'll learn from, not the title.

---

## Internships

### Cartway — Software Engineering Intern, Checkout (Jun 2025 – Aug 2025)

Marketplace payments platform; checkout team of 9. Hybrid, Austin.

- **Owned the payment-error state machine end-to-end.** Before: six ad-hoc error branches in the checkout service, each retrying a little differently. I designed and shipped the typed state machine (9 states, 14 transitions) that every payment error now flows through: explicit retry budget per error class, terminal states that block retry, and an events table for support to read. Implemented in TypeScript, ~2,400 lines including tests.
- **The bug I caused and fixed (week 4).** My first version treated a gateway timeout as terminal. Under a real gateway incident it stranded 312 in-progress checkouts; I traced it from support tickets, wrote the fix (timeout → retryable, with a deadline), and added the regression test that would have caught it. Full story: `Projects/Internship Checkout.md`.
- **Shipped, verified:** checkout error-rate during gateway incidents dropped from "page a human" to "self-heals under retry budget" per the team's incident reviews for the three months after launch. ~1,400 checkouts/day flow through it.

### Harborlight Software — Software Engineering Intern, Platform Tools (May 2024 – Aug 2024)

40-person consultancy; I was one of two interns on the internal-tools pod. On-site, Austin.

- **Built the client-project status dashboard** (Python/Flask + Postgres, then the React frontend) that replaced a spreadsheet updated by hand every Friday. Adopted by 6 project leads; the spreadsheet is gone.
- **Wrote the deployment scripts for the dashboard itself** (Docker + a compose file), which is the least impressive line here and the one that taught me the most: my first deploy broke because I'd hardcoded a path that existed on my laptop and nowhere else.
- Small-grinds ticket duty: ~60 small fixes across internal tools. Learned to read other people's code fast and to leave it tidier.

---

## Teaching & Part-Time

### Alder Ridge University — Teaching Assistant, CS courses (Jan 2023 – May 2026, part-time during semesters)

- **CS 3440 Distributed Systems (Fall 2025, Fall 2024):** led weekly lab sections of 30, graded design docs, ran office hours. Designed 4 of the lab exercises, including the failure-injection lab (kill-a-node mid-election) that students rated the most useful and most hated exercise of the course.
- **CS 2310 Databases (Spring 2024, Fall 2023):** autograder duty. Rebuilt large parts of it — see `Projects/Grading Automation.md` for the academic-integrity edge case that forced the rewrite.
- ~400 students per semester across both courses; wrote ~9,000 pieces of feedback over 6 semesters. Grading under deadline pressure is where I learned to be fast *and* fair.

### Ramirez & Sons Landscaping (family business) — part-time, summers 2021–2023

- Weekend crew lead by summer 2023: 4-person crews, 12–16 residential jobs/week. Quoting, scheduling, collecting payment. Not tech — but it's where I learned that showing up on time and being trusted with the keys is a skill.

---

## Projects

### Distributed KV store with Raft — CS 3440 capstone (Jan 2026 – May 2026)

- Go, ~5,600 lines with tests. Three-to-five-node cluster: leader election, log replication, snapshotting, and a linearizable get/put API behind a gRPC-ish (course framework) interface.
- Passed the course's reference test suite (1,200 scenarios including partition maps and process kills) and my own fault-injection harness (chaos script: random node kills at 2–8s intervals, 30-minute soak, zero committed-write loss across 40 runs).
- Known weaknesses I can enumerate: no lease-based reads (every read goes through the log — correct but slow), snapshot compaction tested at toy scale only. Full notes: `Projects/Capstone Distributed Kv.md`.
- **Ran the course's final-project showcase demo** (top 8 of 96 teams chosen to demo).

### Course projects with real depth

- **Query optimizer mini-project (CS 2310, 2023):** implemented select/project/join reordering over a toy catalog with cost-based choices; measured plan times against Postgres's on the same dataset (mine was 4–40× worse, and the writeup about *why* got full marks — the honest analysis was the assignment).
- **Socket-level HTTP server (CS 3305, 2022):** C, epoll-based, concurrency lab. First time I truly understood what "the network is unreliable" means at the syscall level.

### Hackathons

- **Longhorn Dev Days 2025 (2nd place, 41 teams):** "receipt-splits" — photo-a-receipt, split-the-bill app. I did the OCR-to-ledger pipeline (Tesseract + normalization heuristics) and the API. Learned 30 hours of Go in a weekend; haven't stopped using it.
- **Atl-Sea Hacks 2024 (finalist):** campus lost-and-found service. Fun, and the first time I watched strangers use something I built in real time.

---

## Education

**BS Computer Science, Alder Ridge University, Aug 2022 – May 2026.** 3.8 GPA. Focus: systems (distributed systems, databases, networks, operating systems). TA for 6 semesters (above). Dean's List every semester.

---

## Skills — honest edition

- **Comfortable:** TypeScript, Python, Go, Java, C++ (coursework-era), SQL, React, Git, Docker basics, testing (unit + the autograder taught me property-style thinking).
- **Used in production (internship-scale):** TypeScript/Node, Python/Flask, Postgres, Redis (cache), CI pipelines.
- **Academic but real:** Raft/consensus, failure-injection testing, basic query optimization.
- **Not pretending:** Kubernetes (deployed to it, never operated it), message queues (coursework only), anything at scale.

---

## Numbers I can defend

- 9 states / 14 transitions in the payment-error state machine; ~1,400 checkouts/day through it; 312 stranded checkouts in the bug I caused and fixed.
- 3-to-5-node Raft cluster, ~5,600 lines, 1,200-scenario reference suite + 40 chaos-soak runs, zero committed-write loss.
- ~400 students/semester, ~9,000 graded artifacts over 6 semesters of TA work.
- 6 project leads adopted the status dashboard; the Friday spreadsheet died.
