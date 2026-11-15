---
name: ask-science
description: "Step back from a science study: bring it and the shared .science/ shape up to the current format, then look back over its probes and conversation to judge whether it is on track, drifting or lost, find where STUDY.md, the notebook and the probes disagree, resolve each ambiguity with the user, and say how to resume."
license: MIT
disable-model-invocation: true
---

The user wants to step back from a study: unsure where it stands, sensing that the work, the notebook or the question have wandered, or after the science skills changed. This is a **retrospective** on one study: bring its records up to the current format, look back over what was done, judge whether it still serves the question, settle every place where the records disagree, and hand the user the command that resumes the work.

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
      └── /promote      the work of one or more probes moves into the protocol in the main tree

/ask-science           this: a step back on one study, bringing it to the current format first
```

Answer the user's direct questions about the flow from this map and the skills it names. Read a skill's `SKILL.md` before stating what it does.

## 2. Find the study

No `.science/SETUP.md`: the repo is not set up; recommend `/setup-science` and skip to step 7. Otherwise the study is the one this session loaded, the one the user names, or ask, listing every study in one line (open or closed, the question, its open probes).

## 3. Bring it to the current format

The skills change; a study written under an older version keeps its old shape until this step brings it up to date. Compare the study, and the shared `.science/` parts it uses, with the formats in `lab-notebook`:

- Probe folder names: `NN-<slug>`. An old name carrying a state or a revision, like `14-r0-failed-docking`, loses it (`14-docking`); the state goes on the probe's block.
- `STUDY.md` sections. A later correction written into it moves to the notebook's **Current direction** and **Drift log**, and `STUDY.md` goes back to its starting text.
- `NOTEBOOK.md`, rebuilt in the current sections: the map (threads and probe blocks) and the log built from the old notebook, the probe READMEs and `git log --grep '^<study>:'`.
- Each probe README, its sections renamed and reordered.
- The library's layout and index, and the data folder's index.

`.science/SETUP.md` and the `## Science skills` section of `AGENTS.md` belong to `/setup-science`: when they are out of date, say so and recommend rerunning it; do not edit them here.

Move content, never invent it. Where the current format needs something the old records lack (the **asked** of an old probe, the threads), rebuild it from the probe's first README and first commits and mark it `[reconstructed]`; step 5 asks the user about each one. Delete nothing: old text with no place of its own goes in the nearest section that fits, such as the probe's **Reading** or the thread prose.

Show the plan as one table (path, what changes, where anything rebuilt comes from) and wait for the user's yes. Then apply it with `git mv` for the renames: one commit `<study>: migrate to current format` for the study, and one `science: migrate to current format` for the shared parts. Tags stay on their old commits and keep pointing at the old paths. When everything is already current, say so in one line and go on.

## 4. Look back

Read where the study started (`STUDY.md`), where it says it is (the notebook's **Current direction**, **Map**, **Log** and **Drift log**), what was actually done (`git log --grep '^<study>:'`, the probe READMEs, especially **Asked** against **Reading**), and this session's conversation. Then answer, with the evidence for each:

- What is the question now, and is it still the one in `STUDY.md`, or a change the drift log explains?
- What have the last few probes been trying to find out, and does that work bring the answer closer?
- Where did the direction start to shift, and did the user agree to the shift when it happened?
- Is the study still one question, or has it grown a second that belongs to another study?

Give a **verdict** in a few lines: **on track**, **drifting** (and since when, and why), or **lost**. Then the evidence, most telling first.

## 5. Settle the ambiguities

Compare the records with each other and with the format in `lab-notebook`. Every place where they disagree, or where the right reading is unclear, is an **ambiguity**, and the user resolves it. Look at least for:

- `STUDY.md` and the notebook telling different stories: a current direction with no drift log entry to explain it, a question restated differently.
- The **Map** and the probe folders: a block with no folder, a folder with no block, names that do not match; a block whose **asked**, **found** or **means** says something different from its README.
- A probe's state against its README: open with its results long recorded while later probes ran, evidence with results still out, dropped with nothing under **Dead ends**. A **means** still marked `[inference]` long after the result was discussed.
- Work recorded in git but not in the notebook: probe commits with no log line, results the map does not show.
- Everything the migration marked `[reconstructed]`: confirm or correct it, then drop the mark.
- A story told twice in different words.
- **Ideas** that were already run, and probes run that the study never agreed to.
- Work in the wrong place: this study's work in another study's folder or none, uncommitted changes, commits whose `<study>:` prefix does not match the paths they touch.
- The library and data folder: pages or datasets missing from their index, fetched data inside the data folder.

Ask about them in rounds, the way `grilling` does: numbered questions, each naming the ambiguity, quoting the records that disagree, and giving your recommended reading, worded so "yes" accepts it. Most serious first. Wait for the answers before the next round.

When the **question itself has drifted**, offer three readings:

1. **The drift is legitimate.** The study now asks the new question: rewrite **Current direction** and add a drift log entry. `STUDY.md` stays frozen.
2. **Spin off.** The new question is a different study: it starts with `/experiment <new-study>` in a new session, naming the probes where the drift began under **Builds on**. Record it under **Spin-offs**.
3. **Back to the question.** Set the off-axis probes to `dropped`, record what they taught under **Dead ends**, and pick the next probe from the last on-axis one.

## 6. Repair and prevent

Apply each answer as a new commit, limited to the paths it fixes and prefixed with the study it belongs to; history stays as it is, because the checkout is shared.

Then name what let the drift happen, from step 4, and suggest one guard, written once the user agrees:

- **A Lesson** in the notebook, when it is about this study.
- **A convention in `.science/SETUP.md`**, when it holds for the whole repo.
- **A change to a science skill**, when a skill told the agent to do the wrong thing or left a gap: report it as a proposal naming the skill and the change; the skills are edited where they are maintained, outside the study.

## 7. Back on track

End with the one command that resumes the work, and why: `/experiment <study>` to continue, `/experiment <new-study>` for a spin-off, `/promote` for work ready for the protocol, or `/setup-science` for a repo with no setup. If resuming needs a new session, say so.

Done when the study is in the current format, the user has the verdict, every ambiguity is resolved or deliberately left, and they have that command.
