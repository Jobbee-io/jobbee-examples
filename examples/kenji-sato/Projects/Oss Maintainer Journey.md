<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The Tessergate maintainer journey — first commit to 1.0 and past it

Personal project, January 2019 – present. Tessergate validates and pins namespace-level Kubernetes resource guardrails as code. 4.1K stars, 41 releases, 37 contributors, MIT. This file is the maintainer story — the origin, the decisions, the 1.0, and the contributor conflict that taught me more about governance than any conference talk on the subject.

## The origin, told exactly

January 2019: my home lab had four clusters (a mix of a NAS-hosted setup and cloud free tiers I used for employer-side learning I couldn't do at work), and I kept re-burning the same hour: one team's namespace quietly set `memory: unlimited`, one cluster's staging namespace had no default limit at all, and nothing told me until something fell over. Existing policy engines solved this correctly and heavily — admission controllers, CRDs, an operating model built for platform teams with platform-team headcount. I wanted the *audit-and-pin* layer by itself, run from a laptop, with guardrails expressed as plain YAML in git. A weekend scratchpad became a CLI; the CLI became Tessergate.

I did not build it "to grow an audience." I built it because the hour kept re-burning, and I mention that because every piece of governance advice below is downstream of a tool built for one opinionated user first. The 4.1K stars followed usefulness, not marketing.

## The decisions that shaped the project

**Why guardrails-as-code, not a controller.** The controller architecture was the road not taken, deliberately: laptops-first means no cluster-side install, which means the tool fits brownfield clusters nobody is allowed to touch — which turns out to be most of them. The trade-off I signed up for and still defend: Tessergate can't *enforce* at admission time; it audits, pins drift, and generates the configs an admission controller would consume. Practitioners who need enforcement graduate to the heavy tools, ideally still using Tessergate's output. Being explicitly the *lighter* tool in a stack of heavier ones is a better position than being an average one among three.

**The breaking-changes policy (since v0.7).** Early Tessergate had the standard hobby-project sin: config format churn that followed my learning curve. v0.5 broke three users' CI in a week, and one of them wrote a beautifully dry issue titled "your tool is great, please stop improving it." That issue is the reason the policy exists: deprecation notices two minor versions ahead, old flags kept through a full minor cycle, automated migration notes in every release body, and a `Tessergate migrate` command for format changes. Cost: slower iteration. Benefit: when the 1.0 shipped in September 2022 with a written stability commitment, it landed on two years of earned credibility, and the release thread had zero breaking-change complaints — on an audience-sized project, that absence *is* the metric.

**Recruiting maintainers on purpose.** The 37 contributors didn't happen by accident, and the project's durability is really about three of them: a core contributor I recruited from a high-quality issue thread in 2021 (she now owns the config parser), a docs lead who turned the README from my private shorthand into something strangers could use (that story continues in `Projects/Docs Contribution Battle.md`), and a CI-obsessed contributor whose migration-test harness is the reason the breaking-changes policy is enforceable rather than aspirational. The maintainer skill nobody writes up: turning your best issue-commenters into co-owners *before* you burn out, not after. I recruited on evidence of judgment, not volume — one careful escalation path in an issue was worth fifty closed typos.

**The 1.0 launch (September 2022).** Two years of 0.x, a stability commitment in writing (config format frozen, breaking changes only behind explicit version gates), a migration guide, and a launch post that led with the failure modes honestly — including the v0.5 story above. Installed-base tripling over the following year wasn't the launch's effect alone; it was the launch *confirming* what the policy had already promised. 1.0s are read as promises, and I'd only earned the right to make one.

## The toxic-contributor situation, in full

2023, contributor "V" — technically competent, and over roughly five months: PRs that quietly reverted other contributors' decisions without discussion, review comments on other people's PRs that read as territorial claims ("this is mine, hands off" phrasing toward a first-time contributor), a conversation in the community channel that turned personal toward the docs lead, and finally a threat to fork "the real Tessergate" with the community when I declined to fast-track his architecture rewrite.

What I did, in order:

1. **Private, direct, documented.** Two DMs over a month, each naming the specific behavior and the specific impact, each offering a path back (review the rewrite through the normal RFC process, no privileged lane). Both read; neither changed the behavior.
2. **Public standards, applied equally.** The code of conduct already covered this; the hard part was enforcement, because V was productive. I enforced: channel moderation for the personal attack, PR-review privileges suspended pending the RFC, stated in the governance channel with the reasons — behavior quotes, not character verdicts.
3. **Protecting the target first.** The docs lead got an apology *from me* — the conflict had cost her air in her own project — and a standing offer to hand her any Tessergate interaction she didn't want to carry. She's still the docs lead; the retention *is* the outcome that matters most in the ledger.
4. **The fork threat, answered by not answering it.** A fork is free and legal and none of my business; responding to it as a threat would have dignified it as leverage. He forked; the fork archived after four months. I never mentioned it in the project.

What I'd still do differently: **I waited too long to act** — about six weeks of "he's productive, maybe this passes," during which the first-time contributor he'd targeted went quiet and never returned. Contributor churn that I could have prevented with faster enforcement is the cost I weight heaviest in the whole ledger. The governance lesson I carry to every community I touch: **productivity is never a conduct exemption, and ambiguity about that costs you exactly the contributors you can't afford to lose** — the quiet, good ones.

## The state of it, honestly

Tessergate is healthy and deliberately not huge: I've turned down "join our portfolio" offers from two commercial vendors (the employer-neutrality is the asset; see the IP-boundary note in my applicant file), and the maintainer bench is three deep, which is enough. Weekly installs have run 500–900 since ClusterCamp 2021 (`Projects/Conference Talk That Mattered.md` is that story). If I'm being precise about the failure mode I watch for now: it's not toxic contributors anymore, it's *me* — maintainer attention is the binding constraint, which is why the recruiting decisions above get more of my care than any feature.
