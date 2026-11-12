---
name: setup-science
description: "Configure this repo for the science skills: initialise git if needed, record the scientific domain, the stack, the home branch, the data folder and the conventions in .science/SETUP.md, and start the shared library. Run once before first use of the other science skills."
disable-model-invocation: true
---

# Setup Science

Scaffold the per-repo configuration the science skills assume. Every other science skill reads `.science/SETUP.md` before writing a command or a script, so this is where the repo's science stack is written down once instead of re-explained every session.

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Look at the repo before asking anything, so each question can lead with a recommended answer:

- **Git.** If the folder is not a git repository, run `git init` and say so: the science skills keep every record in git. The work stays **local**: add no remote and push nothing unless the user asks.
- `git remote -v` and the current branch. The current branch becomes the **home branch**: where the science work started. It is a record, and studies may later run on other branches.
- `AGENTS.md`: is there already a `## Science skills` section?
- `.science/SETUP.md`: does a previous run's output exist? If so, this run updates it.
- Environment files (`environment.yml`, `pixi.toml`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `renv.lock`, and the like), job scripts for a scheduler, notebooks, existing data and output folders.
- `GLOSSARY.md`: domain vocabulary already agreed.

### 2. Ask, one section at a time

Lead each section with the recommended answer so the user can accept it in a word. Skip a section when exploration already settled it.

**A. Domain.** Ask briefly what field the investigation belongs to (chemistry, bioinformatics, physics, ecology, ...), and in one line what kind of work the repo does in it. The answer frames every later question and is what the other science skills read to pick sensible defaults. Keep it short: this is a label and a sentence, not an interview.

**B. Environment.** Offer the three managers and let the user choose: **conda** (`environment.yml`), **pixi** (`pixi.toml`) or **uv** (`pyproject.toml`). Recommend the one the repo already uses; with none, recommend **pixi** when the tools come from conda-forge or bioconda (most compiled scientific tools), and **uv** for a pure-Python stack. Ask which tools the probes run, create the environment file with them if it does not exist, and record the exact command that runs something in the environment (`conda run -n <env>`, `pixi run`, `uv run`).

**C. Compute.** Local machine, a scheduler on a cluster, or both. For a scheduler, record how a job is submitted and how its status is checked, because long probes are submitted and resumed later.

**D. Data.** The **data folder** holds the input data the user gives, the starting point of the work: their measurements, instrument output, sample sheets, structures. Ask where it should live, `data/` at the repo root or `.science/data/`; recommend `data/` when the repo already has one, else `.science/data/`. Then ask what data they have and where it is, and on their word move or copy it into `<data>/<slug>/` (see **Data** in `lab-notebook`). Data too large or too private for the repo stays where it is: its folder holds the README with the path and how to reach it. Data a probe fetches (database exports, datasets, model checkpoints) never goes here: it lives in the probe.

**E. Heavy outputs.** The size above which files in a probe or the data folder are gitignored instead of committed. Recommend 5 MB.

**F. Plotting and dashboard.** The plotting library probes use for figures, and what builds the study dashboard. Recommend whatever the stack already uses for figures, and live HTML pages (see `lab-notebook`) for the dashboard. Record any domain viewer the pages need (for molecules, 3Dmol.js).

**G. Promotion.** How a validated probe reaches the protocol: one commit on the current branch, or a pull request. Recommend **commit**; offer **pull request** only when the repo has a remote where changes are reviewed.

### 3. Confirm and write

Show the user a draft of `.science/SETUP.md` and of the `## Science skills` block, and let them edit before writing.

`.science/SETUP.md`:

```markdown
# Science setup

## Domain
<field>: <one line on the kind of work>

## Home branch
<the branch this setup ran on>

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
```

Start the library: `.science/library/index.md` with the heading `# Library` and nothing else, and `.science/library/log.md` with the heading `# Library log` and one entry, `## [<YYYY-MM-DD>] setup | library started`. Start the data folder at the chosen location: `index.md` with the heading `# Data` and one line per dataset moved in.

The `## Science skills` block goes into `AGENTS.md`, created if it does not exist. It states the conventions every science session follows:

- `.science/` is tracked by git, never gitignored. The stack is in `.science/SETUP.md`. The work is local: push only when the user asks.
- Each study is a folder, `.science/<study>/`. All studies share one branch and one checkout; several run at once, each in its own session.
- A session works on one study: `/experiment <study>` loads it, and work for another study starts in a new session.
- The checkout is shared: stay on the current branch, commit only your own paths (`git add <paths>` then `git commit -m "<message>" -- <paths>`), and keep history as it is: no stash, reset, amend or rebase. Retry when git's lock file is busy.
- Commit messages start with the study (`<study>: …`); probes and fixes are tagged `<study>/NN-r<R>`. Details are in the `lab-notebook` skill.
- Literature and documentation live once, in `.science/library/` (the `desk-research` skill keeps it). The user's input data lives in the data folder named in `.science/SETUP.md`; probes read it and never write to it. Everything else a probe loads, it fetches into its own folder.
- Lost, or the question or the notebook seem to have drifted: run `/ask-science`.

Commit `.science/`, the data folder, the environment file and `AGENTS.md` together: `science: setup`.

Done when the folder is a git repository, `.science/SETUP.md` exists with every section filled or marked "not used", the library has its index and log, the data folder has its index, and `AGENTS.md` carries the `## Science skills` block. Then tell the user the next step is `/to-study`.
