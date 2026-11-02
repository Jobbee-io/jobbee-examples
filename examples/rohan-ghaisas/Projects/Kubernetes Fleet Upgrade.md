<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Kubernetes fleet upgrade: 16 clusters, four versions, no outage

Larkspan Software, February to October 2024. Nine months, every cluster we run, and the go/no-go call on every production hop was mine. On my resume it's one bullet. It's the project I'd expect a Staff interview to spend the most time on, so this file is long.

## Where we started

In January 2024 all 16 clusters were on Kubernetes 1.24: 6 production (4 in our primary US East region, 2 in the secondary US West region) and 10 non-production (dev, staging, load test and internal tools). About 140 services, about 3,600 production pods and about 250 production nodes at peak. The largest cluster, East invoice processing, ran about 70 nodes.

Upgrades had been done by hand, one cluster at a time, whenever someone had a free week. Nobody had had one for over a year. Three things made it urgent:

- Cost. Our cloud provider charges an extended-support fee for versions past standard support: $0.50 per cluster-hour on top of the normal control-plane price, about $5,800 a month for 16 clusters. A cluster stops paying only when it reaches a version that is still in standard support.
- Risk. 1.25 removes PodSecurityPolicy, and every cluster used it. The control plane moves one minor version at a time, so every month of waiting meant more hops later, not fewer.
- Loss of control. Extended support for 1.24 ended in early 2025. After that date the provider upgrades the control plane itself, on its schedule, not ours.

## My role

I wrote the proposal in January and owned the program: the plan, the API inventory, the pre-check scripts and the upgrade pipeline, the runbook, the weekly status report to Vikram S. (our Head of Platform), and the go/no-go call for every production hop. I drove most production hops myself.

Shruti P. and Aditya K., two Pune SREs, ran the non-production hops and the PodDisruptionBudget audit. After the 14-minute degradation in May, Shruti built the add-on version matrix and still keeps it. Greg H., the US SRE lead in Columbus, watched every hop that ran late into the US morning. Service teams fixed their own manifests, with one tracking ticket per service, and we fixed 31 charts ourselves for teams that couldn't.

## Options I priced in the proposal

- Keep upgrading by hand. Each manual upgrade in 2022 had taken one engineer 2 to 3 days. 64 hops at that rate is most of a year for one person, with no pre-checks, and the same backlog the next time versions aged out. Rejected.
- Build new clusters on 1.28 and move services across (blue/green clusters). It skips three hops. But it meant moving 140 services' DNS, secrets and Argo CD applications, running double production compute for 4 to 6 weeks per region (about $60K by my estimate), and moving the in-cluster Redis with its data. And it does nothing for the next upgrade. Rejected for production.
- Pay extended support for another year and upgrade in 2025. About $70K, with the PodSecurityPolicy work still waiting and the provider's forced-upgrade date behind it. Rejected.
- In-place upgrades, one minor version at a time, with blue/green node pools, run by a pipeline with manual gates. Chosen. Slower than a cluster swap on paper, but every step can be checked, and the node side can be rolled back.

Two smaller calls inside the chosen option:

- Target 1.28, not the newest version our provider offered (1.29). When I planned, 2 of our add-ons had no release that listed 1.29 as supported. The program was about getting off unsupported versions, not about being newest. The cadence took us to 1.29 in March 2025.
- Roll the node pools on every hop. Kubelets may run up to 2 minor versions behind the API server, so we could have rolled nodes every second hop and halved the node work. I said no, in dev and staging too. Node rolls were where the problems showed up (probes, budgets, the autoscaler), and I wanted each problem to appear with one version change in play, and in staging before production.

## Pre-work, February to May: most of the job

