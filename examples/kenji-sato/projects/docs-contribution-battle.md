<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The docs-contribution battle — upstream docs, merge politics, and what got merged anyway

2021–2023, upstream project: **Autoscale Collective** (invented throughout), a widely deployed cluster-autoscaling component — the kind of foundational OSS where the docs are load-bearing infrastructure and the maintainers are five volunteers guarding a repo with 9K stars. This file is the honest record of my attempt to fix a documentation problem that everyone acknowledged and nobody was empowered to fix, and it's in my record because *how a change lands upstream* is a real skill that no amount of technical correctness substitutes for.

## The problem, stated precisely

Autoscale Collective's scaling-behavior docs had drifted two minor versions behind reality. Three specific claims in the official docs were wrong in ways that cost real hours: the scale-down stabilization window was documented as fixed (it had been configurable since v0.11), the "no scale-down under multiple pending pods" guarantee had been quietly narrowed, and one flags table was missing four production-relevant flags entirely. I knew because Tessergate's guardrail logic interacted with all three behaviors, and my migration-test harness had caught each discrepancy the hard way (`projects/oss-maintainer-journey.md`).

The upstream issue tracker already had three open issues touching the same docs — from 2021, 2022, and one that was just the word "+1" and forty thumbs-up. The docs were a known wound. The maintainers weren't negligent; they were five volunteers whose review bandwidth went to code, with a contributing guide that said docs PRs were welcome and a practice where no one had time to welcome them.

## The battle, in phases

**Phase 1 — the naive PR (lost, deservedly).** I fixed everything at once: 14 files, restructured two pages, rewrote the flags table, "improved" the tone throughout. The PR sat for five weeks and closed with: *"Appreciate the energy, but this is a rewrite — can't review it as a docs change. Please open smaller PRs."* Fair verdict, wrong on my side. I had shipped a mirror-image of the review-bandwidth problem I was complaining about.

**Phase 2 — the flank (worked, slowly).** New strategy: precision over volume, and social proof before review cost.
- One PR per factual error, minimal diff — stabilization window first, with the test output from my harness pasted into the PR description as evidence. Merged in nine days.
- The flags-table PR I split in two: the four missing flags (pure addition, trivial to review) and the restructure (parked — see phase 3). The additions merged in six days.
- Each merged PR linked the dusty issue it resolved with a note — not "you should have done this sooner," just "closes #1482." Closing three-year-old issues publicly recalibrated the maintainers' cost-benefit on docs PRs: same review cost, visible payoff.

**Phase 3 — the structure fight (partially won, correctly lost).** The restructure proposal — reorganizing the concepts pages around behavior instead of flags — was the change practitioners actually needed, and it died, twice: first as a PR (too big), then as a proposal thread where two maintainers disagreed about which of them owned docs decisions, in public, until the thread went quiet in the specific way threads do when everyone wants it to be over. **I let it die, and that was the right call.** A volunteer maintainer group with no docs owner has no one empowered to approve a restructure; the correct fixes were (a) the precision PRs that *didn't* require ownership decisions, and (b) offering to become the owner rather than asking the question nobody could answer. I offered; the timing was wrong on their side (maintainer elections were in flux); the offer stands.

**Phase 4 — the durable artifact (won, the quiet way).** With the maintainer's blessing I published an external **"Autoscale Collective scaling behaviors, verified"** page — a versioned, test-backed companion doc generated from my migration harness, updated per release, clearly marked unofficial. It now gets more referral traffic from the project's own community channels than some official pages, and two Autoscale Collective maintainers link it when users hit the exact discrepancies it documents. The official docs' three errors are fixed and merged; the *structure* lives on outside the repo, maintained by the same harness that found the errors.

## What the battle taught me about OSS reality

- **Review bandwidth is the scarcest resource in open source, and diff size is a tax on it.** The fourteen-file PR was me spending their budget for them. Every successful change I've made upstream since is sized against the reviewer's week, not my ambition.
- **Closing old issues is governance work, not just hygiene.** The three stale issues weren't noise; they were the maintainers' own backlog telling them what users needed. Resolving them publicly built the credit my later, bigger asks drew on.
- **Some battles are won by not fighting them.** The restructure died because the org structure couldn't carry it. Naming that — "there is no docs owner" — instead of pushing a fifth proposal was the difference between a dead thread and a standing offer.
- **External verification is a legitimate docs channel.** When upstream can't move at the speed accuracy requires, a test-backed companion doc keeps users safe *and* creates the evidence trail that eventually gets the official docs fixed. This pattern is now in my employer toolbox too: at Orcadia, the "verified against release" stamps on docs came directly from watching this project's dynamics (`projects/developer-trust-turnaround.md` is Dana's file, but the same mechanic — named verification beats aspirational accuracy).
- **The version I tell in interviews:** I didn't win by being right. I was right in phase 1 and got the PR closed. I won by being right *at the scale the repo could absorb* — which is the actual skill, and the one that separates contributors maintainers recruit from contributors they brace for.
