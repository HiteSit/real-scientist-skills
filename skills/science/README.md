# Science

A flow for scientific work where the next step depends on the last result. Agree one probe, inspect its evidence and choose what comes next. Repeat approved promotion cycles to organize, reuse and preserve work without closing unfinished science. Reading goes into a shared library; the notebook stays current authority.

This is a draft and can change without warning. For the short version and the reasoning behind it, see the [main README](../../README.md).

## Skills

- **[setup-science](./setup-science/SKILL.md)**: Set up a repo for the science skills: record the domain, the stack and the conventions in `.science/SETUP.md`, and start the shared library. You start it.
- **[experiment](./experiment/SKILL.md)**: Load a study (`/experiment <study>`, from any session) and focus the session on it; if the study doesn't exist yet, open it with a short interview and agree the first probe. Then it follows your lead: explain what was done, work on a probe, start the next one, fix one. You start it.
- **[promote](./promote/SKILL.md)**: Roll over probe batches, preserve evidence and technically promote supported work after tree approval, checking consumers and rebuilding one connected scientific map. You start it.
- **[scientific-map](./scientific-map/SKILL.md)**: Build or refresh one offline project HTML map with a tab per study. You can run it at any stage; promotion also calls it.
- **[desk-research](./desk-research/SKILL.md)**: Answer a question by reading papers and documentation through parallel subagents, using your agent's literature tools, and keep the answer in the shared library with the raw search results behind it. The agent can start it.
- **[lab-notebook](./lab-notebook/SKILL.md)**: The layout and formats: the `.science/` tree, the notebook, probe folders and their states, commits and tags, result briefs, plots and the dashboard. The agent can start it.
- **[ask-science](./ask-science/SKILL.md)**: Step back from a study: first it brings the study to the current format of these skills, then judges whether it is on track, drifting or lost, finds where the study, the notebook and the probes disagree, asks you how to resolve each, and gives you the command to resume. You start it.

## How the flow works

