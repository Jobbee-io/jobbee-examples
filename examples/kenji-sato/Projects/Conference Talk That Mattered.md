<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The talk that mattered: ClusterCamp 2021, "Guardrails Without Gatekeepers"

October 2021, while I was at Meridian Grid. Most conference talks produce a good week of traffic and nothing else. This one changed an install curve. On my resume it's one line with two numbers. This file holds how it was built, why I think it worked, and what I got wrong.

## The talk

"Guardrails Without Gatekeepers" stated the namespace-guardrails problem from the pager side. Teams without platform-engineering headcount still need resource-limit discipline. Heavy policy tooling is the right answer for platform teams and the wrong first answer for everyone else. Guardrails-as-code fills the gap. I used Tessergate, my personal project, and said so from the stage.

The talk ran 35 minutes:
- 10 on the problem;
- 15 on the approach, with a live demo;
- 10 on failure modes, including the plain statement that Tessergate can't enforce at admission time, and what to graduate to when you outgrow it.

## How I prepared

- I submitted the proposal in June 2021 and had six weeks between acceptance and the talk.
- I ran 3 dry runs. One was for four Meridian platform engineers I knew would be hostile; they cut 8 minutes of background I thought was essential.
- The demo ran on a local cluster on my laptop, with no conference Wi-Fi involved, and a recorded backup ready if the laptop failed.

## The outcome

- **40K views** on the recording to date. It's still the link people drop in threads about resource governance.
- **Tessergate weekly installs went from 190 to 890 within a month,** and have stayed above 500 since. Installs are release-binary downloads plus Homebrew installs, from public counts. The curve never went back to baseline, which is what adoption looks like, as opposed to attention.

## Why it worked

I've compared it with my other talks (HelmPoint 2020, and the ShipScale workshops in 2022 and 2023), which were all fine and none of which had this curve.

1. **The problem was real, underserved and easy to check.** Every Kubernetes user has the "who set this namespace limit" scar, and almost none have a platform-team budget. The talk didn't need to create demand.
2. **The demo failed on purpose.** Midway through, the cluster rejected my own guardrail apply. I had planted the misconfiguration, and I diagnosed it live with the tool's own output. I planned it because a demo that can't fail isn't trusted. I didn't plan for it to become the most-clipped part of the recording.
3. **Disclosure bought credibility.** I said up front that Tessergate was my personal project, MIT-licensed, employer-neutral, and not Meridian strategy. Speakers who bury an affiliation get found out and discounted.
4. **I told people when not to use it.** "If you have a platform team, this problem is already solved for you; go run the heavy policy engine." That made the tool's scope believable. Tools that claim to be everything get tried like they're nothing.
5. **Nearly three years of project work sat underneath it:** the breaking-change policy, real docs, regular releases (`Projects/Oss Maintainer Journey.md`). The talk didn't create the trust; it exposed it. The outcome was made before the talk was.

## What went wrong

- **The abstract was too clever.** "Gatekeepers" read as a culture talk and nearly got the session put in a culture track, in front of the wrong audience. A program committee member rescued it because she'd hit the same namespace problem the week before. Titles are routing, not branding.
- **There was no capture path.** No short link, no landing page, no "get the starter configs here." People had to find the repo cold. The curve happened despite having no funnel. Every talk since has a one-link capture path, which is how the ShipScale workshops got measurable outcomes.
- **No follow-through.** The questions thread under the recording got 60+ comments. I answered about a third in one frantic week and dropped the rest. Some of those unanswered questions were content ideas I wrote up two years later.

## What I reuse

- Aim at pain the audience already has.
- Disclose affiliation early.
- Leave in a planned failure, and get good at recovering from unplanned ones.
- State the tool's scope and when to stop using it.
- Put one link on the last slide.

This is the pattern behind the Orcadia migration series and the SubstrateNine quickstart rebuild, which is why both have numbers attached.
