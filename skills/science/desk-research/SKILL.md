---
name: desk-research
description: Answer a science question from existing sources (literature, databases, datasets, tool documentation) and keep the answer in the repo's shared library, .science/library/, with the raw search outputs and data files behind it. Use when framing a study needs reading, when a research row on a probe map is on the frontier, or when a question needs reading or data before a probe can be planned.
---

# Desk Research

**Desk research** answers a question from what already exists: papers, databases, datasets, tool documentation. It is the sister of the bench work in probes: nothing is run, things are found, read and saved.

Everything it finds goes into the **library**, `.science/library/`: one shared collection for the whole repo, belonging to no study. Studies link to library pages; the pages themselves never name a study, so any later study can reuse them. The library follows the spirit of Karpathy's LLM Wiki in its simplest form: an index read first, an append-only log, and markdown pages the agent writes and keeps current, with the raw material saved beside them.

Read `.science/SETUP.md` for the domain, data locations and heavy-output threshold.

## The library

```
.science/library/
  index.md                  one line per page, grouped by topic; read first, before any new search
  log.md                    append-only record of every search and page change
  <slug>.md                 one page per research question or topic
  searches/
    <YYYY-MM-DD>-<slug>/    one per search run with a tool
      query.md              tool, exact query, filters, date, number of hits, what was kept and why
      results.json          the tool's output, saved as returned (or .csv, whatever it returns)
      references.bib        the kept papers, with DOIs
  files/
    <slug>/                 datasets, database exports, structures; a fetch script; a .gitignore
```

**Page**, named by slug, flat at the library root:

```markdown
# <title>

**Question:** <what this page answers>
**Updated:** <YYYY-MM-DD>

## Answer
<the answer, each claim cited to its source by DOI or URL>

## Evidence
- [searches/<date>-<slug>](searches/<date>-<slug>/query.md): <what that search contributed>
- [files/<slug>](files/<slug>/): <what the files are>

## Gaps
<what could not be found or verified, and secondary sources used in place of primary ones>
```

A page grows: a later question on the same topic extends it instead of starting a new one, and **Updated** moves.

**index.md** groups pages under `## <topic>` headings, one line each: `- [<title>](<slug>.md): <one-line answer>`.

**log.md** is append-only, one entry per event, so `grep '^## \[' log.md` lists the history: `## [YYYY-MM-DD] search | <slug>: <tool>, <hits> hits, <kept> kept (for <study>)`, `## [YYYY-MM-DD] page | <slug>: new`, `## [YYYY-MM-DD] update | <slug>: <what changed>`. The `(for <study>)` note is the only place a study is named.

**Files** carry provenance: `files/<slug>/` holds a short `README.md` with one row per file (what it is, source, version or access date, licence) and the fetch script that downloads them. Files above the heavy-output threshold go in the folder's `.gitignore`, recorded with a checksum, and the fetch script regenerates them on a fresh clone.

**Primary sources first**: the paper, the official database, the tool's own documentation, never a write-up of them. Follow every claim and every dataset back to the source that owns it. A secondary source is used only when no primary one is reachable, and is marked as such under **Gaps**.

## Literature tools

When a question is bibliographic (finding, reading or checking papers), use the literature tools this harness exposes before generic web search: literature MCP servers (Scite, Semantic Scholar, publisher servers such as Wiley, and the like) and skills or APIs such as OpenAlex. Check which are available at the start of every run, since they differ by harness, and name them in each subagent's brief.

With those tools:

- search with the domain's own vocabulary and several queries per question;
- save every search run under `searches/`, the tool's output exactly as returned;
- cite only papers the tools actually returned, by DOI;
- check retractions and corrections where the tool reports them.

If no literature tool is available, use web search on primary sources and say so under **Gaps**.

## Look up

Every question starts here. Read `index.md` and open the pages that look relevant. When a page already answers the question, report it with its link, and stop: nothing is searched twice. When a page answers it in part, the research below extends that page.

## Research

1. **Collect the questions** the look-up left open: the caller's, and every research row on the probe map's frontier.
2. **Start one research subagent per question**, all at once, in the background, each with a fresh context window. They work in this checkout, on this branch, and leave git to you. Each writes only its own `searches/<date>-<slug>/` folders and its own `files/<slug>/` folder, so they never collide. Brief each with **context pointers**, not copies: the question and slug, `.science/SETUP.md`, the library layout above, any existing page it extends, and the literature tools available. Each reports back a draft answer with its citations.
3. **Keep working while they read.** The caller goes on with whatever does not depend on the answer.
4. **Check each report**: every claim cited, every search saved as returned, every file listed with source and licence, a fetch script for every downloaded file. Send anything missing back to the same subagent.
5. **Write the page yourself.** You alone write pages, `index.md` and `log.md`, so parallel subagents and parallel studies never collide on the shared files. Write or extend the page, add or update its index line, append the log entries.
6. **Commit the library**: `git add .science/library`, then `git commit -m "library: <slug>" -- .science/library` (see **Commits and tags** in `lab-notebook`).

Done when every question has a committed page and an index line. Report each page to the caller, one line with its link. The caller links it from its study: a `done` research row, a **Background** line in `STUDY.md`, or a line under the notebook's **Library**.
