<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Developer-trust turnaround — 18 months at Verity Cloud

Verity Cloud, 2022–2024. When I joined Verity, its developer community — a practitioner forum and a public issue tracker around the developer platform products — didn't dislike the company; it *actively discounted* it. Sentiment panel score: **−34** on an NPS-style scale. The story practitioners told each other: Verity was an enterprise vendor cosplaying developer-friendliness, the docs were sales collateral with code blocks, and the community channel existed to capture leads. Eighteen months later the same panel read **+12**, and the forum's own moderators stopped prefacing product threads with "in my experience with Verity, verify everything." This file documents what worked, what backfired, and the one number I refuse to round up.

## The diagnosis, from listening before building anything

Six weeks of reading forum history, support-ticket deflection data, and — the part that changed my plan — fourteen off-record calls with practitioners who had publicly criticized Verity. Three findings:

1. **The distrust was earned.** In 2020–2021 the community channel had been staffed by an outsourced team reading from a script, docs had been rewritten by an agency with no engineer review, and a promised open-source SDK had been announced, delayed twice, and quietly descoped. Each incident was still individually remembered and collectively fatal.
2. **Nobody disbelieved the product.** The practitioners who rated Verity lowest still rated the underlying platform technically sound. The debt was in *behavior*, not architecture. That made the debt repayable — behavior changes are cheap; architecture changes are not.
3. **Trust would not be rebuilt by campaigns.** Every practitioner I talked to could identify marketing "initiatives" on sight. The turnaround had to look like the company changing, not the company announcing change.

## The program that worked: the unmarketing motion

One program, three commitments, all boring by design:

- **Engineers in the channel, by rotation.** Every Verity platform engineer took one half-day channel shift per month, answering with their name and title. No scripts. I wrote the rotation, the escalation path, and one rule: "don't know" is an acceptable answer; a wrong answer is not. By month six, the highest-trust threads in the forum were the ones engineers had answered.
- **Docs with named reviewers.** Every doc page got a named engineer reviewer and a "last verified against release X.Y" stamp. The agency docs were replaced over two quarters. Where docs were wrong, we said so in the changelog — the corrections log became, weirdly, the most-linked page on the site.
- **The SDK, delivered exactly as promised and late.** We re-announced it with a dated public plan, missed a milestone, *said we missed it and why*, and shipped the rest on the revised dates. The miss-and-acknowledge cycle did more than the on-time parts: the community's complaint had never been the delay, it was the silence.

Sentiment panel: −34 (Q1 2022) → −11 (Q1 2023) → +12 (Q2 2023, held through 2024). Supporting metric that matters more to me: practitioner-initiated posts citing Verity docs as a *positive example* went from zero in 2021 to nine across 2023–2024. You can't buy the ninth one.

## The program that backfired, in full

The **"Verity Builders" advocacy cohort**, launched month 8: a hand-picked group of twelve community members given early access, direct product-team access, and — this was the mistake — a small honorarium and a branded swag pack, announced publicly.

Within three weeks the forum had a thread titled "paid shills," with screenshots of the honorarium clause. Two members resigned from the cohort rather than carry the label. The early-access part nobody minded; the *money and the merch* converted genuine enthusiasm into suspected astroturf, and it contaminated the credibility of cohort members' genuinely independent positive posts.

We killed the honorarium and the swag at month 10, kept the early access, re-invited the two who resigned, and issued a one-paragraph public note explaining the change without excusing it. Recovery took two quarters; the sentiment panel dipped −7 during the "shills" quarter, the only reversal of the 18 months.

**The lesson, stated so I don't relearn it:** developer trust converts *from* demonstrated behavior *and* demonstrated independence. Any program that puts money or merch between a practitioner's honest voice and their honest audience is a program that spends credibility to buy the appearance of it. Early access works because it's a product decision; honorariums fail because they're a influence purchase. I've turned down two "ambassador program" pitches since, and this file is the reason I can explain the no in one sentence.

## What I'd carry to the next org

- **Named humans beat brand voices** — in channels, in docs reviews, in corrections. The single highest-leverage change cost half a day per engineer per month.
- **Miss-and-acknowledge beats silent delay**, every time, everywhere. It is the cheapest trust behavior that exists, and almost nobody does it.
- **Sentiment needs a panel, not a vibes read.** Ours was a 40-person quarterly panel of practitioners recruited from critics and fans alike — the critics mattered most, because they had the most to lose by softening.
- **The number I refuse to round up:** +12 is a passing grade, not a triumph. A community that once scored you −34 and now scores +12 is a community that remembers. That's not a reason to stop; it's the reason the rotation program never got sunset. Trust compounds in both directions.
