<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Sales comp plan redesign: paying on margin, not revenue

Brandvold Controls, April to December 2020, live January 1, 2021. I was a senior compensation analyst. On my resume this is one bullet. This file holds the design, the model, who decided what, and the 3 things that went wrong in the first year. All figures are aggregates; no individual rep's pay appears here.

## The full story

By 2019 Brandvold's sales plan paid reps to discount. Commission was 1.9% of invoiced revenue, and reps could give up to 25% off list without approval. Average discount had climbed from 14.6% in 2016 to 19.4%, and margin on rep-sold orders had fallen. The VP of Sales and the CFO agreed the plan had to change and asked compensation for a design.

I had just become a senior compensation analyst. From April 2020 I was the lead analyst and plan designer. My manager was accountable and presented to the executive team, the VP of Sales decided, and finance owned the margin data. I designed a plan that paid mostly on gross margin dollars and kept the 70/30 pay mix. I back-tested it on 2 years of orders so each rep could see what they would have earned, and ran 11 sessions with reps and regional managers. It went live on January 1, 2021, with 2 quarters in which each rep got the higher of the old and new formulas.

The first quarter was rough. Finance's margin definition included rebates and freight that reps couldn't see, and statements for 27 reps changed after rebates posted. In April we switched to invoice margin. My Excel crediting double-counted split orders and overpaid 14 reps about $38K. The VP chose not to claw it back; I fixed the logic and wrote the requirements for a proper incentive comp system. And 3 of the top 20 reps left during 2021, against about 1 a year before. Two quarters of transition wasn't enough for books built on discounting.

In 2021 the average discount was 15.8%, incentive cost as a share of margin dollars dipped from 7.9% to 7.6%, and 57% of reps were at or above target, inside the range I designed for.

What's still open: margin on rep-sold orders rose from 30.8% to 32.9%, but 2021 price increases ran ahead of cost and I can't separate the two. I left Brandvold in July 2022, 18 months after launch, so I can't say how the plan has held up since.

## What it was and why

Brandvold sold commercial HVAC and refrigeration controls through 120 quota carriers: 104 field territory managers selling to distributors and equipment makers, and 16 inside sales reps. The old plan paid 70% base and 30% variable, and the variable was a 1.9% commission on invoiced revenue, uncapped, paid monthly. Reps could discount up to 25% off list without approval.

That combination paid reps to discount. A sale at 20% off list cut the rep's commission by 20% but cut the company's gross margin on the order by far more. Average discount off list had risen from 14.6% in 2016 to 19.4% in 2019, and gross margin on rep-sold orders fell from 34.2% to 30.8% over the same years. The VP of Sales and the CFO agreed the plan had to change and asked compensation for a design.

## My role

I was the lead analyst and the plan designer. My manager, the compensation manager, was accountable and presented to the executive team. The VP of Sales decided. Sales operations owned territories and targets. Finance owned the margin data and its definition, which matters below. I built the model, wrote the design options, wrote the plan document and the rep FAQ, ran 11 sessions with reps and regional managers, and ran the monthly crediting through 2021.

## The design

- Pay mix stayed at 70/30. Changing what reps are paid on and how much is at risk in the same year was more change than the field would accept.
- 2 measures: 75% of the variable on gross margin dollars against a territory target, and 25% on revenue from new accounts, meaning accounts with no purchase in the prior 24 months.
- Payout curve: nothing below 70% of target, 1.0× from 70% to 100%, 1.5× on margin dollars above 100%, uncapped.
- Monthly advances on margin, with a true-up each quarter.
- Transition: for the first 2 quarters of 2021, each rep was paid the higher of the old formula and the new one.

## The model

I back-tested the new plan on 2018–2019 order data, about 1.3 million invoice lines, to see what each rep would have earned. 61% of reps landed within 10% of what they actually earned, 22% would have earned more than 10% more, and 17% more than 10% less, mostly the heaviest discounters. That table was the most-used page in the rep sessions, because each rep could see their own row and nobody else's.

## The numbers, with their definitions

2020 was distorted by the pandemic, so I compare 2021 with 2019.

- Average discount off list price on rep-sold orders: 19.4% → 15.8%. This is the number I trust most, because it's direct rep behavior.
- Gross margin on rep-sold orders: 30.8% → 32.9%. Part of this is 2021 price increases running ahead of cost, which I can't fully separate out.
- Incentive cost as a share of gross margin dollars: 7.9% → 7.6%.
- Reps at or above 100% of margin target in 2021: 57%, against a design range of 50% to 65%.
- I don't claim revenue growth. List prices rose 6% in 2021, so revenue mostly measures that.

## What went wrong

- The margin definition. Finance's standard gross margin included year-end distributor rebates and actual freight, and a rep could see or control neither. In Q1 2021, statements for 27 reps changed after rebates posted, and trust dropped fast. In April we switched comp to invoice margin: invoice price minus standard cost, visible on every order. I had accepted finance's definition without asking whether a rep could see it on the day of the sale.
- A crediting bug. My Excel model double-credited orders split between 2 territories. 14 reps were overpaid about $38K in total in Q1. The VP of Sales chose not to claw it back. I fixed the logic, added a check that total credit can't exceed 100% of an order, and wrote the requirements for a proper incentive comp system, which went live in 2022.
- The transition was too short. 3 of the top 20 reps by 2019 revenue left during 2021, against about 1 a year before. Their books were built on large discounted accounts, and 2 quarters wasn't enough time to rebuild them.

## What I'd do differently

- Agree every measure's definition with finance, then test it with 3 reps, before the plan document goes out. The question to ask: can a rep see this number on the day of the sale? I've used that test on every incentive plan since.
- Build the crediting checks (total credit per order, statements that change after close) before the first payout, not after.
- Give 4 quarters of transition with a declining guarantee, aimed at the reps whose pay moved most in the back-test.
