# Skills For Real Science

Agent skills for doing real science with a coding agent: an iterative, explorative adaptation of [Matt Pocock's skills for real engineers](https://github.com/mattpocock/skills).

This repository is a fork of Matt's, kept in sync with his `main` every week. His engineering and productivity skills are here as he wrote them, and they still do most of the work; two of them carry small, separate [customizations](#customizations). What this repo adds is a `science/` bucket: a small set of skills for the part of research that cannot be planned up front, because the next step depends on what the last experiment showed.

All the credit for the foundations goes to Matt Pocock. The ideas that make his skills work (grilling before building, a shared language, tight feedback loops, caring about design) are exactly the ideas a scientific workflow needs. If you like these skills, [read his README](https://github.com/mattpocock/skills#why-these-skills-exist) and [join his newsletter](https://www.aihero.dev/s/skills-newsletter).

> [!NOTE]
> The science bucket is a first draft. All six skills are written, but none has been used on a real study yet.

## Engineering is deterministic, science is explorative

Matt's engineering flow works because building software is, at its core, deterministic. Once you and the agent agree on what to build, the whole route can be planned: `/to-spec` writes the destination, `/to-tickets` breaks it into every ticket up front, and `/implement-spec` runs them as a task graph, many in parallel. A failure along the way is a bug, and a bug gets fixed.

Science does not work like that. The unknown is not *how to build it* but *what is true*, and you only learn that by running something and looking at the result. Plan ten experiments up front and the second one usually makes the other eight pointless. So the science flow plans exactly one step at a time.

|                    | Engineering flow                               | Science flow                                                          |
| ------------------ | ---------------------------------------------- | --------------------------------------------------------------------- |
| The unknown        | How to build it                                | What is true, and therefore what to do next                           |
| Plan               | Every ticket written up front by `/to-tickets` | A loose probe map; only the next probe is planned, after the last result |
| Shape of the work  | A task graph, run in parallel                  | A chain of probes, each one gated on a human reading the result       |
| Where work happens | Feature branches, straight into the codebase   | Scratch probes on a study branch, promoted to `main` once validated   |
| The starting doc   | A spec: a contract                             | A direction: expected to drift                                        |
| Done when          | The spec is implemented and reviewed           | The question is answered, or the protocol is stable enough to hand on |
| Failure            | A bug to fix                                   | A result to record: a dead end is still knowledge                     |

In one line: **engineering plans the route and then drives it; science probes, inspects, decides, and only then promotes.**

The two flows meet in one place. Once a scientific protocol stops changing, it has become deterministic, and from there Matt's engineering flow takes over: spec, tickets, implement.

## The philosophy

A few beliefs shape every skill in the science bucket.

**Map loosely, plan one probe at a time.** A probe is a small run of protocol, sized to one session. It plays the role of a ticket. The study starts with a provisional **probe map**, charted the way Matt's `/wayfinder` charts a large effort: your indications split into probes, grouped into ordered phases, wired by dependencies, with whatever is still foggy left unmapped. But a map entry is only a sketch. Each probe is planned properly only when it is next, after the previous result is in, and every result reshapes the map. The other difference from wayfinder is that a wayfinder ticket is resolved by a decision, while a probe is resolved by running something and looking at the data.

**Predict before you run.** Every probe states a prediction, written before it runs: what the result should show if the current belief is right. That turns "look at the result" into a binary check, and keeps both the agent and you honest about what was expected.

**A direction, not a spec.** A study starts from a loose direction and a provisional map, not a contract. The experiments are allowed to move both. The starting direction and map are frozen in `STUDY.md` and never edited, the current ones live in the notebook, and every change of course or reshaping of the map is logged against the probe that forced it. The gap between the two is the history of what the study learned, and the study dashboard shows the starting and current maps side by side.

**Scratch is free, the protocol is agreed.** Inside a probe, the agent organises files however the work needs. The main protocol is shared, so its shape is never chosen alone: before anything is promoted, the agent proposes the directory tree and you approve it.

**Show results, don't dump them.** Every probe ends with a brief that leads with the verdict against the prediction, backed by scientific plots, and one study-wide HTML dashboard is updated after every probe. The raw output sits one link below.

**A dead end is knowledge.** A probe that fails is recorded, not deleted. Probe numbers are never reused, and the notebook keeps a list of dead ends so nobody reruns them.

**The human decides.** After every probe the agent stops, grills you briefly on what the result means to you, and then asks: continue, branch, drop, or promote. The agent runs and inspects; you make the scientific call.

**Everything is in git.** Each study lives on its own branch, one commit per probe, so the branch log reads as the lab history. Heavy outputs are gitignored per probe, but everything needed to rerun the probe and regenerate them is committed.

## The science flow

```
/setup-science           once per repo: domain, stack, conventions
      │
/to-study                grill the question just enough, chart a provisional probe map, open science/<study>
      │
      ▼
┌─► /experiment ──────── one probe per pass:
│     1. plan            the next probe only (your pick, or the map's frontier), with a prediction
│     2. run             in .science/<study>/probes/NN-<slug>/
│     3. inspect         plots, brief, dashboard, verdict vs prediction
│     4. decide          grill the result, then you pick: continue | branch | drop | promote
│     5. record          notebook, reshape the map, commit
│        │
└────────┤ continue / branch / drop
         │ promote
         ▼
      /promote           agree the tree, port to protocol/<step>, regression check, PR into main
         │
         ▼
      stable protocol ─► /to-spec → /to-tickets → /implement-spec   (Matt's engineering flow)
```

### 1. Set up the repo: `/setup-science`

Run once per repo. It asks first which scientific domain the work belongs to (chemistry, bioinformatics, physics, ecology, ...), then records the stack every probe will use: tools and environments, compute (local or a cluster scheduler), where the data lives, the size above which outputs are gitignored, and how plots and the dashboard are built. It all goes into `.science/SETUP.md` on `main`, and the branch conventions go into your `CLAUDE.md` or `AGENTS.md`. The skills themselves stay domain-neutral; the domain lives in this file.

### 2. Frame the study: `/to-study`

`/to-study` frames the scientific question with its own interview, in the style of Matt's `grilling`: rounds of questions, each with a recommended answer you can accept in a word, while `domain-modeling` keeps the glossary sharp, which pays off quickly with domain jargon. Unlike Matt's grilling, it is deliberately not exhaustive. It stops as soon as the question is sharp enough to plan a first probe, and every branch still open goes onto the map or into the fog, to be settled by data rather than by more talk.

Then it charts the **probe map**. You often arrive with a long, complex set of indications: many steps, conditions and checks at once. `/to-study` splits them into probes, the way `/wayfinder` splits a large effort into tickets:

- **Phases** give the hierarchy: each phase is a stage of the work (the probes that answer one sub-question, or prepare what later phases need), listed in the order they run.
- **`after:` edges** give the chronological order: each probe names the probes whose results it needs.
- The **frontier** is every probe whose prerequisites have all run: what can be done next.
- **Not yet mapped** is the fog: questions you can see coming but cannot yet phrase as a probe. They graduate into the map once a result makes them sharp.

For a simple question the map may be two or three probes in one phase. You iterate on it until you accept it.

Finally it writes the study's starting direction (`STUDY.md`): the question, a starting hypothesis, the system it works on, what an answer would look like, the constraints, and the starting probe map. It cuts the `science/<study>` branch and opens the lab notebook with a copy of the map. The map is a provisional plan, not a schedule, and nothing is ticketed.

### 3. Run the loop: `/experiment`

`/experiment` runs exactly one probe per pass:

1. **Plan** the next probe only. It comes from your last decision, or, if you haven't picked one, from the map's frontier, earliest phase first. The map entry is only a sketch drawn before any result, so the probe is planned properly now, from what the results so far have shown. A good probe is the smallest run that could prove the current belief wrong, and its prediction is written before anything runs.
2. **Run** it in its own folder, `.science/<study>/probes/NN-<slug>/`, with its scripts, small inputs, outputs and the exact commands, versions and seeds, so it can be rerun. A crash is not a result: it gets fixed and rerun inside the same probe. A long cluster job is submitted, marked running, and picked up by the next session.
3. **Inspect.** The agent makes the figures, judges the verdict against the prediction it wrote before the run (held, failed, or inconclusive), writes the result brief, and regenerates the study dashboard. How a result is presented is set in `lab-notebook/RESULTS.md`.
4. **Decide, with you.** This is a hard gate after every probe, whatever the verdict. The agent shows the verdict, the key figures and a link to the dashboard, and recommends one of continue, branch, drop, or promote. Then it grills you on the result, in rounds of questions with recommended answers: do you read it the way the brief does, which caveat matters most, what it changes in your belief, which decision it supports. The grilling is as long as the result needs: none or one round for a clean result, several for a surprise. Your call wins.
5. **Record.** Your settled reading of the result and the decision go into the probe README. In the notebook, the probe is ticked on the map, and the map is reshaped for what the result showed: probes it made sharp are added, probes it made pointless are dropped or reordered, and the `after:` edges are fixed. Any change of direction, or any change to the map's structure (a phase added, dropped or reordered, a planned probe dropped), gets a drift log entry citing the probe. Ticking a probe that ran as planned is not drift. The probe is committed as `probe NN: <slug>: <verdict>`.

**Desk research runs alongside.** Not every question needs a run. When one needs reading or data first (papers, databases, datasets, tool documentation), it sits on the probe map as a **research** entry, with no number and no prediction. `/to-study` and `/experiment` dispatch these entries to `desk-research`, the science sister of Matt's `research`. It runs one background subagent per item, all in parallel, and saves each item under `.science/<study>/research/`: a cited note, or a folder holding cited findings, a provenance table, a fetch script, and data files in whatever format the source provides (a CSV, a BibTeX bibliography, structures). For bibliography it uses the literature tools your agent has (Scite, Semantic Scholar, OpenAlex and the like) before falling back to web search. Each item is committed as `research: <slug>`, and its findings are reported at the next checkpoint.

`/experiment` then goes back to step 1 for the next probe. It leaves the loop when you decide to promote, when you stop (the notebook holds the state, so the next session resumes), or when the question is answered, which closes the study with a final line in the notebook naming the answer and the probes behind it.

### 4. Promote: `/promote`

When a probe, or a chain of probes, has held up, `/promote` moves it from scratch into the protocol: the rerunnable steps in the main directory that later probes and the engineering flow build on.

1. It checks the probe is ready: verdict held, decision promote, and it reruns from what is committed.
2. It proposes where the step lives in the main directory, as a tree with a reason for each folder. This is a hard gate: nothing moves until you approve the tree.
3. On a `protocol/<step>` branch cut from `main`, it ports the scripts, replaces hard-coded values with parameters (the probe's values become the defaults), and adds a regression check with Matt's `/tdd`: the promoted step, run on the probe's inputs, reproduces the validated result within a stated tolerance. For docking, that might be "the co-crystal ligand redocks under 2 Å RMSD". Matt's `/code-review` reviews the branch.
4. It opens a pull request into `main` (shaped by Matt's `/pr`) that links the probes it came from, the approved tree, and the regression check with its tolerance.
5. Back on the study branch, it marks the probe as promoted in the notebook and commits `promote NN: <step>`.

The study branch never merges into `main`. Once the pull request has merged, the study branch merges `main` in, so later probes call the promoted step instead of their scratch copy. Then it's back to `/experiment`.

### 5. Hand off to engineering

When the protocol stops changing and needs to run at scale (many targets, a whole library, a production pipeline), the work is deterministic again. It goes into Matt's flow at `/to-spec`, then `/to-tickets` and `/implement-spec`. `/retro` is reused as is at the end.

## What lives where

```
main
  .science/SETUP.md                    the repo's science stack
  <protocol>/                          promoted steps, in the tree you agreed

science/<study>                        one branch per study, never merged into main
  .science/<study>/
    STUDY.md                           the starting direction and probe map, frozen
    NOTEBOOK.md                        current direction, drift log, live probe map, not yet mapped, probe index, dead ends
    dashboard.html                     study-wide dashboard (starting vs current map), regenerated every probe
    research/
      <slug>.md                        a desk-research item: cited prose
      <slug>/                          or a folder: findings, provenance, fetch script, data files
    probes/
      01-<slug>/
        README.md                      intent, prediction, method, result, decision
        .gitignore                     this probe's heavy outputs
        figures/

protocol/<step>                        one branch per promotion, PR'd into main
```

## Vocabulary

The science skills lean on words a model already knows, rather than coining new ones.

- **Study**: the whole investigation around one question. Plays the role of a spec.
- **Direction**: where the study is heading today. Frozen at the start in `STUDY.md`, allowed to drift in the notebook.
- **Probe**: one small run of protocol in scratch, sized to one session. Plays the role of a ticket, but it is planned in full only when it is next.
- **Probe map**: the study's provisional plan: probes grouped into ordered phases, wired by `after:` dependencies. Reshaped after every probe.
- **Frontier**: the probes on the map whose prerequisites have all run.
- **Not yet mapped**: the fog. Questions that are coming but not yet sharp enough to be a probe.
- **Prediction**: what the probe should show if the current belief is right, written before it runs.
- **Lab notebook**: the study's single source of truth. An index, not a store: one line per probe, linking to its folder.
- **Drift log**: every change of direction or of the map's structure, each one citing the probe that caused it.
- **Desk research**: answering a question from existing sources instead of running something. A research entry on the map has a slug, but no number and no prediction.
- **Dead end**: a probe whose answer was no, kept so nobody reruns it.
- **Promote**: moving a validated probe from scratch into the protocol.
- **Protocol**: the promoted, rerunnable steps in the main directory.

## Reference

The skills split on one axis, as in Matt's repo: who can invoke them. **User-invoked** skills are reachable only when you type them (e.g. `/to-study`); their job is to orchestrate. **Model-invoked** skills can be invoked by you _or_ reached for automatically by the agent when the task fits; they hold the reusable discipline.

### Science

The new bucket. Explorative work, one probe at a time.

**User-invoked**

- **[setup-science](./skills/science/setup-science/SKILL.md)**: Configure this repo for the science skills: record the scientific domain, the stack, and the branch conventions in `.science/SETUP.md`. Run once per repo.
- **[to-study](./skills/science/to-study/SKILL.md)**: Grill you just far enough to frame the starting scientific question, split your indications into a provisional probe map (phases, order, dependencies), then open the study's branch and lab notebook.
- **[experiment](./skills/science/experiment/SKILL.md)**: Run a study one probe at a time: plan a probe with its prediction, run it, show the result as plots and a brief, then grill you briefly on what it means before you decide the next step.
- **[promote](./skills/science/promote/SKILL.md)**: Promote a validated probe into the main protocol, after agreeing the directory tree with you, with a regression check and a pull request into `main`.

**Model-invoked**

- **[lab-notebook](./skills/science/lab-notebook/SKILL.md)**: Layout and formats for a study: the `.science/` tree, `STUDY.md`, `NOTEBOOK.md`, probe folders, result briefs, plots and the study dashboard ([RESULTS.md](./skills/science/lab-notebook/RESULTS.md)). Loaded automatically by the agent, and read by the other science skills.
- **[desk-research](./skills/science/desk-research/SKILL.md)**: Gather literature, databases and data files for a study through parallel background subagents, using the agent's literature tools for bibliography, and save each item under the study with citations and provenance. Dispatched for research entries on the probe map.

**Reused from Matt's buckets, unchanged:** `domain-modeling` (inside `to-study`, for the glossary), `prototype` (a quick look at an analysis or a plot), `tdd` and `code-review` (inside `promote`), `pr`, `diagnosing-bugs` (a broken pipeline step), `wizard` (cluster or licence setup), `to-spec`, `to-tickets` and `implement-spec` (the hand-off), and `retro`.

### Engineering (by Matt Pocock)

Skills for code work. Unchanged from [mattpocock/skills](https://github.com/mattpocock/skills).

**User-invoked**

- **[ask-matt](./skills/engineering/ask-matt/SKILL.md)**: Ask which skill or flow fits your situation. A router over the user-invoked skills in this repo.
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)**: Grilling session that also builds your project's domain model, sharpening terminology and updating `GLOSSARY.md` and ADRs inline.
- **[triage](./skills/engineering/triage/SKILL.md)**: Move issues through a state machine of triage roles.
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)**: Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)**: Configure this repo for the engineering skills (issue tracker, triage labels, domain doc layout). Run once per repo before using the other engineering skills.
- **[to-spec](./skills/engineering/to-spec/SKILL.md)**: Turn the current conversation into a spec and publish it to the issue tracker. No interview, just synthesizes what you've already discussed.
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)**: Break any plan, spec, or conversation into a set of tracer-bullet tickets, each declaring its blocking edges, written as text in a local file, or as native blocking links on a real tracker.
- **[implement](./skills/engineering/implement/SKILL.md)**: Build the work described by a spec or set of tickets, driving `/tdd` at pre-agreed seams and closing out with `/code-review` before committing.
- **[implement-spec](./skills/engineering/implement-spec/SKILL.md)**: Implement a whole spec on one integration branch. Works the tickets as a task graph, running implementer subagents across the ready frontier for maximum concurrency, then closes out with `/code-review`.
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)**: Plan a huge chunk of work, more than one agent session can hold, as a shared map of decision tickets on the issue tracker, and resolve them one at a time until the way to the destination is clear.
- **[retro](./skills/engineering/retro/SKILL.md)**: Suggest improvements to the coding agent's environment (navigation, automated checks, coding standards, steering files, tooling) after a session, most severe first.

