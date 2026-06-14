# Handoff: XCR Ventures — Website Redesign (Jekyll)

## Overview
A full redesign of **xcrventures.com** on the XCR Ventures "blueprint" brand
system. The current live site is a single bare page (logo + a few link lists).
This redesign keeps it a **single-page firm site** but gives it real structure
and the brand's drafting-table identity: a blueprint-grid hero, the portfolio
grouped by fund/status, an About + founder block, and a blueprint footer.

The content is faithful to the live site — same portfolio companies, same
founder, and the firm's real status: **XCR is not currently making new
investments**, so there is intentionally **no "apply for funding" flow** and
contact is **deliberately de-emphasized** (one quiet LinkedIn link in the
footer; the founder's name links to LinkedIn for attribution).

---

## About the Design Files
The files in `reference/` are **design references created in HTML/React** — a
prototype showing the intended look and behavior. They are **not production
code to copy directly.** Your job is to **recreate this design in the existing
Jekyll app** using its conventions (Liquid templates/includes, the site's SCSS
or CSS pipeline, `_data` for content, `assets/` for images).

- `reference/xcr-website-redesign.html` — a **single, self-contained** build of
  the whole page. Open it in a browser to see the finished design, scroll
  behavior, hover states, and exact spacing. **This is the source of truth for
  look & feel.**
- `reference/src/*.jsx.txt` + `data.js` — the section components, readable as a
  precise spec of each section's markup, inline styles, and copy. (Saved with a
  `.txt` suffix so they're plain reference text — rename to `.jsx` if you want
  syntax highlighting.) Port the logic/structure; do not ship React.
- `tokens/*.css` — the design tokens as CSS custom properties (colors, type,
  spacing, radii, shadows, motion, blueprint motifs). **Port these verbatim**
  into the Jekyll site's stylesheet (as CSS variables, or convert to SCSS
  variables). `tokens/styles.css` is the entry point that `@import`s the rest.
- `assets/` — the brand logos and the blueprint grid texture. Copy into the
  site's `assets/` directory.

## Fidelity
**High-fidelity (hifi).** Colors, typography, spacing, radii, shadows, and
interactions are final. Recreate pixel-for-pixel. Every measurement below is
exact; when in doubt, measure against `reference/xcr-website-redesign.html`.

---

## Suggested Jekyll structure
```
_data/portfolio.yml          # the three company groups (see "Portfolio data")
_includes/site-header.html   # sticky nav
_includes/hero.html          # blueprint-grid hero
_includes/portfolio.html     # loops _data/portfolio.yml
_includes/about.html         # founder + philosophy
_includes/site-footer.html   # blueprint footer
_sass/_xcr-tokens.scss       # the tokens/*.css values
assets/css/main.scss         # imports tokens + section styles
assets/img/                  # xcr-white.png, xcr-black.png, blueprint-grid.png
index.html                   # front matter + the five includes in order
```
Fonts load from Google Fonts (see Typography). Icons use **Lucide** via CDN
(`https://unpkg.com/lucide@0.544.0/dist/umd/lucide.min.js`, then
`lucide.createIcons()`), or inline the few SVGs you need to avoid the dep.

---

## Design Tokens (exact values)

### Color
| Token | Value | Use |
|---|---|---|
| `--xcr-blue` / `--accent` | `#1f57b3` | primary brand blue, links, badges |
| `--blue-200` / `--xcr-blue-light` | `#95b6eb` | light accent, status dot |
| `--blueprint-field` | `#2b6cd7` | the hero/About-card blue grid ground |
| `--blue-950` | `#081b3d` | footer ground (dark blueprint) |
| `--blue-50` / `--accent-soft` | `#eaf1fc` | soft fills, icon chips, blue badges bg |
| `--bg-page` | `#f5f7fa` (gray-50) | page background |
| `--surface-card` | `#ffffff` | cards, portfolio section bg |
| `--text-strong` | `#0a0e14` | headings on light |
| `--text-body` | `#222936` | body on light |
| `--text-muted` | `#66728a` | secondary text on light |
| `--text-faint` | `#8d99ac` | captions, mono meta |
| `--border` | `#d6dde8` | hairline borders, dividers |
| `--text-on-blue` | `#ffffff` | text on blue fields |
| `--text-on-blue-muted` | `rgba(255,255,255,0.70)` | secondary on blue |
| `--border-on-blue` | `rgba(255,255,255,0.28)` | borders on blue |

