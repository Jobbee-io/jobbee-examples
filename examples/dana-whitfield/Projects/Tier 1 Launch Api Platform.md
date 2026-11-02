<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Tier-1 launch: the Flowramp API platform, waitlist to GA

Halyard Tools, June 2019 to July 2020, with the pipeline measured for four quarters after GA (to June 2021). On my resume this is one bullet: 2,400 registrations, 61% week-4 activation, $14M influenced pipeline. This file holds the rest: the positioning options and the tests that killed two of them, the four launch stages and their exit criteria, who disagreed with me and how it was settled, the budget, every metric's definition, and what went wrong.

## What Flowramp was

Halyard Tools sold a deployment tool, about 110 people in 2019. In the first half of 2019 we repositioned it from "deployment tool" to "deployment platform." The order mattered: docs and quickstarts for the multi-environment features we already had shipped first (March and April), the platform story went out in May, and the rest of the platform features followed a quarter later. Once the product was called a platform, developers asked the obvious question: what can I build on it? Flowramp was the answer. It opened Halyard's deployment engine as a public API. Pipelines were defined declaratively in YAML, versioned in git, run through the API, and checked for drift: the engine compared what was deployed with what the definition said.

## My role, and who did the rest

I owned the positioning, the launch plan and its exit criteria, the waitlist and launch-page copy, the demo scripts, the quickstart brief and its first draft, the measurement frame, the press plan and the launch-day run of show. I reported to the VP of Marketing. Nobody on the launch reported to me; the first PMM I hired started after GA.

The team I worked through:
- The Flowramp product lead and 9 engineers built the product.
- A contract technical writer and 2 engineers (part time) built the docs site to my brief.
- One shared designer did the waitlist and launch pages.
- The VP of Sales owned the sales motion and agreed the pipeline definition with me.
- During the private beta, 8 engineers answered the beta channel on a rotation of 4 hours a week each.

Budget: $310K non-headcount from waitlist to GA. About a third went on the docs site; the next largest line was the launch livestream.

## Positioning: three options, two tests

Option A was the product team's draft: "your deployment pipeline, as an API." In June 2019 I posted the draft landing page in two practitioner communities where I had credibility: a platform-engineering guild and a dev-tools marketing group. I asked for the red pen. The two threads drew 118 comments in four days. "As an API" read as "our UI is bad," not "you can build on this." And three commenters said the real differentiation, declarative definitions with drift detection, wasn't in the copy at all.

That last point was a product gap, not a copy gap. Drift detection existed, but it was undocumented and half built. I wrote a one-page memo for the CEO and CTO, with the thread attached: our strongest differentiator was our least finished feature. I asked for drift detection to be finished before GA. The CTO objected that it would delay the API's v1 auth work. We settled on detection and reporting at GA, with automatic remediation later. Detection had been planned for early 2021, so it shipped about six months early. This is the answer I give when someone asks when marketing last changed a roadmap.

Option B was "GitOps for deployment pipelines." I rejected it before testing. The term implies a pull-based model, where an agent in the cluster pulls the desired state. Flowramp pushed changes from CI. Practitioners would hold us to the term's definition, and they'd be right. I'd rather lose the search volume than lose that argument in every comment thread.

Option C shipped: "Infrastructure pipelines you can commit to." I tested it in August 2019 in a private thread with 25 practitioners. It survived with one change. I dropped the word "serverless" after a well-known commenter took it apart in two sentences; the term meant something specific and we weren't it.

## The launch, in four stages

Every stage had a written exit criterion. We didn't move to the next stage until we hit it.

1. **Waitlist, September to November 2019.** The page had the tested positioning, a working example and nothing else. No fake screenshots. The example was a sample repository with a pipeline definition and a hosted sandbox to run it against. The form asked for an email address only. Exit criterion: 1,000 registrations, and 10% of them completing the example. Result: 1,150 registrations and 12% completion. Those 138 completers already understood the model, and they became our first design partners.
2. **Private beta, December 2019 to March 2020.** 200 accounts: the 138 completers first, then 62 existing Halyard customers. We ran a weekly changelog, a public roadmap and a shared beta channel. I wrote the copy; engineers wrote the answers, under their own names. That split was the trust engine. Exit criterion: 25 accounts in production use, defined as a pipeline running against a non-sandbox target at least weekly for 3 weeks. Result: 31.
3. **Open beta, March 30 to June 2020.** Self-serve signup and the new docs site. The brief said the quickstart must take under 10 minutes; we tested it on 5 engineers outside the company and the median was 8. The first content wave was three deep-dive posts, each co-written with an engineer and each building one real pipeline. The pandemic arrived two weeks before open beta. I cancelled the in-person GA event we had planned in San Francisco and rebuilt GA around a livestream.
4. **GA, July 14, 2020.** A press embargo with two trade outlets: *Deploy Weekly* ran the launch analysis, and *The Stackfield Report* covered the category. The announcement led with a design partner's story, not a feature list. The livestream showed an engineer building a pipeline from scratch, with no slides and one failure left in on purpose. A demo that can't fail isn't trusted.

