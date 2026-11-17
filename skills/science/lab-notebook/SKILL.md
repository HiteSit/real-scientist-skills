---
name: lab-notebook
description: "Layout and formats for science studies: the .science/ tree, STUDY.md, NOTEBOOK.md, probe folders and their states, commits and tags in a shared checkout, result briefs, plots and the study dashboard, and how to triage an off-axis ask or result. Use when starting, running, recording or promoting a probe, when reading or writing a study's notebook, or when the user asks something the current direction does not cover."
license: MIT
---

# Lab notebook

A **study** is one investigation around one question, living in its own folder `.science/<study>/`. It moves forward one **probe** at a time: a small run, chosen with the user once the results before it are in. The **lab notebook** is the study's single source of truth for where it stands.

All studies share the current branch and checkout by default, each session writing only its own approved paths. The **library** (`.science/library/`, see `desk-research`) holds what is read. The **data folder** (`data/` or `.science/data/`, as `SETUP.md` records) holds user inputs and explicitly approved shared source/prepared/reference datasets. Other fetched or produced probe data stays in its probe until approved promotion.

The repo's stack (environment and its run command, compute, data, heavy-output threshold, home branch, promotion mode) is in `.science/SETUP.md`. Read it before writing any command or script.

## Presentation voices

Use these defaults unless the project agrees an override:

- **Operational voice:** write the whole `NOTEBOOK.md`, scientific maps and dashboards in concise operational English, aiming for approximately 80% ASD-STE100-inspired style. Use short sentences, active voice, one idea per sentence and consistent terms. This is a writing target, not formal compliance, certification or a measured score.
- **Narrative voice:** write `STUDY.md` in natural, direct prose: speak as you eat. Keep its existing structure and frozen scientific starting record.

Preserve technical terms, facts, numbers, units, scope, uncertainty, dates, status history, machine fields, IDs, links and verbatim quotations in both voices. A whole-notebook rewrite covers existing prose as well as new text; change its wording, not scientific results or recorded history. Preserve frozen statements and captured receipts. A style rewrite does not reopen `STUDY.md`'s starting record.

Record agreed project overrides in `.science/SETUP.md`.

## The tree

```
.science/
  SETUP.md                    the repo's science setup, written by setup-science
  library/                    what is read: papers, software docs, reviews; see desk-research
  data/                       user inputs and approved shared datasets, when configured here
  <study>/
    STUDY.md                  frozen starting direction; append-only Promoted and Outcome
    NOTEBOOK.md               question, current direction, map of threads and probes, log, ideas, lessons, drift log
    dashboard.html            the study's one live dashboard, grown probe after probe
    dashboard.<ext>           the script that builds it
    _promotion_<title>_<date>/ README, manifest.json and physical rollover; see promote
      promoted/              numbered probe directories, plus relative links to reusable homes
      retained/              numbered evidence directories, plus relative links as appropriate
      discarded/             numbered retired directories, preserved not deleted
      active/                numbered unfinished probes continuing under their existing IDs
    probes/                  current new-question batch; empty immediately after rollover
      NN-<slug>/             stable ID/name, later physically moved into an approved cycle
        README.md             thread, asked, plan, method, result, reading, revisions
        .gitignore            this probe's heavy outputs
        figures/
        <scripts, small inputs, outputs>
```

Inside a probe folder, organise files however the probe needs; only `README.md`, `.gitignore` and `figures/` are fixed. Main-tree homes follow the existing project and require the approved promotion tree; **protocol** names reusable steps, not a compulsory folder.

A probe folder is `NN-<slug>`, named once. Numbers are globally unique **within the study**: take one above the highest allocated ID across notebook, history, every cycle and current batch; never reset or reuse it. The physical record can move in an approved rollover, but keeps its ID/name and captured history. Resolve a record through its current `NOTEBOOK.md` href, not an assumed `probes/NN-<slug>/` path. From another study, use `<study>/NN-<slug>` and resolve through that study's notebook.

