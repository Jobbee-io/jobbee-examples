<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Paid acquisition restructure

Slatebird, January – December 2023. On my resume this is one bullet with 4 numbers: non-brand paid CAC $2,050 → $1,380, payback 24 → 16 months, paid spend $4.2M → $3.1M a year, total new paid accounts +3%. This file holds what I found when I took the budget over, the options I turned down, the definitions agreed with finance, the 2 tests behind the changes, the rebuild, the timeline, who disagreed, the channel I cut on the wrong metric, and what's still untested.

## What I inherited

When I joined Slatebird in August 2022 I took over paid acquisition: $4.2M a year. Brand search $1.6M, non-brand search $1.8M, LinkedIn $0.52M, review sites and Meta $0.28M.

- About 140 campaigns, all bidding on trial signups. 70% of them got fewer than 15 signups a month, too few for automated bidding to learn from.
- In the channel report, brand search was the cheapest line by far, at about $720 per paid account. Non-brand was $2,050 and LinkedIn $3,700.
- In the search terms, about 40% of non-brand signups were students, solo freelancers and people hunting for a free template. They almost never activated.
- Finance has a ceiling for any paid channel: 20 months of simple payback. Non-brand paid was at 24.

The question from leadership in January 2023 was whether to cut paid or fix it.

## The options

1. Finance's first suggestion: cut every channel by 30%, about $1.3M a year. Simple, but it cuts good and bad spend alike, and we'd learn nothing.
2. Hand paid search to an agency. About 12% of spend in fees, and it didn't fix the measurement problem, which was the real one.
3. Fix it in a fixed order. First test whether brand search is incremental, because that test was the fastest and cheapest. Then change what bidding learns from. Only then rebuild the account, because a rebuild resets bidding and would have contaminated the bidding test.

I proposed option 3 with a promise: if non-brand payback wasn't under 20 months by the fourth quarter, I'd bring back option 1 myself. The Director of Growth Marketing and the CFO approved it in late January.

## Definitions, agreed with finance before any change

- Paid CAC: paid media spend plus paid-channel tools and contractors in a period, divided by new paying accounts whose signup came from a paid click (last paid click, 30-day window) in that period. No salaries.
- Payback, in months: paid CAC divided by (starting MRR of a new paid account × 82% gross margin). In 2023 the average new account started at $104 MRR. Simple payback, no churn; I show the cohort version with churn when a decision is close.
- Non-brand CAC is the main number. Blended CAC hides the problem, for reasons in the results.

This took 3 weeks. Finance wanted salaries in CAC. We agreed that channel decisions use paid CAC without salaries, and the fully loaded number goes in finance's quarterly report, never next to a channel comparison.

## Test 1: brand search geo holdout

- Hypothesis: most people who click our brand ads would sign up anyway through organic or direct, because we rank first for our own name and few competitors bid on it.
- The decision rule, written first. Brand search paid for itself under our ceiling only if about 40% of the signups it got credit for were incremental. In the paused metros, that meant total signups falling about 9%. I sized the test to tell a 9% drop from a 3% one.
- Design: brand search paused in 14 metro areas, matched to 14 control metros on 12 months of weekly signups, population and brand-paid share. 6 weeks, March 6 – April 16, 2023. The paused metros held about 18% of US signups. Primary metric: total trial signups from all sources, paused vs control, as a difference-in-differences against the 8 weeks before. I pre-registered a 90% interval: the decision could be reversed in a day by turning brand back on, and finance agreed that was enough confidence for it.
- Result: total signups fell 3.8% in the paused metros (90% CI −6.9% to −0.7%). Brand-paid had been 21% of signups there, so about 82% of them came anyway. The whole interval sat above the 9% break-even.
- What shipped: brand spend cut from $1.6M to $0.4M a year in May. We kept bidding on our name only where auction data showed competitors in more than 20% of auctions, and on comparison searches ("slatebird vs", "slatebird alternative").

Our CEO's worry was that a competitor would take the clicks. The $0.4M was the answer to that: we kept bidding exactly where competitors showed up.

## Test 2: bid on activated trials, not signups

I had 3 choices for what bidding should learn from:
- Paid accounts. The real goal, but non-brand produced about 75 a month spread across dozens of campaigns, and each one arrives up to 60 days after the click. Too few and too late.
- Activated trials. A 7-day lag, about 4 times as many as paid accounts, and activated workspaces converted to paid at about 5 times the rate of the rest. Chosen.
- A predicted value per signup. We had no model for it.

- Hypothesis: if Google Ads learns from activated trials instead of signups, non-brand CAC falls at least 15% at the same spend, because about 40% of non-brand signups never activate.
- Build: offline conversion import. Each activated trial (in 2023: at least 5 assignments within 7 days) is sent back to Google Ads daily with its click ID.
- Design: a 50/50 campaign experiment on the 8 biggest non-brand campaigns, about 60% of non-brand spend, at equal spend, for 6 weeks. It started April 18. After the upload bug below, I threw out the first 11 days and restarted the clock: 6 clean weeks, April 30 – June 10, 2023.
- CAC in the test: spend in each arm divided by paid accounts from that arm within 60 days of signup.
- Result: signups −12%, paid accounts +23%, paid CAC −19% in the treatment half.

