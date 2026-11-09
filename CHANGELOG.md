# Changelog

This fork has no versions; git history is the record. Matt Pocock's releases are in [his CHANGELOG](https://github.com/mattpocock/skills/blob/main/CHANGELOG.md) and arrive here through the weekly upstream sync.

## 2026-11-09

- Science studies now start from a configurable base branch recorded in `.science/SETUP.md`. `/experiment <study>` loads a study in any session, and each session stays with one study.
- `STUDY.md` gains **Promoted** and **Outcome** lines, which reach the base branch through promotion.
- The probe map is now one table holding both the plan and the history (phase, after, status, revisions, latest commit), with **Probe notes** and **Lessons** below it. Only the probes the user agrees to go on the map.
- A probe that was run wrong is fixed in place: there is a **Revisions** entry in its README, a `fix NN:` commit, and a lesson, and the user is asked about every later probe built on the old result.
- Probe folders are now named `NN-r<fixes>-<state>-<slug>` (for example `03-r2-failed-protonation`). When the fix count or state changes, the folder is renamed and every link to it is updated in the same commit. Plain-text references use the stable `NN-<slug>`.

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
