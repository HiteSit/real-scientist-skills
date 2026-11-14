---
name: ask-science
description: "Step back from a science study: look back over its probes and conversation to judge whether it is on track, drifting or lost, find where STUDY.md, the notebook and the probes disagree, resolve each ambiguity with the user, and say how to resume."
license: MIT
disable-model-invocation: true
---

The user wants to step back from a study: unsure where it stands, or sensing that the work, the notebook or the question have wandered. This is a **retrospective** on one study: look back over what was done, judge whether it still serves the question, settle every place where the records disagree, and hand the user the command that resumes the work.

Change nothing until the user approves it. Call the Skill tool with `lab-notebook` for the tree, the formats and the probe states; the checks below compare the study against them.

## 1. The map

Show this map, then mark where the user is once step 2 knows.

```
/setup-science         once per repo: git, .science/SETUP.md, the library, the data folder,
      │                the conventions in AGENTS.md
      │
/experiment <study>    loads a study and focuses the session on it;
      │                opens it first when the folder does not exist (short grilling, first probe)
      │
      ├── probes        one at a time, chosen with the user: open → evidence when the next starts
      │                 (dropped only on the user's word)
      ├── fix a probe   a probe run wrong: fixed in place, rev +1, a lesson
      ├── desk-research a question answered once, into .science/library/, shared by every study
      ├── spin-off      a different question: /experiment <new-study> in a new session
      └── /promote      a probe's work moves into the protocol in the main tree

/ask-science           this: a step back, on one study
```

Answer the user's direct questions about the flow from this map and the skills it names. Read a skill's `SKILL.md` before stating what it does.

## 2. Find the study

No `.science/SETUP.md`: the repo is not set up; recommend `/setup-science` and skip to step 6. Otherwise the study is the one this session loaded, the one the user names, or ask, listing every study in one line (open or closed, the question, its open probes).

## 3. Look back

Read where the study started (`STUDY.md`), where it says it is (the notebook's **Current direction**, **Drift log**, the last probes' notes and **Discussion**), what was actually done (`git log --grep '^<study>:'`, the probe READMEs), and this session's conversation. Then answer, with the evidence for each:

- What is the question now, and is it still the one in `STUDY.md`, or a change the drift log explains?
- What have the last few probes been trying to find out, and does that work bring the answer closer?
- Where did the direction start to shift, and did the user agree to the shift when it happened?
- Is the study still one question, or has it grown a second that belongs to another study?

Give a **verdict** in a few lines: **on track**, **drifting** (and since when, and why), or **lost**. Then the evidence, most telling first.

## 4. Settle the ambiguities

Compare the records with each other and with the format in `lab-notebook`. Every place where they disagree, or where the right reading is unclear, is an **ambiguity**, and the user resolves it. Look at least for:

- `STUDY.md` and the notebook telling different stories: a current direction with no drift log entry to explain it, a question restated differently.
- The **Probes** table and the probe folders: a row with no folder, a folder with no row, names that do not match.
- A probe's state against its README: open with its results long recorded while later probes ran, evidence with results still out, dropped with nothing under **Dead ends**.
- Notebook sections outside the format, or a story told twice in different words.
- **Ideas** that were already run, and probes run that the study never agreed to.
- Work in the wrong place: this study's work in another study's folder or none, uncommitted changes, commits whose `<study>:` prefix does not match the paths they touch.
- The library and data folder: pages or datasets missing from their index, fetched data inside the data folder.

Ask about them in rounds, the way `grilling` does: numbered questions, each naming the ambiguity, quoting the records that disagree, and giving your recommended reading, worded so "yes" accepts it. Most serious first. Wait for the answers before the next round.

When the **question itself has drifted**, offer three readings:

1. **The drift is legitimate.** The study now asks the new question: rewrite **Current direction** and add a drift log entry. `STUDY.md` stays frozen.
2. **Spin off.** The new question is a different study: it starts with `/experiment <new-study>` in a new session, naming the probes where the drift began under **Builds on**. Record it under **Spin-offs**.
3. **Back to the question.** Set the off-axis probes to `dropped`, record what they taught under **Dead ends**, and pick the next probe from the last on-axis one.

## 5. Repair and prevent

Apply each answer as a new commit, limited to the paths it fixes and prefixed with the study it belongs to; history stays as it is, because the checkout is shared.

Then name what let the drift happen, from step 3, and suggest one guard, written once the user agrees:

- **A Lesson** in the notebook, when it is about this study.
- **A convention in `.science/SETUP.md`**, when it holds for the whole repo.
- **A change to a science skill**, when a skill told the agent to do the wrong thing or left a gap: report it as a proposal naming the skill and the change; the skills are edited where they are maintained, outside the study.

## 6. Back on track

End with the one command that resumes the work, and why: `/experiment <study>` to continue, `/experiment <new-study>` for a spin-off, `/promote` for work ready for the protocol, or `/setup-science` for a repo with no setup. If resuming needs a new session, say so.

Done when the user has the verdict, every ambiguity is resolved or deliberately left, and they have that command.
