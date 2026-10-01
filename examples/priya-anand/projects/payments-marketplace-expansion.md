<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Payments marketplace expansion — three countries, two launches, one kill

Cartway, 2018–2020. I led the seller-payments expansion into Canada, the UK, and Germany. Two shipped and grew; one was killed at pilot stage, and the kill memo became the org's template. This file is as much about the kill as the launches — that was the year I learned what product management is actually for.

## Why these three countries

The marketplace (11,000 active sellers at peak) had organic demand signals in all three: Canadian sellers asking for CAD payouts without USD conversion fees, UK sellers needing Faster Payments payout timing, German sellers who would sign up and then abandon onboarding at the bank-verification step. The expansion thesis: seller payments localized per market would unlock supply in each.

## The regulatory surface — what nobody tells you

Payments expansion is a licensing project wearing a product manager's clothes.

- **Canada:** we already had the entities; the work was interbank payout rails (EFT) and provincial money-services-business registration in two provinces. Product-feel: slow paperwork, predictable.
- **UK:** FCA registration as a payment institution, safeguarding requirements for client money, and Faster Payments integration through a sponsoring bank. Product-feel: the safeguarding rules shaped the entire ledger design — client funds segregated, daily reconciliation, the works. Our ledger team earned their salaries twice over.
- **Germany:** BaFin's payment-institution licensing route. The intended path: use the UK entity's EU passporting. The problem arrived quietly — the passporting timeline depended on a regulatory posture that shifted under us mid-project (hard Brexit timeline uncertainty, 2019 vintage).

## Partner integrations

Each country meant new payment partners, and each partner meant a negotiation where the real product was the SLA and the reconciliation format.

- Canadian bank partner: payout T+1, decent API, reconciliation files that needed a custom parser — I wrote the spec for it and the ingest engineer still speaks to me.
- UK Faster Payments via sponsoring bank: near-instant payouts, which became the flagship seller feature ("sellers in the UK get paid in minutes"). The negotiation that mattered wasn't price — it was the cutoff times and what happened to in-flight payouts on the partner's outage days. We designed a degraded-mode (T+1 fallback with seller comms) before launch, which we needed exactly twice.
- German banking partner selection was underway when the licensing picture clouded; we paused before contracting, which is why the kill was cheap.

## The country that failed — and why killing it was the win

**Germany, killed Q3 2019.**

The licensing timeline moved from "passported by Q2" to "unclear, possibly 12+ months via direct BaFin application." Direct application changed the math: licensing/legal costs plus a dedicated compliance hire against a seller base that was real but an order of magnitude smaller than Canada's at equivalent maturity. The unit economics stopped closing inside any horizon the company planned on.

**The kill memo.** One page, four sections: what we believed when we started, what changed, what it would cost to continue, what we salvage. The salvage list was the part leadership actually used — the German localization work (IBAN-first onboarding flow, German-language seller comms) folded into the UK launch's internationalization layer, which later made the eventual EU expansion cheaper when the regulatory picture settled.

Two things I'm proud of:

1. We killed it while the sunk cost was small — before the banking contract, before the marketing commitments.
2. The memo didn't blame anyone. "What changed" was a fact, not an accusation. It got passed around and became the template for two later sunset decisions elsewhere in the org. The most leveraged document I wrote that year was one that said *stop*.

## The launches — numbers

- **Canada (launched Q1 2019):** CAD payouts, EFT rails, provincial MSB registration done. Canadian seller count grew 62% in the 12 months post-launch; payout-related support tickets in CAD dropped 55% (previously every payout was a USD conversion + fee + question).
- **UK (launched Q2 2020):** FCA registration, safeguarding-compliant client-money ledger, Faster Payments payouts. UK sellers grew 48% year one; the "paid in minutes" payout feature became the top-cited reason in seller surveys for choosing Cartway in the UK.

## What I'd do differently

- I'd run the licensing-timeline stress test *before* naming the target countries publicly. Germany got announced internally in a planning doc before its regulatory path was solid, and unpicking that expectation cost political capital the kill memo shouldn't have had to spend.
- The UK safeguarding work made our ledger better everywhere — in hindsight I'd have front-loaded that design conversation in 2018 instead of discovering its value during UK compliance review.
