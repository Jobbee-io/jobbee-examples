<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Developer-trust turnaround: 18 months at Verity Cloud

Verity Cloud, February 2022 to August 2023, with the measurement panel still running through 2024. When I joined, the developer community around Verity's platform products didn't just dislike the company; it discounted everything Verity said. The community was a practitioner forum and the public issue trackers for the platform SDKs and CLI. My sentiment panel's first reading was −34. Eighteen months later it was +12. On my resume this sits behind the bullet about rebuilding the developer-relations partnership. This file holds the diagnosis, the three programs that worked, the one that backfired, how the panel works and why its numbers are noisy, who disagreed, and what still isn't solved.

## Diagnosis first

I spent my first six weeks listening before building anything. I read two years of forum history, went through the support team's ticket-deflection data, and held 14 off-record calls with practitioners who had criticized Verity in public. Three findings shaped the plan:

1. **The distrust was earned.** In 2020 and 2021 an outsourced team had staffed the community channel from a script. An agency had rewritten the docs with no engineer review. An open-source SDK had been announced, delayed twice, and quietly dropped. People still remembered each incident.
2. **Nobody doubted the product.** The practitioners who rated Verity lowest still rated the platform technically sound. The debt was in behavior, not architecture. Behavior is cheap to change; architecture isn't.
3. **A campaign would make it worse.** Every practitioner I spoke to could spot a marketing initiative on sight. The company had to visibly change, not announce that it was changing.

## My role, and who did the work

I designed and owned the program: the panel, the engineer rotation, the docs-verification standard, the corrections policy, and the public communication of the SDK plan. I also built the shared narrative calendar, so advocacy, docs and PMM stopped finding out about launches separately.

I managed none of the people who did the work:
- The VP of Engineering for the platform was the sponsor, and the only person who could commit engineers' time.
- The Head of DevRel ran 5 developer advocates.
- The docs lead ran 6 writers.
- The SDK engineering lead owned the SDK.
- Legal reviewed the policy for engineers posting under their own names.
- Two Verity community managers and the volunteer forum moderators ran the forum day to day.

## How I measured it, and how noisy that is

In March 2022 I recruited a panel of 40 practitioners: 16 public critics, 12 active but neutral forum members, and 12 customers and fans. I chose the critics on purpose. They had the most to lose by softening.

Every quarter the panel answered one question: "How likely are you to recommend Verity's developer platform to a peer, based on how the company behaves with developers?" The scale was 0 to 10. The score is the share of promoters (9 or 10) minus the share of detractors (0 to 6), so it runs from −100 to +100. A free-text box asked what had changed their answer since last quarter. When someone dropped out, I replaced them with a new recruit from the same group. 31 of the original 40 were still on the panel in mid-2023.

The panel is small, and I said so every time I reported it. With 40 people, one panelist moving from detractor to promoter moves the score 5 points. I treated any move under 10 points as noise unless the free text explained it.

The quarterly readings:

| Quarter | Score | What the free text pointed at |
|---|---|---|
| Q1 2022 | −34 | Baseline, before any program |
| Q2 2022 | −30 | Engineers start appearing in threads |
| Q3 2022 | −18 | Engineer answers; docs corrections |
| Q4 2022 | −25 | The "paid shills" thread (below) |
| Q1 2023 | −11 | SDK milestones, including the one we missed and announced |
| Q2 2023 | +12 | SDK GA in May; 9 panelists named it |
| Q3 2023 to Q4 2024 | +9 to +14 | Holding |

I tracked three numbers that don't come from the panel:
- **Median time to a first answer on platform threads:** 3.4 days before the program, 7 hours by mid-2023.
- **Share of platform threads with an answer from a Verity engineer:** 12% before, 58% by mid-2023.
- **Practitioner posts citing Verity's docs as a good example:** none in 2021, and 9 across 2023 and 2024. You can't buy the ninth one.

## Program 1: engineers in the channel

The commitment: each of the 48 engineers on the platform teams takes one half-day shift a month in the forum and issue trackers. They answer under their own name and title, with no script. That is about 24 engineer-days a month, roughly 2.5% of each engineer's time. I wrote the rotation, the escalation path and one rule: "I don't know" is an acceptable answer; a wrong answer is not. If a thread got no answer within 24 hours, it went to the advocate on duty, then to the owning team's lead.

Two engineering managers objected to the sprint cost. The VP of Engineering agreed to a one-quarter trial, April to June 2022, judged on two numbers. The first was median time to first answer, which fell from 3.4 days to 19 hours in the trial. The second was escalations into engineering's on-call queue. They feared escalations would rise; they fell by about 30%, because engineers were answering "how do I" questions before they turned into tickets. The rotation became permanent in July 2022.