### Promotion cycles

A **promotion cycle** separates technical reuse from physical batch rollover. Read `promote` for its exact-tree gate: `_promotion_<title>_<date>/` holds `README.md`, `manifest.json` (large inventories may be compressed) and `promoted/`, `retained/`, `discarded/`, `active/`. Numbered probe directories move physically and directly into those four homes, alongside relative links to current workflows/shared data/archives where appropriate. One physical home per payload; no extra `records/` or cycle `probes/` layer. Retire/archive is not a scientific verdict.

After rollover, study-level `probes/` is empty (`.gitkeep` allowed), reserved for new questions and later rolled into another cycle. Existing unfinished probes continue under the same ID in cycle `active/`; neither partial technical promotion nor physical placement closes them. Do not refill `probes/` with copies or compatibility aliases. Moving records or changing dispositions in an existing cycle requires explicit approval; checkpoint tags preserve historical states. Current notebook hrefs and manifests give latest locations. Preserve frozen receipts/statements and complete captured history; update necessary live consumers and latest-location metadata only. Shared study assets remain outside the batch unless specifically approved.

Use [`scientific-map`](../scientific-map/SKILL.md) to view study records as a connected flow in the shared root HTML. Each in-scope study has a tab. The map is separate from study chart dashboards.

## Probe states

A probe's **state**, shown on its block in the notebook's **Map**, says whether work on it continues. It says nothing about whether the result was good: that is the README's **Outcome**.

- **open**: the probe being worked on. Results arrive, get inspected, discussed, extended or redone while it is open, across as many sessions as the work needs. A probe waiting for a cluster job, or for the user to look at a figure, is open.
- **evidence**: its findings stand on record and the study builds on them. Before starting a next probe, look at every open probe: when its agreed work is finished and results inspected/recorded, it becomes `evidence`; pending jobs, analysis, discussion or partial-component work leave it `open`. Say what remains. Promotion of one component does not close the rest.
- **dropped**: set only when the user says so in plain words. Record what it rules out under **Dead ends**.
- **promoted**: set by `/promote` only for an agreed whole-probe transfer into reusable main-tree homes. A partial component promotion leaves the probe open when work remains, with its scientific outcome/verdict unchanged.

An evidence probe can still be corrected (see **Revisions**). Several probes can be open at once, usually one waiting on a long job while the next one runs.

## STUDY.md

The **direction** the study started from. Written once when the study opens (see **Open a new study** in `experiment`). Its starting sections are **frozen**: never edited again, because the gap between them and the notebook's current direction is the record of how far the experiments moved the study. When part of the framing turns out wrong, correct it in the notebook, under **Current direction** with a **Drift log** entry; `STUDY.md` keeps the start the drift is measured from. Keep each section to a few lines: the evidence behind the framing belongs in library pages and probes.

Two sections at the end only grow, one line at a time:

- **Promoted**: append-only cycle entries naming components, sources, current homes, reuse limits, cycle record and checkpoint tag (or pending authorization). Organization alone never changes the scientific outcome.
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
- `<title>`: [cycle](_promotion_<title>_<date>/README.md); components <names>, from NN-<slug>; homes <paths>; limits <scope>; tag `<study>/promotions/<title>-<date>` (or pending)

## Outcome
<answered | dropped>: <one line, with the probes behind it>
```

## NOTEBOOK.md

The **map** of the study: the question, the threads the probes have opened on it, and for every probe what was asked of it and what it gave back. Readable without opening any probe; each probe's full record stays in its README, and the notebook carries its essence.

**The notebook follows the work.** Every operation on a probe updates the probe's README and the notebook in the same commit, as it happens: the probe's block on the **Map**, and one **Log** line. Operations are: a probe started, a job submitted, results collected, a result shown, a discussion, a fix, a state change. A session that ends leaves the notebook current, with no catching up for the next one.

```markdown
# <Study title>: notebook

**Question:** <the study's question, one line, from STUDY.md>
**Branch:** <the branch this study runs on>

