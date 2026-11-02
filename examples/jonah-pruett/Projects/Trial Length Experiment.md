<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Trial-length experiment: 7, 14 or 30 days

Slatebird, January – December 2024. On my resume this is one bullet: a 3-arm test where no arm won, and a follow-up that did. This file holds both tests: the two hypotheses that couldn't both be true, the designs I turned down, how the test was sized and checked, the result, the segment I didn't trust until I'd tested it on its own, the timeline, who wanted what, and what's still open.

## Why

Slatebird's trial had been 14 days since 2019: the Team plan, no card, and at the end either a paid plan or a free plan for up to 3 people. In late 2023 two teams wanted the length changed, in opposite directions. Sales-assist and customer success wanted 30 days: agency teams need time to load their projects and bring colleagues in. Finance wanted 7: a closer deadline gets people to set up sooner, and cash arrives earlier. Both had anecdotes. Nobody had data, because the trial length had never been tested.

## Designs I turned down

- Switching to 30 or 7 days without a test. Whichever team won the argument would have changed the trial for every signup, and we'd never know what it did.
- 2 arms (14 vs 30). It needed about 26,000 signups instead of 48,000, about 8 weeks instead of 14. But it would have tested only one team's idea, and finance would have asked for the 7-day test next. One 3-arm test was faster than 2 tests in a row.
- A 4th arm with a card required at signup, which finance asked for. It answers a different question, because it changes who signs up at all, and it needed its own sizing. Billing policy also isn't mine to test on the side. It's still untested.
- A 21-day arm. A 4th arm, with a third comparison to correct for, would have added about 6 weeks of enrollment.
- Two other primary metrics. "Converted by the end of the trial" would have made the 30-day arm look worse by design. Revenue-weighted conversion is noisier, because team size varies so much, and would have needed about 3 times the sample.

## Hypotheses, metric and design

- 30-day hypothesis: a 30-day trial raises trial-to-paid by at least 1 point, because teams need more time to bring colleagues in.
- 7-day hypothesis: a 7-day trial raises trial-to-paid by at least 1 point, because a near deadline makes people set up sooner. Both can't be true, which is why it was worth a test.
- Primary metric: trial-to-paid within 60 days of signup, the same window for every arm, so the 30-day arm still had 30 days after its trial ended.
- Secondary: starting MRR of a new paid account. Guardrails: paid accounts still paying after 90 days, and support tickets per 100 trials.
- Design: 3 equal arms, random at workspace creation. Two comparisons against control, so each was tested at 2.5% (Bonferroni). From a baseline of 8.6%, detecting a 1-point change at 80% power needed about 15,700 workspaces per arm. Enrollment ran 14 weeks, February 5 – May 12, 2024: about 48,400 signups.

The sales-assist lead, our finance partner and the Director of Growth Marketing signed the plan on January 26, before anything was built. Both sides agreed in writing what result would change their minds.

## My role

I wrote the hypotheses with the sales-assist lead and our finance partner. I designed the test, sized it and wrote the readout. Our growth PM owned the build. I checked with the engineer that the billing emails, the in-app banner and the lifecycle emails all read the trial end date from one field, so no workspace could get a 14-day email in a 30-day trial. Our analyst reviewed my queries.

## Checks before reading anything

- Sample ratio: 16,152, 16,089 and 16,159 workspaces. No sign of a broken split (p = 0.91).
- The downgrade to the free plan fired on the right day in every arm. I checked 50 workspaces per arm by hand in the first week.

## The result

- Trial-to-paid within 60 days: 7 days 8.3%, 14 days 8.6%, 30 days 8.9%. Against control: 7 days −0.3 points (97.5% CI −1.0 to +0.4), 30 days +0.3 points (97.5% CI −0.4 to +1.0). Neither hypothesis held.
- Starting MRR of a new paid account: $101, $104 and $111. Not significant.
- Still paying after 90 days: 81%, 82% and 84%. Not significant.
- Support tickets per 100 trials: 6.1, 4.8 and 4.9. The 7-day arm's extra tickets were mostly people asking for more time.
- Median days from signup to paid: 8, 14 and 29.

Finance's real argument for 7 days was cash. The 7-day arm paid a median 6 days sooner. At about 1,300 new paid accounts a month, that pulls forward roughly $27K of cash, once. Our finance partner agreed it wasn't worth a possible drop in conversion.

