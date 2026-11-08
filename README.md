# Skills for Real Scientists

Agent skills for doing science with a coding agent. They adapt [Matt Pocock's skills for real engineers](https://github.com/mattpocock/skills) to research, where each step follows from the last result.

This repo is a fork of Matt's. His engineering and productivity skills are here as he wrote them, and they still do most of the work. What's new is the `science/` bucket: six skills that run a study one experiment at a time. The ideas underneath are Matt's: grill before you build, share a vocabulary, keep feedback loops tight, and care about design. If you like these skills, read [his README](https://github.com/mattpocock/skills#why-these-skills-exist) and join [his newsletter](https://www.aihero.dev/s/skills-newsletter).

## Why science needs its own flow

Matt's engineering flow plans the whole route first. `/to-spec` writes down the goal, `/to-tickets` splits it into tickets, and `/implement-spec` builds them, many in parallel. That works because building software is predictable once you agree on what to build.

Research is exploratory. The unknown is what's true, and you learn it by running something and looking at the result. Plan ten experiments up front and the second one often makes the other eight pointless. So the science flow plans one step at a time.

|                    | Engineering flow                    | Science flow                                         |
| ------------------ | ----------------------------------- | ---------------------------------------------------- |
| The unknown        | How to build it                     | What's true, and so what to do next                  |
| Plan               | Every ticket, up front              | A rough map; only the next probe is planned          |
| Shape of the work  | A task graph, run in parallel       | A chain of probes, each one checked by you           |
| Where work happens | Feature branches, into the codebase | Scratch probes on a study branch, promoted when they hold up |
| The starting doc   | A spec, which is a contract         | A direction, which is expected to change             |
| Failure            | A bug to fix                        | A result to record                                   |

When a protocol stops changing, it's predictable again, and Matt's engineering flow takes over.

## How the flow works

- **Plan one probe at a time.** A probe is a small experiment that fits in one session. The study keeps a rough map of probes, but each one is planned properly only when it's next.
- **Predict before you run.** Each probe says what the result should show if your current belief is right. The prediction is written before anything runs.
- **Start from a direction.** Results are allowed to change the direction and the map. Each change is logged against the probe that caused it.
- **Scratch is free, the protocol is agreed.** Inside a probe, the agent organizes files however the work needs. Before anything joins the protocol, you approve where it goes.
- **Show results.** Each probe ends with a short brief and plots, and one dashboard shows the whole study.
- **Keep dead ends.** A failed probe stays in the record, so nobody runs it again.
- **You decide.** After every probe, the agent stops, asks how you read the result, and you choose the next step.
- **One study per session.** `/experiment <study>` loads a study in any session and picks up where the last one stopped. When you ask about another study, the agent records it and gives you the command for a new session.
- **Keep everything in git.** Each study has its own branch, with one commit per probe.

## The science flow

```
/setup-science           once per repo: domain, tools, conventions
      │
/to-study                frame the question, draw a rough probe map, open science/<study>
      │
      ▼
┌─► /experiment ──────── one probe per pass:
│     1. plan            the next probe only, with a prediction
│     2. run             in .science/<study>/probes/NN-<slug>/
│     3. inspect         plots, brief, dashboard, verdict against the prediction
│     4. decide          talk the result through, then you pick: continue | branch | drop | promote
│     5. record          notebook, update the map, commit
│        │
└────────┤ continue / branch / drop
         │ promote
         ▼
      /promote           agree where it goes, port it to protocol/<step>, regression check, PR into the base branch
         │
         ▼
      stable protocol ─► /to-spec → /to-tickets → /implement-spec   (Matt's engineering flow)
```

1. **`/setup-science`**, once per repo, records your field, tools, compute and data locations in `.science/SETUP.md`. The branch you run it on becomes the **base branch**, usually `main`.
2. **`/to-study`** asks just enough questions to frame the question, splits your plan into a rough probe map, and opens a `science/<study>` branch with a lab notebook.
3. **`/experiment <study>`** loads the study and runs one probe per pass: plan it with a prediction, run it, show the result, talk it through with you, and record your decision. Without a study name, it lists your studies and asks. Questions that need reading go to **`desk-research`**, which works in the background.
4. **`/promote`** moves a probe that held up into the protocol on the base branch, through a pull request with a regression check.
5. When the protocol stops changing, Matt's `/to-spec`, `/to-tickets` and `/implement-spec` take it from there.

Each step in detail: [the science flow, step by step](./skills/science/README.md#the-flow-step-by-step).

## What lives where

The science skills keep everything they write in a `.science/` folder at the root of your repo, the way Matt's local issue tracker uses `.scratch/`:

```
.science/
  SETUP.md              your setup, on the base branch
  <study>/              one folder per study, on that study's branch
    STUDY.md            the starting direction, frozen; promotions and the outcome are added at the end
    NOTEBOOK.md         the current direction, probe map and probe index
    dashboard.html      the study's dashboard
    research/           desk-research items
    probes/NN-<slug>/   one folder per probe
```

Each part lives on its own git branch:

- The **base branch** (usually `main`) has `.science/SETUP.md` and the promoted protocol, in the folders you approved. A study's `STUDY.md` arrives there with its first promotion, so the base branch shows every study that produced protocol.
- `science/<study>` has one study's `.science/<study>/` folder. It's cut from the base branch, and after each promotion it merges the base branch back in. It never merges into the base branch itself.
- `protocol/<step>` carries one promoted step into the base branch through a pull request.

The full layout: [folder layout](./skills/science/README.md#folder-layout).

## Vocabulary

- **Study**: one investigation around one question.
- **Direction**: where the study is heading now. The starting one is frozen in `STUDY.md`; the current one lives in the notebook.
- **Probe**: one small experiment that fits in one session.
- **Probe map**: the study's rough plan: probes in ordered phases, linked by `after:` dependencies.
- **Frontier**: the probes whose prerequisites have all run.
- **Not yet mapped**: questions you can see coming but can't yet turn into a probe.
- **Prediction**: what a probe should show if your current belief is right, written before it runs.
- **Lab notebook**: the study's index and current state, one line per probe.
- **Drift log**: every change of direction or of the map, each citing the probe that caused it.
- **Desk research**: answering a question from papers, databases or datasets.
- **Dead end**: a probe whose answer was no, kept so nobody reruns it.
- **Base branch**: the branch you ran `/setup-science` on, usually `main`. Studies start from it and promotions return to it.
- **Protocol**: the promoted, rerunnable steps on the base branch.
- **Promote**: moving a validated probe into the protocol.

## Skills

### Science

You start the first four by typing them. The agent can also load the last two on its own when the task fits.

- **[setup-science](./skills/science/setup-science/SKILL.md)**: Set up a repo for the science skills. Run once.
- **[to-study](./skills/science/to-study/SKILL.md)**: Frame the question, draw the probe map, and open the study's branch and notebook.
- **[experiment](./skills/science/experiment/SKILL.md)**: Load a study and run it one probe at a time.
- **[promote](./skills/science/promote/SKILL.md)**: Move a validated probe into the protocol.
- **[lab-notebook](./skills/science/lab-notebook/SKILL.md)**: The study's layout and formats: notebook, probe folders, result briefs, plots and dashboard.
- **[desk-research](./skills/science/desk-research/SKILL.md)**: Gather papers, database records and data files in parallel, with citations and provenance.

### Matt's skills

His skills fix problems that show up in science too: an agent that misunderstands you, wordy output, code that doesn't work, and a codebase that turns into a mess. The science skills call several of them:

- **Engineering**: `domain-modeling`, `prototype`, `tdd`, `code-review`, `pr`, `diagnosing-bugs`, `wizard`, `to-spec`, `to-tickets`, `implement-spec`, `retro`, and more.
- **Productivity**: `grilling`, `grill-me`, `handoff`, and more.

For the full list and what each skill does, see [Matt's README](https://github.com/mattpocock/skills).

## Install

Ask your coding agent to do it. Paste this prompt:

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

To update, ask your agent to pull the repo.

## This fork

The fork follows Matt's `main` every week and keeps a few small edits to his skills. [MAINTAINING.md](./MAINTAINING.md) explains how.

## Credits and license

The engineering and productivity skills, the repo's structure, and the ideas the science bucket grows from are the work of [Matt Pocock](https://www.aihero.dev). MIT licensed, like the original; see [LICENSE](./LICENSE).
