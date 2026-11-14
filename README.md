# Skills for Real Scientists

[![Release](https://img.shields.io/github/v/release/HiteSit/real-scientist-skills?label=release)](https://github.com/HiteSit/real-scientist-skills/releases/latest)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-standard-5fb3a1)](https://agentskills.io)
[![Synced with mattpocock/skills](https://github.com/HiteSit/real-scientist-skills/actions/workflows/sync-upstream.yml/badge.svg)](https://github.com/HiteSit/real-scientist-skills/actions/workflows/sync-upstream.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)

Agent skills for doing science with a coding agent. They adapt [Matt Pocock's skills for real engineers](https://github.com/mattpocock/skills) to research, where each step follows from the last result.

```bash
npx skills add HiteSit/real-scientist-skills --skill setup-science --skill experiment --skill promote --skill desk-research --skill lab-notebook --skill ask-science
```

This repo builds on Matt's. His engineering and productivity skills are here as he wrote them, and they still do most of the work. What's new is the `science/` bucket: six skills that run a study one experiment at a time. The ideas underneath are Matt's: grill before you build, share a vocabulary, keep feedback loops tight, and care about design. If you like these skills, read [his README](https://github.com/mattpocock/skills#why-these-skills-exist) and join [his newsletter](https://www.aihero.dev/s/skills-newsletter).

## Why science needs its own flow

Matt's engineering flow plans the whole route first. `/to-spec` writes down the goal, `/to-tickets` splits it into tickets, and `/implement-spec` builds them, many in parallel. That works because building software is predictable once you agree on what to build.

Research is exploratory. The unknown is what's true, and you learn it by running something and looking at the result. Plan ten experiments up front and the second one often makes the other eight pointless. So the science flow plans one step at a time.

|                    | Engineering flow                    | Science flow                                         |
| ------------------ | ----------------------------------- | ---------------------------------------------------- |
| The unknown        | How to build it                     | What's true, and so what to do next                  |
| Plan               | Every ticket, up front              | The first probe and a list of ideas; each next probe chosen when it's next |
| Shape of the work  | A task graph, run in parallel       | A chain of probes, each one checked by you           |
| Where work happens | Feature branches, into the codebase | Scratch probes in a study folder; the main tree changes only by promotion |
| The starting doc   | A spec, which is a contract         | A direction, which is expected to change             |
| Failure            | A bug to fix                        | Unexpected results teach; invalid runs need fixing   |

When a protocol stops changing, it's predictable again, and Matt's engineering flow takes over.

## How the flow works

- **Plan one probe at a time.** A probe is a small experiment, usually one session's work. A new study starts with one agreed probe and a short list of ideas; each later probe is chosen with you when it's next.
- **Show the starting expectation.** Before running, the agent says what it expects and why, distinguishing evidence from a guess; "unknown" is fine. The result explains what changed in that working picture, not just whether the guess was right.
- **Start from a direction.** Results are allowed to change the direction. Each change is logged against the probe that caused it.
- **Scratch is free, the protocol is agreed.** Inside a probe, the agent organizes files however the work needs. Before anything joins the protocol, you approve where it goes.
- **Show results.** Each probe ends with a short brief and plots, and one dashboard shows the whole study.
- **Keep dead ends and mistakes.** A dead end stays in the record, so nobody repeats it without reason. A probe that was run wrong is fixed in place, the fix is logged in its README, and the mistake becomes a lesson the agent checks before every later probe.
- **You decide.** After every result, the agent asks how you read it, and you choose what comes next. Probes stay open while you work on them and become evidence when the next one starts; one is dropped only when you say so.
- **One study per session, many studies at once.** `/experiment <study>` loads a study in any session, tells you where it stands, and keeps the conversation on it. A new name opens a new study. Several studies run side by side, each in its own session. When you ask about another study, the agent records it and gives you the command for a new session.
- **Read once, share everywhere.** What you read along the way (papers, software docs) goes into one shared library that every study links to, so nothing is searched twice. Your input data sits in one data folder every study reads; anything else a probe downloads stays in that probe until it's promoted.
- **Keep everything in git, simply.** One branch for all studies, each study in its own folder, each session committing only its own folder. Every probe and every fix gets a tag, so you can go back to any version.

## The science flow

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
/promote                 the probe's work into the protocol in the main tree: agree the tree, port, regression check
      │
      ▼
stable protocol ─► /to-spec → /to-tickets → /implement-spec   (Matt's engineering flow)
```

1. **`/setup-science`**, once per repo, initialises git if needed (the work stays local), lets you choose conda, pixi or uv and where your input data lives (`data/` or `.science/data/`), records your field and compute in `.science/SETUP.md`, writes the conventions into `AGENTS.md`, and starts the shared library.
2. **`/experiment <study>`** loads the study, tells you where it stands, and from then on works on that study as you lead: explain, start a probe, show and discuss a result, fix one. A name with no folder yet opens the study first: a short round of questions, then the first probe. Questions that need reading go to `desk-research`, which works in the background and answers into the library.
3. **`/promote`** moves a probe's work into the protocol in the main tree, with a regression check, as one commit or a pull request.
4. When the protocol stops changing, Matt's `/to-spec`, `/to-tickets` and `/implement-spec` take it from there.

Want to step back? **`/ask-science`** looks back over the study, tells you whether it is on track, drifting or lost, asks you about every place where the records disagree, and tells you how to resume.

Each step in detail: [the science flow, step by step](./skills/science/README.md#the-flow-step-by-step).

## What lives where

The science skills keep everything they write in a `.science/` folder at the root of your repo, the way Matt's local issue tracker uses `.scratch/`:

```
.science/
  SETUP.md              your setup
  library/              what you read: papers, software docs; one page per question, the raw search results
  data/                 your input data (or data/ at the repo root, your choice)
  <study>/              one folder per study
    STUDY.md            the starting direction and first probe, frozen; promotions and the outcome are added at the end
    NOTEBOOK.md         the current direction, the probes and their states, ideas, notes on each probe, lessons
    dashboard.html      the study's dashboard
    probes/             one folder per probe, named like 03-<slug>
```

A probe folder's name is fixed for good. Its state lives in the notebook: `open` while you work on it, `evidence` once the next probe starts, `dropped` when you say so, `promoted` once its work is in the protocol. Its result has a separate outcome: `completed` when a valid run answered its question, even negatively or surprisingly; `inconclusive` when the evidence cannot settle it.

All studies share one branch and one checkout. Every commit starts with its study (`<study>: probe 03: …`), and tags like `<study>/03-r1` mark each probe's versions. The rules for running several sessions side by side: [one branch, many studies](./skills/science/README.md#git-one-branch-many-studies).

The full layout: [folder layout](./skills/science/README.md#folder-layout).

## Vocabulary

- **Study**: one investigation around one question.
- **Direction**: where the study is heading now. The starting one is frozen in `STUDY.md`; the current one lives in the notebook.
- **Probe**: one small experiment, usually one session's work.
- **Probe state**: open, evidence, dropped or promoted, kept in the notebook.
- **Ideas**: what could come next, a short list you agree to; never a schedule.
- **Expectation**: the provisional result and its basis, recorded before running; "unknown" when there is no defensible expectation.
- **Lab notebook**: the study's current state: the probes and their states, the ideas, a few lines on each probe, and the lessons learned.
- **Revision**: an in-place fix of a probe that was run wrong. The probe keeps its number, and its README says what was wrong and what changed.
- **Lesson**: a rule drawn from a mistake, read before each probe.
- **Drift log**: every change of direction, each citing the probe that caused it.
- **Library**: the repo's shared reading, kept by `desk-research`: one page per question, with the searches behind it.
- **Dead end**: an approach the evidence gave reason to stop pursuing, kept so nobody repeats it without reason.
- **Home branch**: the branch you ran `/setup-science` on, where the science work started.
- **Protocol**: the promoted, rerunnable steps.
- **Promote**: moving a probe's work into the protocol in the main tree.

## Skills

### Science

You start `setup-science`, `experiment`, `promote` and `ask-science` by typing them. The agent can also load `lab-notebook` and `desk-research` on its own when the task fits.

- **[setup-science](./skills/science/setup-science/SKILL.md)**: Set up a repo for the science skills. Run once.
- **[experiment](./skills/science/experiment/SKILL.md)**: Load or open a study and work on it, one probe at a time.
- **[promote](./skills/science/promote/SKILL.md)**: Move a probe's work into the protocol.
- **[lab-notebook](./skills/science/lab-notebook/SKILL.md)**: The study's layout and formats: notebook, probe folders, result briefs, plots and dashboard.
- **[desk-research](./skills/science/desk-research/SKILL.md)**: Answer questions by reading papers and documentation in parallel, into the shared library, with citations.
- **[ask-science](./skills/science/ask-science/SKILL.md)**: Step back: is the study on track, and do its records agree?

### Matt's skills

His skills fix problems that show up in science too: an agent that misunderstands you, wordy output, code that doesn't work, and a codebase that turns into a mess. The science skills call several of them:

- **Engineering**: `domain-modeling`, `prototype`, `tdd`, `code-review`, `pr`, `diagnosing-bugs`, `wizard`, `to-spec`, `to-tickets`, `implement-spec`, `retro`, and more.
- **Productivity**: `grilling`, `grill-me`, `handoff`, and more.

For the full list and what each skill does, see [Matt's README](https://github.com/mattpocock/skills).

## Install

The science skills call Matt's skills (`grilling`, `domain-modeling`, `tdd`, `code-review`, `pr`), so install his first if you don't have them: see [his installation steps](https://github.com/mattpocock/skills#installation-30-second-setup) for the plugin or skills.sh command.

Then install the six science skills with [skills.sh](https://skills.sh):

```bash
npx skills add HiteSit/real-scientist-skills --skill setup-science --skill experiment --skill promote --skill desk-research --skill lab-notebook --skill ask-science
```

To update them later, run `npx skills update`.

Or ask your coding agent to install from a clone, so a `git pull` updates everything. Paste this prompt:

```text
Install the skills from https://github.com/HiteSit/real-scientist-skills.

1. Clone the repo, or pull it if I already have a clone.
2. Find my agent's skills folder (for example ~/.claude/skills, ~/.agents/skills, or .claude/skills in this project). Ask me if you're not sure.
3. Symlink the six skills in skills/science/ into that folder, so a git pull updates them.
4. Check whether I already have Matt Pocock's skills (for example grilling, tdd, domain-modeling).
   - If I do, keep mine.
   - If I don't, also symlink every skill folder under skills/engineering/ and skills/productivity/. When customized/<skill> exists, link that folder instead.
5. Tell me what you installed and what you skipped. Then remind me to run /setup-science once in my repo, and /setup-matt-pocock-skills too if you installed Matt's skills.
```

To update a clone install, ask your agent to pull the repo.

## Staying in step with Matt

Every week this repo merges Matt's latest skills, and it keeps a few small edits to two of them. [MAINTAINING.md](./MAINTAINING.md) explains how.

## Credits and license

The engineering and productivity skills, the repo's structure, and the ideas the science bucket grows from are the work of [Matt Pocock](https://www.aihero.dev).

- Everything under `skills/` except `skills/science/` is Matt's, from [mattpocock/skills](https://github.com/mattpocock/skills), merged in unchanged every week.
- `customized/` holds edited copies of two of his skills, `grilling` and `chief-of-staff`, rebuilt from his originals plus the edits in `customizations/`.
- `skills/science/` and the docs around it are new here.

Matt's skills are MIT licensed, and so is this repo. His [LICENSE](./LICENSE) is kept as he wrote it.
