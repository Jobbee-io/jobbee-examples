<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Incident postmortem program

Fernbrook Systems, Platform & Developer Experience, May 2022 – Sep 2023 (build), ongoing ownership since. I built the blameless postmortem practice: adoption from "docs nobody reads" to ~90% of Sev-1/2, action-item completion tracked at 94%. It started with an incident, it survived resistance from the most important engineer in the building, and the version that stuck is smaller than the version I first proposed.

## The incident that started it (May 2022)

A cascading config failure: an internal config service pushed a malformed rule set to 60% of production services over 22 minutes. Result: 2 hours 40 minutes of degraded checkout for the company's largest revenue path, ~$180K in direct revenue impact, 3,100 support tickets, and a customer escalation that reached the board.

I wasn't on call. I was six weeks into the platform org, with a charter that said "operational excellence" and no idea what that meant here yet. What I found when I looked:

- **Four postmortem docs existed in the whole company** (searchable: I checked), oldest from 14 months prior. Three were single-paragraph apologies. One blamed a specific engineer by name, in writing, in a doc any employee could read. That doc was why nobody wrote postmortems.
- The incident *response* was actually good — SRE-style paging, competent mitigation, honest comms. The org knew how to fight fires and had no habit of learning from them. Every fix was a hallway conversation that evaporated.
- The repeating pattern that convinced the CTO: the same failure class — **config propagation without validation or canary** — had caused two smaller Sev-2s in the prior nine months. Three occurrences, zero accumulated learning.

## The design (and the cuts I made to it)

My first proposal was a full SRE-book program: review committees, severity matrices, action-item trackers, blameless training, the works. The VP's feedback, verbatim: "This is beautiful and we will do none of it. What's the smallest thing that would still work?" The shipped version:

1. **One template, short.** Impact (customer-visible, dollars if known), timeline (timestamped, from real sources, corrected where memory was wrong — corrections marked), contributing factors (plural, systemic), what went well (mandatory — this is a blamelessness *mechanism*, not decoration), action items with a name and a date each. Two pages max. The old docs failed because writing them was unpaid labor; the template reduced the labor.
2. **Blamelessness as a rule with teeth.** Contributing factors must be phrased as system or process properties, never as person-verbs ("the engineer deployed" is a timeline entry; "no dry-run existed for config pushes" is a contributing factor). I reviewed the first ten docs personally and bounced two back for person-blame — gently, publicly, with rewrites offered. Those rewrites, done with the authors, were the program's actual marketing.
3. **Action items go on the roadmap or they don't exist.** Each item: owner (a name, not a team), a due date, and a slot in the owning team's sprint. Platform absorbed cross-cutting items as part of my charter. Completion tracked monthly, published. This is the only reason the number is 94% and not 40%.
4. **The review meeting is 30 minutes, blameless by design.** Author presents for 10, discussion 15, no executives present (this rule came after the first review, where a VP's questioning tone withered two engineers into silence; I instituted the no-exec rule with the VP's own agreement after showing him the recording — his reaction, to his credit: "fair").
5. **Cascade trigger:** any doc's contributing factors matching a prior doc's factors auto-links them. The config-class link is what let me show the CTO the three-incidents-same-cause chart that funded the fix work.

## The resistance, and how it actually resolved

- **The senior staff engineer — the company's most respected IC — refused to write one** after his service's Sev-2. His stated reason was legit: "Postmortems here are blame documents with better fonts; I'm not volunteering my neck." He'd been the named engineer in that ancient doc, it turned out. I didn't argue with him in public. I gave him the *first rewrite*: his incident, written by me, blameless-form, and I asked him to mark it up. He marked it up ruthlessly, correctly — and then wrote the next one for his own incident, and it became the best doc in the corpus. He runs reviews now, harder than I do. The lesson: resistance to blamelessness is usually a scar, not a philosophy. Address the scar, not the argument.
- **"We don't have time"** — the standing objection, valid everywhere. Answer was the two-page cap and the platform team doing the *timeline archaeology* (pulling the timestamped facts from logs/pager/comms so authors only did the narrative and analysis). Author time dropped to ~90 minutes median, measured from a survey, and the objection died more of starvation than argument.
- **One exec wanted names in docs "for accountability."** The compromise that held: action items have names (public, tracked); contributing factors don't (systemic, tracked to fix). Accountability attaches to the *fix*, never to the *fallibility*. He accepted it after the first quarter of 94% completion — accountability that actually completes beats accountability that shames.

## Outcome, measured

- **~90% of Sev-1/2 incidents get a doc within 10 business days** (target: 100%; the misses are real and mostly staffing-gap related — I report them, not hide them).
- **Action-item completion 94%** at 60 days, tracked and published monthly.
- **Repeat-cause rate:** contributing-factor classes recurring within 12 months fell from 3/9 classes (the config example) to 1/11 in the year after the program matured. The one that recurred taught its own lesson (the fix had an owner but no verification step — verification is now a required field on every action item).
- Config push canary + validation shipped as the program's flagship fix; three years on, zero config-propagation Sev-1s since.
- **Adoption without me:** I stopped reviewing every doc at month 14; the practice held. Reviews are now staffed by two rotating senior engineers plus the author. When I left the loop and the numbers didn't move, that's when I considered the program real.

## What I'd tell someone building this

1. Start with the smallest version that has one mechanism of *enforcement* (ours: action items on the roadmap). Postmortem programs die of being optional, not of being small.
2. Blamelessness is a formatting rule before it's a culture. Enforce the phrasing and the culture follows; argue the culture first and you'll wait years.
3. Do the timeline archaeology for people. The marginal hour of an incident commander should go to analysis, not scrollback archaeology.
4. "What went well" is mandatory because blamelessness needs positive evidence to survive contact with a defensive reader — and because incident response genuinely contains things done well that otherwise get lost.
5. Recurring-factor auto-linking is the highest-leverage feature nobody asks for. It's what turns 20 docs into a pattern library instead of a graveyard.
