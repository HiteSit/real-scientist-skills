---
name: setup-science
description: "Configure this repo for the science skills: record the scientific domain, the stack, the home branch and the conventions in .science/SETUP.md, and start the shared library. Run once before first use of the other science skills."
disable-model-invocation: true
---

# Setup Science

Scaffold the per-repo configuration the science skills assume. Every other science skill reads `.science/SETUP.md` before writing a command or a script, so this is where the repo's science stack is written down once instead of re-explained every session.

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Look at the repo before asking anything, so each question can lead with a recommended answer:

- `git remote -v` and the current branch. The current branch becomes the **home branch**: where the science work started. It is a record, and studies may later run on other branches.
- `CLAUDE.md` / `AGENTS.md`: is there already a `## Science skills` section?
- `.science/SETUP.md`: does a previous run's output exist? If so, this run updates it.
- Environment files (`environment.yml`, `pixi.toml`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `renv.lock`, and the like), job scripts for a scheduler, notebooks, existing data and output folders.
- `GLOSSARY.md`: domain vocabulary already agreed.

### 2. Ask, one section at a time

Lead each section with the recommended answer so the user can accept it in a word. Skip a section when exploration already settled it.

**A. Domain.** Ask briefly what field the investigation belongs to (chemistry, bioinformatics, physics, ecology, ...), and in one line what kind of work the repo does in it. The answer frames every later question and is what the other science skills read to pick sensible defaults. Keep it short: this is a label and a sentence, not an interview.

**B. Tools and environments.** Which tools the probes run, and how their environment is created and activated. Record the exact activation command.

**C. Compute.** Local machine, a scheduler on a cluster, or both. For a scheduler, record how a job is submitted and how its status is checked, because long probes are submitted and resumed later.

**D. Data.** Where inputs live (in the repo, a shared drive, a remote store) and how a probe references them without hard-coding a personal path.

**E. Heavy outputs.** The size above which a probe's or the library's files are gitignored instead of committed. Recommend 5 MB.

**F. Plotting and dashboard.** The plotting library probes use for figures, and what builds the study dashboard. Recommend whatever the stack already uses for figures, and live HTML pages (see `lab-notebook`) for the dashboard. Record any domain viewer the pages need (for molecules, 3Dmol.js).

**G. Promotion.** How a validated probe reaches the protocol: one commit on the current branch, or a pull request. Recommend **commit**; recommend **pull request** when the repo already reviews changes through pull requests.

### 3. Confirm and write

Show the user a draft of `.science/SETUP.md` and of the `## Science skills` block, and let them edit before writing.

`.science/SETUP.md`:

```markdown
# Science setup

## Domain
<field>: <one line on the kind of work>

## Home branch
<the branch this setup ran on>

## Tools and environments
## Compute
## Data
## Heavy outputs
Gitignore files above <N> MB.
## Plotting and dashboard
## Promotion
<commit | pull request>
```

Start the library: `.science/library/index.md` with the heading `# Library` and nothing else, and `.science/library/log.md` with the heading `# Library log` and one entry, `## [<YYYY-MM-DD>] setup | library started`.

The `## Science skills` block goes into `CLAUDE.md` if it exists, else `AGENTS.md`; if neither exists, ask which to create. It states the conventions every science session follows:

- `.science/` is tracked by git, never gitignored. The stack is in `.science/SETUP.md`.
- Each study is a folder, `.science/<study>/`. All studies share one branch and one checkout; several run at once, each in its own session.
- A session works on one study: `/experiment <study>` loads it, and work for another study starts in a new session.
- The checkout is shared: stay on the current branch, commit only your own paths (`git add <paths>` then `git commit -m "<message>" -- <paths>`), and keep history as it is: no stash, reset, amend or rebase. Retry when git's lock file is busy.
- Commit messages start with the study (`<study>: …`); probes and fixes are tagged `<study>/NN-r<R>`. Details are in the `lab-notebook` skill.
- Literature and reference data live once, in `.science/library/`, shared by every study; the `desk-research` skill keeps it.
- Lost, or the question or the notebook seem to have drifted: run `/ask-science`.

Commit `.science/` and the agent doc together: `science: setup`.

Done when `.science/SETUP.md` exists with every section filled or marked "not used", the library has its index and log, and the agent docs carry the `## Science skills` block. Then tell the user the next step is `/to-study`.
