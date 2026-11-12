---
name: setup-science
description: "Configure this repo for the science skills: record the scientific domain, the stack, and the branch conventions in .science/SETUP.md. Run once before first use of the other science skills."
disable-model-invocation: true
---

# Setup Science

Scaffold the per-repo configuration the science skills assume. Every other science skill reads `.science/SETUP.md` before writing a command or a script, so this is where the repo's science stack is written down once instead of re-explained every session.

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Look at the repo before asking anything, so each question can lead with a recommended answer:

- `git remote -v` and the current branch. The current branch becomes the **base branch**: studies are cut from it and promotions return to it. Confirm it with the user.
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

**E. Heavy outputs.** The size above which a probe's output files are gitignored instead of committed. Recommend 5 MB.

**F. Plotting and dashboard.** The plotting library probes use for figures, and what builds the study dashboard. Recommend whatever the stack already uses for figures, and live HTML pages (see `lab-notebook`) for the dashboard. Record any domain viewer the pages need (for molecules, 3Dmol.js).

### 3. Confirm and write

Show the user a draft of `.science/SETUP.md` and of the `## Science skills` block, and let them edit before writing.

`.science/SETUP.md`:

```markdown
# Science setup

## Domain
<field>: <one line on the kind of work>

## Base branch
<the branch this setup ran on>

## Tools and environments
## Compute
## Data
## Heavy outputs
Gitignore probe outputs above <N> MB.
## Plotting and dashboard
```

The `## Science skills` block goes into `CLAUDE.md` if it exists, else `AGENTS.md`; if neither exists, ask which to create. It states the conventions every science session follows:

- `.science/` is tracked by git, never gitignored.
- Each study lives on its own `science/<study>` branch, one level deep (git refuses `science/<study>/...` beside `science/<study>`), cut from the base branch named in `.science/SETUP.md` or, for a spin-off, from its parent study's branch.
- A session works on one study: `/experiment <study>` loads it, and work for another study starts in a new session.
- Several studies can run at once, each in its own session, git worktree or agent.
- Lost, or the branches, the question or the notebook seem to have drifted: run `/ask-science`.
- One commit per probe on the study branch.
- Promoted protocol reaches the base branch only through a `protocol/<step>` branch and a pull request.
- A study branch never merges into the base branch; it merges the base branch in after each promotion.
- The stack is in `.science/SETUP.md`.

Commit both on the base branch (`science: setup`), so every study branch cut afterwards inherits them.

Done when `.science/SETUP.md` exists on the base branch with every section filled or marked "not used", and the agent docs carry the `## Science skills` block. Then tell the user the next step is `/to-study`.
