<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The wrong blog post: advocacy failure and recovery

Orcadia Cloud, March 2023. I wrote the 1.0 announcement post for Orcadia's new collection agent. It got about 4,100 views and sat on the front page of a practitioner news aggregator for most of a day. It was wrong about the one behavior readers most needed it to be right about, and the community found the error in nine hours. How an advocate handles being wrong in public is central to the job, so here is the full account.

## The error

The post said the agent reconciles checkpoint state on every restart, so "no configuration is ever lost across agent upgrades." That came from the design doc, which had been true eight months earlier. Two hotfixes during the beta changed reconciliation to be checkpoint-triggered: on a config change or an explicit command, not on every restart. Nobody updated the design doc. I wrote from the doc because I had reviewed the design and trusted my memory of it.

The real failure: I checked against documentation instead of against the system. A scratch cluster was thirty minutes away and I skipped it, because it was "just an announcement." For practitioners, an announcement is a contract they build against.

## The recovery

- **Hour 9.** A practitioner I knew from an earlier thread posted a minimal reproduction: upgrade the agent with no config change, kill it, restart it, and the checkpoint stays stale. He tagged me. The thread had 40 comments by then, and people were answering each other with the wrong behavior, sourced from my post.
- **Hours 9 to 11.** I reproduced it on the scratch cluster, the step I should have taken before publishing. Then I confirmed it in the same thread before doing anything else: "Confirmed: the post is wrong. Reconciliation is checkpoint-triggered since the 1.0.1 hotfix; the design doc I used is stale. Correction coming, tracked here."
- **Hour 26.** The corrected post went up at the original URL, with an inline note marking what changed and a link to the thread. No silent rewrite.
- **Day 3.** A short public root-cause note: the design doc drifted across two hotfixes, and our process checked claims against docs, not builds. Practitioners forgive errors; they re-categorize you by whether you can explain how the error happened.
- **Day 6.** The durable fix, in Orcadia's DevRel process: every behavior claim in published content is verified by its author against a running build, with a command transcript or screenshot attached to the draft. It's not review by committee. The gap was never approval; it was verification. In the 11 months before I left Orcadia, the gate caught 7 behavior-drift errors before publication. The team still runs it.

## What it cost

- For a day, the thread's first impression of the 1.0 agent was "the announcement lied." Two practitioner teams I know of delayed their evaluation by a quarter. One told me so at a workshop eight months later, and adopted in the end.
- The product team lost two unplanned days to the correction. That's the real cost of an advocacy error: not the embarrassment, but the tax on other people's sprints.
- For a month, the most-linked mention of my name in that community was a correction.

## What changed in how I work

- Verify against the system, never against the docs, including your own product's docs.
- "Announcement" is not an accuracy exemption. It's the genre practitioners build against first.
- Count what a process change catches. A fix without a counter is a story, not a control.
- The practitioner who caught the error became one of my most useful critics, because he watched the correction land the way a correction should. Trust after a well-handled failure can exceed trust with no failure. That only happens if the handling is fast, public, explained, and followed by a process change.

## What's still open

Nothing from the post is still open. The correction and the root-cause note are public, and the verification gate outlived my time at Orcadia: the team still runs it.
