<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Checkout performance: Core Web Vitals on real phones

Shelfwright, Web Platform team working with the Checkout team, April 2023 to March 2024. One bullet on my resume.

## The full story

In early 2023 checkout was the slowest part of the platform on the phones most shoppers use. Field data put mobile p75 LCP at 4.1 seconds, and retailers were attaching speed reports to their renewal questions. The Checkout team's backlog was full, and Web Platform owns frontend performance, so I took it on in April 2023, with two Checkout engineers at about half time.

I lost the first 5 weeks to lab scores. Lighthouse went from 48 to 87 on my laptop while field LCP barely moved. From then on we reported only field numbers and tested on real mid-range Android phones.

Third-party scripts came next, and that's where most of the trouble was. I deferred the fraud-detection script, and for 6 days the risk team's manual review rate climbed until they traced it to my change. I reverted it the day they found it. It now loads early, with their sign-off, and I list every script's owner before touching anything. Moving merchant scripts to the confirmation page took 7 weeks, not the 2 I planned, because 6 merchants pushed back. Checkout's product manager owned those merchant decisions, and marketing operations owned their own tags. We ended at 9 tags, down from 27.

Alongside that, I built the server-rendered shell and the CI size budgets, and we split and trimmed the JavaScript. In October 2023 we added INP to our field data. It showed a problem FID had hidden: cart recalculation on every keystroke. We moved it off the keystroke path.

In February 2024 a 4-week holdout, which I designed with the data team, showed mobile completion up 1.4%, with a 95% interval of +0.5% to +2.3%. Desktop showed no change we could measure. By March 2024: LCP 2.3s, INP 170ms, CLS 0.03.

The Checkout team now reviews the field numbers weekly, and the budgets run in CI. What stays open is the 9 tags. Each has an owner and a reason, and keeping the count from creeping back up depends on that weekly review, not on me.

## Why

Checkout was the slowest part of the platform on the devices most shoppers use. Our field data (the web-vitals library reporting from every checkout page) showed mobile p75 LCP at 4.1 seconds and CLS at 0.19. Retailers were attaching speed reports to their renewal questions. The Checkout team had a full feature backlog, and Web Platform owns frontend performance, so I took it.

## My role

I led it. Two engineers from the Checkout team worked on it at about half time, and checkout's product manager owned the merchant-facing decisions. I set the targets, did the profiling, wrote the RFCs, built the server-rendered shell and the performance budget checks, and designed the holdout with the data team. The risk team and marketing operations owned the scripts we touched, and every change to their scripts went through them.

## What we changed

- Third-party scripts first. Checkout loaded 27 third-party tags: marketing tags through a tag manager, plus scripts merchants could add themselves. We cut that to 9. Merchant-added scripts moved to the order confirmation page only, and merchants got server-side order events instead. About 140 merchants used checkout scripts. 6 pushed back hard, and we helped each of them move to the events.
- A server-rendered shell. Checkout was a client-rendered single-page app. We server-rendered the order summary and the shipping step, so the largest content arrived in the HTML.
- Less JavaScript. Route-based code splitting, and the address autocomplete loads only when its field gets focus. JavaScript on the first checkout page went from 610KB to 260KB transferred (gzip).
- Layout shift. We reserved space for line-item images and the payment provider's iframe, and cut web fonts from 4 weights to 2.
- Responsiveness. We added INP to our field data in October 2023, ahead of it replacing FID as a Core Web Vital in March 2024. FID had looked fine all along. INP showed the real problem: p75 410ms, mostly from cart recalculation running on every keystroke in the address and promo code fields. We moved tax and shipping recalculation off the keystroke path, debounced it, and split the remaining long tasks so input is handled first.
- A budget that holds. Every checkout route has a JavaScript size budget checked in CI, and the field numbers are on a dashboard the Checkout team reviews weekly.

## The numbers, and their definitions

Field numbers are p75, mobile, from our own field data on checkout pages, March 2023 compared with March 2024.

- LCP: 4.1s to 2.3s.
- CLS: 0.19 to 0.03.
- INP: 410ms (October 2023, when we started measuring it) to 170ms.
- Third-party tags on checkout: 27 to 9.
- Business effect: a 4-week holdout in February 2024 kept 10% of checkout sessions on the old code. Sessions were assigned by cart ID, so a returning shopper stayed in one arm. Completion means sessions with a placed order divided by sessions that reached the first checkout step. Mobile completion was 1.4% higher (relative) on the new code, with a 95% confidence interval of +0.5% to +2.3%. Desktop showed no change we could measure. I quote the interval every time, because the point estimate alone oversells it.

## What went wrong

- I spent the first 5 weeks on lab scores. Lighthouse went from 48 to 87 on my laptop, and field LCP moved from 4.1s to 3.9s. Lab runs use a simulated device and network. Our shoppers were on mid-range Android phones on real networks, and most of the third-party tags didn't even load in my lab setup. After that, field data was the only number we reported, and a small set of real mid-range phones replaced my laptop for testing.
- I deferred the fraud-detection script until after the first interaction. For 6 days its device signal was missing on about 8% of orders, and the risk team's manual review rate rose from 2.2% to 3.5% before they traced it. I reverted the change the day they found it. The script now loads early without blocking rendering, with the risk team's sign-off. Scripts on a checkout have owners, and "third-party" doesn't mean "optional". Now I list every script's owner and what the script needs before touching any of them.
- I underestimated the merchant side. I planned 2 weeks for the merchant script change. With the 6 merchants who pushed back, it took 7.

## What I'd do differently

Agree the holdout design with the data team before the work starts, not near the end. We got a clean result, but only because the change happened to be easy to hold back.
