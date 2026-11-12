---
name: to-study
description: Grill the user just far enough to frame the starting scientific question of a study, reading the literature where the framing needs it, chart a provisional probe map from their indications, then write its direction and open its folder and lab notebook.
disable-model-invocation: true
---

# To Study

Open a **study**: interview the user until the starting **question** is sharp enough to plan a first probe, reading what the framing needs from the literature, split the work ahead into a provisional **probe map**, write both down as the study's **direction**, and open its folder and lab notebook.

A direction is not a spec, and this interview is not exhaustive. The question will change round by round as probes come back, so settling every branch now would be wasted work: the experiments answer what the interview leaves open, and the notebook records every move.

The repo's science setup should be in `.science/SETUP.md`. If it is missing, tell the user to run `/setup-science` and stop.

Call the Skill tool with `lab-notebook` for the tree, the file formats and the rules of the shared checkout, and with `domain-modeling`, so terms are challenged and written to `GLOSSARY.md` the moment they crystallise.

## Process

### 1. Gather

Read `.science/SETUP.md` for the domain and stack, `GLOSSARY.md` for the agreed vocabulary, `.science/library/index.md` for what the repo already knows, and anything the user passes (a file, an issue, a previous study) in full. Finding facts is your job: look them up instead of asking.

If this session already holds a study, triage the ask against that study's **axis** first (see **Off-axis** in `lab-notebook`): a question that belongs in the open study becomes a probe there, not a new study. Confirm the reading with the user before going on.

### 2. Frame the question

Interview the user in **rounds**, the way `grilling` does: each round asks every question whose prerequisites are settled, numbered, each with your recommended answer, worded so "yes" accepts it. Wait for the answers, then ask the next round.

Aim the rounds at the parts of `STUDY.md`, in this order of weight: the **question**, the **starting hypothesis**, the **system**, **what an answer looks like**, the **constraints**.

Some framing questions need **reading**, not the user: what is already known, which systems or datasets exist, which benchmark the field uses. Answer those from the library. For each one the library cannot answer yet, call the Skill tool with `desk-research` at once, and keep interviewing on what does not depend on it. Fold each answer into the next round as it arrives, citing its page.

Stop as soon as the question is **sharp enough to probe**: a first probe can be planned from it, with a prediction that could fail. Every branch still open at that point is not a gap in the interview: it becomes a probe on the map, or goes under **Not yet mapped**, for a probe to answer.

### 3. Chart the probe map

The user often arrives with a long, complex set of indications: many steps, conditions and checks in one go. Splitting that into probes is this skill's job, the way `wayfinder` splits a large effort into tickets. See `lab-notebook` for the map's format.

1. Fan out **breadth-first** over the indications: list every piece of work they imply, without going deep on any one.
2. Cut the work into probes, each the smallest run that answers one thing, sized to one session. Reading or fetching that later probes need (literature and tool documentation for the library; database exports, datasets, model checkpoints for the data folder) becomes a **research row**, marked `(research)`.
3. Find the **hierarchy**: group the probes into phases, each a stage that answers one sub-question or prepares what later stages need.
4. Find the **order of execution**: for each probe, name what blocks it, the probes and research rows whose results it needs (**Blocked by**). Order the phases so the edges point forward.
5. Leave in **Not yet mapped** whatever depends on results too much to state as a probe yet. Chart only what is sharp.
6. Check the indications for more than one study. A piece whose answer would not change this study's direction is a separate study: propose splitting it off, and on the user's yes list it under the notebook's **Spin-offs**, marked not yet opened, for its own `/to-study` run, instead of mapping it here.

Show the map as the `lab-notebook` table, every row `planned`, with the frontier marked. Iterate until the user accepts it. The map is a provisional plan, not a schedule: `/experiment` still plans each probe properly from the results before it, and reshapes the map with the user as results come in.

For a simple question the map may be two or three probes in one phase. That is fine.

Done when every piece of the user's indications sits in the map, under **Not yet mapped**, or is named as out of scope under **Constraints**, and the frontier holds at least one probe.

### 4. Draft the direction

Wait for every framing page dispatched in step 2, and fold in what they found. Then draft `STUDY.md` in the `lab-notebook` format from what the rounds settled. List under **Background** the library pages the framing used. Mark what the rounds left open as unknown, and put the accepted map under **Starting probe map**. Every section is a best current guess, not a commitment.

Show the draft. Iterate until the user accepts it as the starting direction. Then name the study with a short slug, unused under `.science/`.

Done when a reader could plan a first probe from it and every section is either filled or marked unknown.

### 5. Open the study

1. Write `.science/<study>/STUDY.md`. Its starting sections are **frozen** from here on (see `lab-notebook`).
2. Write `.science/<study>/NOTEBOOK.md`: **Branch** set to the current branch, current direction and probe map table copied from `STUDY.md`, the **Not yet mapped** list, the **Library** list started from **Background**, and empty probe notes, lessons and drift log.
3. Create an empty `probes/` folder and the study dashboard (see `lab-notebook`).
4. Commit the study folder, `<study>: open`, and tag it `<study>/open` (see **Commits and tags** in `lab-notebook`).
5. If the frontier holds research rows, call the Skill tool with `desk-research` to start them now, so they are read while the first probe is planned.

Done when the commit and its tag exist and the notebook's probe map has a non-empty frontier. Tell the user the next step is `/experiment <study>`, in this session or a new one.
