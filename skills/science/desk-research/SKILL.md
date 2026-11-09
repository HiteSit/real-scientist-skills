---
name: desk-research
description: Gather what a science study needs from existing sources (literature, databases, datasets, tool documentation) through parallel subagents, and save it under the study as cited notes and data files. Use when a research entry on the probe map is on the frontier, or when a question needs reading or data before a probe can be planned.
---

# Desk Research

**Desk research** answers a question from what already exists: papers, databases, datasets, tool documentation. It is the sister of the bench work in probes: nothing is run, things are found, read and saved. Unlike `research`, it saves more than prose: an item can carry tables, structures, datasets, a bibliography, in whatever format the source provides.

Call the Skill tool with `lab-notebook` for the study tree, and read `.science/SETUP.md` for the domain, data locations and heavy-output threshold.

## Items

Each research question becomes one **item** under `.science/<study>/research/`, named by slug, never numbered (research has no run order):

- `research/<slug>.md` when the answer is prose only;
- `research/<slug>/` when it brings files: a `README.md` plus the files, in any format, organised however the material needs.

Item README:

```markdown
# <title>

**Question:** <what this item answers>
**Feeds:** <the probes or map entries that need it>

## Findings
<the answer, each claim cited to its source>

## Files
| File | What it is | Source | Version or access date | Licence |

## Fetch
<the script or exact commands that download every file; the script lives in the item>

## Gaps
<what could not be found or verified, and secondary sources used in place of primary ones>
```

**Primary sources first**: the paper, the official database, the tool's own documentation, never a write-up of them. Follow every claim and every dataset back to the source that owns it. A secondary source is used only when no primary one is reachable, and is marked as such under **Gaps**.

Heavy files follow the probe rule: files above the threshold in `SETUP.md` go in the item's own `.gitignore`, and the fetch script regenerates them on a fresh clone.

## Literature tools

When an item is bibliographic (finding, reading or checking papers), use the literature tools this harness exposes before generic web search: literature MCP servers (Scite, Semantic Scholar, publisher servers such as Wiley, and the like) and skills or APIs such as OpenAlex. Check which are available at the start of every run, since they differ by harness, and name them in each subagent's brief.

With those tools:

- search with the domain's own vocabulary and several queries per question;
- cite only papers the tools actually returned, by DOI;
- check retractions and corrections where the tool reports them;
- save the bibliography as a file in the item (BibTeX or CSV, with DOIs), alongside the README.

If no literature tool is available, use web search on primary sources and say so under **Gaps**.

## Dispatch

1. Collect the questions: every research entry on the probe map's frontier, plus any question the caller hands over.
2. Start one **research subagent** per item, all at once, in the background, each with a fresh context window. Work in the same working tree and the same branch: no worktrees, no branches, no git commands in the subagents. Each subagent writes only inside its own item path, so they never collide.
3. Brief each subagent with **context pointers**, not copies: the item's question and slug, `.science/<study>/STUDY.md`, `NOTEBOOK.md`, `.science/SETUP.md`, the item format above, and the literature tools available.
4. Keep working while they read. A probe whose **After** names an unfinished item waits for it; everything else goes on.
5. As each subagent reports, check its item: every file listed with source and licence, every claim cited, a fetch script for every downloaded file. Send anything missing back to the same subagent.
6. Commit each finished item yourself: `research: <slug>`. Set its row on the probe map to `done` and link it, fill in any `pending` commit hashes first (see `lab-notebook`), and add it to the notebook's **Research** index. Probes its findings made sharp are proposed to the user at the next checkpoint, not added on your own.

Done when every dispatched item is committed and indexed. Its findings are presented to the user at the next checkpoint of `/experiment`, not at a gate of their own.
