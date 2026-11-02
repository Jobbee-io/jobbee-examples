<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Annual billing as the default

Slatebird, May – July 2025. On my resume this is one bullet under Slatebird. It was a single test on the pricing page, 8 weeks of enrollment, and it's the closest I've come to pricing work. I could change how prices are presented, not the prices: pricing belongs to product marketing and finance.

## Why

The pricing page had a monthly/annual toggle, set to monthly. Annual billing costs 10 months' price for 12 months. In 2024, 31% of new paid accounts chose annual. Finance wanted more of them, and the case was about cash and year 2, not year 1. A monthly account that survives like our average pays about 9.5 months of price in its first year, because only about 60% reach month 12. An annual account pays 10, up front, and about 80% renewed.

## Hypothesis, metric and design

- Hypothesis: if the toggle defaults to annual, the annual share of new paid accounts rises by at least 5 points without lowering paid conversion, because many buyers keep a default.
- Primary metric: annual share of new paid accounts.
- Guardrail: paid conversion within 60 days of a workspace's first pricing-page view.
- Design: 50/50 by workspace at the first pricing-page view. Enrollment May 12 – July 6, 2025: about 22,000 workspaces and 2,600 new paid accounts, sized for a 5-point change in annual share. The guardrail could only catch a drop of about 1.2 points or more, and I wrote that into the plan.

## My role

I wrote the case with our finance partner, designed the test and wrote the readout. Product marketing owned the page and signed off on the change. One engineer built it in 3 days.

## The result

- Annual share: 31.2% → 38.4%, +7.2 points (95% CI +3.6 to +10.8).
- Paid conversion within 60 days: 11.8% in control, 11.9% with the annual default (95% CI −0.8 to +1.0). No measurable change, and a small drop could still hide inside that range.
- Shipped to everyone on July 21, 2025. Annual share stayed between 37% and 39% through the second half of 2025.

## What went wrong

I didn't set a refund guardrail. In week 2, support flagged refund requests on annual plans: 9 in the default arm against 2 in control, almost all of them some version of "I didn't mean to pay for a year." The checkout showed a per-month price with "billed annually" in small type. In week 3, product marketing changed the checkout in both arms to show the total charged today. For weeks 3 to 8, refunds within 30 days were 5 in control and 7 in the default arm, in line with how many annual accounts each arm had. The annual share for weeks 3 to 8 alone was +6.8 points, so the clearer checkout didn't erase the effect. A refund guardrail is now in every pricing-page test plan.

## What's still open

People who take annual because it's the default may renew less than people who chose it. The first renewals from the test came in between May and September 2026: 77% for annual accounts from the default arm, 80% for annual accounts from control. That's about 500 and 400 accounts, so the difference isn't significant. Even at 77% the change pays, because the comparison is with a monthly account that has about a 60% chance of reaching month 12. Year 3 is the number I'd want before calling it settled.