Neutral ramp (cool, blue-tinted): `gray-50 #f5f7fa · 100 #eaeef4 · 200 #d6dde8
· 300 #b6c1d1 · 400 #8d99ac · 500 #66728a · 700 #353e4f · 950 #0a0e14`.
Status (kept low-key): positive `#1f8a54`, warning `#c9871f`, danger `#c0392b`.
**Brand law:** logo elements are never multi-colored — never tint "XCR" and
"VENTURES" differently.

### Typography
Load from Google Fonts:
```html
<link href="https://fonts.googleapis.com/css2?family=Saira:wght@300;400;500;600;700&family=Saira+Expanded:wght@400;500;600;700;800;900&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
```
- **Display / wordmark** — `'Saira Expanded', sans-serif`. Wide squared
  aerospace face. (`--font-display`)
- **Body / UI** — `'Saira', system-ui, sans-serif`. (`--font-body`)
- **Mono** — `'Space Mono', ui-monospace, monospace`. Eyebrows, labels,
  dimension callouts — uppercase, tracked, often prefixed `//`. (`--font-mono`)

Weights: 300/400/500/600/700/800/**900**. Type scale (px): 11, 12, 14, 16, 18,
20, 24, 30, 38, 48, 62, 80, 104. Letter-spacing of note: headings
`-0.01em`; mono labels `+0.08–0.18em`; the wordmark's "VENTURES" is tracked
`0.28em`.

> The brand originally referenced *Eurostile Extended*; it has been retired in
> favor of Saira Expanded. Do **not** reintroduce Eurostile.

### Spacing — 4px grid
`4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96, 128, 160`. Section vertical
padding is **104px** top/bottom (`padding: 104px 40px`). Max content width
**1280px** (`--container-xl`), centered. Blueprint grid module: minor **32px**,
major **128px**.

### Radius
`xs 2 · sm 4 · md 6 (default) · lg 10 · xl 16 · pill 999`. Small and technical
— never pill-soft except true pills (the status pill).

### Shadows (cool, blue-tinted)
- `--shadow-md`: `0 4px 12px rgba(13,42,92,.12), 0 2px 4px rgba(13,42,92,.08)`
- `--shadow-blue-glow`: `0 0 0 1px rgba(31,87,179,.35), 0 8px 28px rgba(31,87,179,.30)` (founder card)
- Card hover lifts ~2px to a deeper shadow.

### Motion
Easing `cubic-bezier(0.2,0,0.1,1)` (standard); durations 120ms / 200ms / 320ms.
Crisp and mechanical — **no bounce/overshoot.**

### Blueprint motifs (CSS, no images required)
Grid (apply over `--blueprint-field`):
```css
background-color: #2b6cd7;
background-image:
  linear-gradient(rgba(255,255,255,.40) 1px, transparent 1px),
  linear-gradient(90deg, rgba(255,255,255,.40) 1px, transparent 1px),
  linear-gradient(rgba(255,255,255,.20) 1px, transparent 1px),
  linear-gradient(90deg, rgba(255,255,255,.20) 1px, transparent 1px);
background-size: 128px 128px, 128px 128px, 32px 32px, 32px 32px;
```
Hero adds a vignette layer on top (`--bp-vignette`): two radial-gradients —
a soft white glare top-center and a dark `rgba(8,27,61,.55)` sink at the bottom.
Diagonal hatch (`--bp-hatch`) and dashed construction lines are available for
flourish. Full token definitions are in `tokens/effects.css`.

---

## Screens / Views (single page, five stacked sections)

The page is one vertical scroll. Order: **Header → Hero → Portfolio → About →
Footer.** Nav links are in-page anchors (`#portfolio`, `#about`).

### 1. Header (`reference/src/Header.jsx.txt`)
- **Purpose:** brand + nav. **Layout:** sticky top, height **72px**, full-width,
  `padding: 0 40px`, flex space-between, `z-index: 50`.
- **Left:** the XCR wordmark (see Wordmark component) at size 26, inline layout.
  Over the hero it is **white**; once the user scrolls >12px it switches to
  **ink** (`#0a0e14`).
- **Right nav:** two anchor links — **PORTFOLIO**, **ABOUT** — in mono,
  uppercase, 12px, bold, letter-spacing `0.12em`, gap 32px. Over hero
  `rgba(255,255,255,0.82)`; scrolled `--text-body`. (No "Contact" link — contact
  is de-emphasized.)
- **Scroll behavior:** when `scrollTop > 12`, header background becomes
  `rgba(255,255,255,0.92)` with `backdrop-filter: saturate(160%) blur(8px)` and
  a `1px solid --border` bottom; transition 200ms. Above the fold it is
  transparent with a transparent border.

### 2. Hero (`reference/src/Hero.jsx.txt`)
- **Purpose:** state what the firm does. **Layout:** the blueprint grid field
  (`#2b6cd7` + grid + vignette), `padding: 128px 40px 96px`, pulled up under the
  header with `margin-top: -72px`. Inner content max-width 1280px, centered.
- **Drafting marks (top-right, absolute, decorative):** a `180×180`
  `1.5px solid rgba(255,255,255,0.28)` rounded square, and above it the mono
  caption **`EST. 2015 · SHEET 1/1`** in `rgba(255,255,255,0.6)`, 11px,
  spacing `0.1em`.
- **Eyebrow:** mono `// ANGEL & EARLY-STAGE INVESTMENT` (the `//` is the
  Eyebrow marker — see component), color `--text-on-blue-muted`.
- **Headline (h1):** *"We invest in and consult with companies at every stage of
  growth."* — Saira Expanded **bold (700)**, `clamp(30px, 4.4vw, 52px)`,
  line-height 1.05, letter-spacing `-0.01em`, **white**, max-width 20ch, margin
  top 20px. (This deliberately replaced an oversized "XCR IS THE BLUEPRINT."
  callout — do not bring that back here; the tagline lives in About.)
- **Sub (p):** *"XCR doesn't build spaceships — we draw the clear path to the
  realization of new ideas."* — 19px, `--text-on-blue-muted`, max-width 54ch.
- **Status pill:** inline-flex, `padding: 9px 16px 9px 14px`, `border-radius:
  999px`, `1px solid rgba(255,255,255,.28)`, bg `rgba(255,255,255,.08)`. An 8px
  light-blue dot (`#95b6eb`) with a `0 0 0 4px rgba(149,182,235,.22)` halo, then
  mono label **NOT CURRENTLY MAKING NEW INVESTMENTS** (white, spacing 0.1em).
- **CTAs (anchors, not buttons):** ① *VIEW THE PORTFOLIO* → `#portfolio` —
  white bg, blue text, mono uppercase 13px, `padding 15px 22px`, radius 6px,
  trailing ↓ icon. ② *ABOUT THE FIRM* → `#about` — transparent with `1.5px solid
  rgba(255,255,255,.28)`, white text.
- **Stat band:** top border `1px solid rgba(255,255,255,.28)`, `padding-top 36px`,
  flex gap 56px. Four stats (value in display, label in mono below): **2015**
  Founded · **8** Companies backed · **1** Exit · acquired · **Multi** Stage.

### 3. Portfolio (`reference/src/Portfolio.jsx.txt` + `data.js`)
- **Purpose:** the book of companies. **Layout:** white section
  (`--surface-card`), `padding: 104px 40px`, top border `1px solid --border`,
  inner max-width 1280px.
- **Heading:** eyebrow `// PORTFOLIO`; h2 *"Companies we've backed"* in display
  bold, `clamp(32px,5vw,56px)`, uppercase, `--text-strong`; sub *"A small,
  deliberate book of companies across consumer, software and hardware."*
- **Three groups**, each with a header row (mono label + zero-padded count, e.g.
  `FUND 1 · CLOSED  04`, bottom border 1px) and a **4-column grid, gap 20px**:
  - **Fund 1 · Closed** — ProMentor, Nami, RevAir, Teakoe (badge tone *blue*)
  - **Exits** — Venuetize (badge tone *solid* blue)
  - **Past portfolio** — Glow, Heal, WAL (badge tone *neutral* gray)
- **Company card** (each wraps an `<a>` opening the company site in a new tab):
  white card, `1px solid --border`, radius 10px, `--shadow-sm`, `padding 20px`,
  full height. Top row: a **sector Badge** (left) and a faint `arrow-up-right`
  icon (right). Then company **name** (Saira Expanded 24px/h4, `--text-strong`),
  a one-line **blurb** (14px, `--text-muted`, min-height 40px). Optional footers:
  a mono note (e.g. `Formerly TopYa!`) and/or an accent **`✓ Acquired by Everi`**
  line (Venuetize). **Hover:** card lifts ~2px to `--shadow-md`.

### 4. About (`reference/src/About.jsx.txt`)
- **Purpose:** who runs XCR + the philosophy. **Layout:** light section
  (`--bg-page`), `padding: 104px 40px`, inner max-width 1280px. Top is a
  **2-column grid `1.1fr 0.9fr`, gap 64px**.
- **Left column:** eyebrow `// ABOUT`; h2 *"XCR doesn't build spaceships. XCR is
  the blueprint."* (display bold, `clamp(32px,5vw,52px)`, uppercase,
  `--text-strong`, max-width 18ch). Body paragraph: *"**Ben Reubenstein**
  founded XCR Ventures in 2015. The firm invests in and consults with companies
  at a variety of stages of growth — our business is not to build prototypes or
  products, but to provide a clear path to the realization of new ideas."* The
  name links to `https://www.linkedin.com/in/benreubenstein/` (accent, 600). A
  muted second line: *"XCR is not currently making new investments."*
- **Right column — founder card:** the blueprint grid field (`#2b6cd7` + grid),
  radius 10px, `--shadow-blue-glow`, `padding 32px`, white text. Mono kicker
  `// FOUNDER · GENERAL PARTNER`; large name **BEN / REUBENSTEIN** (display bold
  30px, uppercase, two lines); a `1px rgba(255,255,255,.28)` divider; then a
  mono spec list (label left in `rgba(255,255,255,.55)`, value right in white):
  **Founded → 2015**, **Role → Founder & GP**, **Status → Closed to new deals**.
  *(No "Connect on LinkedIn" CTA here — contact is de-emphasized.)*
- **Philosophy pillars (below, 3-col grid gap 28px):** each has a `2px solid
  --accent` top rule + 22px padding; a 44px blue-soft (`#eaf1fc`) rounded chip
  with an accent Lucide icon (`pen-tool`, `route`, `compass`); a mono number
  `01/02/03`; an h4 title; a body paragraph.
  - **01 The first check** — "XCR backs founders early and stays close — angel
    and early-stage capital across consumer, software and hardware."
  - **02 A clear path** — "Capital is the start. We consult on the route ahead —
    hiring, GTM, the next raise. The blueprint, not the spaceship."
  - **03 Along for the journey** — "A venture is a journey. There is risk ahead,
    but also excitement. We stay on the line from first check to outcome."

### 5. Footer (`reference/src/Footer.jsx.txt`)
- **Purpose:** sign-off + a single quiet contact path. **Layout:** dark
  blueprint field — `background: #081b3d` (`--blue-950`) + the white grid image
  — `padding: 88px 40px 40px`, inner max-width 1280px.
- **Top block** (flex space-between, bottom border `1px rgba(255,255,255,.28)`,
  `padding-bottom 56px`):
  - **Left (max 38ch):** h2 *"A clear path for new ideas."* — display bold 38px,
    uppercase, **explicit `color: #ffffff`** (do not let a base heading color
    win — this caused an invisible-heading bug in the prototype). Sub paragraph
    (`--text-on-blue-muted`): *"XCR Ventures provides early capital and counsel —
    drawing the clear path to the realization of new ideas."* **No "Contact Ben"
    button.**
  - **Right (two link columns, gap 64px):** **FIRM** → Portfolio (`#portfolio`),
    About (`#about`); **CONNECT** → **LinkedIn**
    (`https://www.linkedin.com/in/benreubenstein/`) — the only contact link, and
    deliberately understated. Column headers are mono eyebrows; links are 14px
    `--text-on-blue-muted`.
- **Bottom bar** (flex space-between, margin-top 32px): the white wordmark
  (size 22, inline) and a mono copyright **`© XCR VENTURES, LLC. 2026 · SCALE
  1:1`** in `rgba(255,255,255,.5)`, 11px, spacing 0.08em.

---

## Reusable components used (from the brand system)
Recreate these as Liquid includes / SCSS classes. Full prop behavior is in the
brand system's `components/` folder; the essentials:

- **Wordmark** — "XCR" in Saira Expanded **900**, uppercase, letter-spacing
  `-0.01em`; "VENTURES" in Saira Expanded **500**, uppercase, letter-spacing
  **`0.28em`**, ~`0.34 × XCR` size, baseline-aligned beside it (inline layout)
  with gap `~0.22 × size`. One shared color (`ink` `#000`, `blue` `#1f57b3`, or
  `white` `#fff`). Never two-tone. You can also just use `assets/xcr-white.png` /
  `xcr-black.png` where a raster mark is fine.
- **Eyebrow** — mono, uppercase, bold 12px, letter-spacing `0.18em`. Renders a
  literal `//` marker before the text (so write the label without `//`). Tones:
  accent blue (default), muted, or `on-blue`.
- **Stat** — display value (Saira Expanded, large) stacked over a mono uppercase
  label; `on-blue` variant uses white / 70%-white.
- **Badge** — mono uppercase 11px, bold, letter-spacing 0.08em, height 22px,
  `padding 0 9px`, radius 4px, `1px` border. Tones: *blue*
  (`bg #eaf1fc / fg #1a4a99 / border #95b6eb`), *solid* (`bg #1f57b3 / fg #fff`),
  *neutral* (`bg #eaeef4 / fg #353e4f / border #d6dde8`).
- **Card** — white, `1px solid --border`, radius 10px, `--shadow-sm`; default
  padding 20px; `interactive` adds the 2px hover-lift to `--shadow-md`.

---

## Interactions & Behavior
- **Header** frosts/inverts on scroll past 12px (see Header section).
- **Nav + hero CTAs** are in-page anchors; the live prototype scrolls a `#site`
  container — in Jekyll use normal document anchors with
  `html { scroll-behavior: smooth; }`.
- **Portfolio cards** are links: `target="_blank" rel="noopener"` to each
  company's real URL (in `data.js`). Hover = 2px lift + deeper shadow.
- **Lucide icons** (`arrow-down`, `arrow-up-right`, `check-circle-2`,
  `pen-tool`, `route`, `compass`) render at 14–22px in `currentColor`.
- **Responsive:** the prototype is desktop-first at 1280px. For Jekyll, collapse
  the portfolio/pillars grids to 2-col then 1-col under ~960/640px, stack the
  About 2-col to 1-col, and reduce section padding to ~64px on mobile. Headlines
  already use `clamp()`.
- No loading/error/form states — this is a static marketing page.

## State Management
Effectively none. The only runtime state is the header's boolean `scrolled`
flag driven by scroll position. Everything else is static content — drive the
portfolio from `_data/portfolio.yml`.

---

## Portfolio data (source of truth — see `reference/src/data.js`)
Suggested `_data/portfolio.yml`:
```yaml
fund1:                       # group label: "Fund 1 · Closed", badge tone: blue
  - name: ProMentor
    sector: Youth sports tech
    blurb: Coaching and video platform for youth athletes and their families.
    url: https://www.promentor.com/
    note: Formerly TopYa!
  - name: Nami
    sector: App monetization
    blurb: Subscription and paywall infrastructure for mobile apps.
    url: https://www.namiml.com/
  - name: RevAir
    sector: Consumer hardware
    blurb: Reverse-air hair drying technology for the home.
    url: https://myrevair.com/
  - name: Teakoe
    sector: Beverage
    blurb: Craft loose-leaf and sparkling tea, brewed in Colorado.
    url: https://www.teakoe.com/
exits:                       # group label: "Exits", badge tone: solid
  - name: Venuetize
    sector: Venue tech
    blurb: Mobile-first guest engagement for stadiums and venues.
    url: https://www.venuetize.com/
    acquirer: Everi
past:                        # group label: "Past portfolio", badge tone: neutral
  - name: Glow
    sector: Smart energy
    blurb: The smart energy tracker for the home.
    url: https://www.indiegogo.com/projects/glow-the-smart-energy-tracker-for-your-home
  - name: Heal
    sector: Healthcare
    blurb: Doctor house calls and in-home primary care.
    url: https://heal.com/
  - name: WAL
    sector: Apparel
    blurb: Direct-to-consumer apparel and outdoor goods.
    url: https://www.walunderground.com/
```
> The blurbs above are concise descriptions of each company; confirm wording
> with the client before publishing (esp. WAL and Glow). Stats in the hero
> (8 backed · 1 exit) are derived from this list — keep them in sync.

---

## Assets
In `assets/` (copy into the Jekyll `assets/` tree):
- `logo/xcr-white.png` — reverse wordmark (use on blue/dark, e.g. header over
  hero, footer).
- `logo/xcr-black.png` — base wordmark (use on white/light).
- `logo/xcr-blueprint.png` — full blueprint treatment (grid + glare + hatch),
  for hero/OG imagery if a raster mark is wanted.
- `logo/xcr-avatar.png` — square mark, good as the favicon.
- `textures/blueprint-grid.png` — the tileable blue grid (the CSS `--bp-grid`
  motif reproduces this without an image; prefer CSS, keep the PNG as fallback /
  for OG images).

Prefer rebuilding the wordmark as live text (Saira Expanded) per the Wordmark
spec so it stays crisp and single-color; use the PNGs where raster is simpler.

## Files in this bundle
```
design_handoff_xcr_website_redesign/
├── README.md                          ← this spec
├── reference/
│   ├── xcr-website-redesign.html      ← self-contained finished design (open this)
│   └── src/                           ← section sources (read as spec, don't ship)
│       ├── Header.jsx.txt  Hero.jsx.txt  Portfolio.jsx.txt
│       ├── About.jsx.txt   Footer.jsx.txt
│       └── data.js
├── tokens/                            ← port these into the Jekyll stylesheet
│   ├── styles.css (entry) colors.css typography.css spacing.css effects.css
│   ├── fonts.css base.css
└── assets/
    ├── logo/ (xcr-white/black/blueprint/avatar .png)
    └── textures/blueprint-grid.png
```
