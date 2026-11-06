<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Incident postmortem program

Fernbrook Systems, Platform & Developer Experience. Built May 2022 to September 2023; I've owned it since. I built the blameless postmortem practice: from almost no postmortems to a doc for about 90% of Sev-1 and Sev-2 incidents, with 94% of action items completed. It started with an incident, survived resistance from the most respected engineer in the building, and the version that stuck is much smaller than the one I first proposed.

## The full story

I was six weeks into the Fernbrook platform job in May 2022 when a config service pushed a malformed rule set to 60% of production and degraded checkout for 2 hours 40 minutes. I wasn't on call. What I found afterwards was the bigger problem: four postmortem docs in the whole company, one of which blamed an engineer by name. The same failure class had caused two Sev-2s in the nine months before. That pattern is what convinced the CTO.

My first proposal was a full program, and my VP sent it back. What shipped was small: a two-page template, a writing rule that keeps people out of contributing factors, action items with owners and dates in team sprints, a 30-minute review, and links between recurring factors. I reviewed the first ten docs myself and sent two back for blaming people. The no-executives rule came from the first review, where a VP's questions silenced two engineers.

Then came the resistance. The company's most respected senior staff engineer refused to write one for his Sev-2; he was the engineer named in the old doc. I wrote his incident up myself in blameless form and asked him to mark it up. He did, hard, and wrote the next one himself. An exec wanted names in docs; we kept names on action items only. Platform took on the timeline work, so authors spent about 90 minutes, not days.

The config-push fix shipped in October 2022, and there has been no config-propagation Sev-1 since. At month 14 I stopped reviewing every doc, and the numbers held. Today about 90% of Sev-1 and Sev-2 incidents get a doc within 10 business days, and 94% of action items close within 60 days. Two rotating senior engineers and the author run the reviews; I still own the program.

What's open: the last 10% of docs, missed mostly when a team is short-staffed, which I report rather than hide. And one cause did repeat, because its fix had an owner but no verification step. Verification is now a required field, and the next year of repeat-cause numbers will show whether that was enough.

## The incident that started it (May 2022)

An internal config service pushed a malformed rule set to 60% of production services over 22 minutes. Checkout, the company's largest revenue path, was degraded for 2 hours 40 minutes: about $180K of direct revenue impact, 3,100 support tickets, and a customer escalation that reached the board.

I wasn't on call. I was six weeks into the platform job, with a charter that said "operational excellence". What I found:

- **Four postmortem docs in the whole company,** the oldest 14 months old. Three were one-paragraph apologies. One named and blamed a specific engineer, in a doc every employee could read. That doc was why nobody wrote postmortems.
- **Incident response was good:** paging, mitigation and communication all worked. The org could fight fires and had no habit of learning from them. Fixes were hallway conversations that disappeared.
- **The same failure class had happened before:** config pushed without validation or canary had caused two smaller Sev-2s in the previous nine months. Three occurrences, nothing learned. That's what convinced the CTO.

## The design, and what I cut from it

My first proposal was the full program: review committees, a severity matrix, an action-item tracker, blameless training. My VP's feedback: "This is beautiful and we will do none of it. What's the smallest thing that would still work?" What shipped:

1. **One short template.** Impact (customer-visible, dollars if known); a timeline from real sources, with corrections to memory marked; contributing factors, plural and systemic; what went well (mandatory, because it shows a defensive reader the doc isn't an attack, and it records what worked); action items, each with a name and a date. Two pages at most. The old docs failed partly because writing them was unpaid work; the template cut the work.
2. **Blamelessness as a writing rule.** Contributing factors must describe the system or process, never a person's action. "The engineer deployed" is a timeline entry; "no dry run existed for config pushes" is a contributing factor. I reviewed the first ten docs and sent two back for blaming people, with rewrites offered. Those rewrites, done with the authors, were the program's real marketing.
3. **Action items go on a roadmap or they don't exist.** Each has a named owner, a due date and a slot in the owning team's sprint. Platform took the cross-cutting ones under my charter. Completion is tracked and published monthly. That's the only reason the number is 94% and not 40%.
4. **A 30-minute review:** the author presents for 10, discussion for 15, no executives in the room. That rule came after the first review, where a VP's questioning silenced two engineers. I showed him the recording, and he agreed to the rule. His word: "fair."
5. **Recurring factors are linked automatically.** When a doc's contributing factors match an earlier doc's, they're linked. The config-push link produced the three-incidents-one-cause chart that funded the fix.

## Resistance

- **The company's most respected senior staff engineer refused to write one** after his service's Sev-2. His reason was fair: "Postmortems here are blame documents with better fonts." He turned out to be the engineer named in the old doc. I didn't argue in public. I wrote the doc for his incident myself, in blameless form, and asked him to mark it up. He marked it up hard and correctly, then wrote the next one for his own incident, and it became the best doc we have. He runs reviews now, more strictly than I do. Resistance to blamelessness was a scar, not a philosophy, and addressing the scar worked.
- **"We don't have time."** The two-page cap helped, and so did platform doing the timeline work: pulling timestamped facts from logs, pages and chat so authors only wrote the analysis. Median author time dropped to about 90 minutes, measured by survey.
- **An exec wanted names in docs "for accountability".** The compromise that held: action items have names, public and tracked; contributing factors don't. Accountability attaches to the fix, not the mistake. He accepted it after a quarter at 94% completion.

## Outcome, measured

- **About 90% of Sev-1 and Sev-2 incidents get a doc within 10 business days.** The target is 100%. The misses are mostly staffing gaps, and I report them.
- **94% of action items completed within 60 days,** published monthly.
- **Repeat causes:** contributing-factor classes that recurred within 12 months went from 3 of 9 to 1 of 11 in the year after the program matured. The one that recurred had a fix with an owner and no verification step, so verification is now a required field on every action item.
- **Config-push validation and canary** shipped in October 2022 as the program's main fix. There has been no config-propagation Sev-1 since.
- **It runs without me.** I stopped reviewing every doc at month 14. Reviews are now run by two rotating senior engineers and the author. The numbers didn't move when I stepped out, which is when I counted the program as real.

## What I'd tell someone building this

1. Start with the smallest version that has one enforcement mechanism. Ours was action items on the roadmap. Postmortem programs die of being optional, not of being small.
2. Enforce the phrasing rule first; the culture follows the format.
3. Do the timeline work for authors so their time goes into analysis.
4. Link recurring factors. It turns 20 docs into a pattern library instead of a graveyard.
