# Results

How a probe's result is shown to the user. The user reads the result and chooses what comes next from what is shown here, so a result they cannot read at a glance is a result that was not delivered.

Use the plotting library and dashboard builder named in `.science/SETUP.md`.

## The brief

Goes under **Result** in the probe README. Lead with the finding and the update, not whether the starting expectation was right.

```markdown
**Headline:** <one sentence: what the result says about the question>
**Outcome:** completed | inconclusive

![<what the figure shows>](figures/<name>.png)

**Update:** <the original expectation and its basis → the observed number or pattern → what changes in the working picture, or what stays the same>
**Test criterion:** <met | not met | unresolved, with the evidence; only when a criterion was recorded before running>
**What the figures show:** <one line per figure, the claim it supports>
**Caveats:** <what could make this misleading: sample size, a failed control, a parameter left at default>
**Suggests:** <the next probe or question, tied to what remains uncertain>
```

Keep the brief to what a reader needs to understand the result. Raw tables and logs stay in the probe folder, linked.

## Figures

Each figure makes **one claim**, stated in its caption and file name. Then:

- When there is a quantitative expectation or test criterion, draw it as a labelled reference line, band or value. Distinguish an agent guess from an evidence-based reference; use a band only when its bounds have a basis. For an exploratory probe with no expectation, show the observation without inventing a target.
- Show the **baseline or control** beside the result on the same axes and scale.
- Show the spread (individual points, a distribution, or an interval), never only a mean.
- Label every axis with its quantity and unit.
- Keep the same colour for the same condition across every probe of the study, so figures from different probes compare side by side.
- Save to the probe's `figures/` as PNG for viewing, and as a vector format when the stack supports one.
- The script that makes each figure lives in the probe folder and regenerates it from committed or reproducible outputs.
- When a result needs interaction (a 3D structure, a table to filter), add a live page to `figures/` as well, following [LIVE-HTML.md](LIVE-HTML.md), and link it from the brief.

## The study dashboard

A study has **one** dashboard, and it grows **probe after probe**. There is never a dashboard per probe: each probe adds its own section to the same page and updates the parts it changed (the current direction, the drift log, the map), while every earlier probe stays on the page. The dashboard is the study's whole trajectory in one place.

One **live page** (see [LIVE-HTML.md](LIVE-HTML.md)), `.science/<study>/dashboard.html`, built by the dashboard script beside it from the notebook and the probe folders. Regenerate it whenever a result is recorded; never edit the HTML by hand.

It shows, top to bottom:

1. **The question and the current direction**, with the starting direction from `STUDY.md` beside it, so the drift is visible at once.
2. **The drift log** as a timeline: each entry, the probe that caused it, and what changed.
3. **The map**: each thread with its prose, and under it each probe with what was asked, what was expected, what was found and what it means (marked `[inference]` until discussed), its state and outcome, the key figure, and a link to the probe README. Promoted probes say where they went; revised probes list their revisions and the **Lessons** they produced.
4. **What could come next**: the **Ideas** list, and the **dead ends**.

Write the explanations for the user who will open the dashboard cold: what was tested, what came out, and why it matters, in plain sentences.

Updating it is part of recording a result: a result is not committed until the dashboard shows it.

Done when the dashboard passes the live-page smoke test, shows every probe up to the current one, and the starting and current directions sit side by side.
