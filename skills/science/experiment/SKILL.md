---
name: experiment
description: Load a science study and focus the session on it (/experiment <study>, from any session), or open it when its folder does not exist yet. Then follow the user's lead on that study - explain what was done, work on an open probe, start the next probe, fix a recorded one, or close the study.
license: MIT
disable-model-invocation: true
---

# Experiment

`/experiment <study>` **loads** a study and **focuses** the session on its folder, `.science/<study>/`: from here on, the conversation is about this study. Loading changes nothing in the study. After it, follow the user: they may want what was done explained, more work on an open probe, the next probe, a fix, or just a discussion. The sections below are the procedures to reach for when their ask needs one.

The study's **direction** is allowed to **drift**. `STUDY.md` is where the study started, and it stays frozen; each probe follows the evidence and the user's choices, wherever that leads. Every move away from the starting direction is logged.

Watch the **axis** the whole time. Whenever an ask from the user or a result leaves it, triage it as `lab-notebook` describes under **Off-axis** and confirm its home with the user before creating anything. Then return to what you were doing.

## Load the study

1. Call the Skill tool with `lab-notebook` for the tree, the formats, the probe states and the rules of the shared checkout. Read `.science/SETUP.md` for the domain and stack; if it is missing, tell the user to run `/setup-science` and stop.
2. **Pick it.** With `/experiment <study>` and the folder `.science/<study>/` present, load it. With a name whose folder does not exist, go to **Open a new study**. Without a name, list the studies (folders under `.science/` with a `STUDY.md`): for each, open or closed, its question, its open probes and current direction, from `NOTEBOOK.md`. Ask which one to load, or the name of a new one.
3. **Check the branch.** Compare the current branch with the notebook's **Branch**. When they differ, tell the user and ask: continue here (update **Branch** in the study's next commit), or stop so they can move to the recorded branch. This session stays on whatever branch it found.
4. **Check the folder.** Uncommitted changes inside `.science/<study>/` are a previous session's unfinished work: show them and ask the user what to do with them. Changes anywhere else belong to other sessions; leave them alone.
5. **Orient.** Read `NOTEBOOK.md` (current direction, probes, ideas, lessons, dead ends) and the README of every open probe. Tell the user in a few lines where the study stands: the question and current direction, each open probe and what it waits for, the latest evidence, and the ideas on the list. If `STUDY.md`, the notebook and the probe folders tell different stories, say so and suggest `/ask-science` instead of guessing.

Done when the user has that summary. When their `/experiment` message already asked for something, go on to it.

This session is now **bound** to the study: it writes only inside `.science/<study>/` (plus the protocol files of a promotion, through `/promote`). When an ask belongs to another study (see **Off-axis** in `lab-notebook`), record it where the triage says, then give the user the exact command for a new session: `/experiment <other-study>`.

## Open a new study

A **direction** is not a spec, and this interview is short: the probes answer what it leaves open, and the notebook records every move.

1. **Gather.** Read `GLOSSARY.md` for the agreed vocabulary, `.science/library/index.md` for what the repo already knows, and anything the user passes (a file, an issue, a previous study) in full. Finding facts is your job: look them up instead of asking. Call the Skill tool with `domain-modeling`, so terms are challenged and written to `GLOSSARY.md` as they crystallise. If this session already holds a study, triage the ask against its axis first: a question that belongs there becomes a probe there, not a new study.
2. **Grill the direction** in rounds, the way `grilling` does: numbered questions, each with your recommended answer, worded so "yes" accepts it. Cover what the user's message has not already settled: the **question**, the **starting hypothesis** (or "unknown"), the **system**, **what an answer looks like**, the **constraints**. Questions that need reading, not the user, go to the library; for each one it cannot answer yet, call the Skill tool with `desk-research` at once, and keep asking about what does not depend on it.
3. **Agree the first probe.** Stop grilling as soon as a first run can be planned that reduces a named uncertainty, and agree that probe with the user. Everything else the user mentioned becomes a line under **Ideas**; a piece that asks a different question goes under **Spin-offs** for its own `/experiment` run.
4. **Draft `STUDY.md`** in the `lab-notebook` format, folding in the library pages the framing used under **Background**. Every section is a best current guess, not a commitment; mark what is open as unknown. Show it, iterate until the user accepts it, and name the study with a short slug unused under `.science/`.
5. **Open it.** Write `STUDY.md` (its starting sections frozen from here on) and `NOTEBOOK.md`: **Branch** set to the current branch, the current direction copied from `STUDY.md`, an empty **Probes** table, the **Ideas** list, the **Library** list started from **Background**. Create an empty `probes/` folder and the study dashboard. Commit `<study>: open` and tag it `<study>/open`.

Done when the commit and its tag exist. Then start the first probe, below, unless the user says otherwise.

## Start a probe

