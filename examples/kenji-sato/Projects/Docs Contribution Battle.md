<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The docs-contribution battle: upstream docs, merge politics, and what got merged anyway

2021 to 2023, on my own time. The upstream project was Autoscale Collective, a widely deployed cluster-autoscaling component: 9K stars, five volunteer maintainers, and docs that were load-bearing infrastructure for everyone who ran it. I tried to fix a documentation problem that everyone acknowledged and nobody was empowered to fix. On my resume it's one pointer in the open-source section. It's here because how a change lands upstream is a skill that being right doesn't replace.

## The problem

The scaling-behavior docs had drifted two minor versions behind the code. Three errors cost people real hours:
- the scale-down stabilization window was documented as fixed, but it had been configurable since v0.11;
- the "no scale-down while several pods are pending" guarantee had been quietly narrowed;
- the flags table was missing four flags that mattered in production.

I found all three because Tessergate's guardrails interact with those behaviors. Our migration-test harness, built by Tessergate's CI maintainer, with autoscaler scenarios I added, caught each discrepancy the hard way (`Projects/Oss Maintainer Journey.md`).

The issue tracker already had three open issues about the same docs: one from 2021, one from 2022, and one that was just "+1" with forty thumbs-up. The maintainers weren't negligent. They were five volunteers whose review time went to code. The contributing guide said docs pull requests were welcome, but nobody had time to review them.

## Phase 1: the naive pull request (lost, deservedly)

In mid-2021 I fixed everything at once: 14 files, two pages restructured, the flags table rewritten, the tone "improved" throughout. It sat for five weeks, then closed with: "Appreciate the energy, but this is a rewrite. Can't review it as a docs change. Please open smaller PRs." Fair. I had handed them a mirror image of the review-bandwidth problem I was complaining about.

## Phase 2: small and precise (worked, slowly)

Late 2021 into 2022. One pull request per factual error, with the smallest possible diff:
- The stabilization window went first, with the harness output pasted into the description as evidence. Merged in nine days.
- I split the flags table in two. Adding the four missing flags was trivial to review and merged in six days. The restructure I parked.
- Each merged pull request closed the stale issue it resolved, with a plain note and no "you should have done this sooner."

Closing two- and three-year-old issues in public changed the maintainers' math on docs pull requests. The review cost was the same; now the payoff was visible.

## Phase 3: the structure fight (partly won, rightly lost)

The change practitioners needed most was reorganizing the concept pages around behaviors instead of flags. It died twice in 2022. First as a pull request, which was too big. Then as a proposal thread, where two maintainers disagreed in public about which of them owned docs decisions, until the thread went quiet the way threads do when everyone wants them to be over.

I let it die, and that was right. A volunteer group with no docs owner has nobody who can approve a restructure. The right moves were the precision fixes, which needed no ownership decision, and offering to become the docs owner instead of asking a question nobody could answer. I offered. Maintainer elections were in flux, so the timing was wrong on their side. The offer still stands.

## Phase 4: the durable artifact (won, quietly)

In 2023, with a maintainer's blessing, I published an external page: "Autoscale Collective scaling behaviors, verified." It's versioned, generated from the harness, updated each release, and clearly marked unofficial. It now gets more referral traffic from the project's own community channels than some official pages. Two maintainers link it when users hit the exact discrepancies it documents. The three official errors are fixed and merged; the structure lives outside the repo, maintained by the same harness that found the errors.

## What I took from it

- **Review bandwidth is the scarcest resource in open source, and diff size is a tax on it.** Every change I've landed upstream since is sized to the reviewer's week, not my ambition.
- **Closing old issues is governance work.** Those stale issues were the maintainers' own backlog telling them what users needed. Resolving them in public built the credit my bigger asks drew on.
- **Some fights are won by not having them.** The restructure died because the project's structure couldn't carry it. Naming that ("there is no docs owner") beat pushing a fifth proposal.
- **A test-backed companion doc is a legitimate docs channel.** When upstream can't move as fast as accuracy needs, it keeps users safe and builds the evidence that eventually gets the official docs fixed. The same idea, verifying claims against a running build rather than trusting docs, is behind the evidence gate I set up at Orcadia (`Projects/Advocacy Failure Recovery.md`).

I didn't win by being right. I was right in phase 1 and got the pull request closed. I won by being right at the size the repo could absorb.
