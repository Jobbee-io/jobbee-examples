<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The deal that died in security review — and the process it built

Rivermont Health, Fennec Systems, August 2021 to June 2023. $420K ACV, 3-year term, closed June 2023. It also died in security review in August 2022 and took ten months to come back. The campaign that brought it back became the security pre-emption checklist I've run on every deal since.

## The deal, and the death

Rivermont: a regional healthcare network with 14 hospitals. Their deployment pain was acute (environment changes still ran on change tickets) and politically loaded (a 2021 outage had made one VP's position fragile). By July 2022 I had a six-person committee aligned, a verbal "we're moving forward," and a start date on the calendar. By my own later accounting, I was already spending the commission.

**August 4, 2022: dead.** The network's security director, a stakeholder I had listed but never engaged, came back from time off, reviewed the vendor package, and killed the evaluation in one email:

- no SOC 2 Type II report (Fennec had Type I only, with the Type II audit in progress);
- no signed HIPAA business associate agreement at the platform layer;
- a data-flow diagram at the "logical" level, when their policy required physical.

I hadn't lost on product, price or politics. I lost on a binder.

This happened in the middle of the ten-week security stall on my Harvestlane deal (`Projects/The 1.5m Three Year Deal.md`). I had started fixing the same blind spot there in mid-July and hadn't carried the fix to my other accounts in time.

## What the loss cost

- **The deal itself,** for ten months: from the death in August 2022 to the signature in June 2023. Healthcare cycles eat ten months standing still.
- **My forecast, for a quarter.** I refused to take the deal out of my Q3 2022 forecast and spent six weeks on it. My coverage math lied to me for the whole quarter. That secondary cost, forecast contamination from an un-dead deal, is the one that changed my behavior most.

## The postmortem, written while the wound was open

Three causes, in order of how much they were mine:

1. **I treated security as a checkbox, not a voter.** In my own committee map, the security director was row six with status "pending." I had a list, not an engagement. The committee-map craft I'm proud of had a blind spot exactly the size of this loss.
2. **I asked "is security a blocker?" instead of "what does security need to say yes?"** The first question invites yes or no. The second invites a requirements list, and a requirements list can be project-managed. The second question is now in my discovery script, word for word.
3. **The vendor's binder was weak, and I knew it.** I knew all three gaps and had rationalized them as details for later. Two of the three were fixable inside the deal window. I never checked the calendar against them.

## The campaign that won the re-opened evaluation

- **January 2023: the re-open.** Rivermont's new infrastructure VP reopened a "phase 2" evaluation. My old champion had survived the reorg; his boss hadn't. I asked for and got a two-week head start before the incumbent's re-bid. I'd earned it by being the only vendor who had sent an unrequested 90-day closure report on every security finding from the dead evaluation.
- **The binder, rebuilt.** The SOC 2 Type II report was issued in March 2023. I didn't audit anything, but I tracked every remaining evidence request with Fennec's security team the way I track a mutual action plan. The BAA was signed at the platform layer in April. And I got Fennec to pay for a physical-level data-flow diagram rather than wait for Rivermont's security team to produce one.
- **The security engagement, done right.** A named Fennec security engineer on the account from day one of the re-open. A 12-finding closure log (the three blockers plus nine smaller items: key-rotation evidence, pen-test recency, the sub-processor list, the incident-notification SLA and the like), kept in Rivermont's format, in their ticket system. Monthly 30-minute syncs with the same director who had killed the deal. By month three she was forwarding me the criteria other vendors were failing.

**June 2023: closed, $420K ACV, 3-year term.** The security director's note to the committee called our package "the most complete vendor submission this office has reviewed." I've never been prouder of a sentence I caused.

## The checklist, on every deal since

Run in the first 30 days of any qualified deal:

1. **Security is a committee seat, engaged by week 2:** a working session, not a document email. If they won't take a meeting, that's a finding, not a skip.
2. **The binder audit.** Before any proposal goes out, I get our actual SOC report status, BAA and DPA posture, and data-flow documentation level in writing from our own security team. I check each against the prospect's industry requirements myself. Anything red gets a dated remediation path before pricing is discussed.
3. **"What does security need to say yes?"** asked word for word, in discovery, to the security stakeholder, not about them.
4. **The un-dead rule.** A deal that dies in security review comes out of forecast the same week. Any re-open starts with a written closure log, not optimism.
5. **The closure-log format** (finding, owner, date, evidence link) travels with me. Two prospects have adopted it as their own vendor-tracking template, the cheapest credibility I've ever bought.

What it changed, measured as security-review time (first contact with the security stakeholder to written security sign-off): 10 weeks at Harvestlane in 2022, and a death at Rivermont. Since the checklist: a median of 4 weeks across the 7 deals of mine that have gone through a formal security review, none longer than 7 weeks.

## What I'd still do differently

The binder gaps were knowable in July 2022 from Fennec's own trust page, and I skipped the check because the deal felt won. The lesson isn't "process beats luck." It's that "feels won" is exactly when discipline is cheapest, and I have the ten months to prove it.

## What's still open

When I left Fennec at the end of 2024, Rivermont was halfway through the 3-year term it signed in June 2023, and its renewal, due in mid-2026, was still open. I don't know how the renewal went.