I shipped to all campaigns in July on the activated-trial result and 30-day paid accounts, and the 60-day number confirmed it in August. Today I'd wait for the 60-day read before shipping. That rule came a year later, from the template test (`Template Onboarding False Win.md`).

The sales-assist lead objected to the 12% drop in signups, since fewer signups looked like fewer leads for his team. His team calls workspaces with 5 or more invited users. In the treatment arm those were up 9%. He agreed to the rollout.

## The rebuild (July – August)

The contractor and I rebuilt 140 campaigns into 22, grouped by intent: comparisons, the category ("resource planning software"), use cases ("agency capacity planning") and problems ("team scheduling spreadsheet"). Shared negative keyword lists blocked "free", "template", "student" and "excel". 16 of the 22 campaigns get at least 20 activated trials a month, enough for bidding to learn. Bidding relearned for about 3 weeks: non-brand CAC rose about 10% in August, then fell.

## Other channels

- LinkedIn: cut in May. That was a mistake; see below.
- Review sites and Meta, $0.28M together: paused in May. Each brought fewer than 15 paid accounts a month. In the January 2024 review I checked both on payback with their own starting MRR. Both were over 30 months, so they stayed off.

## My role

I owned the budget and the plan, with one paid-search contractor at 10 hours a week who did most of the rebuild. I designed both tests and wrote both readouts; our analyst checked the metro matching and my queries. I wrote the spec for the conversion upload, and one engineer built it in 2 sprints. Our finance partner signed off on the definitions.

## Timeline

- August – December 2022: the diagnosis above.
- January 2023: definitions agreed; plan approved.
- March 6 – April 16: brand holdout.
- April 18: bidding test starts. April 29: upload bug found. April 30: clock restarted.
- May: brand cut to $0.4M; LinkedIn, review sites and Meta paused.
- June 10: bidding test ends. July: rolled out to all campaigns.
- July – August: rebuild.
- January 2024: finance review; LinkedIn back.
- March 2024: brand holdout repeated.

## The result, H2 2023 vs H2 2022

- Paid spend $4.2M → $3.1M a year: brand $0.4M, non-brand $2.7M. Of the $1.2M taken out of brand, $0.9M went into non-brand.
- Non-brand paid CAC $2,050 → $1,380. Payback 24 → 16 months, under the ceiling. By my estimate the bidding change explains about 19 points of that 33% drop, and the rebuild and negative keywords the rest. I didn't test them separately.
- Non-brand paid signups that activated: 17% → 26%.
- Total new paid accounts, all channels: +3%, on 26% less paid spend.
- Blended paid CAC, brand included, barely moved: $1,240 → $1,210. The brand campaigns we cut were the cheapest-looking line, and most of what they got credit for came anyway. That's why I never report blended CAC alone.

## What went wrong

- The upload bug. From April 18 to 29 the upload sent times in UTC without saying so. Google read them as Eastern time, so evening conversions looked like they hadn't happened yet and were rejected: about 18% of them. Bidding in the treatment half saw fewer conversions and pulled back, and its signups fell 14% over those 11 days. The contractor noticed, not a check, because I hadn't built one. Now a daily job compares uploaded conversions with the warehouse and alerts at a 5% gap.
- I cut LinkedIn on CAC alone. Its paid CAC was $3,700, the worst line in the report. In January 2024 a finance review showed LinkedIn accounts started at $236 MRR, 2.3 times our average, mostly agencies with 15+ people. On payback that's 19 months, under the ceiling. We restarted it at $15K a month in Q1 2024 and it measured 19 months that year. I never measured what the 8-month gap cost, and I won't guess.
- I ran the brand holdout once, in spring, and called it settled. I re-ran it in March 2024: about 79% came anyway. Close, but I should have planned the repeat.

## What's still open

- Non-brand search has never had a holdout. Its CAC assumes every paid-click signup is incremental, which is surely too generous. A holdout is harder here: non-brand is 87% of paid spend, and pausing it in a fifth of the country costs real signups. I proposed one for 2025. It hasn't run.
- Bidding optimizes whatever we send it. In late 2024 a tracking bug inflated activated trials, bidding chased the false conversions, and non-brand CAC rose from about $1,390 to $1,560 for 2 months (`Template Onboarding False Win.md`). The daily reconciliation catches a broken upload. It can't catch a wrong definition.

## What I'd do differently

- Rank channels on payback with each channel's own starting MRR, from day one. CAC alone ranks channels by the cheapest accounts, not the best ones.
- Build the reconciliation check before the first upload, not after the first bug.
- Put a brand holdout on the calendar once a year.