## Current direction
<Include current promotion cycle and reusable homes, links to records, and still-open partial components when present. These are current pointers, not a replacement history.>
<A short paragraph: where the study is heading now and the working answer so far, with what is still open. Starts from STUDY.md's direction and drifts; rewritten whenever a result moves it.>

## Map

### <thread: a part of the question the probes work on>
<A few sentences of prose: what this thread asks, how its probes moved it, where it stands now.>

- **[NN <slug>](<current-record-relative-path>/README.md)** · <state> · rev <R> · `<study>/NN-r<R>`
  - **asked:** <the user's intent for the probe, as first given>
  - **expected:** <the expectation and its basis, or "unknown">
  - **found:** <the essential result, with the numbers that matter>
  - **means:** <what it means for the question> [inference]

  <Prose as the probe needs it: how it moved from what was asked, what the user made of it, revisions, what was built on it.>

## Log
- <MM-DD> · <NN> · <the essential, in a few words>

## Ideas
- <a probe or reading that could come next, and what raised it>

## Lessons
- <a rule that holds from now on, stated as what to do> (from NN rev 1)

## Library
- [<page title>](../library/<slug>.md): <what this study takes from it>

## Dead ends
- <what was tried, which probe showed it fails, so nobody reruns it>

## Drift log
- [NN-slug](<current-record-relative-path>/README.md): <how the direction changed, and what in the result forced it>

## Spin-offs
- [<study>](../<study>/NOTEBOOK.md): <its question>, raised by <probe NN or the user's ask>, building on <the probes it starts from, or nothing>, run in <a new session or another agent>
```

**Threads** are the parts of the question the probes have actually worked on, in the order they opened. They follow the study wherever it goes: a probe that goes somewhere no thread covers opens a new one, and a thread can end with a short line saying what closed it. However far the study drifts from its starting question, the map shows the path.

A **probe block** is the probe's essence, written from its README: the four labelled lines first, then prose as long as the probe needs. Fill each line as the probe gets there: **asked** and **expected** when it starts, **found** when results are in, **means** at the same moment. **means** is the agent's reading until the user's reading replaces it: mark it `[inference]`, and drop the mark once the discussion settles it.

**Log** lines are short: date, probe and essential event or result. Job IDs, paths and file counts go in the probe's **Method**.

**Branch** records where the study runs. Sessions check it on loading; when the user moves the study to another branch, update it in the study's next commit.

**Ideas** is the study's plan: a short list of what could come next, never a schedule. Only what the user agrees to goes on it. Alternative approaches to the same question stay here as unexecuted ideas. When the user chooses one, it becomes an ordinary next globally numbered probe and leaves the list. Its **Builds on** links name the evidence or reusable steps it uses; a later promotion cycle organizes its findings. An idea needs no separate directory, identifier or lifecycle. A different question follows **Off-axis** below.

A drift log entry is written whenever a decision changes the current direction, even slightly. A probe that followed the current direction is not drift. No entry means the direction held.

**Lessons** are the study's memory of its mistakes. Every fix (see **Revisions**) adds one, phrased as the rule that would have prevented the mistake. Read them before starting any probe. A lesson that holds for the whole repo, not just this study, can go into `.science/SETUP.md` too, once the user agrees.

Keep the notebook to these sections. What a probe needs to say goes in its block or its README; what the story needs goes in the thread prose or the drift log.

## Off-axis

The study's **axis** is its current direction plus its open probes and ideas. An ask or a result is **off-axis** when the axis does not cover it: the user asks about a system, quantity or comparison the direction never names; a result can only be explained by a question the study does not hold; an open probe starts reaching for a second question.

Notice it whenever it happens, not only after a result: mid-run, mid-discussion, in a side question. Answering the user in prose is fine, but the answer alone is lost; every off-axis item lands in the notebook once the user confirms where.

Triage it into one of three homes, testing in this order:

1. **Reading**: it can be answered from existing sources, with nothing run. Check the library's `index.md` first: an existing page answers it at once. Otherwise call the Skill tool with `desk-research`.
2. **This study**: its answer would change this study's current direction. It follows **Ideas** above. An open probe stays one question: the new one is its own globally numbered probe, never an enlargement of the open one.
3. **Another study**: its answer would leave this study's direction untouched, because it asks a different question, often about a different system. If an open study already covers it (a folder under `.science/` whose `STUDY.md` has no **Outcome**), it goes on that study's **Ideas** in that study's session. Otherwise it becomes a new study, with **Spun off from** filled in, and a line under **Spin-offs** here.

A new study runs **in parallel** with this one. Several studies at once is the normal shape of the work: each is its own folder and its own session, in the same checkout. A spin-off that builds on this study's probes names them (`<study>/NN-<slug>`) under **Builds on** and reads them in place. Promotion is not the way to share work between studies; promote a step only when it has earned a place in the protocol on its own merits.

A **session is bound to one study**, so the other study runs in a new session (or another agent, handed its `STUDY.md`): give the user the exact command, `/experiment <study>`, which opens the study when its folder does not exist yet. Then confirm with the user before creating anything: one question naming the item, the home you recommend and the test that put it there, worded so "yes" accepts it. Their answer decides. When the item changes this study's direction, it also gets a **Drift log** entry citing the ask or the probe that raised it.

## Probe README

```markdown
# NN: <probe title>

