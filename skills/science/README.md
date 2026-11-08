# Science

A flow for scientific work, where you can't know the next step until the last result is in. A study starts from a loose direction and moves one probe at a time. Each probe runs in scratch on a study branch, its result comes back as plots and a brief, and you decide what happens next. A probe that holds up is promoted into the main protocol through a pull request.

This is a draft and can change without warning. For the short version and the reasoning behind it, see the [main README](../../README.md).

## Skills

- **[setup-science](./setup-science/SKILL.md)**: Set up a repo for the science skills: record the domain, the stack and the branch conventions in `.science/SETUP.md`. You start it.
- **[to-study](./to-study/SKILL.md)**: Ask you just enough to frame the starting question, split your plan into a rough probe map (phases, order, dependencies), then open the study's branch and lab notebook. You start it.
- **[experiment](./experiment/SKILL.md)**: Run a study one probe at a time: a prediction per probe, plots and a brief per result, and a short talk about each result before you decide the next step. You start it.
- **[promote](./promote/SKILL.md)**: Move a validated probe into the main protocol, after you agree on where it goes. You start it.
- **[desk-research](./desk-research/SKILL.md)**: Gather papers, databases and data files for a study through parallel subagents, using your agent's literature tools, and save them under the study with provenance. The agent can start it.
- **[lab-notebook](./lab-notebook/SKILL.md)**: The study's layout and formats: the `.science/` tree, the notebook, probe folders, result briefs, plots and the dashboard. The agent can start it.

## The flow, step by step

### Set up the repo

Run `/setup-science` once per repo. It first asks which field the work belongs to (chemistry, bioinformatics, physics, ecology, and so on). Then it records the setup every probe will use: tools and environments, compute (local or a cluster scheduler), where the data lives, the size above which outputs aren't committed, and how plots and the dashboard are built.

All of this goes into `.science/SETUP.md` on `main`. The branch conventions go into your `CLAUDE.md` or `AGENTS.md`. The skills themselves don't depend on your field; the field lives in that file.

### Frame the study

`/to-study` frames the question by asking you questions in rounds, like Matt's `grilling`. Each question comes with a recommended answer you can accept in a word. `domain-modeling` keeps the vocabulary precise, which helps a lot in fields full of jargon.

Unlike `grilling`, it stops early. Once the question is clear enough to plan a first probe, it stops asking. Anything still open goes on the map or into "not yet mapped", to be settled by data instead of more discussion.

Then it draws the **probe map**. You often arrive with a long list of steps, conditions and checks. `/to-study` splits them into probes, the way Matt's `/wayfinder` splits a large project into tickets:

- **Phases** group the probes. Each phase is one stage of the work, such as the probes that answer one sub-question, and phases are listed in the order they run.
- **`after:` links** set the order. Each probe names the probes whose results it needs.
- The **frontier** is every probe whose prerequisites have all run. Those are the ones you can do next.
- **Not yet mapped** holds questions you can see coming but can't yet turn into a probe. They join the map once a result makes them clear.

A simple question might need two or three probes in one phase. You revise the map until you accept it.

Finally, it writes the starting direction in `STUDY.md`: the question, a starting hypothesis, the system under study, what an answer would look like, the constraints, and the starting map. It creates the `science/<study>` branch and opens the lab notebook with a copy of the map. The map is a rough plan, not a schedule, and nothing becomes a ticket.

### Run the loop

`/experiment` runs exactly one probe per pass.

