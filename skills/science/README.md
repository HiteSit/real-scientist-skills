# Science

A flow for scientific work, where you can't know the next step until the last result is in. A study starts from a loose direction and moves one probe at a time. Each probe runs in scratch in the study's folder, its result comes back as plots and a brief, and you choose what comes next. Work that earns a place in the protocol is promoted into the main tree. What you read along the way goes into one shared library that every study can use.

This is a draft and can change without warning. For the short version and the reasoning behind it, see the [main README](../../README.md).

## Skills

- **[setup-science](./setup-science/SKILL.md)**: Set up a repo for the science skills: record the domain, the stack and the conventions in `.science/SETUP.md`, and start the shared library. You start it.
- **[experiment](./experiment/SKILL.md)**: Load a study (`/experiment <study>`, from any session) and focus the session on it; if the study doesn't exist yet, open it with a short interview and agree the first probe. Then it follows your lead: explain what was done, work on a probe, start the next one, fix one. You start it.
- **[promote](./promote/SKILL.md)**: Move a probe's work into the protocol in the main tree, after you agree on where it goes. You start it.
- **[desk-research](./desk-research/SKILL.md)**: Answer a question by reading papers and documentation through parallel subagents, using your agent's literature tools, and keep the answer in the shared library with the raw search results behind it. The agent can start it.
- **[lab-notebook](./lab-notebook/SKILL.md)**: The layout and formats: the `.science/` tree, the notebook, probe folders and their states, commits and tags, result briefs, plots and the dashboard. The agent can start it.
- **[ask-science](./ask-science/SKILL.md)**: Step back from a study: is it on track, drifting or lost? It looks back over the probes, finds where the study, the notebook and the probes disagree, asks you how to resolve each, and gives you the command to resume. You start it.

## The flow, step by step

### Set up the repo

Run `/setup-science` once per repo. If the folder isn't a git repository yet, it runs `git init`; the work stays local, and nothing is pushed unless you ask. It first asks which field the work belongs to (chemistry, bioinformatics, physics, ecology, and so on). Then it records the setup every probe will use:

- **Environment:** you choose conda, pixi or uv. It recommends the one your repo already uses, or pixi for conda-forge and bioconda tools and uv for pure Python, creates the environment file if there isn't one, and records the command that runs things in it.
- **Compute:** local, a cluster scheduler, or both.
- **Data:** your input data, the starting point of the work (measurements, instrument output, sample sheets, structures), goes into a data folder. You choose where: `data/` at the repo root or `.science/data/`. One folder per dataset, with an index and a README saying where it came from. Probes read it and never write to it; you can add more of your own data at any time. Data too large or too private for the repo stays where it is, and its folder holds the README with the path.
- **Heavy outputs:** the size above which files aren't committed.
- **Plots and the dashboard:** how they're built.
- **Promotion:** plain commits, or pull requests when the repo has a remote where changes are reviewed.

All of this goes into `.science/SETUP.md`. The branch you ran it on is recorded as the **home branch**, where the science work started; studies may later run elsewhere. It also starts the empty library and the data folder, and writes the conventions into `AGENTS.md`. The skills themselves don't depend on your field; the field lives in that file.

### Open or load a study

`/experiment <study>` means: **this conversation is about this study.** It reads the study's notebook and tells you where things stand: the question and current direction, the probes still open and what they wait for, the latest evidence, and the ideas for what could come next. Loading changes nothing. From there it follows you: explain what was done, keep working on an open probe, start a new probe, fix one, or just talk. Without a study name, it lists your studies and asks.

If the study doesn't exist yet, `/experiment <new-name>` opens it first. It asks you a short round of questions, like Matt's `grilling`, each with a recommended answer you can accept in a word: the question, a starting hypothesis (or "unknown"), the system, what an answer would look like, the constraints. Whatever your message already said, it doesn't ask again. Questions that need reading go to the library and to `desk-research` straight away. `domain-modeling` keeps the vocabulary precise, which helps a lot in fields full of jargon.

