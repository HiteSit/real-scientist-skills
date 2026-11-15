# Skills for Real Scientists

[![Release](https://img.shields.io/github/v/release/HiteSit/real-scientist-skills?label=release)](https://github.com/HiteSit/real-scientist-skills/releases/latest)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-standard-5fb3a1)](https://agentskills.io)
[![Synced with mattpocock/skills](https://github.com/HiteSit/real-scientist-skills/actions/workflows/sync-upstream.yml/badge.svg)](https://github.com/HiteSit/real-scientist-skills/actions/workflows/sync-upstream.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)

Built on [Matt Pocock's skills for real engineers](https://github.com/mattpocock/skills).

Agent skills for reproducible scientific experiments with any coding agent. Agree on one experiment at a time, record the expected result before running it, and use the evidence to choose what to run next. Every run leaves a Git-tracked lab notebook and rerunnable files.

<p align="center">
  <img src="./assets/flow.svg" alt="An IDE where /experiment opens a study, the agent reads the literature into a shared library and asks you to choose at each step, four probes appear one after another, one is dropped, and /promote turns the other three into the protocol under src/" width="100%">
</p>

## Why one experiment at a time

Matt's engineering flow plans the whole route first: `/to-spec` writes down the goal, `/to-tickets` splits it into tickets, and `/implement-spec` builds them, many in parallel. That works because software is predictable once you agree on what to build.

Research and scientific exploration aren't. A plan is a map, and in research nobody has mapped the territory yet. You learn what's relevant by running something and looking at the result: each result shows you more of the territory, and it often shows that the route you planned goes nowhere. So the science flow plans one experiment, called a probe, at a time, and you choose each next probe after seeing the last result. The study's notebook is the map of your scientific question, redrawn after every probe.

Ask a language model a question without steering it, and it gives you the most common answer, the middle of everything it has read. New findings sit away from that middle, and only a clear intention moves the work away from it, away from what you could call AI slop. So before each run the agent writes down the standard answer, and the result shows how far from it reality lands. That distance is what makes the work worth doing, and a rough measure of how unique it is.

|                    | Engineering flow                    | Science flow                                         |
| ------------------ | ----------------------------------- | ---------------------------------------------------- |
| The unknown        | How to build it                     | What's relevant, and so what to do next              |
| Plan               | Every ticket, up front              | The first probe and a list of ideas; each next probe chosen when it's next |
| Shape of the work  | A task graph, run in parallel       | A chain of probes, each one checked by you           |
| Where work happens | Feature branches, into the codebase | Scratch probes in a study folder; the main tree changes only by promotion |
| The starting doc   | A spec, which is a contract         | A direction, which is expected to change             |
| Failure            | A bug to fix                        | Unexpected results teach; invalid runs need fixing   |

When a protocol stops changing, it's predictable again, and Matt's engineering flow takes over.

## What lives where

Everything the science skills write goes in a `.science/` folder at the root of your repo:

```
.science/
  SETUP.md              your setup
  library/              what you read: papers, software docs; one page per question, the raw search results
  data/                 your input data (or data/ at the repo root, your choice)
  <study>/              one folder per study
    STUDY.md            the starting direction and first probe, frozen; promotions and the outcome are added at the end
    NOTEBOOK.md         the map: threads of the question, each probe's asked / expected / found / means, a log of every operation
    dashboard.html      the study's dashboard
    probes/             one folder per probe, named like 03-<slug>
```

Your code stays where it always was. Probes' work reaches it only through `/promote`, after you agree where each file goes. All studies share one branch, and every probe gets a Git tag, so you can go back to any version.

## The skills

You type `/setup-science`, `/experiment`, `/promote` and `/ask-science`. The agent loads `lab-notebook` and `desk-research` on its own when the task fits.

- [setup-science](./skills/science/setup-science/SKILL.md): set up a repo for the science skills. Run once.
- [experiment](./skills/science/experiment/SKILL.md): load or open a study and work on it, one probe at a time.
- [promote](./skills/science/promote/SKILL.md): move the work of one or more probes into the protocol, after a round of questions and a tree you approve.
- [lab-notebook](./skills/science/lab-notebook/SKILL.md): the study's layout and formats: notebook, probe folders, result briefs, plots and dashboard.
- [desk-research](./skills/science/desk-research/SKILL.md): answer questions by reading papers and documentation in parallel, into a shared library, with citations.
- [ask-science](./skills/science/ask-science/SKILL.md): step back, bring an older study to the current format, and check it is on track.

The flow step by step, the principles behind it and the vocabulary: [skills/science/README.md](./skills/science/README.md).

Matt's engineering and productivity skills are included as he wrote them, and the science skills call several of them (`grilling`, `domain-modeling`, `tdd`, `code-review`, `pr`). For what each one does, see [his README](https://github.com/mattpocock/skills).

## Install

Paste this prompt into your coding agent. It installs the six science skills, and Matt's skills too if you don't have them yet:

```text
Install the science skills from https://github.com/HiteSit/real-scientist-skills.

1. Clone the repo, or pull it if I already have a clone.
2. Find the folder you load skills from.
3. Check that folder for Matt Pocock's skills, such as grilling, tdd and domain-modeling.
   - If they're there, keep them and install only the six skills in skills/science/.
   - If they're missing, install the six science skills plus every skill in skills/engineering/ and skills/productivity/. When a skill has a folder in customized/, use that folder instead.
4. Install each skill as a symlink into the clone, so a git pull updates it. If a skill with the same name is already in the folder, ask me before replacing it.
5. Tell me what you installed and what you skipped. Then remind me to run /setup-science in my repo, and /setup-matt-pocock-skills if you installed Matt's skills.
```

To update, ask your agent to pull the clone.

## Staying in step with Matt

Every week this repo merges Matt's latest skills, and it keeps a few small edits to two of them. [MAINTAINING.md](./MAINTAINING.md) explains how.

## Credits and license

The engineering and productivity skills, the repo's structure, and the ideas the science bucket grows from are the work of [Matt Pocock](https://www.aihero.dev). If you like these skills, read [his README](https://github.com/mattpocock/skills#why-these-skills-exist) and join [his newsletter](https://www.aihero.dev/s/skills-newsletter).

- Everything under `skills/` except `skills/science/` is Matt's, from [mattpocock/skills](https://github.com/mattpocock/skills), merged in unchanged every week.
- `customized/` holds edited copies of two of his skills, `grilling` and `chief-of-staff`, rebuilt from his originals plus the edits in `customizations/`.
- `skills/science/` and the docs around it are new here.

Matt's skills are MIT licensed, and so is this repo. His [LICENSE](./LICENSE) is kept as he wrote it.
