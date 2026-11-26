# Set up or refresh the repo

## Inspect

Look at the repo before asking anything, so each question can lead with a recommended answer:

- **Git.** Identify the repository root, current branch and configured remotes. In a new folder, include local `git init` in the setup proposal; add no remote. Record the initial branch as the **home branch** only on first setup. A refresh on another branch does not change where the work began.
- `AGENTS.md`: is there already a `## Science skills` section?
- `.science/SETUP.md`: does a previous run's output exist? If so, this run updates it.
- Environment files (`environment.yml`, `pixi.toml`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `renv.lock`, and the like), job scripts for a scheduler, notebooks, existing data and output folders.
- `GLOSSARY.md`: domain vocabulary already agreed.

## Agree the missing details

Lead each section with the recommended answer so the user can accept it in a word. Skip a section when exploration already settled it.

**A. Domain.** Ask briefly what field the investigation belongs to (chemistry, bioinformatics, physics, ecology, ...), and in one line what kind of work the repo does in it. The answer frames every later question and is what the other science skills read to pick sensible defaults. Keep it short: this is a label and a sentence, not an interview.

**B. Environment.** Offer **conda** (`environment.yml`), **pixi** (`pixi.toml`) or **uv** (`pyproject.toml`). Prefer the existing manager. With no environment, recommend **pixi** for conda-forge or bioconda tools, or **uv** for pure Python. Identify the tools the probes need and the exact run command (`conda run -n <env>`, `pixi run`, or `uv run`). If the environment file is missing, include its creation in the setup proposal.

**C. Compute.** Local machine, a scheduler on a cluster, or both. For a scheduler, record how a job is submitted and how its status is checked, because long probes are submitted and resumed later.

**D. Data.** Inspect the existing data homes. Agree `data/` or `.science/data/` for user inputs and explicitly approved general source/prepared/reference datasets, following **Data** in `lab-notebook`: provenance, licence, checksums and one authority. Move or copy only on instruction, without leaving duplicate authoritative homes. Large/private data may stay externally with a locator. Normal fetched probe data stays local until approved promotion; workflow-specific databases and run outputs stay with their workflow.

**E. Heavy outputs.** The size above which files in a probe or the data folder are gitignored instead of committed. Recommend 5 MB.

**F. Plotting and dashboard.** The plotting library probes use for figures, and what builds the study dashboard. Recommend whatever the stack already uses for figures, and live HTML pages (see `lab-notebook`) for the dashboard. Record any domain viewer the pages need (for molecules, 3Dmol.js). Follow [lab-notebook: Presentation voices](../lab-notebook/SKILL.md#presentation-voices); record any agreed project override here.

**G. Promotion.** Agree repeated physical batch rollovers, technical reuse and preservation into actual working homes, not compulsory code porting or a `protocol/` folder. Read `lab-notebook` for cycle layout and stable-ID/current-location lookup. Recommend scoped authorized commits; independent steps separate, an agreed coupled relocation coherent. PR branch/worktree flow needs separate approval. Record publishing-hook and Git authorization constraints.

**H. Scientific map.** Record the shared root `scientific-map.html` and any approved build home, following [`scientific-map`](../scientific-map/SKILL.md). It uses the project's existing tools and needs no renderer install. Record any scope exclusions for the HTML.

## Confirm and write

Show the proposed setup and `AGENTS.md` block, highlighting changes to existing choices, files and data. After approval, apply only those changes. Leave existing environment files, project-specific settings, overrides and unrelated instructions intact unless the agreed change specifically updates them.

`.science/SETUP.md`:

```markdown
# Science setup

## Domain
<field>: <one line on the kind of work>

## Home branch
<the branch where science work started>

## Environment
<conda | pixi | uv>: <environment file>; run commands with `<command>`
## Compute
## Data
<data/ | .science/data/>; data kept elsewhere: <path or store, and how to reach it, or "none">
## Heavy outputs
Gitignore files above <N> MB.
## Plotting and dashboard
## Promotion
<commit | pull request>
<authorization and hook constraints; independent steps or agreed coupled cycle>
## Scientific map
<shared HTML path; existing runtime, build command and approved source home, or pending; study exclusions, if any>
```

On first setup, create the missing `.science/library/index.md` (`# Library`), `.science/library/log.md` (`# Library log` and a dated `setup | library started` entry), and the chosen data folder's `index.md` (`# Data`, one line per dataset). On refresh, preserve existing indexes, entries, pages, logs, datasets and studies. If an index is missing but material exists, inventory it and propose restoring the index from that material, not an empty replacement. Do not duplicate a setup log entry.

The `## Science skills` block goes into `AGENTS.md`, created if it does not exist. It states the conventions every science session follows:

- `.science/` is tracked by git, never gitignored. The stack is in `.science/SETUP.md`. The work is local: push only when the user asks.
- Each study is a folder, `.science/<study>/`. All studies share one branch and one checkout; several run at once, each in its own session.
- A session works on one study: `/experiment <study>` loads it (or opens it, when the folder does not exist yet), and work for another study starts in a new session.
- The checkout is shared: stay on the current branch and checkpoint only owned paths or hunks under `lab-notebook` **Commits and tags**. Keep history as it is: no stash, reset, amend or rebase.
- Commit messages start with the study (`<study>: …`); probes and fixes use `<study>/NN-r<R>`, cycle checkpoints `<study>/promotions/<title>-<date>`, with no tag overwrites. Check branch/worktree/tag inventory and publishing hooks; staging, commits and remote actions require authorization.
- Literature lives once in `.science/library/`. Shared data holds user inputs and approved general source/prepared/reference datasets with provenance and checksums. Fetched probe data stays local until approved promotion; workflow databases/run outputs stay with their workflow.
- Probe IDs/names persist across physical cycle moves; numbering continues across notebook/history, all cycles and current batch. `NOTEBOOK.md` hrefs locate current records, including unfinished probes in cycle `active/`. Follow `lab-notebook` **Ideas** for alternatives and their selection as ordinary probes; **Builds on** records dependencies.
- Promotion physically rolls numbered folders directly into cycle promoted/retained/discarded/active homes with optional relative asset links, preserving history and leaving `probes/` empty for new questions. No copies or compatibility aliases; technical promotion is a separate decision. Refresh the project map during promotion or on request with `scientific-map`.
- To review drift, update record formats or refresh this configuration, ask the user to run `/maintain-science` with that purpose.

Checkpoint only with repository authorization, staging exact setup, data metadata, environment and `AGENTS.md` paths and excluding heavy files: `science: setup`. If hooks publish, local commit approval alone is insufficient; record pending authorization instead.

Report the configuration created or changed and any pending checkpoint. When setting up a new repo, the next step is `/experiment <study>` to open the first study.