Legal wanted rules before engineers posted under their names. We wrote a one-page guideline together in a week: no roadmap dates, no customer names, and "we're looking at it" only when someone actually is.

## Program 2: docs with named reviewers

About 410 docs pages had been rewritten by the agency. Over the third and fourth quarters of 2022 the docs team replaced them. Every page got a named engineer reviewer and a stamp: "last verified against release X.Y." If a page wasn't re-verified within two minor releases, it showed a warning banner.

Where the docs were wrong, we said so in a public corrections log: the date, what the page had said, and what is true. It had about 140 entries in its first year. The docs lead worried it would advertise our errors. We tried it on one product area for a month first. It became the most-linked docs page from the forum. Practitioners linked it as proof that the docs were maintained.

## Program 3: the SDK, delivered late and on the record

In June 2022 we re-announced the SDK with a dated public plan and four milestones:
- Python alpha, September 2022;
- Go alpha, November 2022;
- TypeScript alpha, January 2023;
- GA for all three, April 2023.

The TypeScript alpha slipped because a security review forced a rewrite of the auth module. We posted the miss two weeks before the due date, with the reason and a new date. It shipped in March, six weeks late. GA shipped in May, one month late.

The miss-and-acknowledge cycle did more for us than the milestones we hit. The community's complaint had never been the delay. It had been the silence.

## The program that backfired

In October 2022, month 8, I launched the "Verity Builders" cohort with the Head of DevRel. Twelve community members got early access, direct access to the product teams, an honorarium of $1,500 a year paid quarterly, and a branded swag pack. We announced it publicly. I added the honorarium myself, because paying people for their time seemed fairer than asking for it free. One of the volunteer moderators told me in review that "paid" would be read as "bought." I overruled him.

Within three weeks the forum had a thread titled "paid shills," with screenshots of the honorarium clause from the public terms page. Two members resigned from the cohort rather than carry the label. Worse, the thread contaminated the genuinely independent posts the other members had written. The early access, nobody minded. The money and the merch turned real enthusiasm into suspected astroturf.

In December 2022 we dropped the honorarium and the swag, kept the early access, and re-invited the two who had resigned. One came back. We posted a one-paragraph public note that explained the change without excusing it. The panel dropped 7 points that quarter. That is inside the noise on its own, but 6 panelists named the thread in their free text, so I counted it as real. Recovery took two quarters. The honorarium cost $18K a year. The credibility cost was far larger.

What I took from it: developer trust comes from behavior you can see, and from independence you can see. Early access works because it is a product decision. An honorarium fails because it reads as buying influence. I've turned down two ambassador-program pitches since, and I can explain the no in one sentence. When I later paid a creator, I paid a professional educator for clearly labeled sponsored work and left the opinions to them (`Projects/Creator Partnership.md`).

## One more disagreement: lead capture

The forum sign-up form asked for company, role and company size, and fed demand-gen lead scoring. That was part of why practitioners believed the channel existed to capture leads. I asked the head of demand generation to remove it. She objected, because the forum was a measurable MQL source. We settled on an email-only sign-up, with a separate opt-in for product updates. Forum-sourced MQLs fell from about 210 a quarter to about 60. I agreed to report that drop every quarter next to the panel score, so nobody could say the cost was hidden. It was a real cost, and the right trade.

## Second-order effects

- The shared narrative calendar outlived the program. Advocacy, docs and PMM still plan launches on it.
- The Ledgerline launch in June 2023 landed on docs the community already trusted. I think that is part of why 71% of launch-page visitors went on to the docs (`Projects/Ledgerline Launch Campaign.md`).
- In 2024, my repositioning of Workflowline failed with analysts and buyers (`Projects/Positioning Failure Postmortem.md`). The developer panel held between +9 and +14 through it. I read that as the community separating how the platform teams behave from what corporate marketing says. It's a useful separation, and a humbling one.

## What isn't solved

- **The rotation is wearing thin.** Every engineer took their shift in 2022. By late 2024, 81% did; the rest skipped without swapping. It now depends on managers enforcing it, which is not how it started.
- **The panel is small, and I recruit it.** A skeptic can call that biased. My answer: critics are 16 of the 40, I publish nothing from it externally, and I report the noise next to the number. It's still a thin instrument.
- **I can't tie sentiment to revenue.** The closest number is trial workspaces created from forum links, and I won't claim causation from it.
- **+12 is a passing grade, not a triumph.** A community that once scored you −34 remembers. That is why the rotation was never sunset.

## What I'd do differently

- No honorarium, and I'd take the moderator's warning instead of overruling it.
- Recruit 60 panelists, not 40, so a 10-point move means something on its own.
- Plan the SDK in three milestones instead of four. The fourth added a date to miss and nothing the community needed.
