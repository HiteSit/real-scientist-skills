---
name: experiment
description: Load a science study (/experiment <study>, from any session) and run it one probe at a time. Plan a probe with a prediction, run it, show the result as plots and a brief, grill the user on what it means, and let them decide the next step after every probe. Also fixes a recorded probe in place when it turns out to have been run wrong.
disable-model-invocation: true
---

# Experiment

Move a study forward through the **probe loop**: plan one probe, run it, inspect it, put it in front of the user, record their decision, plan the next. Each probe is planned only once the previous result is in, because that result is what decides it.

The study's **direction** is allowed to **drift**. `STUDY.md` is where the study started, and it stays frozen; the next probe follows the evidence and the user's decision, wherever that leads. Every move away from the starting direction is logged, and that log is the study's history.

Watch the **axis** the whole time. Whenever an ask from the user or a result leaves it, at any step, triage it as `lab-notebook` describes under **Off-axis** and confirm its home with the user before creating anything. Then return to the step you were on.

## Load the study

Every run starts by loading one **study**, so a fresh session continues exactly where the last one stopped, the way a wayfinder session picks up the next ticket from the map.

1. **Pick it.** With `/experiment <study>`, the study is `science/<study>`. Without an argument, use the current branch if it is a `science/*` branch. Otherwise list the studies: for each `science/*` branch, read `.science/<study>/STUDY.md` and `NOTEBOOK.md` with `git show <branch>:<path>`, without switching branch, and show its question, last probe with verdict, and current direction; then ask which one to load. If there are no study branches, tell the user to run `/to-study` and stop.
2. **Switch to it.** If the working tree has uncommitted changes, stop and ask the user what to do with them before switching. Then check out `science/<study>`.
3. Call the Skill tool with `lab-notebook` for the tree and formats, and read `.science/SETUP.md` for the domain, stack and base branch.

Done when you are on the study branch with its `NOTEBOOK.md` open.

This session is now **bound** to the study. When an ask belongs to another study (see **Off-axis** in `lab-notebook`), record it where the triage says, then recommend a new session and give the user the exact command (`/experiment <other-study>` or `/to-study`). Switch branch in this session only when the user asks, after committing the current probe's state.

## The loop

Run steps 1 to 6 once per probe. One probe per pass, never two in parallel: the second would be planned without the first's result.

### 1. Orient

Read `NOTEBOOK.md` (current direction, probe map, probe notes, lessons, dead ends) and the README of the most recent probe, including its **Decision** and **Next**: that is where the last session, possibly a different one, left the study.

If the frontier holds research entries not yet dispatched, call the Skill tool with `desk-research` to start them in the background now; they run alongside the probe.

If a probe is marked **running**, this session is resuming it: check its job as `SETUP.md` describes, and continue at step 3 or 4 depending on whether it finished.

### 2. Plan the probe

The next probe comes from the user's last decision. If there is none yet, take it from the frontier of the probe map, earliest phase first. The map row is a sketch drawn before any result: plan the probe properly now, from what the results so far have shown.

When the user asks what to do next, or says where the current work should lead ("we are running X, but the aim is Y"), work the next probes out with them in rounds, the way `grilling` does, and add only the ones they agree to as `planned` rows (see **The probe map** in `lab-notebook`).

A good probe is the **smallest run that could prove the current belief wrong**. Size it to one session. Prefer reusing promoted protocol steps over scratch copies of them. Check the plan against every entry under **Lessons**.

Create `probes/NN-r0-running-<slug>/` with the next free number (see `lab-notebook` for the folder name) and write the top of its README: **Builds on**, **Intent**, **Prediction**. Write the prediction now, before anything runs, as a statement the result will either match or contradict. Cite under **Builds on** any research items the probe uses. In the notebook, give the probe's row its number and link, set it to `running`, and start its **Probe notes** entry.

If the plan matches what the user already chose, go straight on. If it departs from it, show the plan in a few lines and wait for the user.

### 3. Run

Organise the probe folder however the work needs. Read `SETUP.md` for how to activate the environment, where data lives and how to submit to compute.

1. Write the scripts and the probe's `.gitignore` for heavy outputs.
2. Run. Record under **Method** the exact commands, tool versions, seeds and inputs, so the probe reruns from what is committed.
3. A run that crashes or is misconfigured is not a result: fix it and rerun inside the same probe, and note the fix under **Method**.
4. For a long job, submit it, record the job id under **Method**, commit the probe as it stands (`probe NN: <slug>: running`), tell the user when to expect it, and end the session.

Done when the outputs the prediction needs exist.

### 4. Inspect

Read [RESULTS.md](../lab-notebook/RESULTS.md) before looking at the outputs. Then:

1. Make the probe's figures.
2. Judge the **verdict** against the prediction written in step 2: **held**, **failed** or **inconclusive**. A surprising result is still judged against the prediction, never against a prediction rewritten after the fact.
3. Write the brief under **Result**.
4. Update the study's single dashboard: regenerate it so it adds this probe's section and refreshes the direction, drift log and map, with every earlier probe still on it.

