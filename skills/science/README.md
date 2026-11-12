# Science

A flow for scientific work, where you can't know the next step until the last result is in. A study starts from a loose direction and moves one probe at a time. Each probe runs in scratch in the study's folder, its result comes back as plots and a brief, and you decide what happens next. A probe that holds up is promoted into the protocol. What you read along the way goes into one shared library that every study can use.

This is a draft and can change without warning. For the short version and the reasoning behind it, see the [main README](../../README.md).

## Skills

- **[setup-science](./setup-science/SKILL.md)**: Set up a repo for the science skills: record the domain, the stack and the conventions in `.science/SETUP.md`, and start the shared library. You start it.
- **[to-study](./to-study/SKILL.md)**: Ask you just enough to frame the starting question, reading the literature where the framing needs it, split your plan into a rough probe map (phases, order, what blocks what), then open the study's folder and lab notebook. You start it.
- **[experiment](./experiment/SKILL.md)**: Load a study (`/experiment <study>`, from any session) and run it one probe at a time: a prediction per probe, plots and a brief per result, and a short talk about each result before you decide the next step. You start it.
- **[promote](./promote/SKILL.md)**: Move a validated probe into the protocol, after you agree on where it goes. You start it.
- **[desk-research](./desk-research/SKILL.md)**: Answer a question by reading papers and documentation through parallel subagents, using your agent's literature tools, and keep the answer in the shared library with the raw search results behind it. The agent can start it.
- **[lab-notebook](./lab-notebook/SKILL.md)**: The layout and formats: the `.science/` tree, the notebook, the probe map, probe folders, commits and tags, result briefs, plots and the dashboard. The agent can start it.
- **[ask-science](./ask-science/SKILL.md)**: When you're lost or something has drifted (git, the study's question, the notebook, the library), it shows the flow and where you are, repairs the drift with you, suggests a guard so it doesn't happen again, and gives you the command to resume. You start it.

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

### Frame the study

`/to-study` frames the question by asking you questions in rounds, like Matt's `grilling`. Each question comes with a recommended answer you can accept in a word. `domain-modeling` keeps the vocabulary precise, which helps a lot in fields full of jargon.

Framing often needs reading: what's already known, which systems or datasets exist, which benchmark the field uses. The agent checks the library first. What the library can't answer goes to `desk-research` straight away, and the interview carries on with whatever doesn't depend on it. The answers come back as library pages, folded into the next round, and `STUDY.md` lists them under **Background**.

Unlike `grilling`, it stops early. Once the question is clear enough to plan a first probe, it stops asking. Anything still open goes on the map or into "not yet mapped", to be settled by data instead of more discussion.

Then it draws the **probe map**, a table in the notebook. You often arrive with a long list of steps, conditions and checks. `/to-study` splits them into probes, the way Matt's `/wayfinder` splits a large project into tickets. Like tickets, probes declare what blocks them:

| # | Probe | Phase | Blocked by | Status | Rev | Tag |
|---|-------|-------|------------|--------|-----|-----|
| 01 | redock-xtal: does the co-crystal ligand redock? | 1 | | held | 0 | `dock/01-r0` |
| | known-binders (research): which ligands have measured affinities? | 1 | | done | | |
| 02 | protonation: does pH 7.4 prep change the poses? | 2 | 01-redock-xtal | held | 1 | `dock/02-r1` |
| | ensemble-dock: do extra receptor states help? | 2 | 02-protonation, known-binders | planned | | |

- **Phases** group the probes. Each phase is one stage of the work, such as the probes that answer one sub-question, and phases are listed in the order they run.
- **Blocked by** sets the order of execution. Each probe names the probes and research rows whose results it needs.
- The **frontier** is every planned probe whose blockers are all done. Those are the ones you can do next.
- **Status** goes from planned to running to the verdict (held, failed, inconclusive), and to promoted once the probe reaches the protocol. **Rev** counts in-place fixes, and **Tag** is the git tag of the probe's latest version.
- **Research** rows are questions answered by reading; they link to their library page once done.
- **Not yet mapped** holds questions you can see coming but can't yet turn into a probe. They join the map once a result makes them clear.

A simple question might need two or three probes in one phase. You revise the map until you accept it.

Finally, it writes the starting direction in `STUDY.md`: the question, a starting hypothesis, the system under study, what an answer would look like, the constraints, the background reading, and the starting map. It creates the study's folder, `.science/<study>/`, opens the lab notebook with a copy of the map, commits it as `<study>: open` and tags it `<study>/open`. The map is a rough plan, not a schedule.

