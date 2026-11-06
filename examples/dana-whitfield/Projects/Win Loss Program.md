<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# The win/loss program that changed roadmap decisions

Halyard Tools, September 2019 to January 2022. I built Halyard's win/loss program from zero: no budget line at the start, no tool, a spreadsheet and an interview guide. In its first two years it produced 94 interviews (58 losses, 36 wins). It changed two roadmap decisions and retired one pricing model. This file holds the program design, the three decisions, and the mistakes.

## The full story

When I started the program in September 2019, Halyard knew its win rate, 54%, and every team had a theory for the losses that put the cause somewhere else. There was no budget and no tool, just a spreadsheet, an interview guide and the habit from my 2016 loss calls at Quillon.

I ran the interviews myself, on deals above $50K ACV, and coded each one against the same frame. For the first two quarters I interviewed only losses. That was a mistake: leaving out the wins hid the onboarding pattern for two extra quarters. In 2020 it was plain anyway. 22 of the first 40 coded losses said, in different words, that they couldn't get it running inside the trial window. Product re-prioritized the quickstart path and setup automation, and the win rate reached 61% over the next three quarters. The change was product's and engineering's; the evidence and the argument for it were mine.

In year two a part-time contract researcher took about half the interviews, after we both coded the same 10 to check we agreed. I got the buyer decline rate from about 50% down to about 30%, later than I should have. The program helped pull drift remediation forward to Q1 2021, and in 2021 the pricing team retired usage credits once the pattern showed up across more than 30 interviews. Along the way, one trimmed verbatim cost a customer success manager an awkward week, and I changed my rule on editing verbatims.

In its first two years the program produced 94 interviews, two roadmap changes and one retired pricing model. I left Halyard in January 2022 and handed the guide, the coding frame and the interview log to the product-marketing team.

What was still open when I left: a 30% decline rate still meant a biased sample, and half the interviews depended on one contractor. I can't speak for how the program ran after that.

## What existed before

Halyard knew its win rate, 54%, and had a folk theory for every loss: "price," "the incumbent," "the demo went sideways." Each team's theory put the loss outside that team's control. Sales lost on price; product lost on features. Nobody ever lost on their own onboarding. The reps on each lost deal had the raw material, but it was unrecorded, and unrecorded knowledge drifts toward whatever flatters the person holding it.

## The design

**Who interviews.** I did, not the account rep. A buyer curates their answer for the rep, because they may work with that person, or avoid them, for years. Someone with no account future hears what reps never hear. In year two a part-time contract researcher ran about half the interviews with the same guide. We both coded the same 10 interviews first to check that we were coding them the same way.

**The interview.** 30 to 40 minutes, structured but conversational. One rule produced most of the value: always ask the follow-up after the polite answer. The first reason a buyer gives is the comfortable one ("price"). The real one is a question further down: "price relative to what we believed it did; your deployment claims needed three engineers to verify." We logged both answers, because the gap between them is the finding.

**The coding.** Every interview was coded against a fixed frame:
- the trigger for the evaluation;
- the alternatives considered;
- the evaluation process;
- decision criteria, both stated and revealed;
- when the deal was actually decided.

Buyers decide earlier than they say, and "when did you decide?" is where losses stop being about features.

**Cadence and output.** Every deal above $50K ACV, win or loss. Each quarter I produced a synthesis: one page of patterns, one page of verbatims, one page of recommended decisions. It went to the whole company and was presented live to leadership. Recordings were available internally under a no-attribution rule, so buyers stayed safe to be honest.

## The decisions it changed

1. **The onboarding rebuild (2020).** Of the first 40 coded losses, 22 described some version of "we couldn't get it running in the trial window." None of the 22 gave "product" as the reason. The folk theory said features; the data said the first 48 hours. Product re-prioritized the quickstart path and setup automation. The win rate moved from 54% to 61% over the next three quarters. The verbatim I keep: "We loved the demo. We just never got our own pipeline to that state."
2. **Drift remediation, pulled forward (2020 to 2021).** The 2019 messaging test had already put drift detection into Flowramp's GA scope (`Projects/Tier 1 Launch Api Platform.md`). Automatic remediation was planned for late 2021. Win/loss found it in 14 loss write-ups as "the thing the other tool had." Two different instruments pointed at the same gap, and remediation moved up two quarters, shipping in Q1 2021.
3. **Usage credits, retired (2021).** In 18 coded losses, and tellingly in 4 wins, buyers described usage credits as "a meter running during evaluation." They under-tested the product to avoid the bill, then judged a hobbled version. The pricing team had defended credits for a year against anecdotes. They retired them one quarter after seeing the pattern across more than 30 interviews, and replaced them with free evaluation tiers. Evaluation-to-paid conversion rose 19% in two quarters.

The quarterly win/loss read also became the one company-wide document people argued with. That's the only compliment I want for a synthesis.

## What I'd do differently

- **I waited too long to include wins.** The first two quarters were losses only, because losses feel urgent. The patterns in why the 54% chose us would have surfaced the onboarding finding two quarters earlier.
- **I treated a 50% buyer decline rate as a fact of nature.** It wasn't. In year two, three changes got it to about 30%: a shorter guide, a $75 thank-you donation to a charity of the buyer's choice, and asking at decision time rather than two weeks later. Every 10 points of decline is a more biased sample. I knew that and acted slowly anyway.
- **I presented verbatims unattributed but not unedited.** One verbatim, lightly trimmed, was recognizable enough internally that it cost a customer success manager an awkward week. Since then my rule is that no verbatim is sharper than the deal team can defend. The no-attribution rule protects buyers; internal people need the same protection.

## Why it matters for the role I want

The program needed no permission, no tool and no headcount to start. It needed the patience to code 94 interviews, and the standing to put the findings in the roadmap debate. That is the difference I look for in a PMM seat: being in the room when the roadmap is argued, not handed it afterwards.