1. **Plan** the next probe only. It comes from your last decision. If you haven't picked one, it comes from the map's frontier, earliest phase first. The map entry was sketched before any results, so the probe is planned properly now, using what the results so far have shown. A good probe is the smallest run that could prove the current belief wrong. Its prediction is written before anything runs.
2. **Run** it in its own folder, `.science/<study>/probes/NN-<slug>/`, with its scripts, small inputs, outputs, and the exact commands, versions and seeds, so anyone can rerun it. A crash isn't a result: it gets fixed and rerun in the same probe. A long cluster job is submitted, marked as running, and picked up in the next session.
3. **Inspect.** The agent makes the figures, compares the result with the prediction (held, failed, or inconclusive), writes the result brief, and updates the study dashboard. [`lab-notebook/RESULTS.md`](./lab-notebook/RESULTS.md) sets how results are presented.
4. **Decide, with you.** The agent always stops here, whatever the verdict. It shows the verdict, the key figures and a link to the dashboard, and recommends continue, branch, drop, or promote. Then it asks you about the result in rounds: do you read it the way the brief does, which caveat matters most, what it changes in your belief, and which decision it supports. A clean result may need one round or none; a surprise may need several. Your decision wins.
5. **Record.** Your reading of the result and your decision go into the probe's README. In the notebook, the probe is ticked off on the map, and the map is updated: probes the result made clear are added, probes it made pointless are dropped or moved, and the `after:` links are fixed. Any change of direction or of the map's structure (a phase added, dropped or moved, a planned probe dropped) gets a drift log entry that cites the probe. Ticking off a probe that ran as planned isn't drift. The probe is committed as `probe NN: <slug>: <verdict>`.

Then `/experiment` goes back to step 1. It leaves the loop when you decide to promote, when you stop (the notebook keeps the state, so the next session picks up), or when the question is answered. In that last case, the notebook gets a final line naming the answer and the probes behind it.

### Desk research

Some questions need reading, not running: papers, databases, datasets, tool documentation. These sit on the probe map as **research** entries, with no number and no prediction. `/to-study` and `/experiment` hand them to `desk-research`, the science version of Matt's `research`.

`desk-research` runs one background subagent per item, all in parallel. It saves each item under `.science/<study>/research/`, either as a cited note or as a folder with cited findings, a provenance table, a fetch script, and data files in whatever format the source provides (CSV, BibTeX, structures). For literature, it uses the tools your agent has (Scite, Semantic Scholar, OpenAlex and similar) before falling back to web search. Each item is committed as `research: <slug>`, and its findings come up at the next decision.

### Promote

When a probe, or a chain of probes, has held up, `/promote` moves it from scratch into the protocol: the rerunnable steps on `main` that later probes and the engineering flow build on.

1. It checks that the probe is ready: the verdict held, you chose promote, and it reruns from what's committed.
2. It proposes where the step goes on `main`, as a folder tree with a reason for each folder. Nothing moves until you approve the tree.
3. On a `protocol/<step>` branch from `main`, it ports the scripts and turns hard-coded values into parameters, with the probe's values as defaults. It adds a regression check with Matt's `/tdd`: run on the probe's inputs, the promoted step must reproduce the validated result within a stated tolerance. For docking, that might be "the co-crystal ligand redocks under 2 Å RMSD". Matt's `/code-review` reviews the branch.
4. It opens a pull request into `main`, written the way Matt's `/pr` describes. The PR links the probes it came from, the approved tree, and the regression check with its tolerance.
5. Back on the study branch, it marks the probe as promoted in the notebook and commits `promote NN: <step>`.

The study branch never merges into `main`. After the pull request merges, the study branch merges `main` in, so later probes use the promoted step instead of their scratch copy. Then you're back in `/experiment`.

### Hand off to engineering

When the protocol stops changing and has to run at scale (many targets, a whole library, a production pipeline), the work is predictable again. It moves to Matt's flow: `/to-spec`, then `/to-tickets` and `/implement-spec`. `/retro` works as it is at the end.

## Folder layout

```
main
  .science/SETUP.md                    the repo's science setup
  <protocol>/                          promoted steps, in the tree you approved

science/<study>                        one branch per study, never merged into main
  .science/<study>/
    STUDY.md                           starting direction and probe map, frozen
    NOTEBOOK.md                        current direction, drift log, current map, not yet mapped, probe index, dead ends
    dashboard.html                     one dashboard for the study (starting vs current map), updated after every probe
    research/
      <slug>.md                        a desk-research item: a cited note
      <slug>/                          or a folder: findings, provenance, fetch script, data files
    probes/
      01-<slug>/
        README.md                      intent, prediction, method, result, decision
        .gitignore                     this probe's large outputs
        figures/

protocol/<step>                        one branch per promotion, merged into main by pull request
```
