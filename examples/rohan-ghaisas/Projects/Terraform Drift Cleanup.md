<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Terraform drift cleanup: six months behind one resume bullet

Larkspan Software, July to December 2023, at about 40% of my time. On my resume it's one short bullet and the least exciting line on the page. It's also the work everything after it depends on: the Kubernetes upgrade and the region failover both assume that what's in code is what's running.

## The full story

When I became Senior SRE in April 2023, our production Terraform was stuck in a loop. One state held about 4,100 resources, plan took 14 minutes, and it showed 1,940 changes nobody had made in code. People stopped running plan and fixed things in the console during incidents, so the drift grew. Another 612 resources sat in no state at all. I proposed the cleanup, and from July to December 2023 I spent about 40% of my time on it.

I planned it and did most of it. We froze non-urgent changes for two weeks in July so the diff stopped moving. I sorted every diff into noise, console changes to keep, and changes to revert, and service teams reviewed every change to their own resources. From August we imported 431 of the unmanaged resources and deleted 181. Then we split the one state into 38. For the last three months Shruti P. worked on it part time and owned the data-store states. Vikram S., our Head of Platform, backed the rule nobody liked: no more console changes in production.

Three things went wrong. I called an access role an orphan after checking only 30 days of activity. It belonged to one customer's monthly file import, which failed in November, and their invoices arrived about 9 hours late. I restored the role within 3 hours of the ticket. Since then, nothing is deleted without being disabled for 45 days first. My first nightly drift job posted about 200 lines a night, and people muted the channel within a week. And the state split took 10 weeks, not the 4 I planned.

By December drift was at 0, plan on the largest state took under 90 seconds, and CI did every production apply. The nightly check still runs.

No task from the project is open. What isn't solved is drift itself: the nightly job still finds about 3 real drift items a week. The difference is that we now see each one within a day and close it in a median of 1.5 business days.

## What it was

When I was promoted to Senior SRE in April 2023, our production Terraform was one root module with one state file of about 4,100 resources. `terraform plan` took 14 minutes and showed 1,940 resources with changes nobody had made in code. People had stopped running plan at all, because the output was unreadable. During incidents, fixes went in through the cloud console and never came back to code. The drift grew, the plan got worse, and fewer people ran it. A loop.

There was a second problem nobody had counted: resources that existed in our cloud accounts but in no Terraform state at all. The first inventory found 612.

## My role

I proposed the cleanup, planned it and did most of it. Shruti P., another Pune SRE, worked on it part time for the last three months and owned the state split for the data stores. Service teams reviewed every change to their own resources. Vikram S., our Head of Platform, agreed to the one rule people didn't like: no more console changes in production.

## How it went

1. Freeze (July). Two weeks with no non-urgent infrastructure changes, so the diff stopped moving while we read it.
2. Triage (July–August). Every one of the 1,940 diffs went into one of three groups. About 1,100 were noise: tags added by a cost tool, attribute ordering, defaults that changed in a provider upgrade. We fixed those with pinned provider versions and a small number of `ignore_changes` rules, each with a comment saying why. About 610 were console changes worth keeping, so we wrote them into code. About 230 were changes to revert, each agreed with the owning team first.
3. Unmanaged resources (August–October). Of the 612, we imported 431 using the import blocks and generated config that Terraform 1.5 added that summer, which turned a week of hand-written imports into an afternoon of review. The other 181 were orphans: old snapshots, unattached volumes, load balancers with no targets. Deleting them saved about $3,900 a month.
4. Split the state (September–November). One state of 4,100 resources became 38 smaller ones, split by layer and owner: network, data stores, clusters, and each service's own resources. The rule was that one state should have one owning team and a blast radius we could reason about. Every `terraform state mv` on production had a second person watching, a backup of both states taken first, and a plan on both sides afterwards that had to show no changes. Plan time on the largest state went from 14 minutes to under 90 seconds.
5. Keep it fixed (November–December). Every state is planned on the pull request and applied by CI after merge; nobody applies to production from a laptop. A nightly job runs plan on every state and opens a ticket for any real drift, with a one-line summary in the team channel. Human write access to the production console was removed. There is a break-glass role that lasts 4 hours and opens a ticket automatically; the ticket closes only with a pull request that puts the change into code.

## The numbers

- Drifted resources: 1,940 to 0 by December 2023. Drift means any resource where plan shows a change that isn't in the main branch.
- Unmanaged resources: 612 found, 431 imported, 181 deleted (about $3,900 a month saved).
- Plan time on the largest state: 14 minutes to under 90 seconds.
- Since then, the nightly job finds about 3 real drift items a week. Median time to resolve: 1.5 business days.
- Break-glass use in 2024: 17 times, every one closed with a pull request.

## What went wrong

- I deleted something that was in use. One of the 181 "orphans" was an access role with no tags and no API calls in the 30 days I checked. A solutions engineer had created it by hand in 2021 for one customer's monthly file import, which ran on the first of the month, outside my 30-day window. When the import ran in November, it failed. The customer's invoices arrived about 9 hours late, and I restored the role within 3 hours of the support ticket. Since then nothing is deleted straight away: it's disabled first, kept for 45 days, and only then deleted. Every resource needs an owner tag, or it shows up in the weekly report.
- The first version of the nightly job posted every diff to the team channel, about 200 lines a night. People muted the channel within a week. The fix was one summary line, and a ticket only for drift that isn't on the known-noise list.
- I underestimated the state split. I planned 4 weeks and it took 10, mostly because every move on live production needed that second person watching.

## What I'd do differently

- Look at 90 days of activity before calling anything an orphan, not 30. Monthly and quarterly jobs hide inside a 30-day window.
- Split the state before the triage, not after. Fourteen-minute plans made every triage session slower than it needed to be.