**Thread:** <the part of the question this probe works on; a new thread when it opens one>

## Asked
<The user's intent for this probe, as they gave it: what they wanted to learn or see, and the scope, data or limits they set. Written when the probe starts, in a few lines.>

## Plan
**Builds on:** <earlier probes, promoted protocol steps and library pages it uses, or "nothing">
**Expectation:** <the provisional result and why: prior evidence, a library source, or an agent guess; "unknown" when there is no defensible expectation>
**Test criterion:** <the observable criterion, only when explicitly testing a hypothesis or validating a method; otherwise omit>
<how the probe will answer what was asked, in a few lines>

## Method
<what was run, the exact commands, tool versions, seeds, inputs, job ids>

## Result
**Outcome:** completed | inconclusive
<the brief: see RESULTS.md>

## Reading
<What the result means for the question: the agent's reading marked [inference] until the discussion with the user settles it. How the probe moved away from what was asked, if it did. The caveat that mattered; ideas it raised.>

## Revisions
- rev 1, fixing `<study>/NN-r0`: <what was wrong>, caught by <the user | the agent>. <what changed>. Outcome <old> → <new>.
```

**Asked** is the user's starting intent, kept as first written. Probes move: the calculation shows something unplanned, the scope narrows, the question sharpens. Record that movement under **Reading**, and in the probe's block on the map, against **Asked**, so the notebook always shows both how the user imagined the probe and where it ended up.

An **expectation** is the working picture before the run, a starting point to update rather than a target to achieve. Start it from the **standard answer**: the answer most represented in your weights, the peak of the Gaussian you answer from. Say it plainly with its basis (evidence, a library page, or only what you learned), so the result can show whether reality sits at the peak or out in the tail, where the real findings usually are. "Unknown" is valid, and needs no invented prediction or numerical confidence. Keep that original entry through revisions. What the evidence changes, and how far from the standard answer it landed, belongs in the result brief's **Update**.

For an explicit hypothesis test or method validation, also record the **Test criterion** before running and report whether it was met. Keep the criterion fixed so the comparison remains meaningful.

The **outcome** describes what the evidence lets us conclude: `completed` when a valid run answers what was asked, including a negative or surprising answer; `inconclusive` when the evidence cannot settle it. Agreement with the expectation does not decide the outcome. A crash or misconfigured run needs fixing, not a scientific interpretation.

## Revisions

A probe that was **run wrong** is fixed at its notebook-linked physical record, whether in the current batch or an earlier cycle's `active/` or other approved disposition. It keeps its ID: correct the bug/input/analysis, rerun there and update current **Method**, **Result** and **Reading**. Keep captured receipts and frozen statements unmodified, adding corrections separately. **Revisions** names the old tag, what was wrong and what changed; tags preserve historical states. A fix does not authorize moving the record back to `probes/`.

A new question, a changed test criterion or a deliberate change of method is a new probe, not a revision. Updating the interpretation of a valid result is ordinary learning: record it under **Reading**, without rerunning just to match the expectation.

Fixing a crash before the probe's first recorded result is part of running it, noted under **Method**. A revision is a fix after that. `/experiment` describes how to make one.

## Data

The **data folder** holds user inputs and explicitly approved general source, prepared or reference datasets. `setup-science` records its existing or agreed location (`data/` or `.science/data/`) in `SETUP.md`; every skill reads that location. Below, `<data>` is that folder.

```
<data>/
  index.md                  one line per dataset: - [<slug>](<slug>/README.md): <what it is>
  <slug>/
    README.md               what it is and where it came from (lab, instrument, person, date); one row per file with its checksum
    .gitignore              files above the heavy-output threshold
    <files>
