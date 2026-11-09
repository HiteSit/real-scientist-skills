---
name: lab-notebook
description: "Layout and formats for a science study: the .science/ tree, STUDY.md, NOTEBOOK.md, probe folders, result briefs, plots and the study dashboard, and how to triage an off-axis ask or result. Use when planning, running, recording or promoting a probe, when reading or writing a study's notebook, or when the user asks something the current direction does not cover."
---

# Lab notebook

A **study** is one investigation around one question, living on its own `science/<study>` branch. It moves forward one **probe** at a time: a small run of protocol, sized to one session, planned only once the previous probe's result is in. The **lab notebook** is the study's single source of truth for where it stands.

The repo's stack (tools, environments, compute, data locations, heavy-output threshold) is in `.science/SETUP.md`. Read it before writing any command or script.

## The tree

```
.science/
  SETUP.md                    on the base branch, written by setup-science
  <study>/                    on science/<study>
    STUDY.md                  the starting direction, frozen; reaches the base branch with the first promotion
    NOTEBOOK.md               current direction, probe map table, probe notes, lessons, drift log
    dashboard.html            the study's one live dashboard, grown probe after probe
    dashboard.<ext>           the script that builds it
    research/                 desk research items, see desk-research
      <slug>.md               prose only
      <slug>/                 README.md plus data files of any format
    probes/
      01-<slug>/
        README.md             intent, prediction, method, result, decision
        .gitignore            this probe's heavy outputs
        figures/
        <scripts, small inputs, outputs>
```

Inside a probe folder, organise files however the probe needs; only `README.md`, `.gitignore` and `figures/` are fixed. The protocol's tree is a different matter: it is agreed with the human at promotion, never chosen alone.

Probe folders are `NN-<slug>`: `NN` counts probes in run order from `01`, `<slug>` says what the probe does. A number is never reused or renumbered: a dropped probe keeps its number, so the numbers stay a faithful history.

## STUDY.md

The **direction** the study started from. Written once by `to-study`. Its starting sections are **frozen**: never edited again, because the gap between them and the notebook's current direction is the record of how far the experiments moved the study.

Two sections at the end only grow, one line at a time:

- **Promoted**: one line per promotion, written by `promote` identically on `protocol/<step>` and on the study branch. The first promotion carries `STUDY.md` to the base branch, so the base branch shows every study that has produced protocol.
- **Outcome**: one line when the study closes: the answer, or why it was dropped, and the probes behind it. Commit it on the study branch (`study: <study>: close`). If the study has promoted anything, commit the same line on the base branch too.

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
## Starting probe map
<the probe map table as first charted, every row planned: see below>

## Promoted
- `<step>` (`protocol/<step>`): from <NN-slug>, <NN-slug>

## Outcome
<answered | dropped>: <one line, with the probes behind it>
```

## NOTEBOOK.md

Where the study stands, readable without opening any probe: the probe map table on top, then a short description of every probe that has started. Each probe's full detail stays in its own README.

```markdown
# <Study title>: notebook

## Current direction
<2 to 4 lines. Starts as a copy of STUDY.md's direction and drifts.>

## Probe map
**Phases:** 1 <title>: <what it answers or prepares> · 2 <title>: <...>

| # | Probe | Phase | After | Status | Rev | Commit |
|---|-------|-------|-------|--------|-----|--------|
| 01 | [<slug>](probes/01-<slug>/README.md): <what it finds out> | 1 | | held | 0 | `a1b2c3d` |
| | [<slug>](research/<slug>.md) (research): <the question it answers> | 1 | | done | | `b2c3d4e` |
| 02 | [<slug>](probes/02-<slug>/README.md): <what it finds out> | 2 | <slug> | inconclusive | 1 | pending |
| | <slug>: <what it finds out> | 2 | <slug>, <slug> | planned | | |

## Probe notes
### 02 <slug>
<3 to 6 lines: the operations it ran, in plain words; the key numbers; the user's decision and why.>
- rev 1, fixing `<hash>`: <what was wrong>, caught by <the user | the agent>; <old verdict> → <new verdict>
- built on 01 before its rev 1: <rerun as rev N | kept>, the user's call

## Lessons
- <a rule that holds from now on, stated as what to do> (from 02 rev 1)

## Not yet mapped
- <a question you can tell is coming but cannot yet phrase as a probe>

## Research
- [<slug>](research/<slug>/README.md): <one-line gist> (feeds: <probes>)

## Dead ends
- <what was tried, which probe showed it fails, so nobody reruns it>

## Drift log
- [NN-slug](probes/NN-slug/README.md): <how the direction changed, and what in the result forced it>

## Spin-offs
- [<study>](../<study>/NOTEBOOK.md) on `science/<study>`: <its question>, raised by <probe NN or the user's ask>, started from <the base branch or this branch at probe NN>, run in <a new session, another agent, or a worktree path>
```

A drift log entry is written whenever a decision changes the current direction or reshapes the probe map (a phase added, dropped or reordered, a planned row dropped), even slightly. A probe that ran as planned is not drift. No entry means the direction held.

**Probe notes** get an entry when a probe starts, filled in as it runs and is decided, and one line per revision. Write them for someone who never opened the README: what was done and what came out, not how.

**Lessons** are the study's memory of its mistakes. Every fix (see **Revisions**) adds one, phrased as the rule that would have prevented the mistake. Read them before planning any probe. A lesson that holds for the whole repo, not just this study, can go into `.science/SETUP.md` too, once the user agrees.

## The probe map

The **probe map** is the study's plan and its history in one table: the probes that can be stated sharply today, the ones running, and every one that has run. It is provisional by nature: every result may reorder it, add to it or prune it.

- **#**: empty while planned. A probe gets its number when it starts, and the slug becomes a link to its folder.
- **Phase**: a stage of the work (the probes that answer one sub-question, or prepare what later phases need). Phases run in the order of the **Phases** line; rows are ordered by phase, then by run order.
- **After**: the probes whose results this one needs, so the chronological order follows from those edges. The **frontier** is every planned row whose **After** probes have all run.
- **Status**: `planned` → `running` → `held` · `failed` · `inconclusive` (the verdict) → `promoted` once it reaches the protocol. A planned row the results made pointless becomes `dropped` and stays, with a drift log entry. Research rows go `planned` → `running` → `done`.
- **Rev**: how many times the probe was fixed in place (see **Revisions**); `0` for a probe never fixed.
- **Commit**: the latest commit that changed the probe: its run, its last fix, or its promotion. A commit cannot contain its own hash, so the cell reads `pending` until the next commit that touches the notebook. Before staging that commit, replace every `pending` with `git log -1 --format=%h -- <the probe's folder or research item>`.

