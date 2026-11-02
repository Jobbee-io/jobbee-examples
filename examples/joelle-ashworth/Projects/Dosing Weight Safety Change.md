<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Dosing weight: a medication-safety event and the process change after it

Hollisbrook University Hospital, first on the cardiology units, then house-wide. The event was in late 2022; the changes went live in March 2023. On my resume this is one bullet. This file holds my part in the review, the process change, the first version that slowed treatment, and the numbers since. It holds nothing about the patient or the staff involved, and nothing from the review itself.

## The event, in the only terms I use

A weight-based anticoagulant infusion on one of our cardiology units ran at more than twice the intended dose for several hours. A weight recorded in pounds had been entered in a field that expected kilograms. The error reached the patient, was found at the next scheduled lab check, and was corrected.

That's all I say about it, here or in an interview. The root cause analysis is confidential patient safety work product, so I don't keep a copy and I don't quote it. What I can talk about is my role and the process change, which is now hospital policy.

## My role

I was the pharmacist on the root cause analysis team, because I'm the cardiology pharmacist for that unit. The team also had the unit's nurse manager, a nurse educator, a nursing informatics specialist, a hospitalist, and the patient safety officer who facilitated. After the review I owned the pharmacy action items. Nursing owned the changes to the bedside double-check. Epic analysts built the record changes. Pharmacy informatics and biomedical engineering changed the smart-pump drug library.

My first instinct in the review was to ask who entered the weight. The facilitator stopped me: the useful question was why the system let anyone do it. That correction was right, and it's how I've approached every event since.

## What we changed

- One dosing weight, in kilograms only. The record has a single "dosing weight" field in kilograms, a read-only pounds display, and a flag when the weight is stated or estimated rather than measured on a scale.
- A pharmacist weight check. For every weight-based high-alert infusion (heparin, bivalirudin, argatroban, and weight-based vasoactive infusions such as dobutamine and milrinone), the verifying pharmacist compares the dosing weight with the most recent measured weights. A difference above 10% stops verification until someone confirms the weight.
- Smart-pump limits. Heparin bolus and rate moved from soft limits, which a nurse can override, to hard upper limits, which a nurse can't.
- Order sets. I rewrote the heparin order sets so the dose shows in units and in units per kilogram, which makes a doubled dose easier to see.

## The first version slowed heparin starts

In the first version, a pharmacist couldn't verify heparin until a measured weight was in the record. In the first 3 weeks, the median time from heparin order to infusion start went from 52 minutes to 81. For a heart attack or a pulmonary embolism, half an hour matters. Emergency and cardiology physicians raised it within days, and they were right.

The fix: heparin can start on a stated or estimated weight, which is flagged. A measured weight is due within 4 hours, and the pharmacist re-verifies and recalculates the rate when it arrives. Median time to start came back to 55 minutes.

I hadn't tested the rule against the most time-critical workflow, and I hadn't brought the emergency department into the design. Both were my misses.

## The numbers, and their definitions

The period is March 2023 to August 2026, 42 months.

- About 9,800 weight-based high-alert infusion orders verified with the weight check.
- 236 weight differences above 10% caught at verification (2.4%). 41 of them were the pounds-for-kilograms pattern, a difference close to a factor of 2.2.
- Pounds-for-kilograms errors reaching a patient on these infusions: none reported in 42 months. Event reporting is voluntary, so "none reported" doesn't prove "none happened." It's the measure the hospital has, and I name its limit.
- Hard-limit stops on heparin pumps: 19 in the first year, each reviewed. 2 led to a library change because the limit was too tight for a legitimate dose.
- Balancing measure: median order-to-start time for heparin, now reported monthly. It has stayed between 50 and 58 minutes.

## What I'd do differently

- Pilot on one unit before going house-wide, with the emergency department in the pilot.
- Track the balancing measure from day 1, not after physicians complain.
- Write down which weight wins when two measured weights disagree. That question came up in month 2, and we answered it case by case for too long.

For an MSL role, two habits from this carry over directly: reporting what I learn about a drug's safety through the proper channel, and protecting what I'm told in confidence without needing a reminder.