It stops as soon as a first probe can be planned, and you agree that **first probe**. Everything else you mentioned goes on a short list of **ideas**: possible next probes, never a schedule. Plan ten experiments up front and the second makes eight of them pointless, so each later probe is chosen with you when it's next. The starting direction goes into `STUDY.md` and stays frozen; the study's folder `.science/<study>/` opens with its notebook, is committed as `<study>: open`, tagged `<study>/open`, and the first probe starts.

The session then stays with that study. If you ask about something that belongs to another study, the agent records it where it belongs and gives you the command for a new session (`/experiment <other-study>`).

### Probes

A probe is the smallest run that reduces a relevant uncertainty. Each one goes like this:

1. **Choose it with you.** From your ask, from what the last result suggested, or from the ideas list. Before it runs, the agent tells you what it expects and why: previous evidence, a library source, or a guess. "Unknown" is fine. An explicit hypothesis test or method validation also records its test criterion.
2. **Run it** in its own folder, `.science/<study>/probes/NN-<slug>/`, with its scripts, small inputs, outputs, and the exact commands, versions and seeds, so anyone can rerun it. A crash isn't a result: it gets fixed and rerun in the same probe. A long cluster job is submitted, and the next `/experiment <study>` collects it.
3. **Show the result.** Figures, a short brief and the study dashboard ([`lab-notebook/RESULTS.md`](./lab-notebook/RESULTS.md) sets how). The brief explains the update: starting expectation → what was observed → what changed or stayed the same, and what is still uncertain. The outcome is `completed` when a valid run answered the probe's question, even negatively or surprisingly, or `inconclusive` when the evidence can't settle it.
4. **Talk it through.** Before you discuss it, the agent has already written its own reading, marked `[inference]`. It then asks how you read the result, which caveat matters most, and what it changes in your belief, in rounds as short as the result allows. Your reading replaces its inference in the probe's README under **Reading** and in the notebook, and a change of direction gets a drift log entry citing the probe.

A probe stays **open** while you work on it, across as many sessions as it needs: more results, a second look, a redo. When the next probe starts, the agent looks at the open ones: a probe whose results are in becomes **evidence**, its findings on record for the study to build on; one still waiting for results (a cluster job, say) stays open, and the agent tells you. That's the normal end of every probe, and it needs no decision from you. A probe is **dropped** only when you say so, with what it rules out written under dead ends. A probe whose work moves into the protocol is **promoted**.

### The notebook: a map of the probes

The notebook updates itself as the work happens. Every operation on a probe (started, job submitted, results collected, result shown, discussed, fixed, state changed) writes the probe's README and the notebook in the same commit, so the notebook is always current.

It is a **map** from the question to the probes. The probes are grouped under **threads**, the parts of the question they actually worked on. A probe that goes somewhere new opens a new thread, so even a large drift from the starting question shows up as a path on the map. Each thread has a few sentences of prose, and each probe has a block:

```
- 15 tetrazolate-md · open · rev 0
  - asked:    run all 56 complexes as a technical MD check, descriptive only
  - expected: no ranking signal
  - found:    112 replicas complete and verified; ProLIF/PBSA queued
  - means:    pending
  <prose: how it moved from what was asked, what you made of it, fixes>
```

**asked** is your intent for the probe, recorded when it starts and never rewritten. When the work moves the probe somewhere else, the move is written against it, so the notebook shows both how you imagined the probe and how it came out. Below the map, a **log** keeps one short line per operation, with the essential result: `11-14 · 15 · 112 replicas collected, all verified`.

The probe's README holds the full record in the same order: **Thread**, **Asked**, **Plan** (builds on, expectation, test criterion), **Method**, **Result**, **Reading**, **Revisions**. `STUDY.md` stays the frozen starting point; when part of the framing turns out wrong, the correction goes in the notebook's current direction and drift log.

