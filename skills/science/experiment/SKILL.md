---
name: experiment
description: Open or resume a study, run and record probes, and compare their findings when you're ready to decide.
license: MIT
disable-model-invocation: true
---

# Experiment

`/experiment <study>` **loads** a study and **focuses** the session on its folder, `.science/<study>/`: from here on, the conversation is about this study. Loading changes nothing in the study. After it, follow the user: they may want what was done explained, more work on an open probe, the next probe, a fix, or just a discussion. The sections below are the procedures to reach for when their ask needs one.

The study's **direction** is allowed to **drift**. `STUDY.md` is where the study started, and it stays frozen; each probe follows the evidence and the user's choices, wherever that leads. Every move away from the starting direction is logged.

Watch the **axis** throughout. When an ask or result leaves it, use **Off-axis** in `lab-notebook`. Follow the user's stated choice of home; if none was given, settle it before creating anything.

## Load the study

1. Read `lab-notebook` for the tree, record formats, probe states and shared-checkout rules. Read `.science/SETUP.md` for the domain and stack; if it is missing, tell the user to run `/maintain-science` to configure the repo before running experiments.
2. **Pick it.** With `/experiment <study>` and the folder `.science/<study>/` present, load it. With a name whose folder does not exist, go to **Open a new study**. Without a name, list the studies (folders under `.science/` with a `STUDY.md`): for each, open or closed, its question, its open probes and current direction, from `NOTEBOOK.md`. Ask which one to load, or the name of a new one.
3. **Check the branch.** Compare the current branch with the notebook's **Branch**. When they differ, tell the user and ask: continue here (update **Branch** in the study's next commit), or stop so they can move to the recorded branch. This session stays on whatever branch it found.
4. **Check the folder.** Uncommitted changes inside `.science/<study>/` are a previous session's unfinished work: show them and ask the user what to do with them. Changes anywhere else belong to other sessions; leave them alone.
5. **Orient.** Read `NOTEBOOK.md` (direction, map, log, ideas, lessons, dead ends) and cycle manifests. Follow each stable probe ID's current notebook href, including unfinished probes in earlier-cycle `active/`; do not assume `probes/NN-<slug>/`. Resolve working/data homes and inspect the current batch, which may be empty after rollover. Summarize question, evidence, open or partially promoted probes, remaining work and agreed ideas. If records disagree, flag the conflict and suggest `/maintain-science` for a review instead of guessing paths or moving records.

Done when the user has that summary. When their `/experiment` message already asked for something, go on to it.

This session is now **bound** to the study: it writes inside `.science/<study>/`, plus explicitly approved shared-data or main-tree paths through setup/promotion. When an ask belongs to another study (see **Off-axis** in `lab-notebook`), record it where the triage says, then give the command for a new session: `/experiment <other-study>`.

## Who runs the experiment

The lead owns the conversation, agrees the scientific question and scope, and presents the result. Only the lead asks the user for decisions, permissions or missing context. A load, explanation or short comparison can stay inline.

For substantial agreed probe work, assign **one worker** with a fresh context and high effort where supported. Give it the question and limits, the notebook-linked probe, setup and relevant earlier records, the exact paths or shared-file sections it owns, required deliverables and checks, and its local checkpoint authority. Pass pointers and the user's actual choices, not the whole conversation. Avoid concurrent edits to the same records.

The worker owns that assignment end to end: run or resume, inspect outputs, organize files, update records and dashboard, verify, and make the scoped local checkpoint when permitted. It returns evidence and caveats, paths and checks, the commit hash or exact blocker, and anything still open. It brings decisions back to the lead instead of expanding the work or asking the user. If only the lead may commit, the worker hands back the verified paths or hunks and the lead checkpoints them under existing authority. If delegation is unavailable or prohibited, the lead does the same work inline.

At meaningful milestones and before pausing, switching probes or handing off, use `lab-notebook` **Commits and tags**. Standing authorization covers verified checkpoints in scope without another permission round, even while a probe is open. Apply those rules to every commit and tag below; when not permitted, report the pending action and why. A local grant does not authorize a publishing hook.

## Open a new study

A **direction** is not a spec, and this interview is short: the probes answer what it leaves open, and the notebook records every move.

