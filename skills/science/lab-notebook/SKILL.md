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
  SETUP.md                    on main, written by setup-science
  <study>/                    on science/<study> only
    STUDY.md                  the starting direction, frozen
    NOTEBOOK.md               current direction, drift log, probe map, probe index
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

Inside a probe folder, organise files however the probe needs; only `README.md`, `.gitignore` and `figures/` are fixed. The tree of the main protocol is a different matter: it is agreed with the human at promotion, never chosen alone.

Probe folders are `NN-<slug>`: `NN` counts probes in run order from `01`, `<slug>` says what the probe does. A number is never reused or renumbered: a dropped probe keeps its number, so the numbers stay a faithful history.

## STUDY.md

The **direction** the study started from. Written once by `to-study`, then **frozen**: never edited again, because the gap between it and the notebook's current direction is the record of how far the experiments moved the study.

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
<the probe map as first charted: see below>
```

## NOTEBOOK.md

An **index**, not a store: each probe's detail lives in its own README, and the notebook gists it in one line and links.

```markdown
# <Study title>: notebook

## Current direction
<2 to 4 lines. Starts as a copy of STUDY.md's direction and drifts.>

## Drift log
- [NN-slug](probes/NN-slug/README.md): <how the direction changed, and what in the result forced it>

## Probe map
### <phase title>
- [ ] <slug>: <what it finds out> <(after: <slug>, <slug>)>
- [ ] <slug> (research): <the question it answers>
- [x] [NN-slug](probes/NN-slug/README.md)

## Not yet mapped
- <a question you can tell is coming but cannot yet phrase as a probe>

## Research
- [<slug>](research/<slug>/README.md): <one-line gist> (feeds: <probes>)

## Probes
- [NN-slug](probes/NN-slug/README.md): **held | failed | inconclusive | running**: <one-line gist> <(promoted: protocol/<step>) when it was>

## Dead ends
- <what was tried, which probe showed it fails, so nobody reruns it>

## Spin-offs
- [<study>](../<study>/NOTEBOOK.md) on `science/<study>`: <its question>, raised by <probe NN or the user's ask>, started from <`main` or this branch at probe NN>, run in <this session, another agent, or a worktree path>
```

A drift log entry is written whenever a decision changes the current direction or reshapes the probe map (a phase added, dropped or reordered, a planned probe dropped), even slightly. Ticking a probe that ran as planned is not drift. No entry means the direction held.

## The probe map

The **probe map** is the study's provisional plan: the probes that can be stated sharply today, grouped into **phases** and ordered. A phase is a stage of the work (the probes that answer one sub-question, or prepare what later phases need); phases are listed in the order they run. Within and across phases, `after:` names the probes whose results a probe needs, so the chronological order follows from those edges. The **frontier** is every unticked probe whose `after:` probes have all run.

The map is provisional by nature: every result may reorder it, add to it or prune it. Planned probes carry a slug and no number, because a number is given only when a probe runs. When it runs, its entry is ticked and becomes a link to its folder.

A **research entry**, marked `(research)`, is a question answered from existing sources instead of a run: no number, no prediction, run by `desk-research` in parallel with everything else. Probes list it under `after:` like any other entry.

Chart only what can be stated sharply. A question you can see coming but cannot yet phrase as a probe goes under **Not yet mapped**, and graduates into the map once a result makes it sharp.

## Off-axis

The study's **axis** is its current direction plus the probe map. An ask or a result is **off-axis** when the axis does not cover it: the user asks about a system, quantity or comparison the direction never names; a result can only be explained by a question the map does not hold; a probe in progress starts reaching for a second question.

Notice it whenever it happens, not only at a checkpoint: mid-run, mid-grilling, in a side question. Answering the user in prose is fine, but the answer alone is lost; every off-axis item lands in the notebook once the user confirms where.

Triage it into one of three homes, testing in this order:

1. **Research entry**: it can be answered from existing sources, with nothing run. It goes on the map marked `(research)`.
2. **New probe in this study**: its answer would change this study's current direction or map. It goes on the map, or under **Not yet mapped** if it cannot be phrased sharply yet. A probe in progress stays one question: the new one is its own probe, never an enlargement of the running one.
3. **New study**: its answer would leave this study's direction untouched, because it asks a different question, often about a different system. It gets its own `science/<study>` branch and `.science/<study>/` directory through `/to-study`, with **Spun off from** filled in, and a line under **Spin-offs** here.

A new study runs **in parallel** with this one, not after it. Several studies at once is the normal shape of the work, and each keeps its own branch, directory and notebook, so they never collide. Agree two things with the user when splitting:

- **Where it starts.** From `main`, when it needs only the shared protocol. From this study's branch at the probe that raised it, when it builds on this study's scratch work: it inherits those probes as they are. Promotion is not the way to share work between studies; promote a step only when it has earned a place in the protocol on its own merits.
- **Who runs it.** This session, once it switches branch; another agent, handed the new study's `STUDY.md`; or a separate git worktree (`git worktree add -b science/<study> ../<repo>-<study> <start>`), so both studies run side by side in their own folders.

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
```

A **prediction** turns "look at the result" into a binary check. Write it before running, never after.

## Heavy outputs

Every probe folder gets its own `.gitignore` listing outputs above the heavy-output threshold in `SETUP.md`. Commit everything needed to rerun the probe and read its result: scripts, small inputs, the README, the figures, small summary tables. The test: a fresh clone can rerun the probe and regenerate every ignored file from what is committed.

## Results

How to present a result (the brief, plots, the study dashboard) is in [RESULTS.md](RESULTS.md), and the patterns for live HTML pages (Python in the browser, adjustable text, molecular viewers) are in [LIVE-HTML.md](LIVE-HTML.md). Read it before inspecting any probe's output.

## Commits

One commit per probe on the study branch, made once its decision is recorded: `probe NN: <slug>: <verdict>`. The branch log then reads as the lab history.
