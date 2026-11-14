---
name: promote
description: Promote a probe's work from a science study into the protocol in the main tree, after agreeing the directory tree with the user.
license: MIT
disable-model-invocation: true
---

# Promote

Move work that has proven itself in a study's scratch probes into the **protocol**: the rerunnable steps in the repo that later probes and the engineering flow build on. Scratch is free-form; the protocol is shared, so its shape is agreed, never chosen alone.

Promote a step because it has earned a place in the protocol, not to share it with another study: a spin-off reads its parent's probes in place.

Call the Skill tool with `lab-notebook` for the tree, the formats and the rules of the shared checkout, and read `.science/SETUP.md` for the stack and the **Promotion** mode.

## 1. Confirm the probe is ready

Read the probe or chain of probes the user names, and the notebook. A step is ready when the probes provide valid evidence supporting its intended reuse, the user asked to promote it, and it reruns from what is committed. Check the relevant controls and validation criteria for that use: `completed` alone is not enough, and an unmet method-validation criterion still blocks that use. A result that differs from the agent's expectation can qualify; explain what the evidence supports. If readiness is not established, say what is missing and stop.

## 2. Agree the directory tree

This step is a hard gate: nothing is written to the protocol until the user approves the tree.

Propose where the promoted step lives in the protocol: the folders and files it adds or changes, with one line per folder saying why it sits there. Show it as a tree. Read the existing protocol first so the proposal extends its layout rather than inventing a parallel one.

Iterate until the user approves the tree, word for word. Record the approved tree in the probe README under **Reading**.

## 3. Port the step

1. Move the probe's working scripts into the approved tree, together with the data the step needs that the probe fetched or produced (a curated set, a reference result, a prepared structure, a trained checkpoint), with its fetch script and source; the approved tree says where data goes. The user's input data stays in the data folder, and the step reads it there. Replace hard-coded paths and one-off values with parameters; keep the probe's values as the documented defaults.
2. Call the Skill tool with `tdd` to add a regression check: the promoted step, run on the probe's committed inputs, reproduces the probe's validated result within a stated tolerance.
3. Call the Skill tool with `code-review` on the protocol change.

Done when the regression check is green and the review's findings are fixed.

## 4. Record and commit

1. In `NOTEBOOK.md`, set the probe's block to `promoted`, say in its prose where it went in the protocol, and add a log line. The folder keeps its name.
2. Append one line under `## Promoted` in `.science/<study>/STUDY.md`: ``- `<step>` (<its place in the protocol>): from NN-<slug>, NN-<slug>; tag `<study>/promote-<step>` ``.
3. Commit, following the **Promotion** mode in `SETUP.md`:
   - **commit**: one commit holding the protocol files, the promoted data and the study folder, `<study>: promote NN: <step>`, limited to those paths, and tagged `<study>/promote-<step>`.
   - **pull request**: the protocol change goes through a short-lived `protocol/<step>` branch in its own worktree (`git worktree add -b protocol/<step> ../<repo>-promote-<step>`), so this checkout stays on its branch. Commit the protocol files and the promoted data there and open the pull request into the current branch, written with the `pr` skill. The description points back to the evidence, so a reviewer can judge the step without the study open: the probes it came from, the approved tree, and the regression check with its tolerance. In this checkout, commit the study folder (`<study>: promote NN: <step>`) and tag it. Once the pull request merges, pull it into this branch and remove the worktree.

Done when the protocol step is committed (or its pull request is open), and the notebook, `STUDY.md` and the tag all name the promotion. Tell the user the next step is back to `/experiment <study>`, building on the protocol.
