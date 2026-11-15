---
name: promote
description: Promote the work of one or more probes from a science study into the protocol in the main tree, after a grilling round and an agreed directory tree.
license: MIT
disable-model-invocation: true
---

# Promote

Move work that has proven itself in a study's scratch probes into the **protocol**: the rerunnable steps in the repo that later probes and the engineering flow build on. Scratch is free-form; the protocol is shared, so its shape is agreed, never chosen alone.

Promote a step because it has earned a place in the protocol, not to share it with another study: a spin-off reads its parent's probes in place.

Call the Skill tool with `lab-notebook` for the tree, the formats and the rules of the shared checkout, and read `.science/SETUP.md` for the stack and the **Promotion** mode.

## 1. Check the named probes

The user names one or more probes (`/promote 01 02 04`), usually with observations about the workflow. Read those probes, the observations and the notebook. A probe is ready when it provides valid evidence supporting its intended reuse and it reruns from what is committed. Check the relevant controls and validation criteria for that use: `completed` alone is not enough, and an unmet method-validation criterion still blocks that use. A result that differs from the agent's expectation can qualify; explain what the evidence supports.

A dropped probe stays a dead end: tell the user it is left out, and why. For any other probe that isn't ready, note what it lacks for the grilling round.

Done when every named probe is ready, left out as dropped, or noted with what it lacks.

## 2. Grill what the promotion is for

Call the Skill tool with `grilling` and run it on this promotion. The aim is to understand what the user needs from it: the final protocol, the methods of a publication, a figure to regenerate, a step later studies rerun. The probes and the user's observations settle much of it; ask only what they leave open.

The first question is always the grouping into **steps**. Propose one step per probe, except where a probe only feeds another: those join into one step (docking, then rescoring of the docked poses, is one ranking step). The user confirms or regroups. When a probe isn't ready, say what it lacks and recommend promoting the rest without it; promote the rest only when the user agrees.

Further questions follow from what the user needs, and only where the answer changes what gets ported: which outputs matter for the paper or the protocol, what a rerun must reproduce and how closely, which values become parameters, which fetched or produced data goes along.

Done when every step has its probes, its intended reuse and its regression tolerance agreed, and every probe that isn't ready is either left out with the user's agreement or the promotion waits for it.

## 3. Agree the directory tree

This step is a hard gate: nothing is written to the protocol until the user approves the tree.

Propose one tree for the whole promotion: where each step lives in the protocol, the folders and files it adds or changes, with one line per folder saying why it sits there. Read the existing protocol first so the proposal extends its layout rather than inventing a parallel one.

Iterate until the user approves the tree, word for word. Record the approved tree under **Reading** in the README of every probe it promotes.

Done when the user has approved the tree word for word and it is recorded in each of those READMEs.

## 4. Port each step

For each step:

1. Move its probes' working scripts into the approved tree, together with the data the step needs that the probes fetched or produced (a curated set, a reference result, a prepared structure, a trained checkpoint), with its fetch script and source; the approved tree says where data goes. The user's input data stays in the data folder, and the step reads it there. Replace hard-coded paths and one-off values with parameters; keep the probes' values as the documented defaults.
2. Call the Skill tool with `tdd` to add a regression check: the promoted step, run on its probes' committed inputs, reproduces their validated result within the agreed tolerance.
3. Call the Skill tool with `code-review` on the protocol change.

Done when every step's regression check is green and the review's findings are fixed.

## 5. Record and commit

Each step gets its own commit and tag, in the same run, so it can be reverted or rerun on its own. For each step:

1. In `NOTEBOOK.md`, set the block of each of its probes to `promoted`, say in its prose where it went in the protocol, and add a log line. The folders keep their names.
2. Append one line under `## Promoted` in `.science/<study>/STUDY.md`: ``- `<step>` (<its place in the protocol>): from NN-<slug>, NN-<slug>; tag `<study>/promote-<step>` ``.
3. Commit, following the **Promotion** mode in `SETUP.md`:
   - **commit**: one commit holding the step's protocol files, its promoted data and the study folder, `<study>: promote NN: <step>` (NN lists the step's probes), limited to those paths, and tagged `<study>/promote-<step>`.
   - **pull request**: the step's protocol change goes through a short-lived `protocol/<step>` branch in its own worktree (`git worktree add -b protocol/<step> ../<repo>-promote-<step>`), so this checkout stays on its branch. Commit the protocol files and the promoted data there and open the pull request into the current branch, written with the `pr` skill. The description points back to the evidence, so a reviewer can judge the step without the study open: the probes it came from, the approved tree, and the regression check with its tolerance. In this checkout, commit the study folder (`<study>: promote NN: <step>`) and tag it. Once the pull request merges, pull it into this branch and remove the worktree.

Done when every step is committed (or its pull request is open), and the notebook, `STUDY.md` and the tags name each one. Tell the user the next step is back to `/experiment <study>`, building on the protocol.
