# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single-page static firm site for XCR Ventures, built with Jekyll 4.4.1 (Ruby 3.4.8, see `.ruby-version`). One vertical scroll: Header → Hero → Portfolio → About → Footer, on the XCR "blueprint" brand system. The firm is **not currently making new investments**, so there is intentionally no funding/contact flow (one quiet LinkedIn link in the footer).

## Commands

```sh
bundle exec jekyll serve        # local dev server with live rebuild
ruby site.rb start              # equivalent to `jekyll serve --host 0.0.0.0`
```

No tests or linters; the only build step is `jekyll build` (run implicitly by `serve`). Output goes to `_site/` (gitignored).

## Architecture

The page is assembled from includes; content is data-driven where it repeats.

- `_layouts/default.html` — the shell. Loads Google Fonts (Saira / Saira Expanded / Space Mono) and **Lucide icons** (CDN) plus the compiled stylesheet, then renders `site-header` → `{{ content }}` → `site-footer`. Contains the small inline script that (a) calls `lucide.createIcons()` and (b) toggles `.is-scrolled` on the header past 12px of scroll.
- `index.html` — front matter + three includes in order: `hero.html`, `portfolio.html`, `about.html`. Header and footer come from the layout.
- `_includes/` — `site-header`, `hero`, `portfolio`, `about`, `site-footer`, and `wordmark.html` (the reusable XCR wordmark, built as live text — pass `size` and optional `tone=white|ink|blue`; omit `tone` to inherit the parent color, as the header does on scroll).
- `_data/portfolio.yml` — **source of truth for the Portfolio section.** Groups (Active / Exits / Past portfolio — the whole book is Fund 1, which is closed) each carry a `tone` (badge style) and a `companies` list. Companies without a `url` (no live site) render as a non-clickable card. `portfolio.html` loops it. The hero stat band ("8 companies backed · 1 exit") is **hand-coded in `hero.html` and derived from this list — keep them in sync** when adding/removing companies.

### Styling

Styles compile through Jekyll's SCSS pipeline:

- `assets/css/main.scss` — the entry point (has the required empty front matter). It only `@use`s the two partials below; Jekyll compiles it to `/assets/css/main.css`, which the layout links.
- `_sass/_xcr-tokens.scss` — the brand design tokens as CSS custom properties (color, type, spacing, radii, shadows, blueprint motifs). Ported verbatim from the design system.
- `_sass/_xcr-site.scss` — base reset, brand helpers (`.xcr-eyebrow`, `.xcr-wordmark`), and every section/component class. Reference values (exact px/colors) come from the handoff; edit here for any visual change.

The blueprint grid/vignette backgrounds are pure CSS (`--bp-grid-image`, `--bp-vignette`), not images. Fidelity is high — measurements are exact, so match existing tokens/classes rather than introducing new magic numbers.

## Design source

`design_handoff_xcr_website_redesign/` is the hi-fi spec this site was built from: `reference/src/*.jsx.txt` (per-section markup spec), `reference/xcr-website-redesign.html` (a Babel-in-browser prototype — the look-and-feel source of truth), `tokens/*.css`, and brand `assets/`. It is **excluded from the Jekyll build** (`_config.yml`) — treat it as documentation, not site code.

## Deploy / hosting

Hosted on **GitHub Pages**; `CNAME` points to `www.xcrventures.com`. Deploy by pushing to the repo — GitHub Pages builds and serves it; no manual build/upload. The `site.rb deploy` task (`aws s3 sync … s3://xcrventures.com`) is **legacy** from a previous S3 setup and is not the current path.

The footer copyright year lives in `_includes/site-footer.html` (currently 2026, in the `© XCR VENTURES, LLC. … · SCALE 1:1` line) — update it there; "update year" is a recurring commit.
