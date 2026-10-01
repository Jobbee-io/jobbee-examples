<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Sam Oaks

sam.oaks@example.com · (555) 017-9944
Denver, CO

*The resume's bigger sibling. A one-pager gets you the shape of the career; this file has the scope numbers, the decisions, and the trade-offs behind every line. The long stories live in the project files in `Projects/` — this file points at them rather than compressing them badly.*

---

## Summary

Staff Engineer / Team Lead, 14 years, currently at Fernbrook Systems in a deliberate hybrid role: direct team of 6, technical charter across the platform, still shipping code weekly. Career arc: enterprise build tooling → founding engineer at a developer-tools startup (Cinderpeak Labs, acquired by Grousemont Systems in 2020) → two years inside the acquirer running integration and a division-wide build consolidation → platform leadership at Fernbrook, where I've led 8–12 engineers across 3 teams at peak. The thread through all of it: developer platforms and the org systems around them — builds, deploys, cost, incident process — with the receipts to show they worked.

---

## Experience

### Fernbrook Systems — Staff Engineer / Team Lead, Platform & Developer Experience (Mar 2022 – present)

Mid-size infrastructure software company, ~300 engineers. Hired to build the platform org; led **12 engineers across 3 teams** at peak (2023–2025: platform infra, developer experience, release tooling); stepped to a deliberate hybrid of 6 direct + org-wide charter in 2026 to keep a hand in the code.

- **Incident postmortem program (2022–2023).** Built the blameless postmortem practice after the quarter that made it unavoidable; adoption went from "docs nobody reads" to ~90% of Sev-1/2 with action-item completion tracked to 94%. Full story including the resistance: `Projects/Incident Postmortem Program.md`.
- **Infra cost program (2023–2024).** $6.1M → $4.3M annual infra spend (−29%) across compute, storage, and CI, with the latency cost of each cut measured and *accepted in writing* by the service owners. Included the politics: three VPs, one CTO mandate, and the two cuts I argued against and lost. Full notes: `Projects/Dev Platform Cost Cuts.md`.
- **Dev platform build-out (2022–2025).** Golden-path service templates (new service to first production deploy: 3 weeks → 2 days), self-serve environment provisioning, and the internal developer portal now covering 87% of services. Adopted by 41 of the company's 46 teams without a mandate — the template's default being right did the persuasion.
- **Team topology work (2024–2025).** Re-cut 3 platform teams around user segments (service teams, pipeline users, cost/ops) after measuring where requests actually came from; platform NPS −12 → +31. Led 12 engineers through it without a single regretted attrition.
- Still hands-on: wrote the release-tooling queue service (Go) that now handles ~2,400 deploys/week; most recent PR this month.

### Grousemont Systems — Senior Staff Engineer, Developer Productivity (Feb 2020 – Mar 2022)

~4,000-engineer enterprise software company; joined via the Cinderpeak acquisition. Ran the engineering side of the integration for the first year, then took the division-wide build consolidation. Full integration story: `Projects/Startup Acquisition Integration.md`; build story: `Projects/Build System Consolidation.md`.

