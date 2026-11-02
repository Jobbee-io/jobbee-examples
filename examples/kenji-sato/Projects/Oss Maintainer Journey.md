<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The Tessergate maintainer journey: first commit to 1.0 and past it

Personal project, January 2019 to now. Tessergate validates and pins namespace-level Kubernetes resource guardrails as code. 4.1K stars, 41 releases, 37 contributors, MIT. My resume gives it a section of facts. This file holds the rest: why it's built the way it is and the alternatives I turned down, the timeline, how the project is governed, what each number means, what broke, the contributor conflict, and what I still haven't solved.

## The origin

In January 2019 my home lab had four clusters: one on a NAS and three on cloud free tiers, which I used to learn things I couldn't try at work. I kept losing the same hour. One namespace had quietly been set to `memory: unlimited`; one cluster's staging namespace had no default limit at all; and nothing told me until something fell over. The existing policy engines solved this correctly and heavily: admission controllers, custom resources, and an operating model built for teams with platform-engineering headcount. I wanted the audit-and-pin layer on its own, run from a laptop, with guardrails written as plain YAML in git. A weekend scratchpad became a CLI, and the CLI became Tessergate.

I built it for one opinionated user, me, before anyone else. The governance choices below all come from that.

## How it works

Tessergate is a single Go binary with five commands:
- `tessergate audit` reads every namespace's ResourceQuota and LimitRange objects through a read-only kubeconfig and compares them with the guardrail files in git.
- `tessergate diff` shows the drift.
- `tessergate pin` writes the patches needed to bring a namespace back in line, as YAML for a person or a CI job to apply. It only changes the cluster if you pass `--apply`.
- `tessergate export` generates admission-controller policies, for Kyverno and OPA Gatekeeper, from the same guardrail files.
- `tessergate migrate` rewrites guardrail files when the config format changes.

Guardrail files support team defaults with namespace overrides, and simple label selectors.

## The design decisions, and what I turned down

**A CLI, not a controller.** A controller needs cluster-admin rights to install. In brownfield clusters, the people who feel this problem often don't have those rights, and the people who do won't add another controller. A CLI with read-only access fits clusters nobody is allowed to touch, which is most of them. The trade-off I accepted and still defend: Tessergate can't enforce at admission time. It audits, pins drift, and exports the policies an admission controller would enforce. Teams that need enforcement graduate to the heavier tools, ideally still using Tessergate's output. Being clearly the lighter tool in a stack is a better position than being an average one among three.

**Plain YAML, not a policy language.** I considered Rego and CUE. Rego would have meant every reviewer learning a policy language to read a guardrail in a pull request. CUE was powerful, but few users knew it in 2019 and its error messages were hard for newcomers. I chose YAML with a small schema, validated with JSON Schema. The cost is expressiveness. Inheritance and selectors arrived only in v0.9, and some requests still can't be expressed. I'd make the same call.

**Go.** It uses the same client libraries as Kubernetes itself, and it ships as one static binary that runs on a laptop or in CI with nothing else installed.

**No telemetry, ever.** The tool doesn't phone home. That makes my usage numbers rough (see below), and I accept that. A guardrails tool that reports on your clusters to someone else's server is a tool security teams rightly block.

## The timeline

- **January 2019:** first commit. v0.1 in March (audit only); public on GitHub in April.
- **May 2020:** v0.5 changed the config format and broke three users' CI in one week. One of them filed a dry issue titled "your tool is great, please stop improving it."
- **September 2020:** v0.7 shipped the breaking-change policy and the `migrate` command.
- **2021:** I recruited the maintainers who made the project durable. The first was a core contributor who now owns the config parser. The second was a docs lead. The third was a CI-focused contributor whose migration-test harness made the breaking-change policy enforceable.
- **October 2021:** the ClusterCamp talk. Weekly installs went from 190 to 890 within a month (`Projects/Conference Talk That Mattered.md`).
- **September 2022:** 1.0, with a written stability commitment.
- **February to July 2023:** the contributor conflict below.
- **2024 to now:** the 1.x line, currently 1.6.

## The breaking-change policy

The v0.5 issue is the reason the policy exists. It has four parts:
- deprecation notices two minor versions ahead;
- old flags kept for a full minor cycle;
- migration notes generated automatically in every release body;
- `tessergate migrate` for every format change.

The migration-test harness enforces it. On every release it runs the stored config fixtures against the previous two minor versions and the three most recent Kubernetes minor versions.

The cost is slower iteration. The benefit showed at 1.0. It landed on two years of kept promises, and the release thread had zero breaking-change complaints. On a project this size, that silence is the metric.

## The 1.0 launch

1.0 shipped in September 2022, after three and a half years of 0.x, the last two under the policy. It came with a written stability commitment: the config format is frozen, and breaking changes come only behind explicit version gates. It also had a migration guide and a launch post that led with the failure modes, including the v0.5 story. A 1.0 is read as a promise, and I only had the right to make one because the policy had been kept for two years first.

## Governance