The readout said it plainly: trial length, by itself, doesn't move conversion for us. Keep 14 days.

## The segment

After the primary read I looked at 6 segments: active users by day 12, team size entered at signup, signup channel, region, device at signup, and company size. That's exploratory, and I labeled it that way.

One split stood out. Workspaces with 2 or more active users by day 12, about 35% of signups, converted at 20.9% with 30 days against 19.0% with 14 (nominal 95% CI +0.4 to +3.4). Single-user workspaces went the other way: 2.4% against 3.0%. A longer trial seemed to help teams already working together and hurt solo signups, which netted to zero.

With 6 cuts and 2 treatment arms I had made more than a dozen comparisons. One interval that barely clears zero is what chance produces at that count. So I didn't ship on it. I wrote it up as the next hypothesis: offer more time only to teams that are already collaborating.

The customer success lead wanted 30 days for every team right away. Finance wanted to drop the subject. I proposed the follow-up with a fixed decision date: ship in early December if it won. The Director of Growth Marketing backed that.

## The follow-up test

- Hypothesis: offering 14 extra days on day 12 to workspaces with 2+ active users raises their trial-to-paid by at least 2 points.
- Control: 14 days. Treatment: 14 days, plus a one-click 14-day extension offered on day 12 to workspaces with 2+ active users, through an in-app banner for the admin and an email.
- Day 12, because the offer had to arrive while the team was still in its trial, with time to decide.
- Eligibility was measured on day 12 in both arms, before anyone saw the offer, so eligible workspaces were compared with eligible workspaces.
- Enrollment July 22 – September 29, 2024. About 34,600 signups, 12,100 of them eligible, sized for a 2-point change.
- Primary metric, pre-registered: trial-to-paid within 60 days among eligible workspaces.
- Result: 19.0% → 20.6%, +1.6 points (95% CI +0.2 to +3.0). 58% of the workspaces offered the extension took it.

## What shipped

The extension went live for eligible workspaces on December 2, 2024. The default stayed at 14 days. Overall trial-to-paid rose by about 0.5 points, roughly 80 extra paid accounts a month at 2024 volume. That's an estimate from the test, not a separate measurement.

I shipped before the 90-day retention guardrail could be read, with a written kill rule: if retention in the treatment came in more than 3 points under control, the extension would come off. It was read in March 2025: 83% against 82%.

## Timeline

- November 2023 – January 2024: 3 meetings to agree the hypotheses. Plan signed January 26.
- February 5 – May 12: enrollment.
- July 11: primary read, 60 days after the last signup. Readout July 15.
- July 22: follow-up starts.
- October: 90-day retention guardrail read for the first test. The full answer to the original question, 8 months after kickoff.
- November 28: follow-up primary read.
- December 2: extension ships.
- March 2025: follow-up retention read.

## What went wrong

- Sales-assist reps extended trials by hand for 5.8% of the 7-day workspaces they were talking to, against 2.1% in control. I hadn't asked for the manual tool to be locked or logged during the test. I analyzed everyone in the arm they were assigned to (intent-to-treat), and a check that dropped the hand-extended workspaces gave the same answer. The tool now asks for a reason and warns when a workspace is in a test.
- The timeline. At kickoff I said "about 3 months". That was enrollment. The primary read needed 60 more days and the retention guardrail 90 after that. Leadership had expected an answer in April and got one in October. Every test plan I write now has a dates table: enrollment ends, primary read, guardrail read.

## What it changed beyond the trial

The 2+ active users signal turned out to matter more than the trial length. When the analyst and I rewrote the activation definition in January 2025, "at least 2 people active within 7 days" went into it, partly because of this test (`Template Onboarding False Win.md`).

## What's still open

- Single-user workspaces are about 65% of signups and convert at about 3%. The 30-day arm hurt them, and nothing I've tested helps them. The free-plan upgrade tests I ran in the first half of 2026 are partly aimed at them.
- Whether a shorter extension, 7 days instead of 14, would do as well. Untested.
- A card-required trial. Untested, and not mine to run alone.

## What I'd do differently

- Lock or log every manual override that can touch a test arm before launch.
- For trial and pricing tests, plan the segment cuts before launch and size the test for the segment that matters, not only the total.