- **Acquisition integration, engineering side (2020–2021).** Kept/rewrote/sunset triage across 60+ services with 45 acquired engineers watching every decision: kept 23 as-is, rewrote 9 (of which 4 were my own former team's code — documented why in the doc, not in hallway opinions), sunset 28. Acquired-team retention at 12 months: 39 of 45.
- **Build consolidation (2021–2022).** Division of ~800 engineers running 5 different build systems (two Maven trees, two Gradle trees, one homegrown Perl thing I still have nightmares about) → single system. CI compute −41%, clean-build p50 26 min → 4 min, and 3 of the 5 old systems fully decommissioned (the homegrown one took a scope fight with its author, which is its own story in the project file).

### Cinderpeak Labs — Founding Engineer → Head of Platform (Sep 2015 – Feb 2020)

Developer-tools startup (continuous-deployment platform for on-prem + cloud). Employee #4; grew with the company to ~45 engineers, where I led the platform group (7 engineers) and still wrote the deploy-agent code.

- **Built the core product.** The deploy agent and pipeline engine — the first version was me and a whiteboard in Sep 2015; by acquisition it ran ~11,000 pipelines/day across 340 customer companies. Wrote the scheduler, the agent protocol, and (to my lasting humility) the YAML schema that we spent 2019 migrating people off of.
- **Scaled the team, not just the system.** Wrote the on-call rotation, the postmortem habit (pre-Acquisition — the seed of what I later built at Fernbrook), and the design-doc culture; interviewed ~200 candidates across the company's life.
- **The 2019 multi-tenant outage era.** Two Sev-1s in one quarter (noisy-neighbor resource exhaustion and a config-propagation stampede) drove the sharding re-architecture I led in H2 2019: tenant shard isolation, per-tenant rate ceilings, blast-radius-tested deploys. No Sev-1 from those causes after.
- Acquired Feb 2020. I stayed 25 more months, which I consider the second-hardest thing I've done; see the integration project file for why the retention number held.

### Kestrel Line Software — Software Engineer → Senior Engineer (Jun 2012 – Sep 2015)

Enterprise build-and-release tooling vendor, ~120 engineers. My build-systems origin story.

- Owned pieces of the build-cache and artifact-repo products; wrote the dependency-resolution rewrite that cut customer support tickets for "phantom missing artifact" by ~60%.
- On-site professional-services stints at 6 enterprise customers — which is where I learned that build systems are org-politics engines, and every consolidation I've run since started with listening before proposing.
- First production pager, first postmortem read in a room where nobody knew my name, first lesson that the deploy pipeline is the product.

---

## Education

**BS Computer Science, Fremont State University, 2008–2012.** Systems focus. Worked 20 hrs/week at the university IT help desk for the last two years — customer empathy, learned the hard way, comes from ticket queues.

---

## Skills, by era

- **2012–2015:** Java, early JVM build internals (Maven, Ivy), Perl (survivor), artifact management, enterprise customers in person.
- **2015–2020:** Go (primary since 2016), distributed scheduling, multi-tenancy, YAML APIs and their discontents, on-call design, zero-to-one product engineering.
- **2020–2022:** integration leadership, org triage at 800-engineer scale, build-system consolidation (Bazel-class tooling), cross-company politics with receipts.
- **2022–now:** Go, platform product thinking, FinOps (unit economics, showback/chargeback), incident process, team topologies, and the ongoing discipline of staying technical while managing.

---

## Numbers I can defend in an interview

- 12 engineers / 3 teams at peak; 6 today; code in production most weeks (Fernbrook).
- $6.1M → $4.3M infra spend (−29%), per-cut latency cost accepted in writing (cost program).
- New service → first prod deploy: 3 weeks → 2 days; 41 of 46 teams adopted without a mandate (dev platform).
- 5 build systems → 1; CI compute −41%; clean-build p50 26 min → 4 min (build consolidation).
- 60+ services triaged in an acquisition: 23 kept / 9 rewritten / 28 sunset; 39-of-45 acquired-team retention at 12 months.
- ~11,000 pipelines/day across 340 customer companies at acquisition (Cinderpeak).
- 2 Sev-1s in a quarter → sharding re-architecture → zero repeats of those causes (Cinderpeak 2019).

## Failures, indexed honestly

- The Cinderpeak YAML schema — I designed it, it calcified, and migrating 340 customers off my own design in 2019 was the bill coming due. I now design config formats like I'll have to migrate off them, because I will.
- At Grousemont, I lost the scope fight over decommissioning the homegrown build system in year 1 and let it sit for 8 months before re-raising it with better allies. The delay cost real CI dollars. Escalate faster; I do now.
- First 6 months at Fernbrook, I over-hired senior platform engineers against a charter that needed two doers more than six architects; re-leveling the plan cost me one good engineer who left for a greener IC track. Hiring to the *work in front of you*, not the work you hope to win — learned at real price.
