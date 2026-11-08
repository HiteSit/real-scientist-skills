---
name: to-study
description: Grill the user just far enough to frame the starting scientific question of a study, chart a provisional probe map from their indications, then write its direction and open its branch and lab notebook.
disable-model-invocation: true
---

# To Study

Open a **study**: interview the user until the starting **question** is sharp enough to plan a first probe, split the work ahead into a provisional **probe map**, write both down as the study's **direction**, cut its branch, and open its lab notebook.

A direction is not a spec, and this interview is not exhaustive. The question will change round by round as probes come back, so settling every branch now would be wasted work: the experiments answer what the interview leaves open, and the notebook records every move.

The repo's science setup should be in `.science/SETUP.md`. If it is missing, tell the user to run `/setup-science` and stop.

Call the Skill tool with `lab-notebook` for the tree and the file formats, and with `domain-modeling`, so terms are challenged and written to `GLOSSARY.md` the moment they crystallise.

## Process

### 1. Gather

Read `.science/SETUP.md` for the domain and stack, `GLOSSARY.md` for the agreed vocabulary, and anything the user passes (a file, an issue, a previous study) in full. Finding facts is your job: look them up instead of asking.

If you are on a `science/<study>` branch already, triage the ask against that study's **axis** first (see **Off-axis** in `lab-notebook`): a question that belongs in the open study becomes a probe there, not a new study. Confirm the reading with the user before going on.

### 2. Frame the question

Interview the user in **rounds**, the way `grilling` does: each round asks every question whose prerequisites are settled, numbered, each with your recommended answer, worded so "yes" accepts it. Wait for the answers, then ask the next round.

Aim the rounds at the parts of `STUDY.md`, in this order of weight: the **question**, the **starting hypothesis**, the **system**, **what an answer looks like**, the **constraints**.

Stop as soon as the question is **sharp enough to probe**: a first probe can be planned from it, with a prediction that could fail. Every branch still open at that point is not a gap in the interview: it becomes a probe on the map, or goes under **Not yet mapped**, for a probe to answer.

### 3. Chart the probe map

The user often arrives with a long, complex set of indications: many steps, conditions and checks in one go. Splitting that into probes is this skill's job, the way `wayfinder` splits a large effort into tickets. See `lab-notebook` for the map's format.

1. Fan out **breadth-first** over the indications: list every piece of work they imply, without going deep on any one.
2. Cut the work into probes, each the smallest run that answers one thing, sized to one session. Work that reads or gathers instead of runs (literature, reference data, tool documentation) becomes a **research entry**, marked `(research)`.
3. Find the **hierarchy**: group the probes into phases, each a stage that answers one sub-question or prepares what later stages need.
4. Find the **chronological order**: for each probe, name the probes whose results it needs (`after:`). Order the phases so their edges point forward.
5. Leave in **Not yet mapped** whatever depends on results too much to state as a probe yet. Chart only what is sharp.
6. Check the indications for more than one study. A piece whose answer would not change this study's direction is a separate study: propose splitting it off, and on the user's yes list it under the notebook's **Spin-offs**, marked not yet opened, for its own `/to-study` run, instead of mapping it here.

Show the map as an indented tree with the edges, and the frontier marked. Iterate until the user accepts it. The map is a provisional plan, not a schedule: `/experiment` still plans each probe properly from the result before it, and reshapes the map as results come in.

For a simple question the map may be two or three probes in one phase. That is fine.

Done when every piece of the user's indications sits in the map, under **Not yet mapped**, or is named as out of scope under **Constraints**, and the frontier holds at least one probe.

### 4. Draft the direction

Draft `STUDY.md` in the `lab-notebook` format from what the rounds settled. Mark what they left open as unknown, and put the accepted map under **Starting probe map**. Every section is a best current guess, not a commitment.

Show the draft. Iterate until the user accepts it as the starting direction. Then name the study with a short slug.

Done when a reader could plan a first probe from it and every section is either filled or marked unknown.

### 5. Open the study

1. Cut `science/<study>` from `main`, or, for a spin-off, from the starting point agreed at the split (see **Off-axis** in `lab-notebook`). If the study runs in its own worktree or with another agent, create the branch there or hand it over, as agreed.
2. Write `.science/<study>/STUDY.md`, then treat it as **frozen**.
3. Write `.science/<study>/NOTEBOOK.md`: current direction and probe map copied from `STUDY.md`, the **Not yet mapped** list, an empty drift log, and no probes run yet.
4. Create an empty `probes/` folder and the study dashboard (see `lab-notebook`).
5. Commit: `study: <study>: open`.
6. If the frontier holds research entries, call the Skill tool with `desk-research` to dispatch them now, so they are read while the first probe is planned.

Done when the branch exists with that commit and the notebook's probe map has a non-empty frontier. Tell the user the next step is `/experiment`.
