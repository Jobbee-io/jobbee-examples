<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The deal that died in security review — and the process it built

Rivermont Health, Fennec Systems, 2022–2023. $420K ACV, closed June 2023. Also: died in security review in August 2022, spent ten months officially dead, and came back. The reason it came back is the reason this file exists — the remediation campaign I ran from the loss became the pre-emption standard I've run on every deal since, and it's a large part of why my average cycle time since has dropped while my average deal size went up.

## The deal, and the death

Rivermont: regional healthcare network, 14 hospitals, deployment-automation pain that was acute (their environment-change process was still change-ticket-driven) and politically loaded (a 2021 outage had already made one VP's position fragile). By July 2022 I had a six-person committee aligned, a verbal "we're moving forward," and a start date on the calendar. I was, by my own later accounting, already mentally spending the commission.

**August 4, 2022: dead.** The network's head of security — a stakeholder I had *listed* but never *engaged* — returned from PTO, reviewed the vendor package, and killed the evaluation in one email: no SOC 2 Type II (Fennec had Type I only, audit in progress), no signed HIPAA BAA at the platform layer, and a data-flow diagram our package described at "logical" level when their policy required physical. I hadn't lost on product, price, or politics. I lost on a binder.

## What the loss actually cost

- The $420K ACV, obviously — but that's the honest part I'd have paid anyway in cycle time: it re-closed in June 2023, ten months later, and healthcare sales cycles eat ten months standing still.
- Six weeks of my Q3 2022, spent on a deal I refused to take out of my forecast, which then made my coverage math lie to me for a full quarter. That secondary cost — forecast contamination from an un-dead deal — is the one that changed my behavior most.

## The postmortem, written while the wound was open

Three causes, in order of how much they were mine:

1. **I treated security as a checkbox, not a voter.** In my own committee map, Robert-equivalent at Rivermont was row six with a "pending" status. I had a *list*, not an *engagement*. The committee-map craft I brag about elsewhere (`Projects/The 1.5m Three Year Deal.md`) had a blind spot exactly the size of this loss.
2. **I asked "is security a blocker?" instead of "what does security need to say yes?"** The first question invites yes/no. The second invites a requirements list, and requirements lists can be project-managed. This reframe is now in my discovery script, verbatim.
3. **The vendor's binder was genuinely weak.** SOC 2 Type II was in progress, the BAA was negotiable but un-started, and the data-flow documentation existed at logical level only. I knew all three and had rationalized all three as "details for later." Two of the three were fixable in the deal window; I never checked the calendar against them.

## The campaign that won the re-opened eval

- **January 2023: the re-open.** Rivermont's new infra VP (my old champion had survived, his boss hadn't) reopened a "phase 2" evaluation. I asked for and got a two-week head start before the incumbent's re-bid — earned by being the only vendor who'd sent an unrequested 90-day closure report on every security finding from the dead eval.
- **The binder, rebuilt:** I ran the SOC 2 Type II audit to completion with Fennec's security team (me as logistics coordinator, not auditor — I tracked evidence requests the way I track mutual action plans), got the BAA signed at the platform layer, and commissioned the physical-level data-flow diagram at Fennec's expense rather than wait for Rivermont's security team to generate it themselves.
- **The security engagement, done right this time:** named security engineer assigned to the account from day one of the re-open; a 12-finding closure log maintained *in Rivermont's format, in their ticket system*; and monthly 30-minute security syncs with the same director who'd killed the deal — who, by month three, was forwarding me the evaluation criteria other vendors were failing.

**June 2023: closed, $420K ACV, 3-year term.** The security director's note to the committee called the package "the most complete vendor submission this office has reviewed." I've never been prouder of a sentence I caused.

## What became standard, on every deal since

The pre-emption process, now a checklist I run in the first 30 days of any qualified deal:

1. **Security is a committee seat, engaged by week 2** — a working session, not a document email. If they won't take a meeting, that's a finding, not a skip.
2. **The binder audit:** before any proposal goes out, I get the vendor's actual SOC/report status, BAA/DPA posture, and data-flow documentation level in writing from our own security team, and I check each against the prospect's industry requirements *myself*. Anything red gets a dated remediation path *before* pricing is discussed.
3. **"What does security need to say yes?"** replaces "is security a blocker?" — asked verbatim, in discovery, to the security stakeholder, not about them.
4. **Un-dead rule:** a deal that dies in security review comes out of forecast the same week, and any re-open starts with a written closure log, not optimism.
5. **The closure log format** (finding → owner → date → evidence link) now travels with me; two prospects have adopted it as their own vendor-tracking template, which is the cheapest credibility I've ever bought.

## What I'd still do differently

The 2022 version of me needed this loss to exist to build the 2023 process. If I'm honest, the binder audit was *knowable* in July 2022 from public SOC listings, and I skipped it because the deal felt won. The lesson isn't "process beats luck." The lesson is that "feels won" is exactly when discipline is cheapest, and I have the ten months of standing still to prove it.
