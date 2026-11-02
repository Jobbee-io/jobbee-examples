<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Grading automation: TA work on the CS 2310 autograder

Alder Ridge University, CS 2310 Databases. I TA'd the course in fall 2023 and spring 2024 and ended up owning the autograder, first as maintenance duty and then as a rebuild. About 400 students a semester. It's the least glamorous thing I've done, and interviewers find it the most interesting, because it's a systems story with a real failure in it.

## What I inherited

A bash-and-Python system built up over about 6 years by successive TAs. Students submitted a ZIP to the course portal. Cron pulled submissions every 15 minutes. A container per student ran their SQL against a fixture database. Results were diffed against expected tables, and a CSV of scores fed the professor's spreadsheet script.

The problems, worst first:

1. **Up to 45 minutes to grade** in the hour before each deadline: 300+ submissions in a burst, processed one container at a time.
2. **The diff was wrong a lot.** Column order in a `SELECT *`, trailing whitespace, and row order without an `ORDER BY` all counted as wrong answers. I re-graded about 60 assignments a semester by hand, a full weekend per assignment cycle.
3. **Feedback was a wall of diff text.** Students couldn't tell which of their three sub-queries failed, so office hours filled with "why did I lose 12 points?"
4. **One shared fixture database.** Two submissions running at the same time could corrupt each other's data, and twice did, producing scores that were nobody's fault.

## What I rebuilt (spring 2024, about 6 hours a week)

**A queue instead of serial cron.** Submissions go into a Postgres queue table; Python workers claim jobs with `SELECT ... FOR UPDATE SKIP LOCKED`, so no submission is graded twice. I measured 4, 8 and 16 workers. 16 saturated the container host's disk and was slower than 8, so 8 it is. Deadline-burst grading time: 45 minutes → about 4.

**Comparing results as relations, not text.** Each query runs against the fixture, and results are compared as sets of rows: order-insensitive by default, order-sensitive only for tests the course staff flag as requiring `ORDER BY`, with a numeric tolerance for floating-point aggregates. Hand re-grades: about 60 a semester → 3, and all 3 were cases where the assignment text itself was ambiguous.

**A fresh database per run,** created from a template (`CREATE DATABASE ... TEMPLATE`) and dropped afterwards. The cross-contaminated scores stopped, and so did the "it passed on my run" tickets.

**Structured feedback.** Pass or fail per test, the student's result next to the expected one, capped at the first 3 mismatching rows per test. Office-hour score questions dropped enough that the professor asked me to present the format at a department teaching seminar.

## The integrity gap the rebuild created

Fall 2024, week 9. I was TA'ing CS 3440 by then, and the new CS 2310 TAs called me as the person who knew the grader. The professor flagged two joins submissions whose output tables were identical down to the column aliases, although the SQL differed. The grader had given both full marks, correctly: it compares result relations, not query text, and any two correct queries produce the same relations.

The old diff grader had leaked query structure (formatting, whitespace, even comments showed up in its diffs), so copying used to be visible by accident. My rebuild removed that leak on purpose. Nobody had ever decided the course needed a copy check. It had one by accident, and I removed it without knowing.

**What I built, over one reading week:**
- Fingerprints per run: a digest of the plan shape from `EXPLAIN`, the column aliases, and the submit time. Submissions with similar fingerprints and near-identical submit times go to a review queue for the professor, with the evidence attached.
- A comparison against each student's earlier submissions that semester, since style and typical mistakes shift when work isn't someone's own.
- Flagged is not penalized. The tool's only job is to put the right pairs in front of a person. That semester 4 pairs were flagged: 2 were coincidences (correct solutions converge), and 2 were real, handled by the professor through the university's process, not by me and not by the tool.

The rule I took from it: automation should make grading fair and make judgment possible, and never quietly make the judgment itself.

## What I'd tell a TA inheriting an autograder

1. Measure before you parallelize. My first 16-worker setup was slower than 8.
2. Every grader encodes a policy nobody wrote down. Find it before you change it.
3. Fair grading and copy detection are different problems with different tools.
4. The last few hand re-grades are usually unclear assignment text. Fixing the text is cheaper than fixing the grader.
