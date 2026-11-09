# Results

How a probe's result is shown to the user. The user decides the next step from what is shown here, so a result they cannot read at a glance is a result that was not delivered.

Use the plotting library and dashboard builder named in `.science/SETUP.md`.

## The brief

Goes under **Result** in the probe README, after the verdict.

```markdown
**Verdict:** held | failed | inconclusive
**Headline:** <one sentence: what the result says about the question>

![<what the figure shows>](figures/<name>.png)

**Against the prediction:** <the prediction, the number or pattern observed, and the gap between them>
**What the figures show:** <one line per figure, the claim it supports>
**Caveats:** <what could make this misleading: sample size, a failed control, a parameter left at default>
**Suggests:** <the next probe or question this points to>
```

Keep the brief to what a reader needs to make the decision. Raw tables and logs stay in the probe folder, linked.

## Figures

Each figure makes **one claim**, stated in its caption and file name. Then:

- Draw the **prediction** on the figure: a reference line, band or expected value, so held or failed is visible without reading the text.
- Show the **baseline or control** beside the result on the same axes and scale.
- Show the spread (individual points, a distribution, or an interval), never only a mean.
- Label every axis with its quantity and unit.
- Keep the same colour for the same condition across every probe of the study, so figures from different probes compare side by side.
- Save to the probe's `figures/` as PNG for viewing, and as a vector format when the stack supports one.
- The script that makes each figure lives in the probe folder and regenerates it from committed or reproducible outputs.
- When a result needs interaction (a 3D structure, a table to filter), add a live page to `figures/` as well, following [LIVE-HTML.md](LIVE-HTML.md), and link it from the brief.

## The study dashboard

A study has **one** dashboard, and it grows **probe after probe**. There is never a dashboard per probe: each probe adds its own section to the same page and updates the parts it changed (the current direction, the drift log, the map), while every earlier probe stays on the page in run order. The dashboard is the study's whole trajectory in one place.

One **live page** (see [LIVE-HTML.md](LIVE-HTML.md)), `.science/<study>/dashboard.html`, built by the dashboard script beside it from the notebook and the probe folders. Regenerate it after every probe; never edit the HTML by hand.

It shows, top to bottom:

1. **The question and the current direction**, with the starting direction from `STUDY.md` beside it, so the drift is visible at once.
2. **The drift log** as a timeline: each entry, the probe that caused it, and what changed.
3. **The probes** in run order: number, title, verdict, the key figure, the headline and a short explanation of what the result means for the study, and a link to the probe README. Promoted probes say where they went; revised probes list their revisions and the **Lessons** they produced.
4. **The probe map**: the current table beside the starting one from `STUDY.md`, compared row by row (added, dropped, moved to another phase), with the frontier marked, and the **dead ends**.

Write the explanations for the user who will open the dashboard cold: what was tested, what came out, and why it matters, in plain sentences.

Updating it is part of every probe: a probe is not finished, and not committed, until the dashboard shows it.

Done when the dashboard passes the live-page smoke test, shows every probe up to the current one, and the starting and current directions sit side by side.