### Fix a probe

Sometimes a recorded probe turns out to have been run wrong: a bug, a wrong input or parameter, a mistake in the analysis or the plots. You might catch it, or the agent might. Tell `/experiment` which probe, and it fixes the probe in place instead of starting a new one:

1. It confirms with you what was wrong. A new question, changed test criterion or deliberate change of method is a new probe, not a fix; updating the interpretation is ordinary learning.
2. It fixes and reruns the probe in the same folder, preserving the original expectation and any test criterion, then updates the outcome and interpretation.
3. If the outcome or the reading changed, it talks the result through with you again.
4. It records the fix. The probe's README gets a **Revisions** entry: what was wrong, who caught it, what changed, and the outcome before and after. The probe's **Rev** goes up by one. The mistake becomes a rule under **Lessons**, which the agent reads before every later probe; a lesson that holds for the whole repo can also go into `.science/SETUP.md`, with your ok.
5. For every probe built on the old result, it asks you whether to rerun it or keep it.
6. It commits `<study>: fix NN: <slug>: <what was wrong> (<old outcome> → <new outcome>)` and tags it `<study>/NN-r1` (then `r2`, and so on). The wrong version stays reachable under its old tag.

### Desk research and the library

Some questions need reading, not running: papers, software and tool documentation, reviews, database documentation. `desk-research` answers them, and keeps every answer in the **library**, `.science/library/`. The library belongs to no study: once a question is answered, every study can reuse the page. It's a simple take on Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f): an index the agent reads first, an append-only log, and markdown pages the agent writes and keeps current, with the raw search results saved beside them.

Desk research only reads. When an answer points to data a probe will load (a database export, a published dataset, a model checkpoint), the page names it with its source, release and licence, and the probe that needs it downloads it. Where each kind of data lives:

| Data | Where it lives |
|---|---|
| Your input data, the starting point | The data folder (`data/` or `.science/data/`), shared by every study |
| Data a probe fetches (database exports, datasets, checkpoints) or produces | The probe's own folder, with a fetch script and its source; later probes in the study read it there |
| Data worth keeping beyond the study | Moved by `/promote` into the protocol, where the tree you approve says |

```
.science/library/
  index.md                  one line per page, grouped by topic
  log.md                    every search and page change, in order
  <slug>.md                 one page per question or topic: the answer, each claim cited
  searches/<date>-<slug>/   one per search: the exact query, the tool's raw output, references.bib
```

1. **Look up.** The agent reads `index.md` first. If a page already answers the question, it uses that page, and nothing is searched twice.
2. **Research.** Otherwise one background subagent per question searches, using the tools your agent has (Scite, Semantic Scholar, OpenAlex and similar) before falling back to web search. Every search is saved as the tool returned it, with the query that produced it.
3. **Write the page.** The main agent alone writes the page, the index line and the log entries, so parallel studies never collide on the library, and commits it as `library: <slug>`.

Studies only link to library pages: `STUDY.md` lists them under **Background**, probes name them under **Builds on**, and the notebook's **Library** section lists what the study uses.

### Promote

Promotion is the one step that changes the main tree. When a probe's work has earned a place in the protocol (the rerunnable steps that later probes and the engineering flow build on), ask for `/promote`:

1. It checks that the evidence supports the step's intended reuse and that it reruns from what's committed. Completion or agreement with an agent guess is not validation: the relevant controls and method-validation criteria must support that use.
2. It proposes where the step goes in the protocol, as a folder tree with a reason for each folder. Nothing moves until you approve the tree.
3. It ports the scripts and turns hard-coded values into parameters, with the probe's values as defaults. It adds a regression check with Matt's `/tdd`: run on the probe's inputs, the promoted step must reproduce the validated result within a stated tolerance. For docking, that might be "the co-crystal ligand redocks under 2 Å RMSD". Matt's `/code-review` reviews the change.
4. It marks the probe as promoted in the notebook and adds a **Promoted** line to `STUDY.md`. By default, the protocol files and the study's records go in one commit, `<study>: promote NN: <step>`, tagged `<study>/promote-<step>`. If `SETUP.md` says this repo promotes through pull requests, the protocol change goes on a short-lived branch in its own worktree, so your checkout stays where it is, and the PR is written the way Matt's `/pr` describes.