**Model-invoked**

- **[prototype](./skills/engineering/prototype/SKILL.md)**: Build a throwaway prototype to answer a design question, either a single shareable HTML file for state/logic questions, or several radically different UI variations toggleable from one route.
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)**: Disciplined diagnosis loop for hard bugs and performance regressions: build a feedback loop that goes red on this bug → minimise → hypothesise → instrument → fix → regression-test.
- **[research](./skills/engineering/research/SKILL.md)**: Investigate a question against high-trust primary sources and capture the findings as a cited Markdown file in the repo, run as a background agent.
- **[tdd](./skills/engineering/tdd/SKILL.md)**: Test-driven development with a red-green-refactor loop. Builds features or fixes bugs one vertical slice at a time.
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)**: Actively build and sharpen a project's domain model: challenge terms against the glossary, stress-test with edge-case scenarios, and update `GLOSSARY.md` and ADRs inline.
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)**: Shared discipline and vocabulary for designing deep modules: a lot of behaviour behind a small interface, placed at a clean seam, testable through that interface.
- **[code-review](./skills/engineering/code-review/SKILL.md)**: Two-axis review of the diff since a fixed point: **Standards** (does it follow the repo's coding standards, plus a Fowler smell baseline?) and **Spec** (does it faithfully implement the originating issue/spec?), run as parallel sub-agents so neither pollutes the other.
- **[pr](./skills/engineering/pr/SKILL.md)**: The shape a pull request body should take: a summary as the smallest visual that makes the change clear, before/after evidence that it works, and a merge-danger call (one-way or two-way door, plus blast radius).
- **[wizard](./skills/engineering/wizard/SKILL.md)**: Generate an interactive bash wizard that walks a human through steps only they can perform: provisioning infrastructure, setting up credentials or CI secrets, walking an unfamiliar third-party dashboard, or running a one-off migration or cutover.

### Productivity (by Matt Pocock)

General workflow tools, not code-specific. From [mattpocock/skills](https://github.com/mattpocock/skills); `grilling` is also available [customized](#customizations).

**User-invoked**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)**: Get relentlessly interviewed about a plan or design until every branch of the design tree is resolved.
- **[handoff](./skills/productivity/handoff/SKILL.md)**: Compact the current conversation into a handoff document so another agent can continue the work.
- **[teach](./skills/productivity/teach/SKILL.md)**: Teach the user a new skill or concept over multiple sessions, using the current directory as a stateful teaching workspace.
- **[to-questionnaire](./skills/productivity/to-questionnaire/SKILL.md)**: Turn a decision you can't answer alone into a Markdown questionnaire for the one person who can, filled in async, or together over a meeting.
- **[wait-what](./skills/productivity/wait-what/SKILL.md)**: Fire this the moment a message doesn't land. The agent re-pitches it with the context you're missing, in plain English, using your `GLOSSARY.md` vocabulary.

**Model-invoked**

- **[grilling](./skills/productivity/grilling/SKILL.md)**: Interview the user relentlessly about a plan, decision, or idea until every branch of the design tree is resolved. The reusable interview primitive behind `grill-me`, `grill-with-docs`, `triage`, `wayfinder` and `improve-codebase-architecture`.
- **[writing-for-agents](./skills/productivity/writing-for-agents/SKILL.md)**: Writing documents for agents: skills, AGENTS.md/CLAUDE.md, and any doc an agent reaches by a pointer.

## Why Matt's engineering skills matter here too

Matt built his skills to fix four failure modes of coding agents, and every one of them shows up in scientific work as well. His full write-up is in [his README](https://github.com/mattpocock/skills#why-these-skills-exist); in short:

1. **The agent didn't do what I want.** Misalignment is fixed with a grilling session before any work starts: `/grill-me`, or `/grill-with-docs`. In science, `/to-study` grills the question until it is sharp enough to probe, and no further.
2. **The agent is way too verbose.** A shared language, built into `/grill-with-docs` (and into `/to-study`) and kept in `GLOSSARY.md`, lets one word replace twenty. Scientific fields are dense with jargon, so this pays off even faster.
3. **The code doesn't work.** Feedback loops: types, tests, and `/tdd`'s red-green-refactor, plus `/diagnosing-bugs` for hard failures. In the science flow, every promoted step carries a `/tdd` regression check against its validated result.
4. **We built a ball of mud.** Caring about design, with `/to-spec`, `/codebase-design` and `/improve-codebase-architecture`. In the science flow, this is why scratch stays in probes and the protocol's tree is agreed before anything lands on `main`.

## Installation

```bash
git clone https://github.com/HiteSit/real-scientist-skills
```

Each skill is a folder with a `SKILL.md`: copy or symlink the ones you want into your agent's skills directory. For a customized skill, take the folder under `customized/`, not the one under `skills/`. Then run `/setup-matt-pocock-skills` and `/setup-science` once in your repo. Update with `git pull`.

## Customizations

A customization is a small local edit to one of Matt's skills, kept outside his tree so the weekly merge never conflicts with it:

- `skills/` stays exactly as upstream ships it (plus `skills/science/`). Never edit Matt's skills there.
- `customizations/<skill>/customization.md` holds the edit. It is appended to that skill's `SKILL.md`, or, if its first line is `<!-- customization:anchor: <exact line> -->`, inserted right after that line.
- `scripts/build.sh` regenerates `customized/<skill>/` (the skill folder with the edit applied) from both. `customized/` is committed so a plain clone has it; never edit it by hand. A skill renamed upstream or an anchor line that disappears fails the build instead of being skipped.

Current customizations:

- **[grilling](./customizations/grilling/customization.md)**: ask each round's questions through the harness's GUI question tool (Claude Code / Codex `AskUserQuestion`, OMP `ask`) when it has one.
- **[chief-of-staff](./customizations/chief-of-staff/customization.md)** (from Matt's `in-progress/`): agent routing for the OMP harness, and `.wiki/` as the default wiki location.

To add one: write `customizations/<skill>/customization.md`, run `scripts/build.sh`, commit both.

## Staying in sync with upstream

`.github/workflows/sync-upstream.yml` runs every Monday (or by hand from the Actions tab) and calls `scripts/sync-upstream.sh`, which:

1. merges `mattpocock/skills` `main`;
2. keeps this fork's own `README.md` and `CHANGELOG.md`;
3. deletes again every path in `fork-removed.txt` (Matt's plugin packaging, release tooling and issue bots, which this fork does not use);
4. rebuilds `customized/`, commits the merge and pushes it.

New upstream skills are listed in the run summary. If the merge hits a conflict it cannot resolve, a customization no longer applies, or the push is refused, the run fails and opens an issue; run `scripts/sync-upstream.sh` locally to finish it.

For maintainers: run `git config core.hooksPath .githooks` once per clone. After that, every commit on `main` is pushed automatically, and every push is first checked with [gitleaks](https://github.com/gitleaks/gitleaks) plus an optional private list of names that must never be published (`~/.config/real-scientist-skills/leak-patterns`, one regex per line, never committed).

## Credits and license

The engineering and productivity skills, the repo's structure, and the philosophy the science bucket grows from are the work of [Matt Pocock](https://www.aihero.dev). This repo adapts them for scientific work. MIT licensed, as the original; see [LICENSE](./LICENSE).