- **Plan one probe at a time.** A probe is a small experiment, usually one session's work. A new study starts with one agreed probe and a short list of ideas; each later probe is chosen with you when it's next.
- **Start from the standard answer.** An LLM answers from the peak of a Gaussian: it gives the answer most represented in its weights, the one it met most often in training. Before running, the agent says that standard answer out loud and what it rests on: evidence, a source, or only what it learned; "unknown" is fine. The probe then shows where reality sits: at the peak, where the standard answer holds, or out in the tail, where the surprises and the real findings are. The result says how far from the standard answer it landed and what that changes.
- **Start from a direction.** Results are allowed to change the direction. Each change is logged against the probe that caused it.
- **Scratch is free, shared homes are agreed.** Promotion extends the existing project layout. Organization does not require parameterizing or refactoring a validated method.
- **Show results.** Each probe ends with a short brief and plots, and one dashboard shows the whole study.
- **Keep dead ends and mistakes.** A dead end stays in the record, so nobody repeats it without reason. A probe that was run wrong is fixed in place, the fix is logged in its README, and the mistake becomes a lesson the agent checks before every later probe.
- **You decide.** After every result, the agent asks how you read it, and you choose what comes next. Probes stay open while you work on them and become evidence when the next one starts; one is dropped only when you say so.
- **One study per session, many studies at once.** `/experiment <study>` loads a study in any session, tells you where it stands, and keeps the conversation on it. A new name opens a new study. Several studies run side by side, each in its own session. When you ask about another study, the agent records it and gives you the command for a new session.
- **One data authority.** User inputs and approved general source/prepared/reference datasets live in shared data with provenance/checksums. Other fetched data stays probe-local until approved promotion; workflow databases and run outputs stay with the workflow.
- **Keep history scoped.** Studies share the current checkout by default. Authorized checkpoints include exact study and approved shared/main-tree paths, not other sessions' work or heavy files. Probe and cycle tags keep earlier versions reachable.
- **Use two voices.** The whole notebook, maps and dashboards default to concise operational English; `STUDY.md` keeps natural, direct narrative and its frozen starting record. [Presentation voices](./lab-notebook/SKILL.md#presentation-voices) defines the style target, preservation rules and project overrides.

## The flow, step by step

```
/setup-science           once per repo: git init if needed, domain, conda | pixi | uv, data folder, AGENTS.md, empty library
      │
      ▼
/experiment <study>      load the study and focus on it; a new name opens it (short grilling, first probe)
      │
      │  then, as you lead:
      │    start a probe   choose it with you, state the expectation, run it in probes/NN-<slug>/
      │    show a result   plots, brief, dashboard; talk it through; record your reading
      │    keep working    an open probe takes as many sessions as it needs
      │    fix a probe     run wrong: fixed in place, with a lesson
      │
      │  probes:  open → evidence when the next starts · dropped on your word
      │
      ▼
/promote 01 02 04        inspect, group steps, approve tree, organize/reuse/preserve, verify, map
      │
      ├──► /experiment <study>   continue open work, choose from ideas, keep global probe numbering; repeat cycles
      └──► stable reusable steps → /to-spec → /to-tickets → /implement-spec
```

### Set up the repo

Run `/setup-science` once per repo. If the folder isn't a git repository yet, it runs `git init`; the work stays local, and nothing is pushed unless you ask. It first asks which field the work belongs to (chemistry, bioinformatics, physics, ecology, and so on). Then it records the setup every probe will use:

- **Environment:** you choose conda, pixi or uv. It recommends the one your repo already uses, or pixi for conda-forge and bioconda tools and uv for pure Python, creates the environment file if there isn't one, and records the command that runs things in it.
- **Compute:** local, a cluster scheduler, or both.
- **Data:** user inputs and explicitly approved general source/prepared/reference datasets, at `data/` or `.science/data/`. Each has provenance, licence, checksums and one authoritative home. Large/private data can remain external with a locator. Normal fetched probe data stays local until approved promotion; workflow-specific databases and run outputs remain with their workflow.
- **Heavy outputs:** the size above which files aren't committed.
- **Plots and the dashboard:** how they're built.
- **Promotion:** repeated physical batch rollovers and separately agreed technical reuse, with scoped authorized checkpoints or an approved PR/worktree flow.

All of this goes into `.science/SETUP.md`. The branch you ran it on is recorded as the **home branch**, where the science work started; studies may later run elsewhere. It also starts the empty library and the data folder, and writes the conventions into `AGENTS.md`. The skills themselves don't depend on your field; the field lives in that file.

### Open or load a study

`/experiment <study>` means: **this conversation is about this study.** It reads the study's notebook and tells you where things stand: the question and current direction, the probes still open and what they wait for, the latest evidence, and the ideas for what could come next. Loading changes nothing. From there it follows you: explain what was done, keep working on an open probe, start a new probe, fix one, or just talk. Without a study name, it lists your studies and asks.

If the study doesn't exist yet, `/experiment <new-name>` opens it first. It asks you a short round of questions, like Matt's `grilling`, each with a recommended answer you can accept in a word: the question, a starting hypothesis (or "unknown"), the system, what an answer would look like, the constraints. Whatever your message already said, it doesn't ask again. Questions that need reading go to the library and to `desk-research` straight away. `domain-modeling` keeps the vocabulary precise, which helps a lot in fields full of jargon.

It stops as soon as a first probe can be planned, and you agree that **first probe**. Everything else you mentioned goes on a short list of **ideas**: possible next probes, never a schedule. Plan ten experiments up front and the second makes eight of them pointless, so each later probe is chosen with you when it's next. The starting direction goes into `STUDY.md` and stays frozen; the study's folder `.science/<study>/` opens with its notebook, is committed as `<study>: open`, tagged `<study>/open`, and the first probe starts.

The session then stays with that study. If you ask about something that belongs to another study, the agent records it where it belongs and gives you the command for a new session (`/experiment <other-study>`).

### Probes

A probe is the smallest run that reduces a relevant uncertainty. Each one goes like this:

1. **Choose it with you.** From your ask, from what the last result suggested, or from the ideas list. Before it runs, the agent tells you the standard answer it starts from (the one most represented in its weights, the peak of the Gaussian) and what that rests on: previous evidence, a library source, or only what it learned. "Unknown" is fine. An explicit hypothesis test or method validation also records its test criterion.
2. **Run it** at its current notebook-linked location: a new question starts in `.science/<study>/probes/NN-<slug>/`; unfinished work physically rolled into a cycle continues there under the same ID. Keep rerunnable scripts, inputs and execution metadata together, without rewriting frozen receipts. A crash is fixed at that record, not copied into a new batch. Long jobs resume through `/experiment <study>`.
3. **Show the result.** Figures, a short brief and the study dashboard ([`lab-notebook/RESULTS.md`](./lab-notebook/RESULTS.md) sets how). The brief explains the update: starting expectation → what was observed → what changed or stayed the same, and what is still uncertain. The outcome is `completed` when a valid run answered the probe's question, even negatively or surprisingly, or `inconclusive` when the evidence can't settle it.
4. **Talk it through.** Before you discuss it, the agent has already written its own reading, marked `[inference]`. It then asks how you read the result, which caveat matters most, and what it changes in your belief, in rounds as short as the result allows. Your reading replaces its inference in the probe's README under **Reading** and in the notebook, and a change of direction gets a drift log entry citing the probe.

A probe stays **open** while work remains, even if some components are promoted. Before the next probe starts, completed recorded work normally becomes **evidence**; unfinished work stays open. **Dropped** requires your words. **Promoted** applies only to an agreed whole-probe transfer. These states and scientific outcomes are distinct from organization dispositions: promote, retain, retire or defer. Archiving does not mean scientifically invalid; a valid negative result may support limited reuse.

### The notebook: a map of the probes

The notebook updates itself as the work happens. Every operation on a probe (started, job submitted, results collected, result shown, discussed, fixed, state changed) writes the probe's README and the notebook in the same commit, so the notebook is always current.

It is a **map** from the question to the probes. The probes are grouped under **threads**, the parts of the question they actually worked on. A probe that goes somewhere new opens a new thread, so even a large drift from the starting question shows up as a path on the map. Each thread has a few sentences of prose, and each probe has a block:

```
- NN comparison · open · rev 0
  - asked:    compare two agreed alternatives
  - expected: unknown
  - found:    first comparison recorded; control pending
  - means:    unresolved
  <prose: interpretation, current homes, partial promotion and remaining work>
```

**asked** is your original intent, never rewritten. Changes are recorded against it. Below the map, a **log** keeps one short line per operation; full paths and execution receipts stay in the probe record.

The probe's README holds the full record in the same order: **Thread**, **Asked**, **Plan** (builds on, expectation, test criterion), **Method**, **Result**, **Reading**, **Revisions**. `STUDY.md` stays the frozen starting point; when part of the framing turns out wrong, the correction goes in the notebook's current direction and drift log.

### Fix a probe

Sometimes a recorded probe turns out to have been run wrong: a bug, a wrong input or parameter, a mistake in the analysis or the plots. You might catch it, or the agent might. Tell `/experiment` which probe, and it fixes the probe in place instead of starting a new one:

1. It confirms with you what was wrong. A new question, changed test criterion or deliberate change of method is a new probe, not a fix; updating the interpretation is ordinary learning.
2. It fixes and reruns at the notebook-linked physical record, even inside an earlier cycle, preserving original expectations, criteria, frozen statements and captured receipts while adding corrected current results.
3. If the outcome or the reading changed, it talks the result through with you again.
4. It records the fix. The probe's README gets a **Revisions** entry: what was wrong, who caught it, what changed, and the outcome before and after. The probe's **Rev** goes up by one. The mistake becomes a rule under **Lessons**, which the agent reads before every later probe; a lesson that holds for the whole repo can also go into `.science/SETUP.md`, with your ok.
5. For every probe built on the old result, it asks you whether to rerun it or keep it.
6. It commits `<study>: fix NN: <slug>: <what was wrong> (<old outcome> → <new outcome>)` and tags it `<study>/NN-r1` (then `r2`, and so on). The wrong version stays reachable under its old tag.

### Desk research and the library

Some questions need reading, not running: papers, software and tool documentation, reviews, database documentation. `desk-research` answers them, and keeps every answer in the **library**, `.science/library/`. The library belongs to no study: once a question is answered, every study can reuse the page. It's a simple take on Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f): an index the agent reads first, an append-only log, and markdown pages the agent writes and keeps current, with the raw search results saved beside them.

Desk research only reads. When an answer points to data a probe will load (a database export, a published dataset, a model checkpoint), the page names it with its source, release and licence, and the probe that needs it downloads it. Where each kind of data lives:

| Data | Where it lives |
|---|---|
| User inputs and approved general source/prepared/reference datasets | Shared data, with provenance/checksums and one authority |
| Normal fetched probe data | Probe-local with fetch instructions/source until approved promotion |
| Workflow databases and run outputs | With their workflow, including after promotion |

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

`/promote 01 02 04` starts a repeatable **promotion cycle**, not a one-way handoff:

1. Inspect the actual study, root, data, Git inventory/hooks and live consumers. Classify scoped components as **promote**, **retain**, **retire** or **defer**. Dropped stays dropped; readiness is specific to intended reuse.
2. Grill the grouping into **steps** first, then ask a few remaining decision questions per round: purpose, preservation, limits, current consumers and checks. Organization can proceed without speculative method generalization.
3. Approve one exact tree before moving anything. Keep actual useful code homes; no compulsory `protocol/` folder or code-porting step. `_promotion_<title>_<date>/` holds the approved-tree/disposition/verification README and `manifest.json` with stable IDs, old-to-new paths and digests (large inventories may be compressed). Physically move numbered folders directly into its `promoted/`, `retained/`, `discarded/`, `active/` homes, alongside relative links to workflows/data/archives as needed. No extra `records/` or cycle `probes/` layer; no symlink-only rollover.
4. Preserve one physical payload home, original records, frozen statements and captured receipts. Update necessary live consumers and current notebook hrefs/manifests; verify hashes, physical disposition, links and affected reuse. Shared study assets do not join the batch automatically. Empty study-level `probes/` after rollover (`.gitkeep` allowed), with no copies/compatibility aliases. Existing-cycle moves need explicit approval; regression checks follow the actual change, not automatic scientific reruns.
5. Update notebook state and current locations, then append the `STUDY.md` cycle entry without changing its frozen framing. Unfinished probes continue at their cycle `active/` locations under the same IDs. Only new questions enter the empty batch.
6. Invoke `scientific-map` to refresh all in-scope tabs and select the current study. Record the checks before the Git checkpoint. Independent steps commit separately; an agreed coupled relocation can be one commit. Authorized tags use `<study>/promotions/<title>-<date>` and preserve earlier states.

Return to `/experiment <study>` with the same numbered probe records and any open work. Repeat cycles as evidence grows.

### View the scientific map

Run `/scientific-map [study]` without moving or promoting anything. It reads the current records and rebuilds the shared `scientific-map.html`. The optional study name selects the first tab. Each tab shows one connected flow with evidence, open work, dead ends and proposals. Open a card to see its sources and any recorded substeps. The skill ships the offline viewer template; the build uses the project's existing tools.

### Alternative approaches

Alternatives to the **same question** stay in notebook **Ideas**, visibly unexecuted. When you choose one, it becomes an ordinary next globally numbered probe. Its **Builds on** links express dependencies; the next promotion cycle organizes its findings. There are no separate approach directories, records or lifecycle. [`lab-notebook` **Ideas**](./lab-notebook/SKILL.md#notebookmd) defines this rule. A different question still follows off-axis triage into reading or another study.

### When you're lost: `/ask-science`

Run `/ask-science` when you want to step back from a study: unsure where it stands, sensing that the work has wandered from the question, or after these skills changed. It works like Matt's `/ask-matt` and `/retro` combined:

1. It shows the map of the science flow.
2. It proposes approved record-format repairs, reconstructing missing history from original READMEs/commits and marking it `[reconstructed]` for you to confirm. Canonical numbered probe records and approved cycle trees are not automatically renamed, moved or duplicated. Physical organization goes through `/promote`. Outdated `.science/SETUP.md` or `AGENTS.md` goes through `/setup-science`.
3. It looks back over the study (where it started, what the last probes tried to find out, where the direction began to shift) and gives a verdict: on track, drifting, or lost.
4. It compares `STUDY.md`, the notebook, the probe folders and git. Every place where they disagree, and everything marked `[reconstructed]`, becomes a question for you, with a recommended reading. If the question itself has drifted, you choose: keep the new direction, spin it off as a new study, or go back to the original question.
5. It applies your answers as new commits, and suggests a guard so the drift doesn't recur: a lesson in the notebook, a convention in `.science/SETUP.md`, or a proposed change to a science skill.
6. It ends with the one command that resumes the work.

`/experiment` suggests it on its own when the records don't agree or the study is in an older format.

### Hand off to engineering

When the protocol stops changing and has to run at scale (many targets, a whole library of compounds, a production pipeline), the work is predictable again. It moves to Matt's flow: `/to-spec`, then `/to-tickets` and `/implement-spec`. `/retro` works as it is at the end.

## Folder layout

The record tree below lives under `.science/`; approved reusable homes and the standalone scientific map/build/runtime live in the project's existing root layout:

```
.science/
  SETUP.md                    your setup: domain, stack, home branch, promotion mode
  library/                    what you read: papers, software docs; index, log, pages, searches
  data/                       user inputs and approved shared datasets, if configured here
  <study>/                    one folder per study
    STUDY.md                  starting direction, background, first probe and ideas, frozen; Promoted and Outcome lines added at the end
    NOTEBOOK.md               question, branch, current direction, map (threads and probe blocks), log, ideas, lessons, library links, dead ends, drift log
    dashboard.html            one dashboard for the study, updated whenever a result is recorded
    _promotion_<title>_<date>/ README, manifest.json and physical numbered probe homes:
      promoted/ retained/ discarded/ active/   plus relative links to current asset homes
    probes/                   current new-question batch; empty immediately after rollover
      NN-<slug>/              stable ID/name; later physically moved into an approved cycle
        README.md             thread, asked, plan, method, result, reading, revisions
        .gitignore            this probe's large outputs
        figures/
```

Numbered records keep their IDs/names and captured history through approved physical moves. `NOTEBOOK.md` hrefs locate them across current batch and all cycles. Numbers never reset or repeat. Unfinished records continue in cycle `active/`, not copies in `probes/`; physical disposition does not override current notebook state.

## Git: one branch, many studies

Every study lives on the same branch, in the same checkout. Running several studies at once means opening several sessions, one per study, side by side. Three rules keep them from getting in each other's way:

- **Stay on the branch.** No session switches branch, because that would move every other session's files too.
- **Commit only approved paths.** Study records and explicitly approved reusable/data/map files belong in the scoped checkpoint; heavy outputs and unrelated work do not.
- **Keep history as it is.** Corrections are new commits; nothing is stashed, reset, amended or rebased.

Every commit message starts with its study, and tags mark the moments worth coming back to:

| Moment | Commit | Tag |
|---|---|---|
| Study opened | `<study>: open` | `<study>/open` |
| Probe's first result | `<study>: probe NN: <slug>: <outcome>` | `<study>/NN-r0` |
| Probe fixed | `<study>: fix NN: …` | `<study>/NN-r1`, `r2`, … |
| Promotion cycle | `<study>: promote NN: <title>` | `<study>/promotions/<title>-<date>` |
| Study closed | `<study>: close` | `<study>/close` |
| Library page | `library: <slug>` | |
| Data added | `data: <slug>` | |

`git log --grep '^<study>:'` shows a study's history and `git tag -l '<study>/*'` its milestones. Check branch, tag, worktree and hook inventory before authorized checkpoints; stage exact paths without heavy or unrelated files. Inventory grants no permission to switch, merge, delete refs/worktrees or publish. Specifically approved fast-forwards or safe merged-ref cleanup preserve occupied worktrees and tags. Publishing hooks require publishing authorization.

## Vocabulary

- **Study**: one investigation around one question.
- **Direction**: where the study is heading now. The starting one is frozen in `STUDY.md`; the current one lives in the notebook.
- **Probe**: one small experiment, usually one session's work.
- **Probe state**: open, evidence, dropped or promoted, kept in the notebook.
- **Ideas**: agreed possibilities, including unexecuted alternatives to the same question; chosen work becomes an ordinary next probe.
- **Expectation**: the provisional result and its basis, recorded before running; "unknown" when there is no defensible expectation.
- **Lab notebook**: a map from the question to the probes, updated at every operation: threads, each probe's intent and result, a short log, ideas and lessons.
- **Revision**: an in-place fix of a probe that was run wrong. The probe keeps its number, and its README says what was wrong and what changed.
- **Lesson**: a rule drawn from a mistake, read before each probe.
- **Drift log**: every change of direction, each citing the probe that caused it.
- **Library**: the repo's shared reading, kept by `desk-research`: one page per question, with the searches behind it.
- **Dead end**: an approach the evidence gave reason to stop pursuing, kept so nobody repeats it without reason.
- **Home branch**: the branch you ran `/setup-science` on, where the science work started.
- **Protocol**: promoted reusable steps in existing project homes, not a prescribed directory.
- **Promotion cycle**: approved physical batch rollover, preservation and separately agreed technical reuse, followed by experimentation.
- **Disposition**: promote, retain, retire or defer; distinct from scientific state/outcome.
- **Scientific map**: one offline HTML page with a connected flow per study tab, generated from current records and separate from the chart dashboards.
