<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Grading automation — TA work on the CS 2310 autograder

Alder Ridge University, CS 2310 Databases. I TA'd the course for two semesters (Spring 2024, Fall 2023), and I ended up owning the autograder — first as maintenance duty, then as a redesign. ~400 students per semester. This is the least glamorous thing I've done and the one interviewers find most interesting, because it's a real systems story about a real failure.

## What the autograder was when I inherited it

A bash-and-Python creature built up over ~6 years by successive TAs. Flow: students submit a ZIP to the course portal → cron pulls submissions every 15 minutes → per-student container runs their SQL against a fixture database → diff-based scoring against expected result tables → CSV of scores that the professor's spreadsheet script consumed.

**The problems, in order of how much they hurt:**

1. **Grading took up to 45 minutes** in the hour before each deadline (300+ submissions in a burst, cron-serialized, one container at a time). Students refreshing the portal was its own little denial-of-service.
2. **Diff-based scoring lied.** Column order in a `SELECT *` result, trailing whitespace, row order without an ORDER BY — all counted wrong. I personally re-graded ~60 assignments per semester by hand because the diff said wrong when the answer was right. That's a full weekend per assignment cycle.
3. **Feedback was a wall of diff text.** Students couldn't tell *which* of their three sub-queries failed. Office hours filled with "why did I lose 12 points" questions the feedback should have answered.
4. **One shared fixture database per student run.** Two submissions running in parallel could — and twice did — corrupt each other's fixture state, producing scores that were nobody's fault and everybody's problem.

## What I rebuilt (Spring 2024, spread across the semester, ~6 hrs/week)

**Queue instead of cron-serial:** submissions into a simple queue table; 8 workers pulling concurrently. Grading burst time 45 min → **~4 minutes**. (I know 8 workers because I measured 4, 8, and 16; 16 saturated the fixture-container host's disk and made things worse. The number is 8 because of a graph, not a guess.)

**Semantic scoring instead of raw diff:** queries execute against the fixture; results compared as *relations* — order-insensitive by default, order-sensitive only when the assignment demands ORDER BY (flagged per-test by the course staff), numeric tolerance for floating-point aggregates. Re-grading-by-hand went from ~60 assignments/semester to **3** (all three were cases where the *assignment itself* was ambiguous, not the grader).

**Per-student fixture isolation:** each run gets a fresh database from a template (Postgres `CREATE DATABASE ... TEMPLATE`), torn down after. The cross-contamination scores died. Also killed a whole class of "works on my run, failed on theirs" support tickets.

**Structured feedback:** per-test pass/fail with the student's result vs. expected side by side, capped at first 3 mismatches per test. Office-hour "why did I lose points" questions dropped noticeably — the professor asked me to present the feedback format at a department teaching seminar, which was somehow more nerve-wracking than any demo I've done.

## The academic-integrity edge case that forced the rewrite

This is the story worth telling.

**Week 9, Fall 2024 semester (post-redesign, now I'm the "autograder alum" the new TAs call):** the professor flags that two submissions for the joins assignment are **identical down to variable names in the output tables** — but the students ran different SQL. The grader scored both full marks. Both *should* have, by design: my semantic comparison compares result relations, not query text. Result-relations are exactly what the assignment asked for. And exactly what makes copying trivial: any two correct queries produce identical relations.

The subtlety: **my redesign made integrity *checking* harder while making grading fairer.** The old diff-grader accidentally leaked query structure (whitespace, formatting, even comments leaked into the diff), so structural similarity between submissions was visible. Semantic comparison deliberately erases everything except the answers. Copy detection was a side effect of a bad grader, and I'd removed the bad grader.

**What was actually wrong (root cause, not vibes):** the course had **no integrity signal at all** for SQL assignments and was unknowingly leaning on the diff-grader's structural leakage as an accidental detector. Nobody had decided that; it just happened. Removing the leakage without replacing the signal left the course blind — and blind courses get found out by students, the hard way, in week 9.

**The rewrite of the check (mine, over one reading week):**
- **Per-run timing and query-shape fingerprints** (plan-shape digests from the fixture DB's EXPLAIN output): similar plan shapes across submissions with near-identical submit timestamps get flagged for human review. Not an accusation — a *queue for the professor's attention*, with the evidence attached.
- **Submission-history comparison** across the semester's runs (same student, prior assignments — writing style and mistake patterns drift when work isn't yours).
- Critically: **flagged ≠ penalized.** The tooling's only job is to put the right two submissions in front of a human. Two of the four flagged pairs that semester were legit coincidences (canonical solutions converge); two were real, handled by the professor through the university's process, not by me and not by the tool.

**The rule I took from it:** automation should make grading fair and make *judgment* possible — it should never silently make the final judgment itself. The old system made judgments (diff-based points) that looked automatic but encoded nobody's actual policy. The new system separates "what the machine can compare" (relations, plans, timestamps) from "what a human must decide" (whether two students cheated).

## What I'd tell a new TA inheriting any autograder

1. **Measure before you parallelize** — my first 16-worker config was slower than 8. Graphs, not folklore.
2. **Every grader encodes a hidden policy.** Find yours, write it down, and check whether anyone ever actually decided it.
3. **Fair grading and integrity detection are different problems** with different tools. Conflating them is how you get either false accusations or blind spots.
4. The 3 remaining hand-regrades will always be assignment-ambiguity bugs, not grader bugs. Fix the assignment text; it's cheaper than fixing the grader.
