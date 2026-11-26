# Review a study

Read the records in their existing format. For a question about the workflow, read the relevant skill and explain where the study is: repo configuration, an open probe or revision, library research, a possible spin-off, or an approved promotion cycle. A question about the flow does not require a verdict or a write.

## Look back

Read where the study started (`STUDY.md`), where it says it is (the notebook's **Current direction**, **Map**, **Log** and **Drift log**), what was actually done (`git log --grep '^<study>:'`, the probe READMEs, especially **Asked** against **Reading**), and this session's conversation. Then answer, with the evidence for each:

- What is the question now, and is it still the one in `STUDY.md`, or a change the drift log explains?
- What have the last few probes been trying to find out, and does that work bring the answer closer?
- Where did the direction start to shift, and did the user agree to the shift when it happened?
- Is the study still one question, or has it grown a second that belongs to another study?

For a trajectory review, give your assessment: **on track**, **drifting** (since when and why), or **lost**, with the strongest evidence first. If records are insufficient, say what you could not establish. This assesses the study's direction; it is not a probe outcome or a user decision.

## Resolve disagreements

Compare the records with each other and with the format in `lab-notebook`. Every place where they disagree, or where the right reading is unclear, is an **ambiguity**, and the user resolves it. Look at least for:

- `STUDY.md` and the notebook telling different stories: a current direction with no drift log entry to explain it, a question restated differently.
- The **Map** and actual record locations: follow notebook hrefs across every cycle and current batch before calling a folder missing. Check ID uniqueness, manifest moves/dispositions, necessary live consumers and absence of duplicate copies/compatibility aliases in `probes/`. An approved archived record is not misplaced.
- State against remaining work: recorded results with unresolved jobs/analysis/discussion or partial components may legitimately stay open. Evidence with unfinished work, dropped with no **Dead ends**, or stale inference labels need clarification; physical `active/` placement does not override current notebook state.
- Work recorded in git but not in the notebook: probe commits with no log line, results the map does not show.
- Entries marked `[reconstructed]`: identify the source and which details the user has confirmed, corrected or left uncertain.
- A story told twice in different words.
- **Ideas** already run or work never agreed to. Distinguish an unexecuted alternative from a numbered probe with evidence. Point out legacy approach folders and their unique content; a review does not move or delete them.
- Work in the wrong place: this study's work in another study's folder or none, uncommitted changes, commits whose `<study>:` prefix does not match the paths they touch.
- Library/data indexes and dataset authority: distinguish explicitly approved shared source/prepared/reference data from unapproved fetched probe data, and workflow databases/outputs from general datasets.
- Ideas and cycles: proposals treated as executed, dropped probes or inconclusive evidence hidden, partial promotion incorrectly closing an open probe, archive mistaken for scientific invalidity, stale consumers or map links, and missing preservation digests.

Use decisions the user has already stated. For genuine ambiguities, quote the conflicting records, most consequential first, and ask what the user means with a recommended reading. A request for a review authorizes findings, not edits. Explain possible repairs and apply only resolutions the user directs.

When the **question itself has drifted**, offer three readings:

1. **The drift is legitimate.** The study now asks the new question: rewrite **Current direction** and add a drift log entry. `STUDY.md` stays frozen.
2. **Spin off.** The new question is a different study: it starts with `/experiment <new-study>` in a new session, naming the probes where the drift began under **Builds on**. Record it under **Spin-offs**.
3. **Back to the question.** Resume from the last on-axis probe. Only mark an off-axis probe `dropped` if the user explicitly drops it; record what it taught under **Dead ends**.

## Apply agreed resolutions

Record agreed changes in the affected records as dated, attributed additions. Preserve earlier readings and observations; update the notebook's current pointers, log and direction as appropriate. Under `lab-notebook` **Commits and tags**, checkpoint each coherent repair if authorized. Report any edits left pending.

If a guard against recurrence would help, propose one where it belongs:

- **A Lesson** in the notebook, when it is about this study.
- **A convention in `.science/SETUP.md`**, when it holds for the whole repo.
- **A change to a science skill**, when a skill told the agent to do the wrong thing or left a gap: report it as a proposal naming the skill and the change; the skills are edited where they are maintained, outside the study.

## Resume

Name the next action and why: `/experiment <study>` for open work or a chosen idea, `/experiment <new-study>` in a new session for a different question, `/curate-probe` for a user-directed layout, or `/promote` for technical reuse or batch rollover. Offer `/scientific-map <study>` if changed records made the map stale. Report unresolved questions without inventing answers.
