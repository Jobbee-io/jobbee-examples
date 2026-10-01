<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The win/loss program that changed roadmap decisions

Halyard Tools, 2019–2022. The project I cite when a company asks whether PMM can be a strategic function or is permanently a content desk. I built Halyard Tools' win/loss program from zero — no budget line, one part-time researcher, a spreadsheet, and a lot of stubbornness — and within two years it had changed two roadmap decisions and retired one pricing model. This file is the design of the program, the decisions it changed, and the parts of the craft that don't survive being written down as a template.

## What existed before (nothing, and worse than nothing)

Halyard Tools knew its win rate (54%) and had folk theories for every loss: "price," "the incumbent," "the demo went sideways." Every theory was someone's experience standing in for evidence, and — the tell I've since learned to spot everywhere — every team's folk theory assigned the loss to a factor outside that team's control. Sales lost to price; product lost to features; nobody ever lost to their own onboarding. The raw material was there (every closed-lost deal had a rep who'd been on the calls) but the knowledge was unstructured, unrecorded, and self-serving in exactly the way unrecorded knowledge always is.

## The program design

**Who does the interviews, and why that's the whole ballgame:** I interviewed directly — not the account rep. The rep on a lost deal is the person least able to hear the real reason; the buyer curated their answer for the person they'd be working with (or avoiding) for years. A neutral third party with no account future gets answers reps never hear. Where travel budgets allowed, a researcher I trained ran the second-year interviews with the same guide, and we calibrated on ten shared interviews to keep the coding consistent.

**The interview itself:** 30–40 minutes, structured but conversational, with one rule that produced most of the value — *always ask the follow-up after the polite answer.* The first reason a buyer gives is the socially comfortable reason ("price"); the real reason lives one follow-up down ("price *relative to what we believed it did* — your deployment claims needed three engineers to verify"). We logged the first answer AND the follow-up, because the gap between them is the finding.

**The coding:** every interview coded against a fixed frame — triggers, alternatives considered, evaluation process, decision criteria stated vs. revealed, and the moment the deal was actually decided (buyers decide earlier than they say; the "when did you decide" question is where losses stop being about features). Coded in a spreadsheet before anyone told me I needed a tool; the tool came later and changed nothing about the thinking.

**Cadence and output:** every deal above $50K ACV, win or loss (losses-only programs drift toward complaint-collecting; wins are half the signal). Quarterly synthesis: one page of patterns, one page of verbatims, one page of recommended decisions. Sent to the whole company, presented to leadership live, with recordings available under a no-attribution rule so buyers stayed safe to be honest.

## The decisions it changed

**1. The onboarding rebuild (2020).** Twenty-two of the first 40 coded losses had some version of "we couldn't get it running in the trial window" — and none of the 22 said "product" as the reason. The folk theory said features; the data said the first 48 hours. Product re-prioritized the quickstart path and setup automation; win rate moved from 54% to 61% over the following three quarters. The verbatim I keep: "We loved the demo. We just never got our own pipeline to that state."

**2. The drift-detection priority call (2020–2021).** The community messaging test had already flagged drift detection as the missing differentiator (`projects/tier-1-launch-api-platform.md`); win/loss independently found it in 14 loss write-ups as "the thing the other tool had." Two independent signals from two different instruments pointing at the same gap is as close to certainty as roadmap decisions get. It shipped six months early.

**3. The usage-credit pricing model, retired (2021).** Eighteen coded losses (and, tellingly, four wins) described usage credits as "a meter running during evaluation" — buyers under-tried the product to avoid the bill, then evaluated a hamstrung version. The pricing team had defended the model for a year against anecdotes; they retired it one quarter after seeing the pattern across 30+ interviews, replaced by free evaluation tiers. Evaluation-to-paid conversion went up 19% in two quarters.

**Cumulatively:** 94 interviews over two years, three decisions above, and a quieter cultural shift — the quarterly win/loss read became the one company-wide document people actually argued with, which is the only compliment I want for a synthesis doc.

## What I'd do differently

- **I waited too long to include wins.** The first two quarters were losses-only because losses feel urgent. Wins-only patterns (why the 46% chose us, often for reasons adjacent to why others left) would have found the onboarding finding two quarters earlier.
- **Buyer decline rate was 50% and I treated it as a fact of nature.** It wasn't — a shorter guide, a $75 thank-you donation to a fund of the buyer's choosing, and asking *at decision time* instead of two weeks later got the rate to ~30% in year two. Every 10 points of decline is a biased sample; I knew this and underacted anyway.
- **I presented verbatims unattributed but not unedited.** One verbatim, lightly trimmed for length, was recognizable enough internally that it cost a CSM an awkward week. The no-attribution rule protects buyers; internal people need the same protection, and since then "no verbatim sharper than the deal team can defend" is my editing standard.

## What this proves about PMM as a function

The program needed no permission, no tooling, and no headcount to start — a calendar, a guide, and the standing to ask buyers for 30 minutes. What it needed that most orgs won't give: someone with the patience to code 94 interviews and the standing to put the finding in front of the roadmap debate. That's the PMM-as-translator seat in one project: not the person who makes the roadmap sound good — the person who makes sure the roadmap hears what the market actually said.
