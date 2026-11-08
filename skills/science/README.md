# Science

Draft. A parallel flow for scientific investigation, where the next step is unknown until the last result is in. Instead of a spec split into tickets, a study starts from a loose direction and moves one probe at a time; each probe runs in scratch on a study branch, its result is shown as plots and a brief, and the human decides what comes next. What proves itself is promoted into the main protocol through a pull request. These skills are excluded from the plugin and the top-level README, get no docs pages, and can change without warning.

The flow: `/setup-science` once per repo, then `/to-study` to open a study, `/experiment` for the probe loop, and `/promote` whenever a probe earns a place in the protocol.

- **[setup-science](./setup-science/SKILL.md)**: Configure a repo for the science skills: record the domain, the stack and the branch conventions in `.science/SETUP.md`. User-invoked.
- **[to-study](./to-study/SKILL.md)**: Grill you just far enough to frame the starting scientific question, split your indications into a provisional probe map (phases, order, dependencies), then open the study's branch and lab notebook. User-invoked.
- **[experiment](./experiment/SKILL.md)**: Run a study one probe at a time, with a prediction per probe, plots and a brief per result, and a short grilling on what each result means before the user decides the next step. User-invoked.
- **[promote](./promote/SKILL.md)**: Promote a validated probe into the main protocol, after agreeing the directory tree with the user. User-invoked.
- **[desk-research](./desk-research/SKILL.md)**: Gather literature, databases and data files for a study through parallel subagents, using the harness's literature tools for bibliography, and save them under the study with provenance.
- **[lab-notebook](./lab-notebook/SKILL.md)**: Layout and formats for a study: the `.science/` tree, the notebook, probe folders, result briefs, plots and the study dashboard.
