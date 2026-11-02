<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Base Resume — Paul Brennan

paul.brennan@example.com · (555) 017-4826
github.com/example/paulbrennan · linkedin.com/in/example-paulbrennan
Kansas City, MO

*This is my resume's bigger sibling. I've built for the web since 2004, and a one-page resume can't hold 22 years, nor should it. Recent roles get full detail here; the agency years before 2012 are summarized on purpose. Where a story is long, the project files in `Projects/` carry it.*

---

## Summary

Senior Frontend Engineer at Shelfwright, a commerce platform, aiming for Staff in design systems, accessibility and web performance. I've built for the web since 2004. The work that matters for this role starts in 2012 at product companies, and most of it is from 2019 on. Since 2021 I've led Shelfwright's cross-team frontend problems as an IC: the design system rebuild, checkout performance on Core Web Vitals, and the accessibility remediation that met the European Accessibility Act date. Before that, seven years at Crewloft, where I helped build an AngularJS app and later co-led its incremental migration to React. I measure with field data and real assistive tech, I write the RFC before the code, and I've been through enough platform shifts to plan migrations that don't stop the product.

---

## Experience

### Shelfwright — Senior Frontend Engineer (Jul 2019 – present)

Commerce platform that runs storefronts and checkout for about 1,400 mid-size retailers; about 9M orders a year go through checkout. Web engineering is 11 product teams. Checkout team Jul 2019 – Feb 2021; Web Platform team since Mar 2021 (design system, frontend performance, accessibility tooling).

- **Accessibility remediation (Oct 2024 – Jun 2025).** Led the program after an external WCAG 2.1 AA audit found 318 issues across 26 flows, ahead of the European Accessibility Act date (June 28, 2025). Traced 61% of the issues to 9 shared components and fixed those first. All 47 critical and 121 serious issues fixed and re-tested by June 20, 2025; the August 2025 re-audit found 6 new issues, none critical. Full notes: `Projects/Accessibility Remediation.md`.
- **Checkout performance (Apr 2023 – Mar 2024).** Field p75 on mobile: LCP 4.1s → 2.3s, INP 410ms → 170ms, CLS 0.19 → 0.03. Third-party tags on checkout 27 → 9. A 4-week holdout showed mobile checkout completion up 1.4% (95% CI +0.5% to +2.3%). Full notes: `Projects/Checkout Performance.md`.
- **Design system rebuild (Mar 2021 – Dec 2022).** Technical lead (IC) for a team of 3 engineers and 2 designers. Replaced three component libraries with one token-based React system; 9 of 11 product teams on it and 74% of component usage coming from it by Dec 2023. Storefront CSS 410KB → 150KB. Full notes: `Projects/Design System Rebuild.md`.
- **Merchant theming (2022).** Replaced override-CSS theming with 38 semantic tokens. The median merchant theme went from about 900 lines of CSS to 38 token values plus about 60 lines. Theme-tagged support tickets went from about 210 to about 120 a quarter.
- **Checkout team (2019–2021).** Built the split-payment UI (gift card plus card) in 2020, used on about 11% of orders by 2021, and moved checkout's forms to one validation model shared by all 6 steps.
- **Frontend RFC review (2025 – present).** Started a fortnightly review for frontend changes that cross team lines; 23 RFCs reviewed in 2025.
- **Mentoring.** Weekly frontend office hour since 2022. Two engineers I mentored were promoted to senior (2023, 2025).
- Nominated for Staff in the 2025 cycle. The web org had one Staff opening, and it went to a colleague with a strong case. There is no web Staff opening in 2026.
- Era tech: TypeScript, React, CSS custom properties, Storybook, Playwright (visual regression and axe), jscodeshift, Node for server rendering, the web-vitals library for field data.

### Crewloft — Frontend Engineer → Senior Frontend Engineer (May 2012 – Jun 2019)

Scheduling and dispatch software for trade contractors (HVAC, plumbing, electrical): about 2,600 contractor businesses by 2019. I was the second frontend hire. The frontend team was 6 by 2016 and 7 when I left. Promoted to Senior in 2015.

