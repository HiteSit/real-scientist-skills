---
name: lab-notebook
description: "Layout and formats for science studies: the .science/ tree, STUDY.md, NOTEBOOK.md, probe folders and their states, commits and tags in a shared checkout, result briefs, plots and the study dashboard, and how to triage an off-axis ask or result. Use when starting, running, recording or promoting a probe, when reading or writing a study's notebook, or when the user asks something the current direction does not cover."
license: MIT
---

# Lab notebook

A **study** is one investigation around one question, living in its own folder `.science/<study>/`. It moves forward one **probe** at a time: a small run, chosen with the user once the results before it are in. The **lab notebook** is the study's single source of truth for where it stands.

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
    NOTEBOOK.md               branch, current direction, probes, ideas, probe notes, lessons, drift log
    dashboard.html            the study's one live dashboard, grown probe after probe
    dashboard.<ext>           the script that builds it
    probes/
      01-<slug>/              NN-<slug>, named once and never renamed
        README.md             builds on, intent, expectation, method, result, discussion, revisions
        .gitignore            this probe's heavy outputs
        figures/
        <scripts, small inputs, outputs>
```

Inside a probe folder, organise files however the probe needs; only `README.md`, `.gitignore` and `figures/` are fixed. The protocol's tree is a different matter: it is agreed with the human at promotion, never chosen alone.

A probe folder is named `NN-<slug>`, for example `03-protonation`. `NN` counts probes in run order from `01`, and a number is never reused, so the numbers stay a faithful history. `<slug>` says what the probe does. The name is fixed for the probe's whole life: its state lives in the notebook. Refer to a probe by this name everywhere; from another study, write `<study>/NN-<slug>`.

## Probe states

A probe's **state**, kept in the notebook's **Probes** table, says whether work on it continues. It says nothing about whether the result was good: that is the README's **Outcome**.

- **open**: the probe being worked on. Results arrive, get inspected, discussed, extended or redone while it is open, across as many sessions as the work needs. A probe waiting for a cluster job, or for the user to look at a figure, is open.
- **evidence**: its findings stand on record, and the study builds on them. This is the normal end of every probe, and it happens on its own: when the next probe starts, **look** at each open probe first. One whose results are in and recorded becomes `evidence`; one whose results are still out (a job not collected, outputs not yet inspected) stays `open`, and you tell the user so.
- **dropped**: set only when the user says so in plain words. Record what it rules out under **Dead ends**.
- **promoted**: set by `/promote`, when the probe's work moves into the protocol in the main tree.

An evidence probe can still be corrected (see **Revisions**). Several probes can be open at once, usually one waiting on a long job while the next one runs.

## STUDY.md

The **direction** the study started from. Written once when the study opens (see **Open a new study** in `experiment`). Its starting sections are **frozen**: never edited again, because the gap between them and the notebook's current direction is the record of how far the experiments moved the study.

Two sections at the end only grow, one line at a time:

- **Promoted**: one line per promotion, written by `promote`.
- **Outcome**: one line when the study closes: the answer, or why it was dropped, and the probes behind it.

```markdown
# <Study title>

**Spun off from:** <study and probe or ask that raised it, or omit>

## Question
## Starting hypothesis
<a best current guess, or "unknown">
## System
<the materials, targets, datasets the study works on>
## What an answer looks like
<the result that would settle the question, as observable as possible>
## Constraints
## Background
- [<page title>](../library/<slug>.md): <what it settled for the framing>
## First probe
<what it finds out, and why it comes first>
## Ideas
- <a probe or reading the user mentioned for later>

## Promoted
- `<step>` (<its place in the protocol>): from NN-<slug>, NN-<slug>; tag `<study>/promote-<step>`

## Outcome
<answered | dropped>: <one line, with the probes behind it>
```

## NOTEBOOK.md

Where the study stands, readable without opening any probe: the probes table on top, then a short description of every probe that has started. Each probe's full detail stays in its own README.

```markdown
# <Study title>: notebook

**Branch:** <the branch this study runs on>

