<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Anticoagulation Transitions Clinic: outcomes measurement

Companion to `Anticoagulation Transitions Clinic.md`, the overview.

Every number is an aggregate from the clinic's quality reports. No patient-level data appears here, and none left the quality department.

## Definitions first

I wrote the outcome definitions into the proposal in September 2021 and agreed them with the quality department before the first visit. The point was that nobody could say later I'd picked the measure that flattered the clinic. One definition still changed, in month 2, and that change is described below.

## The primary outcome

An emergency department visit or a hospital admission within 30 days of the discharge that led to the referral, where the reason for the visit is either:

- bleeding at or above the severity threshold; or
- a new or worsening clot: a stroke, a clot in another artery, a deep vein thrombosis or a pulmonary embolism.

It's counted at any of the 3 hospitals in the Hollisbrook system. A visit to a hospital outside the system counts only if its record reaches our chart, so some are missed. That happens in every group, though not necessarily at the same rate.

The severity threshold. My first version counted any bleeding that led to an emergency visit or admission. In month 2 the quality analyst pointed out that this would count every nosebleed that brought someone in for reassurance. We adopted the widely used international definitions of major and clinically relevant non-major bleeding, and re-ran the baseline with them.

## Who counts, and how

- The quality department's query pulls every emergency visit and admission within 30 days for the patients in each group. It's broad on purpose: reading a non-event costs less than missing an event.
- A quality nurse reviews each visit against the written definition.
- A second reviewer, a pharmacist who doesn't work in the clinic, reviews every event and a 10% sample of the non-events.
- Disagreements go to a hospitalist on the quality committee.
- The reviewers can see the dates, so they know which period a chart is from. Chart review can't be blinded to that.
- I don't review outcome charts for my own clinic.

## The 3 groups

- Historical cohort: discharges from July 2019 to June 2021 that would have met the referral criteria, from the same services (n=560). Built by the quality department with the same query and the same definition.
- All referred patients: February 2022 to January 2024 (n=650). Everyone referred, whether or not they came to a visit.
- Patients seen: the 505 of those 650 who had a visit.

The 30-day rate of the primary outcome: 6.2% historical, 4.4% all referred, 3.5% seen.

The window stops at January 2024 because the 2-year comparison was agreed up front as the formal evaluation, and it was run in spring 2024. Since then, the quarterly report tracks the same outcome for all referred patients as a running check, not as a new comparison.

## Why I lead with 4.4%

- Selection. Patients who come to a visit differ from those who don't. They're more likely to be well enough, organized enough and adherent enough to show up. The seen-only rate mixes the clinic's effect with that difference. The all-referred rate keeps everyone the clinic tried to reach, so it can't be flattered by who came.
- Uncertainty. The research office statistician calculated the 95% confidence intervals. For the difference between 6.2% and 4.4%, the interval runs from about −0.7 to +4.3 percentage points, so it includes no effect at all. For the seen-only difference it runs from about +0.1 to +5.3: it clears zero barely, and that's the comparison with the selection problem. I can read this output; I didn't run it. I put both intervals on the slide when I presented the clinic at the symposium in 2025.

## What the comparison can't show

1. It's before/after, not randomized.
2. The historical cohort includes the first COVID year. Admissions, emergency visits and follow-up all looked different then. Some of that would lower the historical rate and some would raise it, and I can't say which won.
3. Practice moved between the periods. A larger share of new starts were on DOACs rather than warfarin, and that alone can change bleeding rates.
4. Missed outside visits, as above.
5. Small numbers. A few events either way move a rate by a full point.

A concurrent group. In 2024 I asked the quality team about using eligible discharges from the system's other 2 hospitals, which have no clinic, as a concurrent comparison. The answer was not now: chart review there isn't funded, and they're community hospitals with fewer cardiology admissions and a different patient mix. I still think it's the best comparison available, and it's on the list for the next quality-improvement cycle.

One effect runs against the clinic, and I leave it in. When a pharmacist finds an active bleed at a visit and sends the patient to the emergency department, that visit counts as an event. A clinic that finds problems raises its own event rate. I've never removed those visits, and I wouldn't.

## Process measures

These say whether the clinic did what it was set up to do. They're reported every quarter.

- Visit within 10 days of discharge: 84% of patients seen since booking moved before discharge in October 2022. Median 6 days from discharge to visit.
- No-shows, as a share of booked visits: 31% from February to September 2022, 12% after the October change, and between 10% and 14% since.
- Doses outside the label: 13% of DOAC patients at the first visit. 88% of those corrected under the protocol; the rest sent to the prescriber.
- Drug access: about 5% of patients seen didn't have the drug at home or had stopped it, mostly because of cost or insurance approval.
- Handoff sent to the receiving clinician the same day: 97% of visits since the 2023 template.

## The budget case

Pharmacist visits weren't billable under our setup, so the case had to rest on avoided cost.

- My first version, spring 2023: $1.1M a year. I counted every readmission among clinic patients that the clinic plausibly touched, against the historical rate, and priced each at the hospital's average readmission cost. Finance didn't accept it, and they were right: most of those readmissions had nothing to do with the anticoagulant.
- The rebuilt version used finance's own method. Only admissions with an anticoagulant-related primary diagnosis count; emergency visits that didn't lead to admission don't. The avoided number is the difference between the historical rate and the clinic's first-year rate, applied to the referrals expected that year, and priced at finance's cost for those admissions. Result: $310K a year. The cost inputs are finance's internal figures, so I don't publish them.
- It rests on fewer than 10 avoided admissions a year, so one bad quarter moves it a lot. I said that in the meeting. I think that's part of why finance believed it.
- With the cardiology division funding part of a pharmacist's time, it kept the clinic open.

## What the measurement supports

It supports this: the clinic reached patients soon after discharge, found and fixed doses outside the label, and the 30-day event rate was lower after it opened. It doesn't support an exact effect size, or proof that the clinic caused the drop. That's the order I present it in: 4.4% first, then the interval, then the seen-only number with its caveat, then the COVID-year baseline.

## What I'd do differently

- Agree with finance how avoided admissions are counted before the first patient.
- Set up a concurrent comparison at launch, before the other hospitals' patients could become part of the clinic.
- Size the evaluation in advance. Two years of referrals was never going to give a precise answer on an outcome this uncommon, and I'd have said so in the proposal.
