---
name: promote
description: Promote a validated probe from a science study into the protocol on the base branch, after agreeing the directory tree with the user.
disable-model-invocation: true
---

# Promote

Move work that has proven itself in a study's scratch probes into the **protocol**: the rerunnable steps on the **base branch** (named in `.science/SETUP.md`) that later probes and the engineering flow build on. Scratch is free-form; the protocol is shared, so its shape is agreed, never chosen alone.

Promote a step because it has earned a place in the protocol, not to share it with another study: a spin-off study can start from its parent's branch instead.

You must be on a `science/<study>` branch. Call the Skill tool with `lab-notebook` for the tree and formats, and read `.science/SETUP.md` for the stack.

## 1. Confirm the probe is ready

Read the probe or chain of probes the user names, and the notebook. A probe is ready when its verdict is **held**, its decision was **promote**, and it reruns from what is committed. If any of these fails, say which and stop.

## 2. Agree the directory tree

This step is a hard gate: nothing is written to the protocol until the user approves the tree.

Propose where the promoted step lives in the protocol: the folders and files it adds or changes, with one line per folder saying why it sits there. Show it as a tree. Read the existing protocol first so the proposal extends its layout rather than inventing a parallel one.

Iterate until the user approves the tree, word for word. Record the approved tree in the probe README under **Decision**.

## 3. Port the step

1. Cut `protocol/<step>` from the base branch.
2. Move the probe's working scripts into the approved tree, along with any research items the step needs at run time (reference data, say), with their fetch scripts and provenance. Replace hard-coded paths and one-off values with parameters; keep the probe's values as the documented defaults.
3. Call the Skill tool with `tdd` to add a regression check: the promoted step, run on the probe's committed inputs, reproduces the probe's validated result within a stated tolerance.
4. Record the promotion in `.science/<study>/STUDY.md` on this branch. If the file isn't there yet (the first promotion from this study), copy it from the study branch with `git show science/<study>:.science/<study>/STUDY.md`. Append one line under `## Promoted`: ``- `<step>` (`protocol/<step>`): from <NN-slug>, <NN-slug>``. This is how `STUDY.md` reaches the base branch.
5. Call the Skill tool with `code-review` on the branch.

Done when the regression check is green and the review's findings are fixed.

## 4. Open the pull request

Open a pull request from `protocol/<step>` into the base branch. Call the Skill tool with `pr` for its shape. The description points back to the evidence, so a reviewer can judge the step without the study open:

- the study branch and the probe or probes it came from, linked to their READMEs;
- the approved tree;
- the regression check and the tolerance it holds to.

Done when the pull request is open and links all three.

## 5. Close the loop on the study

Back on `science/<study>`:

1. In `NOTEBOOK.md`, set the probe's row to `promoted` with **Commit** `pending`, add `promoted to protocol/<step>` to its probe notes, and note the pull request in the probe README under **Decision**.
2. Append the same `## Promoted` line to `.science/<study>/STUDY.md`, byte for byte as on `protocol/<step>`, so both branches hold the same file and the later merge is clean.
3. Fill in every earlier `pending` commit hash (see `lab-notebook`), then commit: `promote NN: <step>`.
4. Once the pull request has merged, merge the base branch into the study branch, so later probes call the promoted step instead of the probe's scratch copy. The study branch itself never merges into the base branch.

Done when the notebook and `STUDY.md` name the promotion and, after the merge, the study branch contains the promoted step. Tell the user the next step is back to `/experiment <study>`, building on the protocol.