## Current direction
<2 to 4 lines. Starts as a copy of STUDY.md's direction and drifts.>

## Probes
| # | Probe | State | Rev | Tag |
|---|-------|-------|-----|-----|
| 01 | [<slug>](probes/01-<slug>/README.md): <what it found> | evidence | 0 | `<study>/01-r0` |
| 02 | [<slug>](probes/02-<slug>/README.md): <what it found> | evidence | 1 | `<study>/02-r1` |
| 03 | [<slug>](probes/03-<slug>/README.md): <what it is finding out> | open | 0 | |

## Ideas
- <a probe or reading that could come next, and what raised it>

## Probe notes
### 02 <slug>
<3 to 6 lines: the operations it ran, in plain words; the key numbers; how the user read the result.>
- rev 1, fixing `<study>/02-r0`: <what was wrong>, caught by <the user | the agent>; <old outcome> → <new outcome>
- built on 01 before its rev 1: <rerun as rev N | kept>, the user's call

## Lessons
- <a rule that holds from now on, stated as what to do> (from 02 rev 1)

## Library
- [<page title>](../library/<slug>.md): <what this study takes from it>

## Dead ends
- <what was tried, which probe showed it fails, so nobody reruns it>

## Drift log
- [NN-slug](probes/NN-<slug>/README.md): <how the direction changed, and what in the result forced it>

## Spin-offs
- [<study>](../<study>/NOTEBOOK.md): <its question>, raised by <probe NN or the user's ask>, building on <the probes it starts from, or nothing>, run in <a new session or another agent>
```

**Branch** records where the study runs. Sessions check it on loading; when the user moves the study to another branch, update it in the study's next commit.

**Ideas** is the study's plan: a short list of what could come next, never a schedule. Only what the user agrees to goes on it. The next probe is chosen with the user when it is next, from the list, from the last result, or from a new thought; once started, it leaves the list.

A drift log entry is written whenever a decision changes the current direction, even slightly. A probe that followed the current direction is not drift. No entry means the direction held.

**Probe notes** get an entry when a probe starts, filled in as it runs and is discussed, and one line per revision. Write them for someone who never opened the README: what was done and what came out, not how.

**Lessons** are the study's memory of its mistakes. Every fix (see **Revisions**) adds one, phrased as the rule that would have prevented the mistake. Read them before starting any probe. A lesson that holds for the whole repo, not just this study, can go into `.science/SETUP.md` too, once the user agrees.

Keep the notebook to these sections. When it needs to say more about a probe, that belongs in the probe's README; when the story needs more, that belongs in the drift log.

## Off-axis

The study's **axis** is its current direction plus its open probes and ideas. An ask or a result is **off-axis** when the axis does not cover it: the user asks about a system, quantity or comparison the direction never names; a result can only be explained by a question the study does not hold; an open probe starts reaching for a second question.

Notice it whenever it happens, not only after a result: mid-run, mid-discussion, in a side question. Answering the user in prose is fine, but the answer alone is lost; every off-axis item lands in the notebook once the user confirms where.

Triage it into one of three homes, testing in this order:

1. **Reading**: it can be answered from existing sources, with nothing run. Check the library's `index.md` first: an existing page answers it at once. Otherwise call the Skill tool with `desk-research`.
2. **This study**: its answer would change this study's current direction. It goes under **Ideas**, or becomes the next probe if the user wants it now. An open probe stays one question: the new one is its own probe, never an enlargement of the open one.
3. **Another study**: its answer would leave this study's direction untouched, because it asks a different question, often about a different system. If an open study already covers it (a folder under `.science/` whose `STUDY.md` has no **Outcome**), it goes on that study's **Ideas** in that study's session. Otherwise it becomes a new study, with **Spun off from** filled in, and a line under **Spin-offs** here.

A new study runs **in parallel** with this one. Several studies at once is the normal shape of the work: each is its own folder and its own session, in the same checkout. A spin-off that builds on this study's probes names them (`<study>/NN-<slug>`) under **Builds on** and reads them in place. Promotion is not the way to share work between studies; promote a step only when it has earned a place in the protocol on its own merits.

A **session is bound to one study**, so the other study runs in a new session (or another agent, handed its `STUDY.md`): give the user the exact command, `/experiment <study>`, which opens the study when its folder does not exist yet. Then confirm with the user before creating anything: one question naming the item, the home you recommend and the test that put it there, worded so "yes" accepts it. Their answer decides. When the item changes this study's direction, it also gets a **Drift log** entry citing the ask or the probe that raised it.

## Probe README

```markdown
# NN: <probe title>

