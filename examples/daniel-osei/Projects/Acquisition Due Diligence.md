<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Acquisition due diligence: 4 findings that changed the deal

Bramhall Sayre LLP, buy side. A public software company buying a private developer-security software company (300–500 employees, ARR in the $60M–$90M band). Deal value in the $500M–$1B band. Diligence ran 7 weeks from February 2025, signing was in April, closing in July. I was a 5th-year associate and ran the commercial and IP diligence workstream. On my resume it's one bullet. Neither company is named, and negotiated amounts appear only as bands or percentages.

## The assignment, and my part

The M&A partner led the deal. Separate teams ran tax, employment, privacy, real estate and antitrust. My workstream was everything about the target's contracts and IP: customers, resellers, vendors, inbound licenses, open source, and who owns the code. The output was an issues list the partner could negotiate from, and our comments on the seller's disclosure schedules.

I ran a team of 4 junior associates and 2 paralegals, set the review plan, wrote the issues list, and drafted the first versions of the special indemnity and the closing-deliverable language for my findings. I joined the negotiation calls on those sections. The partner negotiated price, the escrow size and everything else. An IP partner reviewed the patents. The buyer's outside code-audit firm ran the open-source scan; I read the report and turned it into legal risk.

## How we reviewed

The data room held about 3,100 documents, 680 of them commercial or IP contracts. I split the team by contract type: 2 associates on customer and reseller contracts, 1 on vendor and inbound licenses, 1 on contractor and employee IP agreements. The paralegals ran the data-room index and the request list to the seller.

A lawyer read 240 contracts in full: the top 50 customer contracts, every reseller and OEM agreement, every inbound IP license, and every contractor agreement for engineers on the core product. The other 440 went through an AI-assisted review tool that tagged assignment, change of control, exclusivity, most-favored-customer pricing and IP ownership. We read a 10% sample of those by hand to check the tags.

## What we found

41 issues logged. 9 were terms-level, meaning they needed something in the purchase agreement. 4 of those changed it:

1. Open source. A library under a strong copyleft license (AGPL) was compiled into the on-premises version of the product, which about 60 customers ran. That can create an obligation to offer source code. The buyer's insurer excluded it from the representations and warranties policy because it was now a known issue. Result: a special indemnity for remediation, backed by a separate escrow of about 1.5% of the price for 18 months, plus a covenant to start replacing the library before closing.
2. Code ownership. 2 contractors who wrote parts of the core product in 2017–2018 had agreements that called their work "work made for hire" but contained no assignment of IP. For software written by a contractor, that label usually doesn't transfer ownership. Result: signed confirmatory assignments from both became a closing deliverable. The seller paid the contractors for them.
3. Change of control. 7 of the top 25 customer contracts, about 29% of ARR, let the customer terminate, or required its consent, on a change of control. The buyer wanted the consents as a closing condition and the seller refused. Result: a covenant to seek them jointly, with the buyer's sales leaders on the calls. 5 of 7 consented before closing. This one didn't change the price. It changed the integration plan.
4. A reseller's exclusivity. An exclusive reseller agreement for one region had a non-compete that bound the seller's "affiliates". After closing, the buyer would be an affiliate, and its own products would be caught. Result: an amendment narrowing "affiliates" to the target and its subsidiaries became a closing condition. It was signed 3 weeks before closing.

The other 5 terms-level issues were handled with specific representations or disclosure items rather than new terms: 2 most-favored-customer pricing clauses, an inbound license that needed the licensor's consent on a change of control, and uncapped IP indemnities in 2 customer contracts.

## The numbers, and their definitions

- Contracts: 680 commercial and IP contracts in the data room. "Read in full" means a lawyer read every page: 240. The other 440 were tagged by the tool, and we read 44 of them by hand as the sample.
- Issues: 41 logged. "Terms-level" means it needed a representation, an indemnity, a covenant or a closing condition: 9. "Changed the deal" means the signed agreement differs from the buyer's first draft because of it: 4.
- Effort: 7 weeks and about 1,900 hours across my team of 7, from the time records, rounded.
- Escrow: about 1.5% of the price, held for 18 months. The exact figure isn't mine to publish.

## What went wrong

- My first issues memo, in week 3, ran past 90 pages, organized contract by contract. The partner asked for 3 pages ranked by what each issue did to price, terms or the integration plan. I rewrote it over a weekend. Every issues list I've written since starts with that ranked page.
- The review tool tagged change of control by keyword. It missed 3 customer contracts that said "assignment by operation of law, merger or otherwise". Our 10% sample caught 1. We re-ran the search on all 440 tool-reviewed contracts with wider terms and found the other 2. I don't trust a tag now until a sample says it works.
- I asked for the code scan in week 4, not week 1. The scan took 2 weeks, so the biggest finding of the deal arrived in week 6 of 7. The escrow was negotiated under time pressure I had created.

## Since closing

The library was replaced by December 2025. As of November 2026 there have been no claims against the escrow, which runs until January 2027. The 2 customers who hadn't consented before closing both renewed in 2026.

## What I'd do differently

Order the code scan on day 1. Agree the format of the issues list with the partner before anyone reads the first contract. Test the review tool on 20 contracts we've already read before trusting it with 440.

Product and commercial counsel at an acquisitive company work on diligence, integration and the contracts that follow a deal. This file is also how I'd describe a confidential deal in an interview: the type of finding, the term that solved it, and my part in it, with no names and no numbers beyond bands.
