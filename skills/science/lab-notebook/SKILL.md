---
name: lab-notebook
description: "Layout and formats for science studies: the .science/ tree, STUDY.md, NOTEBOOK.md, the probe map, probe folders, commits and tags in a shared checkout, result briefs, plots and the study dashboard, and how to triage an off-axis ask or result. Use when planning, running, recording or promoting a probe, when reading or writing a study's notebook, or when the user asks something the current direction does not cover."
---

# Lab notebook

A **study** is one investigation around one question, living in its own folder `.science/<study>/`. It moves forward one **probe** at a time: a small run, sized to one session, planned only once the results it depends on are in. The **lab notebook** is the study's single source of truth for where it stands.

All studies live on one branch, in one checkout. Several studies run at once as separate sessions in that checkout, each writing only inside its own folder. Two shared places sit beside the studies. The **library** (`.science/library/`, see `desk-research`) holds what is read: papers, software documentation, reviews. The **data folder** (`data/` or `.science/data/`, as `SETUP.md` records; see **Data**) holds the input data the user gives. Everything else a probe loads or makes, it fetches or produces in its own folder.

The repo's stack (environment and its run command, compute, data, heavy-output threshold, home branch, promotion mode) is in `.science/SETUP.md`. Read it before writing any command or script.

## The tree

```
.science/
  SETUP.md                    the repo's science setup, written by setup-science
  library/                    what is read: papers, software docs, reviews; see desk-research
  data/                       the user's input data, when SETUP.md puts it here instead of data/ at the root; see Data
  <study>/
    STUDY.md                  the starting direction, frozen; Promoted and Outcome lines added at the end
    NOTEBOOK.md               branch, current direction, probe map, probe notes, lessons, drift log
    dashboard.html            the study's one live dashboard, grown probe after probe
    dashboard.<ext>           the script that builds it
    probes/
      01-r0-held-<slug>/      NN-r<revisions>-<state>-<slug>, see below
        README.md             blocked by, intent, prediction, method, result, decision
        .gitignore            this probe's heavy outputs
        figures/
        <scripts, small inputs, outputs>
```

Inside a probe folder, organise files however the probe needs; only `README.md`, `.gitignore` and `figures/` are fixed. The protocol's tree is a different matter: it is agreed with the human at promotion, never chosen alone.

Probe folders are named `NN-r<R>-<state>-<slug>`, for example `03-r2-failed-protonation`:

- `NN` counts probes in run order from `01`. A number is never reused or renumbered: a dropped probe keeps its number, so the numbers stay a faithful history.
- `r<R>` is how many times the probe was fixed in place (see **Revisions**), from `r0`.
- `<state>` is where the probe stands now, one of six words: `running` while it runs; then its verdict, `held`, `failed` or `inconclusive`; unless the user decided **promote** (`promoted`) or **drop** (`dropped`, a dead end), which override the verdict. The README keeps the original verdict. A fix sets the state to the new verdict, so a promoted probe that gets fixed stops being `promoted` until it is promoted again.
- `<slug>` says what the probe does, and never changes.

The short form `NN-<slug>` (`03-protonation`) is the probe's stable name: use it in plain-text references (**Blocked by**, the drift log, **Promoted** lines, commit messages). From another study, write `<study>/NN-<slug>`.