## The activation miss, and the fix

The open-beta exit criterion was activation: 60% of a signup cohort running a first successful production pipeline within 28 days of signup. "Week-4 activation" on my resume means exactly that. The first cohort (April 2020) came in at 54%.

The funnel had five steps: sign up, create a project, connect a cloud account, define a pipeline, run it in production. Step 3 was the leak. Only 68% of people who reached it got through. To connect an account, users had to hand-write a cloud IAM role from a 40-line policy in our docs. Engineering built a one-command role generator with scoped tokens in two weeks. Step 3 rose to 84%, and the May cohort activated at 61%.

If step 3 had been the only change, activation would have risen to about 67%. It didn't. The extra people who now got through step 3 activated at a lower rate than the people who had always made it. I reported 61%, with that note, and we used the same query for every cohort after. Cohorts in the two quarters after GA ran between 58% and 63%.

## Who disagreed, and how it was settled

- **The CEO wanted a big-bang GA** at PlatformSummit in November 2019. I argued for the staged plan: drift detection wasn't done, and we had no activation baseline to spend acquisition money against. We settled it in writing. If the waitlist missed 1,000 registrations by November 30, we would revisit and go to a conventional launch. It passed 1,000 on November 12.
- **The VP of Sales wanted the waitlist form to ask for company size, role and phone**, and to route sign-ups to SDRs. I refused the phone field and the routing. Developers who get a sales call for joining a waitlist stop joining waitlists. The compromise: we captured the company domain from the email address, and every registration went into the CRM from day one. Sales got full credit later through the influenced-pipeline definition, which we agreed before the first registration.
- **The CTO and drift detection.** Settled above: detection at GA, remediation later.

## Pricing: the week-2 fix, and the bigger miss

The GA pricing page had two parts: a per-seat plan and usage credits for pipeline runs. It was the one asset I never tested, while the announcement went through three test rounds. Per-seat pricing confused everyone: on a platform, the people who use it aren't the people who buy seats. In week 2 we moved to team-based pricing with an emergency page revision.

I fixed the seat problem and defended the usage credits. That was the bigger mistake, and it took a year to surface. Win/loss later showed that credits made buyers under-test the product during evaluation. They were retired in 2021 (`Projects/Win Loss Program.md`). Testing effort should follow risk, and pricing was the riskiest page in the launch.

## The numbers, and their definitions

- **2,400 registrations:** verified accounts from the day the waitlist opened to GA day. That includes about 210 waitlist sign-ups who unsubscribed during the wait for open beta.
- **61% week-4 activation:** defined above, from the May 2020 cohort on.
- **$14M influenced pipeline, Q3 2020 to Q2 2021:** opportunities sourced by, or touched within 90 days of, a launch-program touchpoint. The VP of Sales, the CFO and I agreed that definition in writing in August 2019, before the waitlist opened. Of the $14M, $5.3M was sourced: the first touch was the launch program itself. I give both numbers when asked, because "influenced" overlaps with work sales would have done anyway.
- **260 design-partner accounts across both betas.** 41 were case-study candidates by the second quarter after GA, and 6 case studies were published by mid-2021.
- **Activation and revenue:** activated accounts converted to paid within 90 days at 14%, against 3% for accounts that never activated. But about half of Flowramp's first-year revenue came from 11 enterprise accounts that never went through self-serve at all. The self-serve funnel was the front door for developers, not for the biggest buyers.

## What went wrong

- **The waitlist page said "early 2020" for beta access.** The rest of the waitlist got in when open beta opened on March 30. 18% of waitlist sign-ups unsubscribed during the gap. Under-promising is right; a vague promise is not. Every waitlist I've run since gives a month and updates it publicly when it moves.
- **The pricing page,** above.
- **The livestream failure was too deep in the demo.** The planned failure came at minute 34 and the recovery at minute 41. Peak live viewing was about 1,900; about 950 were still there for the recovery. Leave a failure in, yes, but in the middle, not near the end.

## What carried forward, and what didn't get solved

What carried forward:
- Drift detection reached GA. Win/loss later pulled the remediation half forward too.
- The 28-day activation definition became Halyard's standard self-serve metric.
- The written, pre-agreed pipeline definition came with me to Verity Cloud. So did the pattern of recruiting design partners from people who complete a working example. The Ledgerline design-partner program used a sample dataset the same way (`Projects/Ledgerline Launch Campaign.md`).
- The platform repositioning that Flowramp completed reached a 2.1x win rate in evaluations against deployment-only tools within 18 months of the May 2019 story.

What didn't get solved:
- Activation measured getting started, not staying. Only 47% of activated accounts were still running weekly pipelines six months later. Nobody owned that number while I was there.
- I never found a self-serve path that worked for the largest buyers. They came through sales, evaluated with an engineer on a call, and needed a different story: risk and control, not speed.

## What I'd defend, and what I'd change

I'd defend the staged launch, the exit criteria, and agreeing definitions before the first registration. I'd change three things: test the pricing page before the announcement, give the waitlist a month instead of a season, and set a six-month retention target next to the activation target from the start.