### Run the loop

`/experiment <study>` first loads the study: it reads the notebook and the last probe's decision, so a new session picks up exactly where the last one stopped, the way a wayfinder session picks up the next ticket. Without a study name, it lists your open studies (question, last probe, verdict, current direction) and asks which one to load. If you're on a different branch than the one the study recorded, it tells you and asks before going on.

The session then stays with that study. If you ask about something that belongs to another study, the agent records it where it belongs and gives you the command to open a new session for it (`/experiment <other-study>` or `/to-study`). How many probes you run in one session is up to you.

Each pass runs one probe:

1. **Plan** the next probe only. It comes from your last decision. If you haven't picked one, it comes from the map's frontier, earliest phase first. The map entry was sketched before any results, so the probe is planned properly now, using what the results so far have shown. A good probe is the smallest run that could prove the current belief wrong. Its prediction is written before anything runs.
2. **Run** it in its own folder, `.science/<study>/probes/NN-r0-running-<slug>/`, with its scripts, small inputs, outputs, and the exact commands, versions and seeds, so anyone can rerun it. A crash isn't a result: it gets fixed and rerun in the same probe. A long cluster job is submitted, marked as running, and picked up in the next session.
3. **Inspect.** The agent makes the figures, compares the result with the prediction (held, failed, or inconclusive), writes the result brief, and updates the study dashboard. [`lab-notebook/RESULTS.md`](./lab-notebook/RESULTS.md) sets how results are presented.
4. **Decide, with you.** The agent always stops here, whatever the verdict. It shows the verdict, the key figures and a link to the dashboard, and recommends continue, branch, drop, or promote. Then it asks you about the result in rounds: do you read it the way the brief does, which caveat matters most, what it changes in your belief, and which decision it supports. A clean result may need one round or none; a surprise may need several. Your decision wins.
5. **Record.** Your reading of the result and your decision go into the probe's README. In the notebook, the probe's row gets its verdict, and the probe gets a few lines under **Probe notes**: what it ran, the key numbers, your decision. The map changes only as you agreed: probes you added become planned rows, probes the result made pointless are marked dropped. Any change of direction or of the map's structure gets a drift log entry that cites the probe. A probe that ran as planned isn't drift. The probe is committed as `<study>: probe NN: <slug>: <verdict>` and tagged `<study>/NN-r0`.

Probes run one at a time by default, because each result decides the next. When two probes on the frontier are independent of each other (two long cluster jobs, say), they can run at once if you agree. Each still gets its own inspection and its own decision.

The agent never adds probes to the map on its own. When you ask "what should we do next?", or say "we're running X, but the aim is Y", it works out the next probes with you in rounds of questions, and only the ones you agree to go on the map.

Then `/experiment` goes back to step 1. It leaves the loop when you decide to promote, when you stop (the notebook keeps the state, so any later session continues with `/experiment <study>`), or when the question is answered. In that last case, the notebook gets a final line naming the answer and the probes behind it, `STUDY.md` gets an **Outcome** line, and the study is tagged `<study>/close`.

### Fix a probe

Sometimes a recorded probe turns out to have been run wrong: a bug, a wrong input or parameter, a mistake in the analysis or the plots. You might catch it, or the agent might. Tell `/experiment` which probe, and it fixes the probe in place instead of starting a new one:

1. It confirms with you what was wrong. A new question or a changed prediction is a new probe, not a fix.
2. It fixes and reruns the probe in the same folder, then judges the new result against the original prediction, which never changes.
3. If the verdict or the reading changed, it talks the result through with you again, and your decision may change.
4. It records the fix. The probe's README gets a **Revisions** entry: what was wrong, who caught it, what changed, and the verdict before and after. The map row's **Rev** goes up by one. The mistake becomes a rule under **Lessons**, which the agent reads before planning every later probe; a lesson that holds for the whole repo can also go into `.science/SETUP.md`, with your ok.
5. For every probe built on the old result, it asks you whether to rerun it or keep it.
6. It commits `<study>: fix NN: <slug>: <what was wrong> (<old verdict> → <new verdict>)` and tags it `<study>/NN-r1` (then `r2`, and so on). The wrong version stays reachable under its old tag.

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

Studies only link to library pages: `STUDY.md` lists them under **Background**, research rows on the map point to them, and the notebook's **Library** section lists what the study uses.

### Promote

When a probe, or a chain of probes, has held up, `/promote` moves it from scratch into the protocol: the rerunnable steps that later probes and the engineering flow build on.