1. **Gather.** Read `GLOSSARY.md` for the agreed vocabulary, `.science/library/index.md` for what the repo already knows, and anything the user passes (a file, an issue, a previous study) in full. Finding facts is your job: look them up instead of asking. Call the Skill tool with `domain-modeling`, so terms are challenged and written to `GLOSSARY.md` as they crystallise. If this session already holds a study, triage the ask against its axis first: a question that belongs there becomes a probe there, not a new study.
2. **Grill the direction** in rounds, the way `grilling` does: numbered questions, each with your recommended answer, worded so "yes" accepts it. Cover what the user's message has not already settled: the **question**, the **starting hypothesis** (or "unknown"), the **system**, **what an answer looks like**, the **constraints**. Questions that need reading, not the user, go to the library; for each one it cannot answer yet, call the Skill tool with `desk-research` at once, and keep asking about what does not depend on it.
3. **Agree the first probe.** Stop grilling as soon as a first run can be planned that reduces a named uncertainty, and agree that probe with the user. Everything else the user mentioned becomes a line under **Ideas**; a piece that asks a different question goes under **Spin-offs** for its own `/experiment` run.
4. **Draft `STUDY.md`** in the `lab-notebook` format, folding in the library pages the framing used under **Background**. Every section is a best current guess, not a commitment; mark what is open as unknown. Show it, iterate until the user accepts it, and name the study with a short slug unused under `.science/`.
5. **Open it.** Write `STUDY.md` (its starting sections frozen from here on) and `NOTEBOOK.md`: **Question** and **Branch** filled in, the current direction from `STUDY.md`, an empty **Map** and **Log**, the **Ideas** list, the **Library** list started from **Background**. Create an empty `probes/` folder and the study dashboard. Commit `<study>: open` and tag it `<study>/open`.

Done when the starting records exist and the opening checkpoint is made or accounted for. Start the agreed first probe unless the user says otherwise.

## Start a probe

1. **Choose it with the user.** The next probe comes from the user's ask, the last result's **Suggests**, or the **Ideas** list. When the choice is open ("what should we do next?", "we are running X, but the aim is Y"), work it out in rounds, the way `grilling` does. A good probe is the **smallest run that reduces a relevant uncertainty and updates the working picture**. Prefer reusing promoted protocol steps over scratch copies of them, and existing library pages over new reading. Check the plan against every entry under **Lessons**.
2. **Look at open probes** under **Probe states** in `lab-notebook`: finished agreed work with inspected/recorded results becomes `evidence`; pending jobs, analysis, discussion or partial-component work stays `open`. Say what remains.
3. **Create a new question** in `probes/NN-<slug>/` using the numbering and **Ideas** rules in `lab-notebook`. A cycle never resets numbering. Continuing an unfinished probe instead uses its existing ID at the notebook-linked cycle location, without copying it into `probes/`. For a new probe, write **Thread**, **Asked** and **Plan** with **Builds on**, **Expectation**, applicable **Test criterion** and working homes. Add its `open` block with the actual record href and log line, then remove its agreed idea. Checkpoint only under repository authorization.
4. **Tell the user** in a few lines what you expect, why, and which uncertainty the probe addresses; say when the expectation is only an agent guess or is unknown. When the plan matches what the user already chose, go straight on; when it departs from it, wait for them.

## Run

Work at the probe's notebook-linked location. Run commands through `SETUP.md`'s environment and compute route. Read shared inputs from authoritative homes and fetch other inputs beside the probe with provenance/fetch instructions (see **Data** in `lab-notebook`). Workflow databases/run outputs stay with the workflow. New user data can enter shared data on instruction; fetched data requires approved promotion.