- API inventory. I ran pluto and kube-no-trouble against every Helm chart and every live cluster. 212 manifests across the 140 services used APIs that 1.25 or 1.26 removes: PodSecurityPolicy, the beta PodDisruptionBudget, and old CronJob and HorizontalPodAutoscaler versions. Nothing we ran used the beta APIs that 1.27 removes, and 1.28 removed none we used. The same month I added pluto to every chart's CI, so no new manifest could bring a removed API back.
- PodSecurityPolicy replacement. Pod Security Admission with "baseline" enforced and "restricted" in audit mode, plus 3 Kyverno policies for our own rules: images only from our registry, resource requests and limits required, and an owner label on every workload. It ran in audit mode for 4 weeks on every cluster before that cluster's 1.25 hop.
- Helm release history. 37 releases had removed APIs stored in their history, which blocks the next `helm upgrade` after the hop. We rewrote them with the mapkubeapis plugin before each cluster's hop, not after.
- Disruption budgets. 58 services had no PodDisruptionBudget, so a node drain could take all their pods at once. 9 had a budget that allowed zero disruptions, which blocks a drain forever. Each was fixed with the owning team agreeing the numbers. Our default: at most 25% of replicas unavailable, and at least 2 replicas for anything customer-facing.
- Readiness probes. Draining staging nodes gave 502s on 23 services whose readiness probes said "ready" before the app was. Most returned 200 from a health endpoint before their database pool and caches were warm. All 23 were fixed before any production hop.

The service teams were the slow part. I planned 4 weeks for them to fix their manifests, and it took 9. In week 5, with about 40% of the tickets still open, I changed the approach: my team made the mechanical changes centrally (an API version bump, a new disruption budget) and sent each pull request to the owning team for review only. That's where the 31 charts came from. Vikram set a date after which a chart with a removed API would fail CI and not deploy, and that closed the rest.

## How a hop ran

Order: dev, then staging with a 1-week soak, then the 2 West production clusters with a 3-day soak, then the 4 East production clusters. West went first because it carries the least live traffic (read replicas, batch work and the standby for ingestion), so a mistake there costs least.

Production hops ran 13:00–17:00 IST. That is 03:30–07:30 US Eastern in summer, the lowest traffic of our day, with the whole Pune team awake. Working from India was an advantage here, not a constraint.

Each hop was a pipeline with manual gates between the steps:

1. Pre-checks, the day before. No removed APIs in the live cluster or in the charts. Every customer-facing service has a disruption budget that allows at least one disruption. Helm histories are clean. Add-on versions match the target in the matrix (from late May). There is room for a second node pool. No SEV-1 or SEV-2 is open.
2. Control plane upgrade, about 30 to 40 minutes on our provider. This is the one-way step: a managed control plane can't be downgraded. So the go/no-go was really a decision about the control plane, and everything before it existed to make that decision safe.
3. Add-ons, each to the version in the matrix: cluster-autoscaler, CNI, CoreDNS, kube-proxy, ingress controller, CSI driver.
4. Node pools, blue/green. Create a new pool on the new version and scale it to the old pool's node count (from late May; see below). Cordon the old pool. Drain 3 nodes at a time, and start the next batch only when every pod from the last one is running and ready. The largest cluster took about 2 hours to drain. Keep the old pool cordoned for 24 hours as the rollback, then delete it. We used that rollback twice, both times in staging.
5. Post-checks. Synthetic transactions (upload an invoice, approve it, search for it), error rates and SLO burn, watched for 60 minutes before I closed the hop.

Hands-on time for a production hop, counting the pre-checks the day before and the old pool's deletion the day after, fell from about 7.5 hours (the first) to about 2 hours (the last).

## Timeline and turning points

- January 2024: proposal approved. The fee was the argument that got it funded. The PodSecurityPolicy removal was the one that worried me.
- February to May: inventory, Pod Security Admission in audit mode, Helm histories, budgets and probes. Week 5 of the manifest work: the switch to central fixes.
- April: dev and staging clusters to 1.25.
- May: the 2 West production clusters to 1.25, then East. On Tuesday 21 May, the 14-minute degradation (below). I paused the East hops for a week to add the add-on matrix and the pre-scaled node pool to the pipeline.
- June and July: 1.26 and 1.27 across the fleet. By now the pipeline did most of the work. In June a Redis deployment blocked a drain for 5 hours (below).
- August: the last cluster reached 1.27, the oldest version still in standard support, and the extended-support fee went to zero.
- September and October: 1.28 on all 16 clusters.
- November: the first quarterly cadence plan.

## The numbers, with definitions

