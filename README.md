# Jobbee Workspace Examples

Example Jobbee workspaces — real-looking, entirely fictional people, showing exactly what to put in the three files that do the work:

- **Applicant Profile** (`job_applicant.md`) — how Jobbee reads your situation when it searches for jobs
- **Base Resume** (`resumes/base/MASTER_BASE_RESUME.md`) — your resume's bigger sibling: everything that didn't fit on the page
- **Project files** (`projects/*.md`) — one file per project, capture each and every detail you know

> [Jobbee](https://jobbee.io) finds your jobs and writes your resumes. These example workspaces show the input side of that: the workspace files you own, written the way Jobbee reads them.

## What's here

Each folder under `examples/` is one complete example workspace:

| Persona | Level | Why it exists |
|---|---|---|
| [`maya-chen`](examples/maya-chen/) | Senior Backend Engineer | The core use case: senior IC with deep systems work, targeting staff-level roles |
| [`diego-ramirez`](examples/diego-ramirez/) | New Graduate | Entry-level search: internships, projects, and coursework as evidence |
| [`sam-oaks`](examples/sam-oaks/) | Staff+ / Lead | Leadership scope without losing hands-on depth |

> The three folders are fictional personas, assembled for these examples. Names, employers, numbers, and projects are invented; any resemblance to real people or companies is coincidental. Don't copy the specifics — copy the shape: what kind of fact goes in which file.

## Using an example

1. Pick the persona closest to your level.
2. Read `job_applicant.md` first — it's the file Jobbee reads when searching for your jobs.
3. Open `resumes/base/MASTER_BASE_RESUME.md` — the longer, fuller record your tailored resumes are cut from.
4. Skim `projects/` — depth is the point. The bar for "enough": the file should hold the answer to any relevant interview question about that project.

Then write yours. Plain, honest notes beat polished prose — Jobbee reads for facts, not grammar.

## Repository layout

```
examples/<persona>/
  job_applicant.md                  # Applicant Profile — read by job search & scoring
  resumes/base/MASTER_BASE_RESUME.md  # Base Resume — read by resume tailoring
  projects/*.md                     # Project files — one per project, no limit
```

## License

Contents of this repository are licensed under [CC-BY-4.0](LICENSE). You are free to copy and adapt the example files into your own Jobbee workspace (or anywhere else) with attribution.

## More

- [Jobbee](https://jobbee.io) — the product these examples are for
- [Guide: the workspace files that do the work](https://jobbee.io/guide) — the concepts, explained

## Contributing

Found a fact that doesn't hold up, or want to add a persona (career-changer, design, product…)? Issues and PRs are welcome. New personas must be fictional end-to-end — the scrub gate in CI enforces it.
