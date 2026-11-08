---
name: experiment
description: Run a science study one probe at a time. Plan a probe with a prediction, run it, show the result as plots and a brief, grill the user on what it means, and let them decide the next step after every probe.
disable-model-invocation: true
---

# Experiment

Move a study forward through the **probe loop**: plan one probe, run it, inspect it, put it in front of the user, record their decision, plan the next. Each probe is planned only once the previous result is in, because that result is what decides it.

The study's **direction** is allowed to **drift**. `STUDY.md` is where the study started, and it stays frozen; the next probe follows the evidence and the user's decision, wherever that leads. Every move away from the starting direction is logged, and that log is the study's history.

Watch the **axis** the whole time. Whenever an ask from the user or a result leaves it, at any step, triage it as `lab-notebook` describes under **Off-axis** and confirm its home with the user before creating anything. Then return to the step you were on.

You must be on a `science/<study>` branch with a `NOTEBOOK.md`. If not, tell the user to run `/to-study` and stop. Call the Skill tool with `lab-notebook` for the tree and formats, and read `.science/SETUP.md` for the domain and stack.

## The loop

Run steps 1 to 6 once per probe. One probe per pass, never two in parallel: the second would be planned without the first's result.

### 1. Orient

Read `NOTEBOOK.md` (current direction, probe map, dead ends) and the README of the most recent probe.

If the frontier holds research entries not yet dispatched, call the Skill tool with `desk-research` to start them in the background now; they run alongside the probe.

If a probe is marked **running**, this session is resuming it: check its job as `SETUP.md` describes, and continue at step 3 or 4 depending on whether it finished.

### 2. Plan the probe

The next probe comes from the user's last decision. If there is none yet, take it from the frontier of the probe map, earliest phase first. The map entry is a sketch drawn before any result: plan the probe properly now, from what the results so far have shown.

A good probe is the **smallest run that could prove the current belief wrong**. Size it to one session. Prefer reusing promoted protocol steps over scratch copies of them.

Create `probes/NN-<slug>/` with the next free number and write the top of its README: **Builds on**, **Intent**, **Prediction**. Write the prediction now, before anything runs, as a statement the result will either match or contradict. Cite under **Builds on** any research items the probe uses.

If the plan matches what the user already chose, go straight on. If it departs from it, show the plan in a few lines and wait for the user.

### 3. Run

Organise the probe folder however the work needs. Read `SETUP.md` for how to activate the environment, where data lives and how to submit to compute.

1. Write the scripts and the probe's `.gitignore` for heavy outputs.
2. Run. Record under **Method** the exact commands, tool versions, seeds and inputs, so the probe reruns from what is committed.
3. A run that crashes or is misconfigured is not a result: fix it and rerun inside the same probe, and note the fix under **Method**.
4. For a long job, submit it, record the job id under **Method**, mark the probe **running** in the notebook, tell the user when to expect it, and end the session.

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

Then **grill the result** with the user before the decision. Ask in **rounds**, the way `grilling` does: numbered questions, each with your recommended answer, worded so "yes" accepts it. Aim them at what the result means: whether the user reads it the way the brief does, which caveat matters most, what it changes in their belief about the question, and which of the decisions it supports. Keep it as short as the result allows: a clean result may need one round or none, a surprise may need several. Stop when the user's reading of the result and their decision are both settled.

Their call wins over your recommendation.

### 6. Record

1. Write the user's decision and its reason under **Decision**, with the reading of the result the grilling settled, and **Next** if it points to a probe.
2. Update `NOTEBOOK.md`: the probe's line and verdict, and new dead ends. Tick the probe on the map, then reshape the map for what the result showed: add the probes it made sharp (from **Not yet mapped** or new), drop or reorder the ones it made pointless, fix the `after:` edges.
3. If the decision moved the direction or reshaped the map even slightly, rewrite **Current direction** and add a **Drift log** entry that cites this probe and says what in its result forced the move.
4. Commit: `probe NN: <slug>: <verdict>`.

Done when the commit exists and the notebook reads correctly without opening the probe.

## Leaving the loop

- **promote**: tell the user the next step is `/promote` with this probe.
- **The user stops**: the notebook already holds the state; the next session picks up at step 1.
- **The question is answered**: say so at the checkpoint, and propose closing the study with a final line under **Current direction** that states the answer and the probes that support it.

Otherwise, go back to step 1.