Keep the agreed work usable as you go. Name or move ordinary working files, group inputs, scripts and outputs, fix affected live references within your ownership, and document what to open and how to rerun it. Do this as part of the experiment without a separate curation request. Use the [move safeguards](../lab-notebook/SKILL.md#moving-working-files); leave a move blocked if it would break a consumer you cannot repair safely. A different purpose is different work: recommend `/curate-probe-tree` when the user wants the layout to reflect a particular way of comparing, presenting or using a probe. Neither kind of organization promotes it.

1. Write the scripts and the probe's `.gitignore` for heavy outputs.
2. Run. Record under **Method** the exact commands, tool versions, seeds and inputs, so the probe reruns from what is committed.
3. A run that crashes or is misconfigured is not a result: fix it and rerun inside the same probe, and note the fix under **Method**.
4. For a long job, submit it, record its ID under **Method**, add a log line and checkpoint (`<study>: probe NN: <slug>: job submitted`). Tell the user what to expect. A later `/experiment <study>` collects and verifies the results, then checkpoints the collection with its own log line.

Done when the outputs needed to answer what was asked exist.

## Record observations now

Read [RESULTS.md](../lab-notebook/RESULTS.md) before looking at the outputs. Then:

1. Record what was actually observed under **Result** and **found**, with sources, figures and caveats. For a valid reported result, write the brief against the original expectation and any pre-run test criterion; use `completed` or `inconclusive` as `lab-notebook` defines them. Partial observations get a milestone, not a forced outcome.
2. In **Reading** and **means**, date and attribute any provisional interpretation to the agent and mark it `[inference]`. If the evidence does not support a reading yet, say what remains unresolved. Update the **Log** and dashboard, verify and checkpoint the result. A comparison or user response is not a prerequisite.
3. Present the finding, key figures and dashboard, uncertainty and any suggested next step. Mention relevant library findings or off-axis questions. Leave the probe open while agreed work remains, even after partial promotion.

## Compare or decide when asked

The user may return in ordinary conversation to one probe, several results, an earlier alternative or a pattern across probes. Resolve the references through the notebook. Compare the relevant observations, criteria, controls and limits; say when they are not comparable. Answer the actual question without scheduling a decision meeting or running another probe.

A request to compare is not a choice. Keep any new interpretation dated, attributed and distinct from measurements; a recommendation is still `[inference]`. If the user makes a clear choice, act on it once within scope without asking them to confirm it. Ask only if the intended choice or its consequences are genuinely ambiguous. Choosing one approach does not by itself drop the others, promote a component or retroactively change an outcome.

Append the dated reading or decision and its basis to each affected probe's **Reading**, cross-linking the other stable IDs. For an immutable record, put the later reading beside its link in the current notebook instead. Keep original observations, expectations, criteria and earlier attributed readings visible. Bring the corresponding **Map** blocks, thread summary and **Log** into agreement; update **Ideas** or **Dead ends** only as decided. If direction changed, update **Current direction** and cite the relevant probes in the **Drift log**. Refresh affected dashboard views and checkpoint the coherent change. A comparison with no new reading or decision needs no record mutation.

Only an explicit drop sets `dropped`. Technical reuse and physical batch rollover require `/promote` and its approved tree. On request, refresh the shared project map with `scientific-map`; keep charts in the study dashboard.

## Fix a probe

When a recorded probe was **run wrong**, resolve its ID through `NOTEBOOK.md` and fix it at that physical record as **Revisions** in `lab-notebook` describes. A record inside a cycle is not missing and is not copied or moved back into the current batch. Preserve other work under its existing authorization.

1. **Identify the fix.** Name the probe, what was wrong, and whether it is a revision or a new probe (see **Revisions** in `lab-notebook`). Proceed on a clear user instruction; if the repair or its scope is uncertain, settle that first.
2. **Fix and rerun** at that recorded location under the same ID. Update current **Method** with the corrected run, preserving captured receipts and frozen statements separately. Keep **Asked**, original **Expectation** and **Test criterion** unchanged.
3. **Show the result again** as above when the outcome or the reading changed; when only the numbers moved, report the fix in a few lines.
4. **Record the revision.** In the README, add a **Revisions** entry: the tag of the wrong version, what was wrong, who caught it, what changed, the outcome before and after. On the probe's block, raise the rev and tag to `<study>/NN-r<R>`, update **found** and **means**, and say in its prose what the fix changed; add a log line and a **Lessons** entry: the rule that would have prevented the mistake. If the lesson holds for the whole repo, ask the user whether it also goes into `.science/SETUP.md`. If the corrected result moves the direction, update it with a **Drift log** entry.
5. **Check what was built on it.** Identify every dependent probe, including spin-offs. Mark the affected blocks you own (`built on NN before its rev N`); give the other study's session the affected IDs and correction rather than editing its records. Record any explicit rerun or keep decisions and ask only about unresolved ones. If the fixed probe was promoted, flag the affected protocol step for a new promotion.
6. Checkpoint the verified fix and affected records only, using the fix message and revision tag in `lab-notebook`.

Done when the correction is recorded, its checkpoint or blocker is reported, and dependent work is marked rerun, kept, or awaiting the user's decision.

## Close the study

If the evidence answers the question, offer to close the study. If the user already asked to close it, record that choice. Account for open work without inventing outcomes. Add the answer or reason for stopping and the supporting probes to **Current direction** and the append-only **Outcome** in `STUDY.md`. Checkpoint `<study>: close` and tag it `<study>/close` under the repository's authorization.

When the user stops for the day, checkpoint any remaining coherent work without closing the probe or study. `/experiment <study>` picks up from that record.
