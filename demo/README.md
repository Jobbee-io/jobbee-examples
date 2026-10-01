<!-- ILLUSTRATIVE DEMO ARTIFACT for Jobbee (jobbee.io). Hand-authored for this example — not a live product run. CC-BY-4.0, see repo LICENSE. -->

# The full loop — how one Jobbee search works

> ILLUSTRATIVE DEMO — everything in this folder is hand-authored to show the shape of a Jobbee loop. It is not a live product run, and Thornfield Pay is a fictional company.

Jobbee does two things with your workspace files: it **finds and scores jobs** against what you've told it, and it **writes a tailored resume** per job. When your files are ambiguous or missing specifics, it doesn't guess — it pauses and asks you a clarification question by email, and your answer is written back into your files. Here's the loop, using [`priya-anand`](../examples/priya-anand/) as the candidate:

```
 your files                    Jobbee                          output
 ──────────                    ──────                          ──────
 job_applicant.md      ──►   reads what you want,      ──►   scored matches
 (who you are,           │    scores jobs against      │     (with rationale)
  what you've got,       │    it; pauses to ask        │
  what you won't take)   │    when something's         │
                         │    missing or ambiguous     │
 resumes/base/           │                             ├──►  match rationale
 MASTER_BASE_RESUME.md ──►                               │    (why this job,
 (the full record        │                               │     what matched,
  to tailor from)        │                               │     what to check)
                         │                               │
 projects/*.md         ──►   depth evidence for        ──►   tailored resume
 (one file per           │    selective pull-forward  │     (1–2 pages, per job)
  project)               │    into the one-pager      │
```

If a job is interesting but your file is thin — say, it never states your citizenship, or "platform experience" could mean two things — the loop inserts a step: **Jobbee asks, you answer, the answer is written back into `job_applicant.md`** (under `## Clarifications`, with visa facts also landing in `## Visa / Work Authorization` as machine-readable bullets). Next search, that fact is just... there.

## This demo, artifact by artifact

- **[`jd-fintech-api-pm.md`](jd-fintech-api-pm.md)** — a fictional posting: *Principal Product Manager, API Platform* at Thornfield Pay (NYC hybrid, TN/H-1B sponsorship offered).
- **[`match-rationale.md`](match-rationale.md)** — how the job scored for Priya (82/100): which of her file facts matched, which fact pulled the score down (comp, flagged as a trade-off rather than silently resolved), and the two clarifications her file had *pre-answered* so no pause was needed. Read this one if you want to understand why the files reward completeness.
- **[`tailored-resume.md`](tailored-resume.md)** — the resume Jobbee writes for that one job: selective pull-forward from her base resume (the API platform and API-sunset stories front-loaded, the payments expansion kept, the pricing experiment dropped for this audience), reframed for the JD's stated needs.

## The input side

Priya's files are the input half of this loop:

- [`examples/priya-anand/job_applicant.md`](../examples/priya-anand/job_applicant.md) — the profile Jobbee reads to search and score, including her `## Clarifications` history and `## Visa / Work Authorization` section
- [`examples/priya-anand/resumes/base/MASTER_BASE_RESUME.md`](../examples/priya-anand/resumes/base/MASTER_BASE_RESUME.md) — the full record tailoring cuts from
- [`examples/priya-anand/projects/`](../examples/priya-anand/projects/) — five project files providing the depth evidence

## The honest caveats

This trio is **hand-authored for illustration**: the job, the company, the score, and the resume were written by a person to show what the loop looks like, not captured from a live run. The parts that are real are the *contracts*: the file categories, the open-ended markdown format, the clarification write-back behavior (Q/A log under `## Clarifications`, visa facts under `## Visa / Work Authorization`), and the tailoring philosophy — pull forward what this job needs, keep the full record in the base resume.