A **research entry**, marked `(research)`, is a question answered from existing sources instead of a run: no number, no prediction, run by `desk-research` in parallel with everything else. Probes list it under **After** like any other row.

Chart only what can be stated sharply. A question you can see coming but cannot yet phrase as a probe goes under **Not yet mapped**, and graduates into the map once a result makes it sharp.

**The user decides what goes on the map.** Next probes come out of a conversation, usually started by the user ("what should we do next?", "we are running X, but the aim is Y"): work them out with the user in rounds, the way `grilling` does, and add as `planned` rows only the probes they agree to. Never add a planned row on your own.

## Off-axis

The study's **axis** is its current direction plus the probe map. An ask or a result is **off-axis** when the axis does not cover it: the user asks about a system, quantity or comparison the direction never names; a result can only be explained by a question the map does not hold; a probe in progress starts reaching for a second question.

Notice it whenever it happens, not only at a checkpoint: mid-run, mid-grilling, in a side question. Answering the user in prose is fine, but the answer alone is lost; every off-axis item lands in the notebook once the user confirms where.

Triage it into one of three homes, testing in this order:

1. **Research entry**: it can be answered from existing sources, with nothing run. It goes on the map marked `(research)`.
2. **New probe in this study**: its answer would change this study's current direction or map. It goes on the map, or under **Not yet mapped** if it cannot be phrased sharply yet. A probe in progress stays one question: the new one is its own probe, never an enlargement of the running one.
3. **Another study**: its answer would leave this study's direction untouched, because it asks a different question, often about a different system. If an open study already covers it (check the `science/*` branches), it goes on that study's map in that study's session. Otherwise it gets its own `science/<study>` branch and `.science/<study>/` directory through `/to-study`, with **Spun off from** filled in, and a line under **Spin-offs** here.

A new study runs **in parallel** with this one, not after it. Several studies at once is the normal shape of the work, and each keeps its own branch, directory and notebook, so they never collide. Agree two things with the user when splitting:

- **Where it starts.** From the base branch, when it needs only the shared protocol. From this study's branch at the probe that raised it, when it builds on this study's scratch work: it inherits those probes as they are. Promotion is not the way to share work between studies; promote a step only when it has earned a place in the protocol on its own merits.
- **Who runs it.** A **session is bound to one study**, so the default is a new session: give the user the exact command to start it (`/to-study` for a new study, `/experiment <study>` for an open one). Another agent, handed the new study's `STUDY.md`, or a separate git worktree (`git worktree add -b science/<study> ../<repo>-<study> <start>`) also work. This session switches branch only when the user asks for it, after the current probe's state is committed.

Then confirm with the user before creating anything: one question naming the item, the home you recommend and the test that put it there, worded so "yes" accepts it. Their answer decides. When the item is new to this study (a new probe or research entry), adding it reshapes the map, so it also gets a **Drift log** entry citing the ask or the probe that raised it.

## Probe README

```markdown
# NN: <probe title>

**Builds on:** <earlier probes or promoted protocol steps, or "the study direction">
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
- rev 1, fixing `<hash of the wrong commit>`: <what was wrong>, caught by <the user | the agent>. <what changed>. Verdict <old> → <new>; decision <kept | changed from ...>.
```

A **prediction** turns "look at the result" into a binary check. Write it before running, never after, and never rewrite it in a revision.

## Revisions

A probe that was **run wrong** is fixed **in place**: a bug, a wrong input or parameter, a mistake in the analysis or the plots. The fix goes in the same `NN` folder, the probe reruns, and **Method**, **Result** and (if the user changes it) **Decision** describe the corrected run. The README's **Revisions** section keeps one entry per fix, so the mistake stays on record; the wrong outputs survive only in git history.

A new question, a changed prediction or a deliberate change of plan is never a revision: it is a new probe.

Fixing a crash before the probe's first commit is part of running it, noted under **Method**. A revision is a fix after that commit. `/experiment` describes how to make one.

## Heavy outputs

Every probe folder gets its own `.gitignore` listing outputs above the heavy-output threshold in `SETUP.md`. Commit everything needed to rerun the probe and read its result: scripts, small inputs, the README, the figures, small summary tables. The test: a fresh clone can rerun the probe and regenerate every ignored file from what is committed.

## Results

How to present a result (the brief, plots, the study dashboard) is in [RESULTS.md](RESULTS.md), and the patterns for live HTML pages (Python in the browser, adjustable text, molecular viewers) are in [LIVE-HTML.md](LIVE-HTML.md). Read it before inspecting any probe's output.

## Commits

One commit per probe on the study branch, made once its decision is recorded: `probe NN: <slug>: <verdict>`. Each revision is its own commit: `fix NN: <slug>: <what was wrong> (<old verdict> → <new verdict>)`. The branch log then reads as the lab history.