```

Data too large or too private for the repo stays where it is: its `<data>/<slug>/` folder holds the README with the path and how to reach it.

**Who writes it.** Add user data on their instruction, or general source/prepared/reference datasets through an explicitly approved setup or promotion tree. Each dataset has provenance, source/release, licence, preparation/fetch instructions and file checksums; indexes and consumers point to one authority. Stage only the approved dataset metadata and small files, with a scoped `data: <slug>` commit when authorized. Probes read shared datasets and never mutate them; changed prepared versions need a new recorded identity and provenance.

**Probe-local by default.** External exports, checkpoints and intermediates stay with the probe that first fetches or produces them, with the source and fetch command/script in its README and heavy files ignored. Later probes read that home directly. Promotion may approve a general dataset into shared data without retaining a duplicate authority. Workflow-specific databases, caches and run outputs stay with their workflow, not in shared data merely because they are large or useful.

## Heavy outputs

Every probe folder gets its own `.gitignore` listing outputs above the heavy-output threshold in `SETUP.md`. Commit everything needed to rerun the probe and read its result: scripts, small inputs, the README, the figures, small summary tables. The test: a fresh clone can rerun the probe and regenerate every ignored file from what is committed.

## Results

How to present a result (the brief, plots, the study dashboard) is in [RESULTS.md](RESULTS.md), and the patterns for live HTML pages (Python in the browser, adjustable text, molecular viewers) are in [LIVE-HTML.md](LIVE-HTML.md). Read it before inspecting any probe's output.

## Commits and tags

The checkout is **shared**: other sessions may be working in other study folders at this moment. Every science session keeps to these rules:

Read Git status, branch/worktree/tag inventory and hooks before a checkpoint. These conventions describe how an **authorized** commit is scoped, not permission to stage, commit or publish. A hook that pushes makes a nominally local commit a remote action needing authorization.

- **Stay on the current branch.** Changing branch moves every other session's files too.
- **Commit only approved exact paths**: `git add <paths>`, then `git commit -m "<message>" -- <paths>`. Include the session's study records and explicitly approved main-tree/data/map paths only; exclude heavy outputs and unrelated work.
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
| Promotion cycle | `<study>: promote NN: <title>` | `<study>/promotions/<title>-<date>` |
| Study closed | `<study>: close` | `<study>/close` |
| Library page | `library: <slug>` | |
| Data added | `data: <slug>` | |

When authorized, tag the checkpoint without overwriting an existing tag. Independent steps commit separately; an agreed coupled relocation can be one cycle commit. Branch inventory is read-only: no branch switch, merge, deletion, worktree creation/removal or remote action follows automatically. A specifically approved fast-forward or safe merged-ref cleanup preserves occupied worktrees, tags and unrelated work. Pull-request mode is an optional separately approved worktree flow. Record pending checkpoints honestly.