- **Dispatch board (2013).** One of three engineers who built the AngularJS dispatch board, the product's main screen. I wrote the drag-and-drop schedule grid.
- **Technician web app (2014–2015).** Offline-capable mobile web app for job notes and photos, used by about 18,000 technicians by 2019. Built on AppCache first and moved to a service worker in 2018. AppCache taught me to distrust any cache I can't inspect.
- **AngularJS → React migration (Aug 2016 – Mar 2019).** Co-led the incremental migration of 214 AngularJS directives and components with no feature freeze (41 features shipped during it); board re-render on drag 2.8s → 0.35s. Estimated at 12 months, took 31. Full notes: `Projects/Angularjs To React Migration.md`.
- **Mentoring.** Onboarded and mentored 3 frontend engineers; wrote the team's first frontend code review guide (2016).
- Era tech: jQuery and Backbone (2012), AngularJS (2013–2019), React and Redux (from 2016), TypeScript (from 2018), Grunt, then webpack.

### Earlier (2004–2012, summarized on purpose)

- **Brightkettle Studio, Kansas City — Web Developer → Senior Interactive Developer (Sep 2006 – Apr 2012).** Interactive agency of about 30 people with museum, education and cultural clients. Flash and ActionScript 3 interactives, then HTML, CSS and jQuery. Led a team of 3 developers from 2010 to 2012, including their reviews; that's where I learned I want to stay an IC. Rebuilt a science museum's Flash classroom interactive in HTML5 for iPads in 2011. Full notes: `Projects/Flash To Html5 Rebuild.md`.
- **Fernhollow Digital, Kansas City — Junior Web Developer (Mar 2004 – Aug 2006).** About 60 small-business sites. Moved the agency from table layouts to CSS layouts in 2005, and spent a lot of time on Internet Explorer 6 bugs.

---

## Education

**BFA Graphic Design, Pellingham College of Art, 2000–2004.** Typography and grid systems, which I still use every week in design system work. Learned HTML in a web design elective in 2002.

---

## Skills (honest)

- Strong and current: semantic HTML, CSS (grid, custom properties, container queries, cascade layers), TypeScript, React, design tokens and theming, Storybook, Playwright, jscodeshift codemods, WCAG 2.1 and 2.2 AA, WAI-ARIA patterns, testing with NVDA, JAWS, VoiceOver and TalkBack, Core Web Vitals and field monitoring, Chrome DevTools performance profiling, webpack and Vite.
- Working knowledge: Node for server rendering and backend-for-frontend layers, Next.js, GraphQL clients, Figma (I read and edit design files; I'm not the designer).
- Not my strength: native mobile, backend data stores, WebGL and 3D.
- Earlier tools I no longer offer: Flash and ActionScript 3, jQuery, Backbone, AngularJS. I can still read AngularJS, which helps on migrations.

---

## Numbers I can defend

- Checkout (field, p75, mobile): LCP 4.1s → 2.3s, INP 410ms → 170ms, CLS 0.19 → 0.03; JavaScript on the first checkout page 610KB → 260KB gzip; mobile completion +1.4% (95% CI +0.5% to +2.3%).
- Accessibility: 318 audit issues; 47 critical and 121 serious fixed by June 20, 2025; 33% of the issues detectable by automated tools; re-audit found 6 new, 0 critical.
- Design system: 23 → 3 button implementations; 9 of 11 teams; 74% of component usage; 140 → 38 merchant-facing tokens.
- Migration: 214 AngularJS directives and components, 41 features shipped during it, 31 months against a 12-month estimate.
- Flash rebuild: 22 → 14 modules; about 9 → 25+ frames per second on a first-generation iPad.

## Failures, indexed honestly

- Five weeks spent on Lighthouse lab scores (48 → 87) while field LCP barely moved (4.1s → 3.9s).
- Deferred the fraud-detection script on checkout. For 6 days the risk team's manual review rate rose from 2.2% to 3.5%. I reverted it the day they found it.
- Built about 40 design system components over 7 months before any team used one, and a 140-token theming API nobody could use.
- The combobox I built in 2022 had 3 serious accessibility issues that our automated checks missed.
- A two-owner state bug during the React migration sent 14 jobs to the wrong day for 3 customers (Nov 2017). And the 12-month estimate that took 31.
