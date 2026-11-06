<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Payments marketplace expansion — three countries, two launches, one kill

Cartway, 2018–2020. I led the seller-payments expansion into Canada, the UK and Germany. Canada and the UK launched and grew. Germany was killed at the pilot stage in Q3 2019, and the kill memo became the template the org used for two later sunset decisions.

## The full story

When I joined Cartway's seller payments in 2017, sellers in three countries were telling us the same thing in different ways. Canadians lost a conversion fee on every USD payout. UK sellers waited 3–5 business days. German sellers abandoned onboarding at a bank check built for US accounts. In 2018 we set out to localize payouts in all three. Germany went into an internal planning doc before its licensing path was solid. That was a mistake, and it cost me later.

Canada came first, because we already had the entities. I wrote the requirements and the spec for the bank partner's reconciliation files, and we launched in Q1 2019.

The UK was the long one: FCA registration, safeguarding rules for client money, and Faster Payments through a sponsoring bank. The safeguarding rules reshaped our ledger, with client funds segregated and reconciled daily. The ledger team built it, and the finance controller ran the reconciliation. I came to that design late, during compliance review, when I should have started it in 2018. We designed a degraded mode for partner outages before launch, and launched in Q2 2020.

Germany depended on passporting from the UK entity. In 2019, with the Brexit timeline uncertain, that path went from "by Q2" to "possibly 12+ months" through a direct application. We paused partner selection before signing anything. I wrote the kill memo, our VP of International argued to continue, and the VP Product and the CFO decided within two weeks. Germany was killed in Q3 2019, with about $90K sunk, most of it reusable.

Through all of it I owned the product requirements, the partner criteria, the launch order and the seller payout experience. Our partnerships lead owned price, counsel owned the filings, and 9 engineers built it.

Canadian sellers grew 62% in the 12 months after launch, and UK sellers 48% in their first year, a number I heard after I left. The kill memo became the org's sunset template. When I left Cartway in February 2021, the open part was the rest of the EU. The German localization work sat in the UK layer, ready for when the regulatory picture settled.

## Why these three countries

The marketplace (11,000 active sellers at peak) had demand signals in all three:

- Canadian sellers were paid in USD and lost a conversion fee on every payout. "Why is my payout less than my sales" was a top-3 support topic for them.
- UK sellers waited 3–5 business days for payouts and asked for Faster Payments timing.
- German sellers signed up and then abandoned onboarding at the bank-verification step, because our flow assumed US account formats.

The thesis: seller payments localized per market would unlock supply in each.

## My role vs. the team

I was Senior PM when this started and Lead PM from 2019. I owned the product requirements for each country, the payment-partner selection criteria, the launch sequence, the seller-facing payout experience, and the kill memo. I sat in every partner negotiation on SLAs, cutoff times and reconciliation formats. Our partnerships lead owned price and the commercial terms.

The team: 9 engineers across payouts and the ledger, a ledger tech lead, our compliance counsel (with outside counsel in the UK and Germany), and the finance controller who ran safeguarding reconciliation. The regulatory filings were counsel's; deciding what the product had to do to satisfy them was mine.

## The regulatory surface

Payments expansion is a licensing project wearing a product manager's clothes.

- **Canada.** We already had the entities. The work was interbank payout rails (EFT) and money-services-business registration in two provinces. Slow paperwork, predictable.
- **UK.** FCA registration as a payment institution, safeguarding requirements for client money, and Faster Payments through a sponsoring bank. The safeguarding rules shaped the whole ledger design: client funds segregated, reconciled daily. Our ledger team earned their salaries twice over.
- **Germany.** BaFin's payment-institution route. The plan was to use the UK entity's EU passporting. The problem arrived quietly: the passporting path depended on a regulatory posture that shifted under us mid-project, with the 2019 Brexit timeline uncertain.

## Partner integrations

Each country meant new payment partners, and in each negotiation the real product was the SLA and the reconciliation format, not the price.

- **Canadian bank partner:** payouts at T+1, a decent API, and reconciliation files that needed a custom parser. I wrote the spec for it; the ingest engineer still speaks to me.
- **UK, Faster Payments via a sponsoring bank:** near-instant payouts, which became the flagship seller feature ("sellers in the UK get paid in minutes"). The terms that mattered were cutoff times and what happened to in-flight payouts on the partner's outage days. We designed a degraded mode before launch (fall back to T+1 and tell sellers why), and we needed it exactly twice in the first year.
- **Germany:** banking-partner selection was underway when the licensing picture clouded. We paused before contracting, which is why the kill was cheap.

## Germany: the kill

The licensing timeline moved from "passported by Q2" to "unclear, possibly 12+ months via direct BaFin application." A direct application changed the math:

- **Cost to continue:** about $650K in the first year (licensing and legal counsel, a local compliance officer, initial capital) before a single payout, plus 12 or more months of waiting.
- **What it would serve:** about 140 sellers in the German pilot, an order of magnitude below Canada at the same stage. At our payments take rate, the German book would have needed more than 5 years to pay back year-one costs.
- **Sunk cost at the kill:** about $90K, most of it localization work we could reuse.

Our VP of International wanted to continue, because Germany was in the annual plan and had been announced internally. I wrote the memo, and the VP Product and the CFO decided within two weeks of reading it. Killed Q3 2019.

**The kill memo.** One page, four sections: what we believed when we started, what changed, what it would cost to continue, what we salvage. The salvage list was the part leadership actually used. The German localization work (an IBAN-first onboarding flow, German-language seller comms) folded into the UK launch's internationalization layer. That later made EU expansion cheaper when the regulatory picture settled.

The memo didn't blame anyone. "What changed" was a fact, not an accusation. It got passed around and became the template for two later sunset decisions elsewhere in the org. The most useful document I wrote that year was one that said stop.

## The launches, with numbers

Seller counts below are sellers with at least one payout in the month.

- **Canada (launched Q1 2019):** CAD payouts on EFT rails, provincial MSB registration done. Canadian sellers grew 62% in the 12 months after launch. Payout-related support tickets from Canadian sellers fell 55%. Before, every payout was a USD conversion, a fee and a question.
- **UK (launched Q2 2020):** FCA registration, a safeguarding-compliant client-money ledger, Faster Payments payouts. UK sellers grew 48% in year one. "Paid in minutes" became the top-cited reason in seller surveys for choosing Cartway in the UK.

## What I'd do differently

- Run the licensing-timeline stress test before naming target countries. Germany went into an internal planning doc before its regulatory path was solid. Unpicking that expectation cost political capital the kill memo shouldn't have had to spend.
- Front-load the safeguarding design. The UK rules made our ledger better everywhere: segregation and daily reconciliation caught errors in the US book too. I'd have started that design conversation in 2018 instead of discovering its value during UK compliance review.