Then you're back in `/experiment <study>`, building on the protocol.

### When you're lost: `/ask-science`

Run `/ask-science` when you want to step back from a study: unsure where it stands, or sensing that the work has wandered from the question. It works like Matt's `/ask-matt` and `/retro` combined:

1. It shows the map of the science flow.
2. It looks back over the study (where it started, what the last probes tried to find out, where the direction began to shift) and gives a verdict: on track, drifting, or lost.
3. It compares `STUDY.md`, the notebook, the probe folders and git. Every place where they disagree becomes a question for you, with a recommended reading. If the question itself has drifted, you choose: keep the new direction, spin it off as a new study, or go back to the original question.
4. It applies your answers as new commits, and suggests a guard so the drift doesn't recur: a lesson in the notebook, a convention in `.science/SETUP.md`, or a proposed change to a science skill.
5. It ends with the one command that resumes the work.

`/experiment` suggests it on its own when the records don't agree.

### Hand off to engineering

When the protocol stops changing and has to run at scale (many targets, a whole library of compounds, a production pipeline), the work is predictable again. It moves to Matt's flow: `/to-spec`, then `/to-tickets` and `/implement-spec`. `/retro` works as it is at the end.

## Folder layout

Everything the science skills write lives in `.science/` at the root of your repo:

```
.science/
  SETUP.md                    your setup: domain, stack, home branch, promotion mode
  library/                    what you read: papers, software docs; index, log, pages, searches
  data/                       your input data, if you chose .science/data/ over data/ at the root
  <study>/                    one folder per study
    STUDY.md                  starting direction, background, first probe and ideas, frozen; Promoted and Outcome lines added at the end
    NOTEBOOK.md               question, branch, current direction, map (threads and probe blocks), log, ideas, lessons, library links, dead ends, drift log
    dashboard.html            one dashboard for the study, updated whenever a result is recorded
    probes/
      01-<slug>/              NN-<slug>, named once and never renamed
        README.md             thread, asked, plan, method, result, reading, revisions
        .gitignore            this probe's large outputs
        figures/
```

A probe's folder name never changes; its state (open, evidence, dropped, promoted), revision count and latest tag are on its block in the notebook's map.

## Git: one branch, many studies

Every study lives on the same branch, in the same checkout. Running several studies at once means opening several sessions, one per study, side by side. Three rules keep them from getting in each other's way:

- **Stay on the branch.** No session switches branch, because that would move every other session's files too.
- **Commit only your own folder.** Each session commits with a path limit (`git commit -- .science/<study>`), so it never picks up another session's half-finished work.
- **Keep history as it is.** Corrections are new commits; nothing is stashed, reset, amended or rebased.

Every commit message starts with its study, and tags mark the moments worth coming back to:

| Moment | Commit | Tag |
|---|---|---|
| Study opened | `<study>: open` | `<study>/open` |
| Probe's first result | `<study>: probe NN: <slug>: <outcome>` | `<study>/NN-r0` |
| Probe fixed | `<study>: fix NN: …` | `<study>/NN-r1`, `r2`, … |
| Probe promoted | `<study>: promote NN: <step>` | `<study>/promote-<step>` |
| Study closed | `<study>: close` | `<study>/close` |
| Library page | `library: <slug>` | |
| Data added | `data: <slug>` | |

`git log --grep '^<study>:'` shows one study's history, `git tag -l '<study>/*'` its milestones, and `git checkout <study>/03-r1` takes you back to exactly that version of a probe.