- **Roles:** contributor, then reviewer, then maintainer. There are 3 maintainers with merge rights besides me. Each owns an area through a CODEOWNERS file: config parser, docs, CI and release.
- **Format changes go through a written RFC**, open for at least two weeks.
- **Decisions are by lazy consensus among maintainers.** As creator I keep a tie-break. I've used it twice, and I want to give it up (see below).
- **The code of conduct** has been the Contributor Covenant since 2020. Enforcement is the hard part, as the conflict below shows.
- **Service targets:** first review on a pull request within 2 days (median), issue triage within a week.
- **Time:** about 6 hours a week on average, more in release weeks. All of it on my own time; the IP boundary is in my applicant file.

How I recruit maintainers matters more than any feature. I recruit on evidence of judgment, not volume: one careful escalation path in an issue thread is worth fifty closed typos. The point is to turn your best issue commenters into co-owners before you burn out, not after.

## The numbers, and what they mean

- **4.1K stars:** the GitHub count. It's close to a vanity metric. I list it because people search on it.
- **41 releases:** 24 in the 0.x line (March 2019 to August 2022) and 17 since 1.0.
- **37 contributors:** people with at least one merged pull request. 9 have more than 5.
- **Weekly installs:** release-binary downloads plus Homebrew installs per week, from the platforms' public counts. Without telemetry I can't separate new users from reinstalls or CI runners, so I use it only as a trend. About 190 a week before ClusterCamp, 890 at the peak a month after, and between 500 and 900 every week since.
- **Adopters:** organizations that added themselves to the adopters file by pull request. There were 9 at 1.0, 27 a year later, and 38 today. Most are single teams. Three are companies, none of them my employers, that built Tessergate into their internal platform toolchains. That's the adoption I'm proudest of.

## What broke, and the fixes

- **v0.5, May 2020:** the format change above. The fix was the policy, the `migrate` command, and later the harness.
- **1.3.0, March 2024:** a regression in LimitRange parsing for pods with several containers that each set default limits. The harness missed it because none of the fixtures had more than one container. A user reported it on a Saturday morning, and 1.3.1 shipped 36 hours later. We added 14 fixtures for multi-container cases, and the release checklist now asks which fixture covers each parser change.

## The contributor conflict

In 2023 a contributor I'll call V was technically strong. Over about five months:
- his pull requests quietly reverted other contributors' decisions without discussion;
- his review comments on other people's pull requests read as territory claims, including "this is mine, hands off" phrasing toward a first-time contributor;
- a channel conversation with the docs lead turned personal;
- when I declined to fast-track his architecture rewrite, he threatened to fork "the real Tessergate."

What I did, in order:
1. **Private, direct and documented.** Two direct messages, in April and May, each naming the specific behavior and its impact. Each offered a path back: take the rewrite through the normal RFC process, with no privileged lane. He read both. Neither changed anything.
2. **Public standards, applied equally.** The code of conduct already covered this. The hard part was enforcing it on a productive contributor. In June I removed the personal attack under channel moderation and suspended his review rights pending the RFC. I stated it in the governance channel with quotes of the behavior, not verdicts on his character.
3. **The target came first.** The docs lead got an apology from me, because the conflict had cost her room in her own project, and a standing offer to hand me any interaction she didn't want to carry. She's still the docs lead. Keeping her is the outcome that matters most.
4. **The fork threat got no answer.** A fork is free, legal and none of my business. Treating it as a threat would have made it leverage. He forked in July; the fork was archived four months later. I never mentioned it in the project.

My mistake: I waited too long. For about six weeks I told myself "he's productive, maybe this passes." In that time the first-time contributor he had targeted went quiet and never came back. That is the cost I weigh heaviest. Productivity is never an exemption from conduct rules. Any ambiguity about that costs you exactly the quiet, careful contributors you can't afford to lose.

## Boundaries with employers

At SubstrateNine I maintain the official guardrails starter configs for its users. Those live in SubstrateNine's repository; Tessergate stays employer-neutral. I've turned down two commercial vendors who offered to bring Tessergate into their portfolios. Its neutrality is what makes it useful, and three of the adopter companies told me so directly.

## What isn't solved

- **Bus factor.** The release signing keys sit with me and one other maintainer, and I still hold the tie-break. My plan for 2027 is a three-maintainer steering vote and keys shared with all four maintainers. Until then, the project depends on me more than it should.
- **Admission-time enforcement** is still the most requested feature, with over 200 thumbs-up on the issue. I keep saying no, because it would make Tessergate a controller and lose the property that makes it fit brownfield clusters. Export is the answer I offer instead. Not everyone accepts it.
- **Kubernetes keeps moving.** Each Kubernetes minor release costs about a weekend of compatibility work. The CI maintainer and I split it, and it is the least visible work in the project.
- **My attention is the binding constraint.** It isn't toxic contributors anymore; it's me. That's why recruiting gets more of my care than any feature.

## What I'd do differently

- Write the breaking-change policy before v0.5, not after it broke three people's CI.
- Act within a week on conduct problems, whatever the person's output.
- Share release keys and the tie-break from 1.0 on, when the project first made a public promise.