- 64 control-plane hops (16 clusters x 4 versions), February to October 2024. 24 of them in production.
- Zero customer-facing outage minutes. An outage minute is a minute in which our synthetic checks failed, or in which the public API's availability SLO (99.95% a month) burned error budget because of an upgrade. There were none.
- One degradation, which I count against the program anyway: 14 minutes. Invoice search isn't part of the public API SLO. It has its own target, p99 under 1 second, and those 14 minutes broke it. I'd rather count it than hide behind my own definition.
- Hands-on time per production hop: about 7.5 hours to about 2 hours, first to last, as defined above.
- Extended-support fees: about $5,800 a month to zero in August 2024. About $35K was paid in 2024 before that.
- The cadence: in 2025 the fleet moved three more minor versions with no program and no extended-support fees (1.29 in March, 1.30 in June, 1.31 in September), and one a quarter so far in 2026. That is the result I'm proudest of.

## What went wrong

- The 14 minutes. On the 1.25 hop of one East production cluster, I upgraded the control plane but not the cluster-autoscaler, whose minor version should match the control plane's. In those days a new node pool started small, and the autoscaler grew it as pods arrived from the drain. The 1.24 autoscaler against a 1.25 control plane made no scale-up decisions. Pods sat pending, and invoice search p99 went to 2.1 seconds with a 0.6% error rate until I scaled the new pool by hand, 14 minutes in. The dev, staging and West hops had the same mismatch. Their new pools happened to start with enough nodes for their traffic, so the autoscaler never had to act and the mistake stayed invisible until the busiest cluster. Two fixes: the add-on version matrix became the first pre-check, and the new pool is now scaled to the old pool's size before the first cordon, so a drain never depends on the autoscaler reacting in time.
- The manifest estimate: 4 weeks planned, 9 taken. Teams had their own roadmaps, and "your chart uses a removed API" isn't urgent until the week it breaks. I should have made the mechanical fixes centrally from day one and asked teams only to review.
- A Redis deployment with a budget of zero disruptions blocked a drain for 5 hours in June, past the end of the window. No customer impact, but it ate a whole window. I'd found it in the audit and accepted the team's "we'll fix it before the hop." After that, a usable disruption budget became a pre-check that fails the hop, not a ticket.

## Who disagreed, and how it was settled

- Service teams, on the dates. Settled by doing the mechanical fixes for them and by Vikram's CI cut-off.
- Our security and compliance lead wanted "restricted" enforced from each cluster's 1.25 hop, for our SOC 2 controls. In audit mode, 41 workloads failed "restricted" (most ran as root or asked for extra Linux capabilities), and enforcing it would have blocked their deploys in the middle of the program. I proposed "baseline" enforced and "restricted" in audit, with a monthly report of violations by team. She agreed on the condition of the report. By December 2024 the count was 9.
- Vikram asked whether we could turn on network policies in the same program. I said no: one change in play per hop, or a bad hop teaches you nothing. Network policies went in during 2025 as their own project.

## Second-order effects

- The pipeline outlived the program. The same pre-checks and node-pool steps now run our monthly node image updates, which used to be manual.
- Honest disruption budgets and probes made every drain safe, not only upgrade drains. When a node fails now, its pods reschedule without the 502s we used to see.
- Pod Security Admission plus the Kyverno policies became a SOC 2 control that our auditors test. The old PodSecurityPolicy setup never was one.

## What still isn't solved

- Redis still runs in the cluster and is still the slowest thing to drain. Moving it to the provider's managed Redis is on the platform roadmap, not done.
- The add-on matrix is still put together by hand from release notes each quarter. It takes Shruti about a day, and nothing checks it but us.
- The cadence depends on people. Since 2025 the quarterly upgrade owner rotates among the Pune SREs, and a quarter can be skipped only with a written reason. It has been skipped once, in Q4 2025, when the region outage postmortem took the slot.

## What I'd do differently, and what I'd defend

- Make the add-on version matrix part of the plan from day one, not a lesson from the busiest cluster.
- Make mechanical manifest fixes centrally from the start.
- Put the quarterly cadence in place before the catch-up program. A cadence is what stops you needing a program.
- I'd defend in-place upgrades over a cluster swap, the 1.28 target, and rolling nodes on every hop. Each made the program slower on paper, and each removed a way for a production hop to go wrong.