1. **Choose it with the user.** The next probe comes from the user's ask, the last result's **Suggests**, or the **Ideas** list. When the choice is open ("what should we do next?", "we are running X, but the aim is Y"), work it out in rounds, the way `grilling` does. A good probe is the **smallest run that reduces a relevant uncertainty and updates the working picture**. Prefer reusing promoted protocol steps over scratch copies of them, and existing library pages over new reading. Check the plan against every entry under **Lessons**.
2. **Look at the open probes** and settle their state as `lab-notebook` describes under **Probe states**: results in and recorded → `evidence`; results still out → stays `open`, and say so.
3. **Create** `probes/NN-<slug>/` with the next free number and write the top of its README: **Builds on**, **Intent**, **Expectation**, and **Test criterion** when applicable. In the notebook, add the row as `open`, take it off **Ideas**, and start its **Probe notes** entry.
4. **Tell the user** in a few lines what you expect, why, and which uncertainty the probe addresses; say when the expectation is only an agent guess or is unknown. When the plan matches what the user already chose, go straight on; when it departs from it, wait for them.

## Run

Organise the probe folder however the work needs. Run every command through the environment's run command in `SETUP.md`, and read `SETUP.md` for how to submit to compute. Read the user's input data from the data folder by its repo-relative path; fetch everything else the probe loads (database exports, datasets, model checkpoints) into the probe's own folder, with a fetch script and the source in the README (see **Data** in `lab-notebook`). When the user hands over new data of their own mid-study, add it to the data folder with its own `data: <slug>` commit.

1. Write the scripts and the probe's `.gitignore` for heavy outputs.
2. Run. Record under **Method** the exact commands, tool versions, seeds and inputs, so the probe reruns from what is committed.
3. A run that crashes or is misconfigured is not a result: fix it and rerun inside the same probe, and note the fix under **Method**.
4. For a long job, submit it, record the job id under **Method**, commit (`<study>: probe NN: <slug>: job submitted`), and tell the user when to expect it. The probe stays open; a later `/experiment <study>` collects it.

Done when the outputs needed to address the probe's intent exist.

## Show a result

Read [RESULTS.md](../lab-notebook/RESULTS.md) before looking at the outputs. Then:

1. Make the probe's figures, assign the **Outcome** (`completed` or `inconclusive`, as `lab-notebook` defines them), and write the brief under **Result**: what changed in the working picture and what remains unresolved, against the original expectation and any test criterion.
2. Regenerate the study dashboard so it shows this result.
3. **Present it** in one message: the one-sentence finding and the outcome, what shifted from the starting expectation and what remains uncertain, the key figures, a link to the dashboard, what it suggests next, the findings of any library pages finished meanwhile, and any off-axis question it raised with the home you recommend.
4. **Talk it through** in rounds, the way `grilling` does, as short as the result allows: a clean result may need one round or none, a surprise several. Aim at how the user reads it, which caveat matters most, and what it changes in their belief about the question.
5. **Record** under **Discussion** the reading the conversation settled. Finish the probe's **Probe notes** entry, add any ideas the user agreed to, and any new dead ends. If the direction moved even slightly, rewrite **Current direction** and add a **Drift log** entry citing this probe. Commit: the first recorded result is `<study>: probe NN: <slug>: <outcome>`, tagged `<study>/NN-r0`; later results in the same probe are `<study>: probe NN: <slug>: <what changed>`.

The probe stays open: more work on it continues until the next probe starts. When the user says in plain words to drop a probe, set it to `dropped`, record what it rules out under **Dead ends**, and commit. When they want its work in the protocol, the next step is `/promote`.

## Fix a probe

When the user, or you, finds that a recorded probe was **run wrong** (a bug, a wrong input or parameter, a mistake in the analysis or the plots), fix it in place as `lab-notebook` describes under **Revisions**. Commit any other probe's work as it stands first, then come back to it.

1. **Confirm the fix.** Name the probe, what was wrong, and whether it is a revision or a new probe (see **Revisions** in `lab-notebook`). Wait for the user's yes.
2. **Fix and rerun** in the same folder. Update **Method** to the corrected run. Keep the original **Expectation** and any **Test criterion** exactly as written.
3. **Show the result again** as above when the outcome or the reading changed; when only the numbers moved, report the fix in a few lines.
4. **Record the revision.** In the README, add a **Revisions** entry: the tag of the wrong version, what was wrong, who caught it, what changed, the outcome before and after. In the notebook, add 1 to **Rev**, set **Tag** to `<study>/NN-r<R>`, add the revision line to the probe's notes, and a **Lessons** entry: the rule that would have prevented the mistake. If the lesson holds for the whole repo, ask the user whether it also goes into `.science/SETUP.md`. If the corrected result moves the direction, update it with a **Drift log** entry.
5. **Check what was built on it.** For every probe whose **Builds on** names the fixed one, in this study or in a spin-off, add a line to its notes (`built on NN before its rev N`) and ask the user, probe by probe, whether to rerun it (a fix of its own, in its own study's session) or keep it. If the fixed probe was promoted, tell the user the protocol step carries the mistake and needs a new promotion.
6. Commit the study folder, `<study>: fix NN: <slug>: <what was wrong> (<old outcome> → <new outcome>)`, and tag it `<study>/NN-r<R>`.

Done when the commit and its tag exist and every probe built on the old result is marked rerun or kept.

## Close the study

When the question is answered, or the user wants to stop the study for good, propose closing it: open probes become `evidence` (or stay as the user says), a final line goes under **Current direction**, and the **Outcome** line goes into `STUDY.md`, both stating the answer, or why it stops, and the probes behind it. Commit `<study>: close` and tag it `<study>/close`.

When the user simply stops for the day, nothing is needed: the notebook holds the state, and `/experiment <study>` picks it up.
