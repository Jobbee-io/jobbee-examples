<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The wrong blog post — advocacy failure and recovery

Orcadia Cloud, March 2023. The 1.0 announcement post for Orcadia's new collection agent — 4,100 views, front page of a practitioner news aggregator for most of a day, and technically wrong about the one behavior the audience most needed to be right about. The community found it in nine hours. This file is the full account, because how an advocate handles being wrong *in public* is the whole ballgame in this job, and I'd rather own the account than have the version that circulates without it.

## The post, and the error

The announcement's core claim: the new agent reconciles checkpoint state **on every restart**, so "no configuration is ever lost across agent upgrades." That sentence came from the design doc — which had been true when written, eight months earlier. Two hotfixes during the beta had changed reconciliation to be **checkpoint-triggered** (on config change or explicit command, not on every restart), the design doc had never been updated, and I wrote the post from the doc because I'd reviewed the design and trusted my familiarity.

The failure mode has a name and it's not "typo": **I verified against documentation instead of against the system.** Worse, I *had* the verification tool — a scratch cluster was thirty minutes away — and skipped it because the post was "just an announcement," i.e., precisely the genre where advocates most believe accuracy is negotiable. It isn't. For practitioners, an announcement post is a contract they build against.

## Nine hours of being publicly wrong

- **Hour 0:** post published, aggregator pickup, the good metrics a launch post wants.
- **Hour 9:** a practitioner I knew from a previous thread posted a minimal reproduction: upgrade an agent with no config change, kill it, restart — checkpoint stays stale. Caption: "announcement says every restart; this says otherwise. Which is it?" Tagged me directly. By then the thread had 40 comments and the answer people were giving each other was the *wrong* one, sourced from my post.
- **Hours 9–11:** I reproduced it myself in the scratch cluster — the step I should have taken before publishing — confirmed the commenter, and posted the confirmation *in the thread* before doing anything else: the community hears it from the author in public, not from a changelog in private.

## The recovery, in the order I did it

1. **Public confirmation in the source thread (hour 11).** "Confirmed — the post is wrong; reconciliation is checkpoint-triggered since the 1.0.1 hotfix; the design doc I sourced from is stale. Correction incoming, tracking here." No hedging, no "the documentation currently states" passive-voice fog. The author owning the error in the author's own thread is the only version of this that preserves trust.
2. **The corrected post, visibly wrong (hour 26).** Published with the corrected behavior, an inline annotation marking what changed, and a link to the thread. Left the original URL serving the correction — the worst outcome would have been a silent rewrite pretending the thread was confused.
3. **The root-cause note (day 3).** Not "we fixed the typo" — a short public note on *why* the error existed: design-doc drift across two hotfixes, and an announcement process that verified claims against docs instead of against the build. Practitioners forgive errors; they re-categorize you based on whether you can explain the error's mechanism.
4. **The internal fix (week 2, the durable one).** Shipped the review change inside Orcadia's DevRel process: **every behavior claim in published content gets verified against a running build by the author, with a one-line screenshot-or-command-transcript attached to the draft.** Not review-by-committee — author-verification with evidence, because the gap was never approval, it was verification. In the 18 months after, that gate caught eleven behavior-drift errors pre-publication. I keep the count; it's the number that says the failure bought something.

## What it cost, honestly

- The thread's first impression of the 1.0 agent was "the announcement lied" for a day; two practitioner teams that I know of postponed evaluation by a quarter — one told me directly, at a workshop, eight months later, and adopted eventually.
- The product team spent two unplanned days on the correction cycle, which is the cost advocacy failures really charge: **not the embarrassment, the tax on other people's sprints.**
- My own: the most-linked version of my name in that community for a month was a correction. I'd rate that cost as appropriate.

## What it taught me — the advocate-credibility ledger

- **The audience grades error handling, not error avoidance.** The practitioner who caught it became one of my most useful critics afterward, because he watched the correction land the way you'd want a correction to land. Trust after a handled failure can exceed trust with no failure at all — but only if the handling is fast, public, mechanically explained, and followed by a process change.
- **"Announcement" is not an accuracy exemption.** The genre where advocates are most tempted to relax is the genre practitioners build against first.
- **Verify against the system, never against the docs — your own product's docs included.** Docs are someone's past belief with a stylesheet.
- **The evidence-gate is the apology that keeps working.** The screenshot-attached-to-draft rule has a number attached (11 catches) because I insisted we count it; a process change without a counter is a story, not a control.

The one-paragraph version for interviews: I wrote a launch post from a stale design doc, a community member reproduced the error in nine hours, and I corrected it publicly within two, root-caused it within three days, and shipped the verification gate that made it the last error of its class — and the reason I can be trusted with launch narratives is that this file exists.
