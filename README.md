# Jobbee Workspace Examples

Example Jobbee workspaces — real-looking, entirely fictional people, showing exactly what to put in the three files that do the work:

- **Applicant Profile** (`Applicant Profile.md`) — how Jobbee reads your situation when it searches for jobs
- **Base Resume** (`Base Resume.md`) — your resume's bigger sibling: everything that didn't fit on the page
- **Project files** (`Projects/*.md`) — at least one file per project, capture each and every detail you know

> [Jobbee](https://jobbee.io) finds your jobs and writes your resumes. These example workspaces show the input side of that: the workspace files you own, written the way Jobbee reads them.

## What's here

Each folder under `examples/` is one complete example workspace. Pick the persona closest to your situation — profession *and* the use-case column. (Professions were chosen so that senior pay clears $400K TC / $190K base on [levels.fyi](https://www.levels.fyi) — these are searches where comp precision genuinely matters.)

| Persona | Profession | Level | Use case demonstrated |
|---|---|---|---|
| [`maya-chen`](examples/maya-chen/) | Senior Backend Engineer | Staff-track senior | **Picky** — hard filters (on-call maturity, industries) + a non-visa clarification answered |
| [`diego-ramirez`](examples/diego-ramirez/) | New Graduate (SWE) | Entry | **Immigrant** — F-1/OPT/STEM timeline, sponsorship need, visa clarification + write-back |
| [`sam-oaks`](examples/sam-oaks/) | Staff+ / Lead | Leadership without losing hands-on | Core senior-IC shape: scope without title inflation |
| [`priya-anand`](examples/priya-anand/) | Principal Product Manager (API platform / payments) | Principal | **Full-data** — the most complete workspace: ranked locations, per-geo comp, machine-readable visa facts, clarification history. Also **cross-country** (US/UK/remote-EU) and **picky** (won't-list stated plainly) |
| [`ravi-kulkarni`](examples/ravi-kulkarni/) | Data Scientist (experimentation / causal inference) | Senior DS, 6 YOE | **Immigrant** — H-1B mechanics, PERM in progress, the transfer-vs-restart trade-off written out; real-life location constraint (direct flights to spouse's city) |
| [`marcus-webb`](examples/marcus-webb/) | Investment Banking Director (TMT / fintech) | Director, 15 YOE | **Picky** — 8 explicit filters with reasons, comp *structure* floor; proof `Projects/` isn't only for engineers (deals as projects) |
| [`elena-vargas`](examples/elena-vargas/) | Enterprise Account Executive (infra / data platforms) | Principal AE, 12 YOE | **Quota-carrying comp constraints** — OTE floor, base/variable split, uncapped accelerators, territory quality, per-year attainment history incl. an honest 94% year |
| [`dana-whitfield`](examples/dana-whitfield/) | Principal Product Marketing Manager (developer / technical products) | Principal PMM, 14 YOE | **Brand-evangelist work in a comp-real title** — title precision note, messaging tested in dev communities, positioning failure postmortem, win/loss as strategy |
| [`kenji-sato`](examples/kenji-sato/) | Staff Developer Advocate (engineer-origin DevRel) | Staff / lead-track, 11 YOE | **OSS record as proof-of-work** — 4.1K-star maintainer project documented as searchable facts, measured talk outcomes, green-card visa facts, travel constraint stated plainly |

> The folders are fictional personas, assembled for these examples. Names, employers, numbers, and projects are invented; any resemblance to real people or companies is coincidental. Don't copy the specifics — copy the shape: what kind of fact goes in which file.

## Clarifications & write-back

Jobbee reads these files with NLP — there's no schema to satisfy. When a file is **ambiguous or missing a material fact**, Jobbee pauses and asks a clarification question by email; your answer is then written back into `Applicant Profile.md` as a Q/A log under `## Clarifications` (newest last), with visa/work-authorization answers also landing as plain bullets under `## Visa / Work Authorization`. See it in [`diego-ramirez`](examples/diego-ramirez/Applicant%20Profile.md) (the visa question fired for him, and the answer created his visa section) and [`priya-anand`](examples/priya-anand/Applicant%20Profile.md) (a visa clarification plus an ambiguity clarification, both answered and logged). Contrast on purpose: [`maya-chen`](examples/maya-chen/Applicant%20Profile.md) states her citizenship inline, so the visa gate never fired for her — she only got a non-visa clarification (comp-vs-remote).

## Full loop demo

The [`demo/`](demo/) directory shows one complete loop end-to-end (illustrative, hand-authored): a fictional job posting → the match rationale explaining the score against priya-anand's files → the tailored resume Jobbee writes from her base resume. Start at [`demo/README.md`](demo/README.md).

## Using an example

1. Pick the persona closest to your level.
2. Read `Applicant Profile.md` first — it's the file Jobbee reads when searching for your jobs.
3. Open `Base Resume.md` — the longer, fuller record your tailored resumes are cut from.
4. Skim `Projects/` — depth is the point. The bar for "enough": the file should hold the answer to any relevant interview question about that project.

Then write yours. Plain, honest notes beat polished prose — Jobbee reads for facts, not grammar.

## Repository layout

Files appear here with the same names you see in the Jobbee editor (the workspace file tree), not the internal storage paths.

```
examples/<persona>/
  Applicant Profile.md    # Applicant Profile — read by job search & scoring
  Base Resume.md          # Base Resume — read by resume tailoring
  Projects/*.md           # Project files — at least one per project, no limit
demo/                     # Illustrative full loop: JD → match rationale → tailored resume
```

## License

Contents of this repository are licensed under [CC-BY-4.0](LICENSE). You are free to copy and adapt the example files into your own Jobbee workspace (or anywhere else) with attribution.

## More

- [Jobbee](https://jobbee.io) — the product these examples are for
- [Guide: the workspace files that do the work](https://jobbee.io/guide) — the concepts, explained

## Contributing

Found a fact that doesn't hold up, or want to add a persona (career-changer, design, product…)? Issues and PRs are welcome. New personas must be fictional end-to-end — the scrub gate in CI enforces it.
