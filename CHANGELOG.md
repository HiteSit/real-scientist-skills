# Changelog

This fork has no versions; git history is the record. Matt Pocock's releases are in [his CHANGELOG](https://github.com/mattpocock/skills/blob/main/CHANGELOG.md) and arrive here through the weekly upstream sync.

## 2026-11-08 (later)

- Rewrote the README in plain language under the title "Skills for Real Scientists". It still covers every topic, and Matt's skill list now links to his README.
- Moved the step-by-step science flow and the full folder layout to `skills/science/README.md`.
- Moved the fork mechanics (customizations, weekly sync, hooks) to `MAINTAINING.md`, which the sync now keeps as the fork's own.

## 2026-11-08

- Forked `mattpocock/skills` at `4ae2317` (v1.3.2).
- Added the `science/` bucket: `setup-science`, `to-study`, `experiment`, `promote`, `lab-notebook`, `desk-research`.
- Added customizations (`customizations/` → `customized/`, built by `scripts/build.sh`) for `grilling` and `chief-of-staff`.
- Added the weekly upstream sync (`scripts/sync-upstream.sh`, `.github/workflows/sync-upstream.yml`) and the maintainer hooks (`.githooks/`).
- Removed Matt's plugin packaging, release tooling and issue bots (listed in `fork-removed.txt`).
