<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Privacy program and DPA rollout

Bramhall Sayre LLP, for a B2B workforce-software client: scheduling and time-tracking software, about 1,100 business customers, about 28% of them in the EU and UK. January–October 2024, with a handover to the client in November. My resume has one bullet on this. It's the closest thing in my record to the privacy side of a product counsel job, so this file holds the full version, including the mistake that cost a subprocessor launch. The client isn't named.

## Why it started

The client processes its customers' employee data: names, schedules, hours worked, location at clock-in. That makes it a processor (a "service provider" under California's law) for every customer, and every enterprise customer wanted its own terms on that. Precise location counts as sensitive data under several US state laws, which mattered for how the DPA describes the processing. By the end of 2023:

- The DPA template dated from 2019. It had been patched for the new EU Standard Contractual Clauses in 2022, and for California, but not for the US state privacy laws passed since.
- More than 140 negotiated versions were in force. Nobody could say which customers had which subprocessor rights, audit rights or breach-notice deadlines.
- Enterprise deals stalled on it: a median of 9 business days to agree a DPA when the customer sent redlines.

The client's GC asked us to fix it in one program instead of one customer at a time.

## Who owned what

I ran the day-to-day: the plan, the DPA, the negotiation playbook, the contract inventory and the rollout tracking. A privacy partner supervised and made the calls on the contested GDPR points, such as how far audit rights go and how the transfer terms are structured. A 2nd-year associate built the inventory with me. The client's privacy program manager owned the data map, with the security lead and 2 engineering leads. The GC approved every position.

## The options

1. Update the template and keep negotiating one customer at a time. Cheapest. Rejected: the 140+ versions would stay in force, and the client still wouldn't know what it had promised.
2. One DPA with no variants, take it or leave it. The GC liked how simple it was. Rejected once we sorted the 58 DPAs negotiated in the second half of 2023: about 70% of customer redlines were the same handful of asks, and large customers would negotiate anyway. Pre-approving the common answers was cheaper than fighting each one.
3. One DPA built in modules, a fixed set of pre-approved variants, and a rollout to every customer and subprocessor. Chosen.

## The data map (January–February)

12 product data flows and 46 subprocessors, with where each one stores data. I wrote the questions; the client's team answered them. 2 flows sent data to a subprocessor that wasn't on the public list. The GC's decision: correct the public list before anything else moved, so the new DPA would describe a true list.

## The DPA (March–April)

One document in 4 parts:

- Core processor terms: acting only on the customer's instructions, staff confidentiality, security, subprocessors, help with data-subject requests, deletion or return at the end, and audits.
- The EU and UK module: the transfer clauses for data leaving the EU and the UK, in the controller-to-processor form for customers, with the UK addendum for UK data, mirrored in processor-to-processor terms with each subprocessor.
- The US module: the service-provider terms California requires, and the processor-contract terms in the other state laws. My first draft listed each state's terms separately. It ran 9 pages and would have needed rewriting with every new law. I rewrote it as one set of terms that meets the strictest version of each common requirement, plus a short schedule for anything state-specific.
- The security exhibit, written with the client's security lead.

Annexes: a description of the processing built from the data map, product by product, naming clock-in location and the setting that lets a customer turn it off; and the subprocessor list with storage locations.

The standard terms: subprocessor changes on 30 days' notice with a right to object, and breach notice to the customer within 72 hours of confirming a breach that affects its data.

Transfers to the US. Some US subprocessors were certified under the EU-US Data Privacy Framework, in force since July 2023. The privacy partner's call was to keep the standard transfer clauses as the base for every transfer anyway and note the framework where it applied, because the 2 frameworks before it were struck down by the EU's top court. I agreed, and drafted it that way.

## The 12 variants, and what was refused (April)

Built from the 2023 negotiated DPAs: the asks that came up most, each with pre-approved text and an approver. By type, they include breach notice in 48 hours instead of 72; an on-site audit, at most once a year and at the customer's cost, only when the independent audit report doesn't answer a specific question or after a breach; 60 days' notice of new subprocessors instead of 30; and a commitment to keep the customer's data in the EU region. The rest are of the same kind. Anything outside the 12 goes to the privacy partner or the GC.

The arguments:

- Audit rights. Enterprise customers' privacy counsel wanted on-site audits on request. The security lead wanted independent audit reports only. The privacy partner decided, and the on-site variant above is the furthest it goes.
- Breach notice. Sales wanted to offer 24 hours to close regulated customers. The security lead's point: 24 hours from discovery is often before anyone knows what was affected, so the notice would be empty or wrong. 48 hours, with GC approval, was the limit.
- Prior written consent for new subprocessors. Sales wanted it as a variant for the largest customers. The GC refused: with consent rights, one customer's silence can hold up a subprocessor for every customer. It isn't one of the 12. That refusal matters for the mistake below.

## The rollout (May–October)

- About 955 customers on the online terms got the new DPA with 30 days' notice and an accept button. The online terms let the client update the DPA on notice. The GC still wanted acceptance on record, because a customer's auditor asks for an accepted or signed DPA, and "we notified you" is a weak answer. So the program counted acceptance, not notice.
- About 145 customers with negotiated contracts got an amendment to sign, in 3 waves by contract value, largest first, so the hardest negotiations started earliest.
- Every subprocessor got a contract matching the new DPA.

## Timeline and turning points

- January: kickoff; data-map questions out.
- February: the 2 unlisted subprocessors found; public list corrected.
- March–April: DPA drafted, variants set, GC approval.
- May: rollout starts.
- June: the consent mistake.
- July: online acceptance stalls near 40% in month 3. Notices re-sent to legal and billing contacts in August.
- October: 83%.
- November: the inventory and the subprocessor-change check handed to the client's privacy program manager.

## The numbers, and their definitions

- On the new DPA: the customer accepted it online or signed the amendment. 83% of about 1,100 customers by the end of October 2024, 9 months after kickoff. By group: about 124 of 145 negotiated-contract customers signed, and about 790 of 955 online-terms customers accepted.
- Versions in force: 140+ → the 12 approved variants, plus 21 legacy contracts that keep their older terms until renewal. Those are the 21 negotiated-contract customers who didn't sign.
- The 17% not counted: those 21, and about 165 online-terms customers, mostly small customers on monthly plans who never opened the notice. The online terms already apply the new DPA to them after the notice period. I don't count them, because the measure is acceptance on record.
- Objections: 6 customers objected to a term during the online notice period. All 6 settled on one of the 12 variants.
- Subprocessors with a contract matching the new DPA: 46 of 46.
- Time to agree a DPA when a customer sends redlines, from the first redline to agreed text: median 9 business days on the 58 negotiated in the second half of 2023, 3 on the 64 negotiated in the 6 months after launch.

## What went wrong

- The consent mistake. My plan assumed every customer had notice-and-object rights for new subprocessors. 38 enterprise customers had negotiated prior written consent instead. In June the client added an analytics subprocessor and the notice went to every customer. 9 days later, one customer's privacy counsel wrote back to point out that they had to consent first. They were right. We paused the new subprocessor for those 38 customers' data and asked for consent. 31 consented within 6 weeks. The other 7 stayed excluded through a configuration change.

  The cause was mine. My inventory tracked 22 fields per contract, and subprocessor terms were one free-text field. I'd recorded what the clause was called, not what it required the client to do. I rebuilt the inventory around obligations that trigger action. The rebuild found 38 consent rights, 17 subprocessor notice periods longer than 30 days, 23 breach-notice deadlines shorter than 72 hours, and 11 commitments on where data is stored.
- The first online rollout went only to each customer's account administrators, who often weren't the person who decides on legal terms. Acceptance stalled near 40% in month 3. We re-sent it to each customer's legal and billing contacts, and acceptance climbed from there.

## Second-order effects

- The rebuilt inventory became a register the client's privacy program manager keeps. Before any new subprocessor is announced, it lists the customers who need consent or longer notice. Since the handover the client has added 4 subprocessors through that check, as of my last look in 2026, with no repeat of June.
- DPA negotiation stopped holding up enterprise deals: median 9 → 3 business days.
- The data map is now reviewed every quarter by the privacy program manager and the engineering leads, instead of once.

## What isn't solved

- The 21 legacy contracts keep their older terms until they renew, through 2027. Prior consent now survives only there: most of the 38 took the 60-day notice variant when they signed the amendment.
- The 7 customers who never consented are among the 21. Until they renew, they depend on a configuration exception that engineering has to keep in place.
- The data map is only as current as its last review. Nothing technical stops a new feature from sending data somewhere new before privacy hears about it.
- The US schedule needs updating as each new state law takes effect. That's now the client's job, with the firm on call.

## What I'd do differently

- Build the inventory around what each contract makes the client do, from day 1.
- Ask product for the subprocessor roadmap before writing the rollout plan, not after.
- Send terms to the people who decide, which means asking customers who that is.