Done when the brief, the figures and the dashboard all show this probe.

### 5. Checkpoint

This is a hard gate: the user decides after every probe, whatever the verdict.

Present, in one message:

- the verdict and the one-sentence headline;
- the probe's key figures, and a link to the dashboard;
- a recommended decision, with the reason:
  - **continue**: the next probe along the current direction;
  - **branch**: a probe off a new question this result opened;
  - **drop**: a dead end, with what it rules out;
  - **promote**: the probe is solid and reruns, so it belongs in the protocol.
- the findings of any research items finished since the last checkpoint, one line each with a link;
- whether the decision would move the current direction, and how;
- any off-axis question this result raised, with the home you recommend for it.

Then **grill the result** with the user before the decision. Ask in **rounds**, the way `grilling` does: numbered questions, each with your recommended answer, worded so "yes" accepts it. Aim them at what the result means: whether the user reads it the way the brief does, which caveat matters most, what it changes in their belief about the question, and which of the decisions it supports. Keep it as short as the result allows: a clean result may need one round or none, a surprise may need several. Stop when the user's reading of the result and their decision are both settled, and any probes they want added or dropped are agreed.

Their call wins over your recommendation.

### 6. Record

1. Write the user's decision and its reason under **Decision**, with the reading of the result the grilling settled, and **Next** if it points to a probe.
2. Rename the probe folder from `running` to its state with `git mv`: the verdict, or `dropped` if the user decided drop. Rewrite every link to the old name (see **Renaming** in `lab-notebook`).
3. Update `NOTEBOOK.md`: set the probe's row to that state, with **Rev** `0` and **Commit** `pending`; finish its **Probe notes** entry (what it ran, the key numbers, the decision); add new dead ends. Then reshape the map as the checkpoint agreed: add the rows the user agreed to, set the rows it made pointless to `dropped`, fix the **After** edges.
4. If the decision moved the direction or reshaped the map even slightly, rewrite **Current direction** and add a **Drift log** entry that cites this probe and says what in its result forced the move.
5. Fill in every earlier `pending` commit hash, then commit: `probe NN: <slug>: <verdict>`.

Done when the commit exists and the notebook reads correctly without opening the probe.

## Fix a probe

When the user, or you, finds that a recorded probe was **run wrong** (a bug, a wrong input or parameter, a mistake in the analysis or the plots), fix it in place as `lab-notebook` describes under **Revisions**. This can happen at any point, even in the middle of another probe: commit or set aside that probe's state first, then come back to it.

1. **Confirm the fix.** Name the probe, what was wrong, and whether it is a revision or a new probe (a new question or a changed prediction is a new probe). Wait for the user's yes.
2. **Fix and rerun** in the same folder. Update **Method** to the corrected run. Never touch the **Prediction**.
3. **Inspect again** as step 4 does: new figures, the verdict against the original prediction, a new brief, the dashboard regenerated.
4. **Take it to the user** as step 5 does when the verdict or the reading of the result changed; the decision may change with it. When nothing changed but the numbers, report the fix in a few lines.
5. **Record the revision.**
   1. In the README, add a **Revisions** entry: the hash of the wrong commit, what was wrong, who caught it, what changed, the verdict and decision before and after.
   2. Rename the folder with `git mv` to the new revision count and state, for example `03-r0-held-<slug>` → `03-r1-failed-<slug>`, and rewrite every link to the old name (see **Renaming** in `lab-notebook`). In the notebook, set the row's **Status** to the new state, add 1 to **Rev**, set **Commit** to `pending`, and add the revision line to the probe's notes.
   3. Add a **Lessons** entry: the rule that would have prevented the mistake. If it holds for the whole repo, ask the user whether it also goes into `.science/SETUP.md`.
   4. If the corrected result moves the direction or the map, update them and add a **Drift log** entry, as step 6 does.
6. **Check what was built on it.** For every row whose **After** names the fixed probe, add a line to its notes (`built on NN before its rev N`) and ask the user, probe by probe, whether to rerun it (a fix of its own, through these same steps) or keep it. Leave its status as it is until they decide. If the fixed probe was promoted, tell the user the protocol step carries the mistake and needs a new promotion.
7. Fill in every earlier `pending` hash, then commit: `fix NN: <slug>: <what was wrong> (<old verdict> → <new verdict>)`.

Done when the commit exists and every probe built on the old result is marked rerun or kept.

## Leaving the loop

- **promote**: tell the user the next step is `/promote` with this probe.
- **The user stops**: the notebook already holds the state; any later session continues with `/experiment <study>`.
- **The question is answered**: say so at the checkpoint, and propose closing the study: a final line under **Current direction**, and the **Outcome** line in `STUDY.md` (see `lab-notebook`), both stating the answer and the probes that support it.

Otherwise, go back to step 1.
