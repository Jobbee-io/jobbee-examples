<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Design system rebuild

Shelfwright, Web Platform team. The build ran from March 2021 to December 2022, and I tracked adoption through December 2023. On my resume it's two bullets: the rebuild and the merchant theming model. Of everything I've done, it's the closest to the Staff role I want: 21 months as technical lead, 11 product teams to win over, and the storefront branding of every retailer on the platform (about 1,400 today) riding on one API I designed.

## Where we started

In early 2021 Shelfwright had three component libraries. The storefront used a fork of Bootstrap 3 with years of Sass on top. The merchant admin had its own React library. Checkout had built a third, because neither of the others handled its forms. An audit I ran in March 2021 found 23 different button implementations and 14 different modals across the web codebase. Storefront CSS on the default theme was 410KB uncompressed.

Merchants felt it most. A retailer branded their storefront by writing override CSS against our class names. The median theme was about 900 lines of overrides, and every storefront release broke some of them. Theme breakage was the largest category of merchant support tickets that touched the frontend.

## The RFC and the options it priced

I wrote the RFC in March 2021. The goal: one system, built on design tokens, that product teams want to use and that merchants can theme without writing CSS against our internals. It priced four options, starting with doing nothing.

- Do nothing. About 210 theme tickets a quarter at roughly 40 minutes of support time each, about 2 engineer-weeks per storefront release spent on theme breakage, three libraries fixing the same bugs separately, and storefront CSS growing about 30KB a year.
- Tokens only: one token package that all three libraries read. About 3 months. It would make colors and spacing consistent and do nothing about 23 buttons, 14 modals, or merchants writing CSS against our class names. Rejected as the end state, kept as the first step.
- Extend the merchant admin's React library, the most complete of the three. But it used a CSS-in-JS runtime that added about 40KB gzip and style work at render time. That was fine in an admin app and too slow for storefronts on mid-range phones, and it had no theming at all.
- Adopt an off-the-shelf styled component library and theme it. Merchants' themes would then be written against a third party's internals. That was the trap we were already in with the Bootstrap 3 fork.

We chose our own token-based React system, with one exception: for the components where accessible behavior is hard, we built on headless primitives and wrote only the styling. Our engineering manager and Ruth K., the director of web engineering, approved it in April 2021 with the team below.

## My role

I was the technical lead, as an IC. The team was me, three engineers, two designers (Noor A. led design) and a product manager at half time. I wrote the RFC and the token architecture, built the dialog, combobox and form-field components myself, wrote the codemods, and ran adoption with each product team. Noor owned the visual language and the component specs. The other engineers built most of the remaining components. I didn't manage anyone; we all reported to the Web Platform engineering manager.

## The architecture

Tokens come in three tiers:

- Core tokens are raw values: the palette, the spacing scale, the type scale, radii.
- Semantic tokens say what a value is for: surface, text, border, focus and so on. `color.text.muted` points at a core gray, and a merchant can point it somewhere else.
- Component tokens say what one component uses. `button.primary.background` points at a semantic token.

Merchants only ever touch semantic tokens. That one rule is the whole theming model: we can change components and core values without breaking a merchant's brand.

The tokens live in one JSON source. A build step turns them into CSS custom properties and a TypeScript type, and Noor's Figma library uses the same names, so a designer and an engineer use the same word for the same thing.

Components are React, styled with CSS custom properties that read the tokens, so a theme change doesn't need a rebuild. On the storefront, the server renders each merchant's theme as one block of custom properties in the HTML, cached per merchant. For dialog, menu, combobox and tabs we built on headless primitives and wrote our own styling, instead of writing keyboard and focus handling from scratch. Storybook held the docs, and Playwright ran visual regression and axe checks on every story.

Component APIs were narrow on purpose. Button has 3 variants and 3 sizes and no color prop. A team that wanted a red button got a "danger" variant after a design review, not a style override. Any team can propose a new component in a short RFC, and the system team decides whether it becomes core or stays local to that team.

Releases: one package, semver, a minor release about once a month. From version 2.0 on, a breaking change ships with a codemod or doesn't ship.

## Merchant theming: 140 tokens, then 38

The theming API was my design, and it was my biggest mistake on the project.

Version 1.0, in April 2022, exposed 140 tokens to merchants: the semantic tokens plus many component tokens, because I thought the agencies that build merchant themes would want the control. Noor argued for about 30. In practice agencies changed tokens almost at random: hover colors with no relation to their base color, text colors that failed contrast on half the surfaces. Theme tickets went up for two months.

Version 2.0, in September 2022, cut it to 38 semantic tokens: 16 for color, 10 for type, 6 for shape (radii and borders), 4 for spacing and density, 2 for motion. Hover and pressed colors are no longer set by hand; the theme editor computes them from the base color when the merchant saves. The editor also blocks text and surface pairs below 4.5:1 contrast. It was a breaking change. A converter mapped 1.0 themes onto 2.0, and merchants whose themes didn't convert cleanly got a side-by-side preview and a named support contact.

For whatever tokens can't express, merchants still write custom CSS: a median of about 60 lines, down from about 900 lines of overrides. In 2023, once cascade-layer support passed 96% of storefront traffic, we put the system's CSS in a layer below merchant CSS, so merchant rules win without `!important`.

