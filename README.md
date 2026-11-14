# Skills for Real Scientists

[![Release](https://img.shields.io/github/v/release/HiteSit/real-scientist-skills?label=release)](https://github.com/HiteSit/real-scientist-skills/releases/latest)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-standard-5fb3a1)](https://agentskills.io)
[![Synced with mattpocock/skills](https://github.com/HiteSit/real-scientist-skills/actions/workflows/sync-upstream.yml/badge.svg)](https://github.com/HiteSit/real-scientist-skills/actions/workflows/sync-upstream.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)

Agent skills for doing science with a coding agent. They adapt [Matt Pocock's skills for real engineers](https://github.com/mattpocock/skills) to research, where each step follows from the last result.

```bash
npx skills add HiteSit/real-scientist-skills --skill setup-science --skill to-study --skill experiment --skill promote --skill desk-research --skill lab-notebook --skill ask-science
```

This repo builds on Matt's. His engineering and productivity skills are here as he wrote them, and they still do most of the work. What's new is the `science/` bucket: seven skills that run a study one experiment at a time. The ideas underneath are Matt's: grill before you build, share a vocabulary, keep feedback loops tight, and care about design. If you like these skills, read [his README](https://github.com/mattpocock/skills#why-these-skills-exist) and join [his newsletter](https://www.aihero.dev/s/skills-newsletter).

## Why science needs its own flow

Matt's engineering flow plans the whole route first. `/to-spec` writes down the goal, `/to-tickets` splits it into tickets, and `/implement-spec` builds them, many in parallel. That works because building software is predictable once you agree on what to build.

Research is exploratory. The unknown is what's true, and you learn it by running something and looking at the result. Plan ten experiments up front and the second one often makes the other eight pointless. So the science flow plans one step at a time.

|                    | Engineering flow                    | Science flow                                         |
| ------------------ | ----------------------------------- | ---------------------------------------------------- |
| The unknown        | How to build it                     | What's true, and so what to do next                  |
| Plan               | Every ticket, up front              | A rough map; only the next probe is planned          |
| Shape of the work  | A task graph, run in parallel       | A chain of probes, each one checked by you           |
| Where work happens | Feature branches, into the codebase | Scratch probes in a study folder, promoted when they hold up |
| The starting doc   | A spec, which is a contract         | A direction, which is expected to change             |
| Failure            | A bug to fix                        | Unexpected results teach; invalid runs need fixing   |

When a protocol stops changing, it's predictable again, and Matt's engineering flow takes over.

## How the flow works

- **Plan one probe at a time.** A probe is a small experiment that fits in one session. The study keeps a rough map of probes as a table, where each probe names what blocks it, like a ticket. Each one is planned properly only when it's next, and only the probes you agree to go on the map.
- **Show the starting expectation.** Before running, the agent says what it expects and why, distinguishing evidence from a guess; "unknown" is fine. The result explains what changed in that working picture, not just whether the guess was right.
- **Start from a direction.** Results are allowed to change the direction and the map. Each change is logged against the probe that caused it.
- **Scratch is free, the protocol is agreed.** Inside a probe, the agent organizes files however the work needs. Before anything joins the protocol, you approve where it goes.
- **Show results.** Each probe ends with a short brief and plots, and one dashboard shows the whole study.
- **Keep dead ends and mistakes.** A dead end stays in the record, so nobody repeats it without reason. A probe that was run wrong is fixed in place, the fix is logged in its README, and the mistake becomes a lesson the agent checks before every later probe.
- **You decide.** After every probe, the agent stops, asks how you read the result, and you choose the next step.
- **One study per session, many studies at once.** `/experiment <study>` loads a study in any session and picks up where the last one stopped. Several studies run side by side, each in its own session. When you ask about another study, the agent records it and gives you the command for a new session.
- **Read once, share everywhere.** What you read along the way (papers, software docs) goes into one shared library that every study links to, so nothing is searched twice. Your input data sits in one data folder every study reads; anything else a probe downloads stays in that probe until it's promoted.
- **Keep everything in git, simply.** One branch for all studies, each study in its own folder, each session committing only its own folder. Every probe and every fix gets a tag, so you can go back to any version.

## The science flow

```
/setup-science           once per repo: git init if needed, domain, conda | pixi | uv, data folder, AGENTS.md, empty library
      │
/to-study                frame the question (reading the library where needed), draw a rough probe map, open .science/<study>/
      │
      ▼
┌─► /experiment ──────── one probe per pass:
│     1. plan            the next uncertainty to address, and the starting expectation
│     2. run             in .science/<study>/probes/NN-r0-running-<slug>/
│     3. inspect         plots, brief, dashboard, what the evidence changes
│     4. decide          talk the result through, then you pick: continue | branch | drop | promote
│     5. record          notebook, update the map, commit
│        │
└────────┤ continue / branch / drop
         │ promote
         ▼
      /promote           agree where it goes, port it, regression check, one commit (or a PR)
         │
         ▼
      stable protocol ─► /to-spec → /to-tickets → /implement-spec   (Matt's engineering flow)
```

1. **`/setup-science`**, once per repo, initialises git if needed (the work stays local), lets you choose conda, pixi or uv and where your input data lives (`data/` or `.science/data/`), records your field and compute in `.science/SETUP.md`, writes the conventions into `AGENTS.md`, and starts the shared library.
2. **`/to-study`** asks just enough questions to frame the question, sends what needs reading to **`desk-research`**, splits your plan into a rough probe map, and opens the study's folder with a lab notebook.
3. **`/experiment <study>`** loads the study and runs one probe per pass: state the uncertainty and starting expectation, run it, show what the evidence changes, talk it through with you, and record your decision. Without a study name, it lists your studies and asks. Questions that need reading go to `desk-research`, which works in the background and answers into the library.
4. **`/promote`** moves a probe that held up into the protocol, with a regression check, as one commit or a pull request.
5. When the protocol stops changing, Matt's `/to-spec`, `/to-tickets` and `/implement-spec` take it from there.

Lost, or think something has drifted? **`/ask-science`** shows where you are, repairs the drift with you, and tells you how to resume.

Each step in detail: [the science flow, step by step](./skills/science/README.md#the-flow-step-by-step).

## What lives where

The science skills keep everything they write in a `.science/` folder at the root of your repo, the way Matt's local issue tracker uses `.scratch/`:

```
.science/
  SETUP.md              your setup
  library/              what you read: papers, software docs; one page per question, the raw search results
  data/                 your input data (or data/ at the repo root, your choice)
  <study>/              one folder per study
    STUDY.md            the starting direction, frozen; promotions and the outcome are added at the end
    NOTEBOOK.md         the current direction, the probe map table, notes on each probe, lessons
    dashboard.html      the study's dashboard
    probes/             one folder per probe, named like 03-r2-completed-<slug>
```

A probe folder's name shows the probe's number, how many times it was fixed in place, and where it stands now (`running`, `completed`, `inconclusive`, `promoted` or `dropped`). `completed` means a valid run answered its question, even with a negative or surprising result; `inconclusive` means the evidence cannot settle it. Explicit tests separately report whether their criterion was met. The agent renames the folder when its state changes, and updates every link to it in the same commit.

All studies share one branch and one checkout. Every commit starts with its study (`<study>: probe 03: …`), and tags like `<study>/03-r1` mark each probe's versions. The rules for running several sessions side by side: [one branch, many studies](./skills/science/README.md#git-one-branch-many-studies).

The full layout: [folder layout](./skills/science/README.md#folder-layout).

## Vocabulary

- **Study**: one investigation around one question.
- **Direction**: where the study is heading now. The starting one is frozen in `STUDY.md`; the current one lives in the notebook.
- **Probe**: one small experiment that fits in one session.
- **Probe map**: the study's plan and history in one table: every probe with its phase, what blocks it, its status, how often it was fixed, and its tag.
- **Frontier**: the probes whose blockers are all done.
- **Not yet mapped**: questions you can see coming but can't yet turn into a probe.
- **Expectation**: the provisional result and its basis, recorded before running; "unknown" when there is no defensible expectation.
- **Lab notebook**: the study's current state: the probe map, a few lines on each probe, and the lessons learned.
- **Revision**: an in-place fix of a probe that was run wrong. The probe keeps its number, and its README says what was wrong and what changed.
- **Lesson**: a rule drawn from a mistake, read before planning each probe.
- **Drift log**: every change of direction or of the map, each citing the probe that caused it.
- **Library**: the repo's shared reading, kept by `desk-research`: one page per question, with the searches behind it.
- **Dead end**: an approach the evidence gave reason to stop pursuing, kept so nobody repeats it without reason.
- **Home branch**: the branch you ran `/setup-science` on, where the science work started.
- **Protocol**: the promoted, rerunnable steps.
- **Promote**: moving a validated probe into the protocol.

## Skills

### Science

You start `setup-science`, `to-study`, `experiment`, `promote` and `ask-science` by typing them. The agent can also load `lab-notebook` and `desk-research` on its own when the task fits.

- **[setup-science](./skills/science/setup-science/SKILL.md)**: Set up a repo for the science skills. Run once.
- **[to-study](./skills/science/to-study/SKILL.md)**: Frame the question, draw the probe map, and open the study's folder and notebook.
- **[experiment](./skills/science/experiment/SKILL.md)**: Load a study and run it one probe at a time.
- **[promote](./skills/science/promote/SKILL.md)**: Move a validated probe into the protocol.
- **[lab-notebook](./skills/science/lab-notebook/SKILL.md)**: The study's layout and formats: notebook, probe folders, result briefs, plots and dashboard.
- **[desk-research](./skills/science/desk-research/SKILL.md)**: Answer questions by reading papers and documentation in parallel, into the shared library, with citations.
- **[ask-science](./skills/science/ask-science/SKILL.md)**: Find where you are in a study, repair what drifted, and get back on track.

### Matt's skills

His skills fix problems that show up in science too: an agent that misunderstands you, wordy output, code that doesn't work, and a codebase that turns into a mess. The science skills call several of them:

- **Engineering**: `domain-modeling`, `prototype`, `tdd`, `code-review`, `pr`, `diagnosing-bugs`, `wizard`, `to-spec`, `to-tickets`, `implement-spec`, `retro`, and more.
- **Productivity**: `grilling`, `grill-me`, `handoff`, and more.

For the full list and what each skill does, see [Matt's README](https://github.com/mattpocock/skills).

## Install

The science skills call Matt's skills (`grilling`, `domain-modeling`, `tdd`, `code-review`, `pr`), so install his first if you don't have them: see [his installation steps](https://github.com/mattpocock/skills#installation-30-second-setup) for the plugin or skills.sh command.

Then install the seven science skills with [skills.sh](https://skills.sh):

```bash
npx skills add HiteSit/real-scientist-skills --skill setup-science --skill to-study --skill experiment --skill promote --skill desk-research --skill lab-notebook --skill ask-science
```

To update them later, run `npx skills update`.

Or ask your coding agent to install from a clone, so a `git pull` updates everything. Paste this prompt:

```text
Install the skills from https://github.com/HiteSit/real-scientist-skills.

1. Clone the repo, or pull it if I already have a clone.
2. Find my agent's skills folder (for example ~/.claude/skills, ~/.agents/skills, or .claude/skills in this project). Ask me if you're not sure.
3. Symlink the seven skills in skills/science/ into that folder, so a git pull updates them.
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