**Builds on:** <earlier probes, promoted protocol steps and library pages it uses, or "nothing">
**Intent:** <what this probe finds out, one or two lines>
**Expectation:** <the provisional result and why: prior evidence, a library source, or an agent guess; "unknown" when there is no defensible expectation>
**Test criterion:** <the observable criterion, only when explicitly testing a hypothesis or validating a method; otherwise omit>

## Method
<what was run, the exact commands, tool versions, seeds, inputs>

## Result
**Outcome:** completed | inconclusive
<the brief: see RESULTS.md>

## Discussion
<how the user read the result, the caveat that mattered, what it changed; ideas it added>

## Revisions
- rev 1, fixing `<study>/NN-r0`: <what was wrong>, caught by <the user | the agent>. <what changed>. Outcome <old> → <new>.
```

An **expectation** is the working picture before the run, a starting point to update rather than a target to achieve. Record it and its basis before running; "unknown" is valid, and needs no invented prediction or numerical confidence. Keep that original entry through revisions. What the evidence changes belongs in the result brief's **Update**.

For an explicit hypothesis test or method validation, also record the **Test criterion** before running and report whether it was met. Keep the criterion fixed so the comparison remains meaningful.

The **outcome** describes what the evidence lets us conclude: `completed` when a valid run answers the probe's stated intent, including a negative or surprising answer; `inconclusive` when the evidence cannot settle it. Agreement with the expectation does not decide the outcome. A crash or misconfigured run needs fixing, not a scientific interpretation.

## Revisions

A probe that was **run wrong** is fixed **in place**: a bug, a wrong input or parameter, a mistake in the analysis or the plots. The fix goes in the same folder, the probe reruns, and **Method**, **Result** and **Discussion** describe the corrected run. The README's **Revisions** section keeps one entry per fix, naming the tag of the wrong version, so the mistake stays on record; the wrong outputs survive in git under that tag.

A new question, a changed test criterion or a deliberate change of method is a new probe, not a revision. Updating the interpretation of a valid result is ordinary learning: record it under **Update**, without rerunning just to match the expectation.

Fixing a crash before the probe's first recorded result is part of running it, noted under **Method**. A revision is a fix after that. `/experiment` describes how to make one.

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

**Everything else a probe needs lives in the probe.** External database exports, published datasets, model checkpoints, intermediate results: the probe that first needs them fetches or produces them in its own folder, with a fetch script and the source (database and release, model repository, URL, access date, licence) in its README; heavy files go in its `.gitignore`. Later probes in the study read them there, by the probe's name. Data that should outlive the study reaches the protocol only through `/promote`, into the tree the user approves.

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
| Probe's first result recorded | `<study>: probe NN: <slug>: <outcome>` | `<study>/NN-r0` |
| Other work on a probe (started, job submitted, more results) | `<study>: probe NN: <slug>: <what changed>` | |
| Probe fixed | `<study>: fix NN: <slug>: <what was wrong> (<old outcome> → <new outcome>)` | `<study>/NN-r<R>` |
| Probe set to evidence or dropped | `<study>: probe NN: <slug>: <state>` | |
| Probe promoted | `<study>: promote NN: <step>` | `<study>/promote-<step>` |
| Study closed | `<study>: close` | `<study>/close` |
| Library page | `library: <slug>` | |
| Data added | `data: <slug>` | |

Tag right after the commit with `git tag <name>`. `git tag -l '<study>/*'` lists a study's milestones. The work is **local**: commits and tags stay in this repository, and reach a remote only when the user asks (`git push`, then `git push origin --tags`).