## Adoption, which was the real project

Checkout was the first team on it, in October 2021, 7 months after we started. I paired with each team for its first two weeks and wrote jscodeshift codemods for the mechanical parts: imports, prop renames and the old class names. Over 2022 the codemods changed about 1,900 files across 9 repos.

Checkout found problems in the form components in its first week. Our form field assumed validation on blur. Checkout's 6 steps shared one validation model, which I had built on that team, with async checks (address, promo codes) and errors that arrive after a server call. I rewrote the form field's API around Checkout's model, which meant reworking about a dozen components already built on the old one.

The order after Checkout came from two questions: which teams were about to build new UI anyway, and which had the most duplicated components. The storefront team went last. Its lead was against moving at all, because any change to storefront markup could break merchant override CSS. We settled it by keeping the old class names as frozen aliases on the new components, planned for 12 months, so old merchant themes kept working while merchants moved to tokens.

Two teams stayed off on purpose: merchant analytics, whose UI is mostly charts, and an internal operations tool. Neither would have gained much, and we had more to do elsewhere.

After December 2022 the build team shrank to one full-time engineer, plus one engineer from each adopting team for one sprint a quarter. I moved to checkout performance in April 2023 and kept reviewing system RFCs.

## Timeline and turning points

- March–April 2021: audit, RFC, approval.
- April–September 2021: tokens and about 40 components, with no team using any of them.
- October 2021: Checkout adopts, and the form field gets reworked in its first week.
- January 2022, month 10: I start measuring adoption. The first reading is 11% of component usage.
- April 2022: theming 1.0, 140 tokens.
- June 2022: the codemod incident.
- September 2022: theming 2.0, 38 tokens.
- December 2022: the build ends with 7 teams on the system.
- December 2023: 9 of 11 teams and 74% of component usage.

## The numbers, and what they mean

- Product teams on the system: 9 of 11 by December 2023. A team counts when its new UI comes from the system by default and more than half of its component usage does.
- Component usage from the system: 74% in December 2023, up from 11% in January 2022. A monthly script counts JSX elements in product code and reports the share imported from the system rather than from local components.
- Button implementations: 23 to 3 (the system's, plus one in each of the two teams that didn't migrate). Counted the same way as the 2021 audit: code search for button components and styled clickable elements, then a visual check.
- Storefront CSS on the default theme: 410KB to 150KB uncompressed. Most of the cut was the Bootstrap 3 fork and Sass that nobody could prove unused until the old components were gone.
- Merchant theming: from a median of about 900 lines of override CSS to 38 token values plus a median of about 60 lines of custom CSS.
- Merchant-facing tokens: 140 in version 1.0, 38 in version 2.0.
- Theme-related support tickets: about 210 in Q4 2021, about 120 in Q4 2023. These are tickets tagged "theme" by support. Support's tagging changed slightly in 2022, so I treat this as direction, not precision.

## What went wrong

- I built for 7 months before anyone used it. By October 2021 we had about 40 components and no adopter. A two-month pilot with 5 components would have found Checkout's form problems too, with far less to rework.
- The 140-token theming API, above. A breaking change that I caused.
- A codemod mishandled spread props in about 60 files. It rewrote `<button className="btn btn-primary">` into `<Button variant="primary">`, but where the props came in through a spread, it couldn't see the class names and produced a Button with no variant. One release in June 2022 left the gift-card page's buttons unstyled for 3 hours before a merchant reported it. Since then a codemod refuses to touch any element with a spread and lists it for a person, every codemod runs against a fixture set built from real files, and visual regression runs on migrated pages before merge, not after.
- I didn't measure adoption until month 10. Until then I reported components built, which said nothing about whether teams used them.
- The combobox I built passed our automated checks and still had 3 serious accessibility issues, found in the 2024 audit (`Accessibility Remediation.md`). Automated checks were our only gate. They shouldn't have been.

## Second-order effects

- When the 2024 accessibility audit came, 194 of its 318 issues traced back to 9 shared components. Because most UI came from the system, fixing a component once fixed it everywhere. The same fact cut the other way: my combobox carried its 3 issues into every surface that used it. A shared component spreads a bug as efficiently as a fix.
- Later work got cheaper. In the 2023 checkout performance work, cutting web fonts from 4 weights to 2 was a token change, not a hunt through CSS.

## What still isn't solved

- 26% of component usage is still local, mostly data tables and charts. We never built a shared table: each team's tables need different sorting, selection and editing, and every proposal I saw was either too narrow or a framework.
- About 250 merchants were still on legacy override CSS at the end of 2023. They run on the frozen class-name aliases, which were meant to last 12 months and can't be removed until those merchants move.
- One full-time engineer is thin for a system 9 teams depend on. The sprint rotation helps, but the backlog of component requests grew through 2023.

## What I'd do differently, and what I'd defend

- Ship 5 components to one team in month 2, and grow the system from what that team needs.
- Design the merchant theming API with 5 real merchants' themes in hand, not from our own token list. And listen to the designer who said 30.
- Put manual keyboard and screen reader testing into each component's definition of done from day one.
- I'd defend the semantic-token boundary for merchants, building our own system instead of theming a third party's, and headless primitives for the hard components. All three still hold.
