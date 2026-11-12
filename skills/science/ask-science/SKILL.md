---
name: ask-science
description: "Put a confused science session back on track: show the science flow, find where you are and what drifted (git branches, the study's question, the notebook), repair it with the user, and say how to resume."
disable-model-invocation: true
---

The user is lost in a science study: unsure where they are, or sensing that the branches, the question or the notebook have drifted from the protocol. Get them back on the tracks: show the flow, find where they are, repair what drifted, guard against it happening again, and hand them the one command that resumes the work.

Change nothing until the user approves it. Call the Skill tool with `lab-notebook` for the tree, the formats and the folder names; the checks below compare the repo against them.

## 1. The map

Show this map, then mark where the user is once step 2 knows.

```
/setup-science        once per repo, on the base branch: .science/SETUP.md
      │
/to-study             cuts science/<study> from the base branch: STUDY.md + NOTEBOOK.md
      │
/experiment <study>   loads one study per session, then loops on science/<study>:
      │                 plan → run → inspect → decide (with the user) → record
      ├── fix a probe     a probe run wrong: fixed in place, rev +1, a lesson
      ├── desk-research   a question answered from sources, in parallel
      ├── spin-off        a new question: a new study, in a new session
      └── /promote        a validated probe → protocol/<step> → PR into the base branch;
                          the study branch then merges the base branch in
```

Answer the user's direct questions about the flow from this map and the skills it names. Read a skill's `SKILL.md` before stating what it does.

## 2. You are here

A read-only check. Read `.science/SETUP.md` first for the base branch, then check what the current branch calls for:

- **No `.science/SETUP.md`** on any branch: the repo is not set up. Recommend `/setup-science` and skip to step 5.
- **The base branch, a `protocol/*` branch, or any other branch**: list the studies, one line each, read with `git show science/<study>:.science/<study>/NOTEBOOK.md` without switching: the question, the last probe and its state, the current direction. List every `protocol/*` branch and whether it is merged into the base branch. Check the Git rows below for this branch.
- **A `science/<study>` branch**: check that study in depth, against every row below. Other studies get one line each, as above.

| Kind | Drift to look for |
|---|---|
| Git | Uncommitted changes. Commits on the wrong branch: probe or notebook work on the base branch, study work on a `protocol/*` branch, protocol code on the study branch outside a probe folder. A study branch that has not merged the base branch since a promotion merged. A `protocol/*` branch left unmerged with no open pull request. A worktree or session holding another study. |
| Science | The **Current direction** against the question in `STUDY.md`: has it moved away with no **Drift log** entry? Probes whose **Intent** does not serve the question. Work in this session that belongs to another study, or to no study. A question that has drifted so far it is a different study. |
| Notebook | Every started row in the probe map has a folder whose name matches its number, **Rev** and **Status**, and every folder has a row. No `pending` hash older than the last commit. A `running` probe has a job id or an active run. Every decided probe has a **Decision**, and the last one a **Next**. Every revision has its probe notes line and a **Lessons** entry. Links resolve. |

Report the result in a few lines: the branch and what kind it is, the study and its last probe, and the drift found, most serious first. A clean check says so and goes to step 5.

## 3. Repair

Take the drift one item at a time, most serious first. For each, propose the fix in a line or two, wait for the user's yes, then apply it and commit it on the branch it belongs to. For example:

- Work committed on the wrong branch: cherry-pick it to the right branch, then revert it or reset it where it landed, whichever the user prefers.
- A folder name, a table row or a `pending` hash out of step: apply what `lab-notebook` says it should be.
- A direction that moved without a drift log entry: write the entry with the user, citing the probe that moved it.

When the **question itself has drifted**, the fix is the user's choice, so offer three options:

1. **The drift is legitimate.** The study now asks the new question: rewrite **Current direction** and add a drift log entry. `STUDY.md` stays frozen.
2. **Spin off.** The new question is a different study: start it with `/to-study`, cut from this branch at the probe where the drift began, in a new session. Record it under **Spin-offs**, and set probes that belong to the new study to `dropped` here.
3. **Back to the question.** Set the off-axis probes to `dropped`, record them under **Dead ends** if they taught something, and replan from the last on-axis probe.

## 4. Prevent

Find what let the drift happen. Read this session's conversation, the study branch's `git log`, and the notebook's **Drift log**: they usually show where it began, such as the first commit on the wrong branch, or the first probe whose Intent left the question. Read older session logs only when the user points at one.

Then suggest where the guard belongs, and write it once the user agrees:

- **A Lesson** in the notebook, when it is about this study.
- **A convention in `.science/SETUP.md`**, when it holds for the whole repo.
- **A change to a science skill**, when a skill told the agent to do the wrong thing or left a gap. Report it to the user as a proposal, naming the skill and the change. Never edit the skills from inside a study.

## 5. Back on track

End with the one command that resumes the work, and why: `/experiment <study>` to continue, `/to-study` for a new question, `/promote` for a validated probe, or `/setup-science` for a repo with no setup. If resuming needs a new session, give the exact command for it.

Done when the user has that command, and every drift item is repaired or deliberately left as it is.
