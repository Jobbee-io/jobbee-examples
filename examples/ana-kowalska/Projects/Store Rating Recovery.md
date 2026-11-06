<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Store rating recovery after release 8.12

Migiem, customer app, March to June 2024. I was the release captain for version 8.12, the worst release we've had, and I led the recovery afterwards. One bullet on my resume.

## The full story

I was release captain for 8.12. It moved session tokens to encrypted storage, and tokens created before an April 2022 format change failed to parse. It went to 20% on 5 March 2024, and I approved 100% the next day, because crashes and ANRs looked normal. A logout isn't a crash. Support saw it first. The hotfix reached 100% 31 hours later, but by then about 140,000 users had been logged out, and for about 6 hours our SMS provider's rate limit stopped roughly 30% of the login codes they needed from arriving.

The 28-day average of new ratings fell to 3.1. I owned the hotfix, the new release process and how we measured the recovery, and I ran the review replies with our support lead. Our product manager owned the review-prompt change, and a backend engineer fixed the SMS limit with the provider. Our first reply template was corporate, and few reviewers updated their rating; plain replies worked much better. The fix alone took the average to 4.3 by the end of April. By the end of June it was 4.6, and I keep that step separate: most of it came from the prompt change in May, asking at a better moment, not from a better app.

The public rating was back at 4.5 by mid-June, and the staged-rollout gates have run on every release of both apps since April 2024.

What's open: the gates only watch what we chose to measure. The login gate exists because 8.12 got past gates that only watched crashes and ANRs. The next bad release could fail in a way none of the four gates sees.

## What happened

Version 8.12 moved session tokens into encrypted storage. Tokens created before a format change in April 2022 failed to parse in the new code, and the app treated those users as logged out. About 22% of our Android users still had an old token, because our sessions were long-lived. They had to log in again with an SMS code, and at that volume our SMS provider rate-limited us: for about 6 hours on 7 March, roughly 30% of login codes didn't arrive.

The rollout: 20% on Tuesday 5 March, 100% on Wednesday 6 March. I approved the step to 100%. Crash-free users for 8.12 were at 99.7% and the ANR rate was normal. A logout isn't a crash, so none of our gates could see it. Support saw it first.

Hotfix 8.12.1 reached 100% 31 hours after the 100% step. It read the old token format correctly, so anyone who hadn't opened 8.12 yet was never logged out. By then about 140,000 users had been.

## The damage, by definition

- 1-star share of new ratings: 8% in February, 47% in the week of 4 March, about 3,900 one-star ratings in the first 4 days.
- Average of new ratings over a rolling 28 days (Play Console): 4.4 in February, lowest at 3.1 for the 28 days ending 31 March.
- Public rating on the Play listing, which Google weights toward recent ratings: 4.5 before, lowest at 4.1 in early April.

## My role

I owned the hotfix and the review replies together with our support lead, and I wrote the new release process. Our product manager owned the review-prompt change, and I owned how we measured it. A backend engineer fixed the SMS rate limit with the provider.

## What we changed

The release process. Every release now goes 1% → 5% → 20% → 50% → 100% over at least 7 days. Each step has written gates for the new version: crash-free users at least 99.5%, user-perceived ANR rate at most 0.30%, logins per daily active user no more than 10% above the previous version, and a 1-star share of its ratings no more than double the baseline. The login gate is the one that would have caught 8.12. If a gate fails, the release captain halts, and only our engineering manager can override.

Review replies. We replied to about 2,600 one-star reviews that mentioned logging out, each within 48 hours. Reviewers get a notice when a developer replies, and about 19% of them updated their review, to an average of 4.0.

The review prompt. Before, we called the In-App Review API on a user's 3rd app open, which often meant mid-task, sometimes while an order was late. Now it appears on the order-complete screen after a user's 2nd delivered order. One idea was to show it only to people who had rated their delivery 4 or 5 in our own order rating. I argued against it and it was dropped: Google's guidelines say not to ask opinion questions before or while showing the prompt, and the store rating would end up measuring our filter instead of the app.

## The numbers, and what I claim from them

- Average of new ratings (28 days): 3.1 to 4.3 for the 28 days ending 30 April, with the fix and nothing else. Then 4.6 for the 28 days ending 30 June, after the prompt change shipped on 7 May.
- Public rating: 4.1 to 4.5 by mid-June, 14 weeks after 8.12. 4.6 since September 2024.
- Since April 2024: 93 releases across both apps, 7 halted at 1% or 5%, none past 5% with a blocking bug.

A store rating is the easiest number on a resume to bend, so here is the split. I asked product to hold the prompt change until May so the two effects would land in different windows. The 4.3 is the fix. Most of the step from 4.3 to 4.6 is the prompt asking happier people at a better moment, not the app getting better. I say so whenever I quote it.

## What went wrong

- I approved 100% after one day at 20%, with gates that only watched crashes and ANRs.
- Our test plan covered updates with accounts made that month, never a token from 2022. A few months earlier I had learned with the cart migration (`Crash And Anr Recovery.md`) to test upgrades with real old data. I applied it to data I knew about, not to the session token.
- Our first reply template was corporate apology text. About 4% of the first 300 reviewers updated their rating. Plain text worked better: what broke, that it's fixed, update and log in once. About 21% of the next 2,300 updated.
- In the first week I wanted to show the prompt more often to dilute the 1-stars. Our PM talked me out of it, and Google limits how often the prompt shows anyway.