**Renaming.** Whenever the revision count or the state changes, rename the folder with `git mv` in the same commit as the change: the probe commit, a fix, a promotion, a drop. In that commit, search `.science/<study>/` for the old folder name and rewrite every link to it (the notebook, other probes' READMEs, the dashboard and its script), so no link breaks. Other studies and the library refer to probes by stable name only, so a rename never reaches outside the study's folder.

## STUDY.md

The **direction** the study started from. Written once by `to-study`. Its starting sections are **frozen**: never edited again, because the gap between them and the notebook's current direction is the record of how far the experiments moved the study.

Two sections at the end only grow, one line at a time:

- **Promoted**: one line per promotion, written by `promote`.
- **Outcome**: one line when the study closes: the answer, or why it was dropped, and the probes behind it.

```markdown
# <Study title>

**Spun off from:** <study and probe or ask that raised it, or omit>

## Question
## Starting hypothesis
## System
<the materials, targets, datasets the study works on>
## What an answer looks like
<the result that would settle the question, as observable as possible>
## Constraints
## Background
- [<page title>](../library/<slug>.md): <what it settled for the framing>
## Starting probe map
<the probe map table as first charted, every row planned: see below>

## Promoted
- `<step>` (<its place in the protocol>): from NN-<slug>, NN-<slug>; tag `<study>/promote-<step>`

## Outcome
<answered | dropped>: <one line, with the probes behind it>
```

## NOTEBOOK.md

Where the study stands, readable without opening any probe: the probe map on top, then a short description of every probe that has started. Each probe's full detail stays in its own README.

```markdown
# <Study title>: notebook

**Branch:** <the branch this study runs on>

## Current direction
<2 to 4 lines. Starts as a copy of STUDY.md's direction and drifts.>

## Probe map
**Phases:** 1 <title>: <what it answers or prepares> · 2 <title>: <...>

| # | Probe | Phase | Blocked by | Status | Rev | Tag |
|---|-------|-------|------------|--------|-----|-----|
| 01 | [<slug>](probes/01-r0-held-<slug>/README.md): <what it finds out> | 1 | | held | 0 | `<study>/01-r0` |
| | [<slug>](../library/<slug>.md) (research): <the question it answers> | 1 | | done | | |
| 02 | [<slug>](probes/02-r1-inconclusive-<slug>/README.md): <what it finds out> | 2 | 01-<slug>, <research slug> | inconclusive | 1 | `<study>/02-r1` |
| | <slug>: <what it finds out> | 2 | 02-<slug> | planned | | |

## Probe notes
### 02 <slug>
<3 to 6 lines: the operations it ran, in plain words; the key numbers; the user's decision and why.>
- rev 1, fixing `<study>/02-r0`: <what was wrong>, caught by <the user | the agent>; <old verdict> → <new verdict>
- built on 01 before its rev 1: <rerun as rev N | kept>, the user's call

## Lessons
- <a rule that holds from now on, stated as what to do> (from 02 rev 1)

## Not yet mapped
- <a question you can tell is coming but cannot yet phrase as a probe>

## Library
- [<page title>](../library/<slug>.md): <what this study takes from it>

## Dead ends
- <what was tried, which probe showed it fails, so nobody reruns it>

## Drift log
- [NN-slug](probes/<the probe's folder>/README.md): <how the direction changed, and what in the result forced it>

## Spin-offs
- [<study>](../<study>/NOTEBOOK.md): <its question>, raised by <probe NN or the user's ask>, building on <the probes it starts from, or nothing>, run in <a new session or another agent>
```

**Branch** records where the study runs. Sessions check it on loading; when the user moves the study to another branch, update it in the study's next commit.

A drift log entry is written whenever a decision changes the current direction or reshapes the probe map (a phase added, dropped or reordered, a planned row dropped), even slightly. A probe that ran as planned is not drift. No entry means the direction held.

**Probe notes** get an entry when a probe starts, filled in as it runs and is decided, and one line per revision. Write them for someone who never opened the README: what was done and what came out, not how.

**Lessons** are the study's memory of its mistakes. Every fix (see **Revisions**) adds one, phrased as the rule that would have prevented the mistake. Read them before planning any probe. A lesson that holds for the whole repo, not just this study, can go into `.science/SETUP.md` too, once the user agrees.

## The probe map

The **probe map** is the study's plan and its history in one table: the probes that can be stated sharply today, the ones running, and every one that has run. Probes work like tickets: each declares what **blocks** it, and the order of execution follows from those edges. The map is provisional by nature: every result may reorder it, add to it or prune it.

- **#**: empty while planned. A probe gets its number when it starts, and the slug becomes a link to its folder.
- **Phase**: a stage of the work (the probes that answer one sub-question, or prepare what later phases need). Phases run in the order of the **Phases** line; rows are ordered by phase, then by run order.
- **Blocked by**: the probes and research rows whose results this one needs, by stable name. The **frontier** is every planned row whose blockers have all been decided (probes) or are `done` (research).
- **Status**: `planned`, then the same word as the probe's folder name once it starts (see **The tree**): `running`, `held`, `failed`, `inconclusive`, `promoted` or `dropped`. A planned row the results made pointless becomes `dropped` too and stays, with a drift log entry; it never had a folder. Research rows go `planned` → `running` → `done`.
- **Rev**: how many times the probe was fixed in place (see **Revisions**); `0` for a probe never fixed.
- **Tag**: the git tag of the probe's latest run or fix, `<study>/NN-r<R>` (see **Commits and tags**). The name is known before the commit, so write it in the same commit that creates the tag. `git show <tag>` returns the probe exactly as it stood.

A **research row**, marked `(research)`, is a question answered from existing sources instead of a run: no number, no prediction, answered by `desk-research` as a page in the library, and linked to that page once `done`. Probes list it under **Blocked by** like any other row.

Probes run **one at a time** by default, because each result decides the next. Two probes may run at once only when both are on the frontier, neither blocks the other, and the user agrees; typically two long cluster jobs. Each still gets its own inspection, checkpoint and commit.

Chart only what can be stated sharply. A question you can see coming but cannot yet phrase as a probe goes under **Not yet mapped**, and graduates into the map once a result makes it sharp.

**The user decides what goes on the map.** Next probes come out of a conversation, usually started by the user ("what should we do next?", "we are running X, but the aim is Y"): work them out with the user in rounds, the way `grilling` does, and add as `planned` rows only the probes they agree to.

## Off-axis

The study's **axis** is its current direction plus the probe map. An ask or a result is **off-axis** when the axis does not cover it: the user asks about a system, quantity or comparison the direction never names; a result can only be explained by a question the map does not hold; a probe in progress starts reaching for a second question.

Notice it whenever it happens, not only at a checkpoint: mid-run, mid-grilling, in a side question. Answering the user in prose is fine, but the answer alone is lost; every off-axis item lands in the notebook once the user confirms where.

Triage it into one of three homes, testing in this order:

1. **Research row**: it can be answered from existing sources, with nothing run. Check the library's `index.md` first: an existing page answers it at once. Otherwise it goes on the map marked `(research)`.
2. **New probe in this study**: its answer would change this study's current direction or map. It goes on the map, or under **Not yet mapped** if it cannot be phrased sharply yet. A probe in progress stays one question: the new one is its own probe, never an enlargement of the running one.
3. **Another study**: its answer would leave this study's direction untouched, because it asks a different question, often about a different system. If an open study already covers it (a folder under `.science/` whose `STUDY.md` has no **Outcome**), it goes on that study's map in that study's session. Otherwise it becomes a new study through `/to-study`, with **Spun off from** filled in, and a line under **Spin-offs** here.

A new study runs **in parallel** with this one. Several studies at once is the normal shape of the work: each is its own folder and its own session, in the same checkout. A spin-off that builds on this study's probes lists them by stable name (`<study>/NN-<slug>`) under **Blocked by** and reads them in place. Promotion is not the way to share work between studies; promote a step only when it has earned a place in the protocol on its own merits.

A **session is bound to one study**, so the new study runs in a new session (or another agent, handed its `STUDY.md`): give the user the exact command to start it (`/to-study` for a new study, `/experiment <study>` for an open one). Then confirm with the user before creating anything: one question naming the item, the home you recommend and the test that put it there, worded so "yes" accepts it. Their answer decides. When the item is new to this study (a new probe or research row), adding it reshapes the map, so it also gets a **Drift log** entry citing the ask or the probe that raised it.

## Probe README

```markdown
# NN: <probe title>

**Blocked by:** <the probes and research rows it needs, by stable name, or "nothing">
**Uses:** <promoted protocol steps and library pages it relies on, or omit>
**Intent:** <what this probe finds out, one or two lines>
**Prediction:** <what the result shows if the current belief is right, stated so it can be checked>

## Method
<what was run, the exact commands, tool versions, seeds, inputs>

## Result
**Verdict:** held | failed | inconclusive
<the brief: see RESULTS.md>

## Decision
continue | branch | drop | promote: <the human's call and why>
**Next:** <the probe this points to, if any>

## Revisions
- rev 1, fixing `<study>/NN-r0`: <what was wrong>, caught by <the user | the agent>. <what changed>. Verdict <old> → <new>; decision <kept | changed from ...>.
```

**Blocked by** matches the probe's row on the map. A **prediction** turns "look at the result" into a binary check. Write it before running, never after, and never rewrite it in a revision.

## Revisions

A probe that was **run wrong** is fixed **in place**: a bug, a wrong input or parameter, a mistake in the analysis or the plots. The fix goes in the same `NN` folder, the probe reruns, and **Method**, **Result** and (if the user changes it) **Decision** describe the corrected run. The README's **Revisions** section keeps one entry per fix, naming the tag of the wrong version, so the mistake stays on record; the wrong outputs survive in git under that tag.

A new question, a changed prediction or a deliberate change of plan is never a revision: it is a new probe.

Fixing a crash before the probe's first commit is part of running it, noted under **Method**. A revision is a fix after that commit. `/experiment` describes how to make one.

## Data

The **data folder** holds the **input data the user gives**: their measurements, instrument output, sample sheets, structures, the starting set the work begins from. Nothing else. `setup-science` asks where it lives, `data/` at the repo root or `.science/data/`, and records the choice in `SETUP.md`; every skill reads the location from there. Below, `<data>` is that folder.

```
<data>/
  index.md                  one line per dataset: - [<slug>](<slug>/README.md): <what it is>
  <slug>/
    README.md               what it is and where it came from (lab, instrument, person, date); one row per file with its checksum
    .gitignore              files above the heavy-output threshold
    <files>
```

Data too large or too private for the repo stays where it is: its `<data>/<slug>/` folder holds the README with the path and how to reach it.

**Who writes it.** Only the user's own data goes in, at setup or at any later point (new measurements arriving mid-study, say). The agent adds it only when the user hands it data ("put this file in the data folder"), one `data: <slug>` commit per dataset, limited to `<data>/<slug>/` and `<data>/index.md`. Probes **read** from it by repo-relative path and never write to it.

**Everything else a probe needs lives in the probe.** External database exports, published datasets, model checkpoints, intermediate results: the probe that first needs them fetches or produces them in its own folder, with a fetch script and the source (database and release, model repository, URL, access date, licence) in its README; heavy files go in its `.gitignore`. Later probes in the study read them there, by the probe's stable name. Data that should outlive the study reaches the protocol only through `/promote`, into the tree the user approves.

## Heavy outputs

Every probe folder gets its own `.gitignore` listing outputs above the heavy-output threshold in `SETUP.md`. Commit everything needed to rerun the probe and read its result: scripts, small inputs, the README, the figures, small summary tables. The test: a fresh clone can rerun the probe and regenerate every ignored file from what is committed.

## Results

How to present a result (the brief, plots, the study dashboard) is in [RESULTS.md](RESULTS.md), and the patterns for live HTML pages (Python in the browser, adjustable text, molecular viewers) are in [LIVE-HTML.md](LIVE-HTML.md). Read it before inspecting any probe's output.

## Commits and tags

The checkout is **shared**: other sessions may be working in other study folders at this moment. Every science session keeps to these rules:

- **Stay on the current branch.** Changing branch moves every other session's files too.
- **Commit only your own paths**: `git add <paths>`, then `git commit -m "<message>" -- <paths>`. A study session's paths are its own `.science/<study>/` folder, plus the protocol files of a promotion; the library's are `.science/library/`; the user's data, `<data>/<slug>/` and `<data>/index.md`. Changes elsewhere in the tree belong to someone else: leave them as they are.
- **Add history, keep it**: every correction is a new commit. Stash, reset, amend and rebase reach into other sessions' work.
- When git reports its lock file (`index.lock`) is busy, another session is committing: wait a few seconds and retry.

Messages start with the study, so `git log --grep '^<study>:'` shows one study's history:

| Event | Commit message | Tag |
|---|---|---|
| Study opened | `<study>: open` | `<study>/open` |
| Probe decided | `<study>: probe NN: <slug>: <verdict>` | `<study>/NN-r0` |
| Long job submitted | `<study>: probe NN: <slug>: running` | |
| Probe fixed | `<study>: fix NN: <slug>: <what was wrong> (<old verdict> → <new verdict>)` | `<study>/NN-r<R>` |
| Probe promoted | `<study>: promote NN: <step>` | `<study>/promote-<step>` |
| Study closed | `<study>: close` | `<study>/close` |
| Library page | `library: <slug>` | |
| Data added | `data: <slug>` | |

Tag right after the commit with `git tag <name>`. `git tag -l '<study>/*'` lists a study's milestones. The work is **local**: commits and tags stay in this repository, and reach a remote only when the user asks (`git push`, then `git push origin --tags`).