1. It checks that the probe is ready: the verdict held, you chose promote, and it reruns from what's committed.
2. It proposes where the step goes in the protocol, as a folder tree with a reason for each folder. Nothing moves until you approve the tree.
3. It ports the scripts and turns hard-coded values into parameters, with the probe's values as defaults. It adds a regression check with Matt's `/tdd`: run on the probe's inputs, the promoted step must reproduce the validated result within a stated tolerance. For docking, that might be "the co-crystal ligand redocks under 2 Å RMSD". Matt's `/code-review` reviews the change.
4. It marks the probe as promoted in the notebook and adds a **Promoted** line to `STUDY.md`. By default, the protocol files and the study's records go in one commit, `<study>: promote NN: <step>`, tagged `<study>/promote-<step>`. If `SETUP.md` says this repo promotes through pull requests, the protocol change goes on a short-lived branch in its own worktree, so your checkout stays where it is, and the PR is written the way Matt's `/pr` describes.

Then you're back in `/experiment <study>`, building on the protocol.

### When you're lost: `/ask-science`

Run `/ask-science` whenever you're unsure where you are, or the work seems to have left the tracks: work that landed in the wrong study's folder, a direction that has moved away from the study's question, a notebook that no longer matches the probe folders, a library page missing from the index. It works like Matt's `/ask-matt` and `/retro` combined:

1. It shows the map of the science flow.
2. It checks where you are, without changing anything: every study in one line, then your study in depth (git, the question against the current direction, the notebook against the folders) and the library.
3. It proposes a fix for each piece of drift, most serious first, and applies it only with your yes, always as a new commit. If the question itself has drifted, you choose: keep the new direction, spin it off as a new study, or go back to the original question.
4. From this session and the study's git history, it finds what let the drift happen, and suggests a guard: a lesson in the notebook, a convention in `.science/SETUP.md`, or a proposed change to a science skill.
5. It ends with the one command that resumes the work.

`/experiment` suggests it on its own when the notebook and the folders don't agree.

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
    STUDY.md                  starting direction, background and probe map, frozen; Promoted and Outcome lines added at the end
    NOTEBOOK.md               branch, current direction, probe map, probe notes, lessons, library links, dead ends, drift log
    dashboard.html            one dashboard for the study (starting vs current map), updated after every probe
    probes/
      01-r0-held-<slug>/      NN-r<fixes>-<state>-<slug>
        README.md             blocked by, intent, prediction, method, result, decision, revisions
        .gitignore            this probe's large outputs
        figures/
```

A probe folder's name carries its state, so a plain `ls probes/` shows where the study stands:

```
01-r0-promoted-redock-xtal
02-r1-held-protonation
03-r2-failed-ensemble-dock
04-r0-running-water-maps
```

- The **number** counts probes in run order and never changes.
- **r** and a count say how many times the probe was fixed in place. `r2-failed` is a probe that failed even after two fixes.
- The **state** is where it stands now: `running`, then its verdict (`held`, `failed`, `inconclusive`), or `promoted` or `dropped` once you decide so. The README keeps the original verdict.
- The **slug** says what the probe does and never changes.

When the count or the state changes, the agent renames the folder with `git mv` and updates every link to it in the same commit. Elsewhere, probes are named by their stable short form, like `02-protonation`.

## Git: one branch, many studies

Every study lives on the same branch, in the same checkout. Running several studies at once means opening several sessions, one per study, side by side. Three rules keep them from getting in each other's way:

- **Stay on the branch.** No session switches branch, because that would move every other session's files too.
- **Commit only your own folder.** Each session commits with a path limit (`git commit -- .science/<study>`), so it never picks up another session's half-finished work.
- **Keep history as it is.** Corrections are new commits; nothing is stashed, reset, amended or rebased.

Every commit message starts with its study, and tags mark the moments worth coming back to:

| Moment | Commit | Tag |
|---|---|---|
| Study opened | `<study>: open` | `<study>/open` |
| Probe decided | `<study>: probe NN: <slug>: <verdict>` | `<study>/NN-r0` |
| Probe fixed | `<study>: fix NN: …` | `<study>/NN-r1`, `r2`, … |
| Probe promoted | `<study>: promote NN: <step>` | `<study>/promote-<step>` |
| Study closed | `<study>: close` | `<study>/close` |
| Library page | `library: <slug>` | |
| Data added | `data: <slug>` | |

`git log --grep '^<study>:'` shows one study's history, `git tag -l '<study>/*'` its milestones, and `git checkout <study>/03-r1` takes you back to exactly that version of a probe.
