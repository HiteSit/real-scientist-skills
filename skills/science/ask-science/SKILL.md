---
name: ask-science
description: "Put a confused science session back on track: show the science flow, find where you are and what drifted (git, the study's question, the notebook, the library), repair it with the user, and say how to resume."
license: MIT
disable-model-invocation: true
---

The user is lost in the science work: unsure where they are, or sensing that git, the question, the notebook or the library have drifted from the conventions. Get them back on the tracks: show the flow, find where they are, repair what drifted, guard against it happening again, and hand them the one command that resumes the work.

Change nothing until the user approves it. Call the Skill tool with `lab-notebook` for the tree, the formats, the folder names and the rules of the shared checkout; the checks below compare the repo against them.

## 1. The map

Show this map, then mark where the user is once step 2 knows.

```
/setup-science        once per repo: git init if needed, .science/SETUP.md, the home branch,
      │               an empty library and data folder, the conventions in AGENTS.md
      │
/to-study             frames the question, reading the library where needed;
      │               opens .science/<study>/ with STUDY.md + NOTEBOOK.md, tag <study>/open
      │
/experiment <study>   loads one study per session, then loops in its folder:
      │                 plan → run → inspect → decide (with the user) → record, tag <study>/NN-r0
      ├── fix a probe     a probe run wrong: fixed in place, rev +1, a lesson, tag <study>/NN-r<R>
      ├── desk-research   a question answered once, into .science/library/, shared by every study
      ├── spin-off        a new question: a new study folder, in a new session
      └── /promote        a validated probe → the protocol, by commit or pull request,
                          tag <study>/promote-<step>

All studies: one branch, one checkout, one session each, commits limited to their own folder.
```

Answer the user's direct questions about the flow from this map and the skills it names. Read a skill's `SKILL.md` before stating what it does.

## 2. You are here

A read-only check.

- **No `.science/SETUP.md`**: the repo is not set up. Recommend `/setup-science` and skip to step 5.
- **Otherwise**: list every study, one line each from its `NOTEBOOK.md` and `STUDY.md`: open or closed, the question, the last probe and its state, the recorded **Branch**. Then find the study the user is in: the one this session loaded, the one the user names, or ask. Check that study in depth against every row below; check the Git and Library rows for the repo as a whole.

| Kind | Drift to look for |
|---|---|
| Git | The current branch against the study's recorded **Branch**. Uncommitted changes, sorted by owner: this study's folder, another study's folder, the library, the protocol, elsewhere. Commits whose `<study>:` prefix does not match the paths they touch, and science commits with no prefix. Decided probes, fixes, promotions and closes with no tag, and tags whose probe row says otherwise. Stashes, a detached HEAD, a branch switch in the reflog during a running study. |
| Science | The **Current direction** against the question in `STUDY.md`: has it moved away with no **Drift log** entry? Probes whose **Intent** does not serve the question. Work in this session that belongs to another study, or to no study. A question that has drifted so far it is a different study. |
| Notebook | Every started row in the probe map has a folder whose name matches its number, **Rev** and **Status**, and every folder has a row. **Blocked by** matches between each row and its README. A `running` probe has a job id or an active run. Every decided probe has a **Decision**, and the last one a **Next**. Every revision has its probe notes line and a **Lessons** entry. Links resolve. |
| Library and data | Every library page has an index line, and every index line a page. Every `done` research row links to a page. Every page's **Evidence** points to saved searches. Pages that name a study. Every dataset in the data folder has an index line and a README naming where it came from. Anything in the data folder besides the user's own input data (fetched exports, checkpoints, probe outputs). Fetched data in a probe with no source or fetch script. |

Report the result in a few lines: the branch, the study and its last probe, and the drift found, most serious first. A clean check says so and goes to step 5.

## 3. Repair

Take the drift one item at a time, most serious first. For each, propose the fix in a line or two, wait for the user's yes, then apply it as a new commit, limited to the paths it fixes and prefixed with the study it belongs to. History stays as it is: the checkout is shared, so every repair adds a commit. For example:

- Work that landed in the wrong study's folder: move it with `git mv` into the right one, and commit.
- A folder name, a table row or a missing tag out of step: apply what `lab-notebook` says it should be; a missing tag goes on the commit that should carry it.
- A study now running on another branch: update **Branch** in its notebook, or tell the user how to return to the recorded one.
- A direction that moved without a drift log entry: write the entry with the user, citing the probe that moved it.
- A library page missing from the index, or naming a study: fix the index or the page, and log it.

When the **question itself has drifted**, the fix is the user's choice, so offer three options:

1. **The drift is legitimate.** The study now asks the new question: rewrite **Current direction** and add a drift log entry. `STUDY.md` stays frozen.
2. **Spin off.** The new question is a different study: start it with `/to-study` in a new session, with the probes where the drift began listed under its **Blocked by**. Record it under **Spin-offs**, and set probes that belong to the new study to `dropped` here.
3. **Back to the question.** Set the off-axis probes to `dropped`, record them under **Dead ends** if they taught something, and replan from the last on-axis probe.

## 4. Prevent

Find what let the drift happen. Read this session's conversation, the study's history (`git log --grep '^<study>:'` and `git log -- .science/<study>`), and the notebook's **Drift log**: they usually show where it began, such as the first commit touching another study's folder, or the first probe whose Intent left the question. Read older session logs only when the user points at one.

Then suggest where the guard belongs, and write it once the user agrees:

- **A Lesson** in the notebook, when it is about this study.
- **A convention in `.science/SETUP.md`**, when it holds for the whole repo.
- **A change to a science skill**, when a skill told the agent to do the wrong thing or left a gap. Report it to the user as a proposal, naming the skill and the change; the skills are edited where they are maintained, outside the study.

## 5. Back on track

End with the one command that resumes the work, and why: `/experiment <study>` to continue, `/to-study` for a new question, `/promote` for a validated probe, or `/setup-science` for a repo with no setup. If resuming needs a new session, give the exact command for it.

Done when the user has that command, and every drift item is repaired or deliberately left as it is.
