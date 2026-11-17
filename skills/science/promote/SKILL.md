---
name: promote
description: Roll over a science study's probe batch, preserve evidence and technically promote supported work after tree approval, with consumer checks and a connected scientific map.
license: MIT
disable-model-invocation: true
---

# Promote

Run an approved **promotion cycle**: physically roll over the current probe batch, promote components ready for their stated reuse, and preserve the rest. Technical promotion and batch rollover are separate decisions; neither requires pointless code porting. Return to experimentation and repeat. **Protocol** means reusable steps in their actual working homes, not a required directory.

Read `lab-notebook` and `.science/SETUP.md`. Before proposing the tree, read [`scientific-map`](../scientific-map/SKILL.md) for the shared project HTML, build files and verification.

## 1. Inspect the work

Read the named probes through the notebook's current record links, `STUDY.md`, earlier cycles and notebook **Ideas**. Inspect the actual project root, current `probes/` batch, shared study assets/data, reusable homes, Git status, branches, tags, worktrees and hooks, plus live consumers: scripts, notebooks, dashboards, launchers, queued jobs and path references. Distinguish live paths from captured historical commands.

Classify every scoped component: **promote** for supported technical reuse, **retain** as evidence, **retire** from current use while preserving it, or **defer** pending work/decision. Agree physical batch dispositions separately. Dropped probes stay dropped and are excluded from technical promotion, not preservation rollover. A valid negative result can support limited reuse; unmet validation blocks unsupported use, not preservation or unrelated organization. Archive placement is not a scientific-invalidity verdict.

Done when each component has its source, intended use, evidence limits, consumers and proposed disposition accounted for.

## 2. Grill the purpose

Read `grilling`. The **first question is grouping into steps**: propose one per probe, joining a probe that only feeds another, and let the user confirm or regroup. Explain incomplete components and recommend a scoped cycle rather than silently excluding them.

Then ask only a few decision questions per round, each with a recommendation: physical batch dispositions, technical reuse and actual working homes, preservation, consumers, checks/tolerances, data and commit grouping. Keep code where it serves reuse; migrate only necessary live paths. Parameterization, refactoring or a reusable framework is not a prerequisite for organization. Organize first; generalize only after observed proof justifies it.

Done when scope, dispositions, reuse limits, verification and grouping are agreed, including what waits.

## 3. Approve the tree

**Hard gate: no physical move, archive or main-tree write before the user approves the exact tree.** Extend existing homes, explaining each folder. Include the batch, any explicitly scoped earlier-cycle moves, map/build source, datasets and cycle record. Shared study assets are not automatically part of the batch. Return to approval if the tree changes.

Each cycle is `.science/<study>/_promotion_<title>_<date>/`:

```
README.md       approved tree, decisions/dispositions, scope and verification
manifest.json   old → new paths, dispositions and digests; large inventories may be compressed
promoted/       physical numbered probe directories; links to current reusable homes as needed
retained/       physical numbered evidence directories; relative links where appropriate
discarded/      physical numbered retired directories, preserved not deleted; optional links
active/         physical numbered unfinished probes, continuing under the same IDs
```

Move the batch's numbered folders directly into these four directories, preserving their names and complete captured history. No extra `records/` or cycle `probes/` layer. Mixed physical directories and relative links to current workflows, shared data or archives are legitimate; symlinks alone are not batch rollover. Each payload has one physical home. After rollover, study-level `probes/` is empty (`.gitkeep` allowed), ready for new questions, with no copies or compatibility aliases. Unfinished probes continue in cycle `active/`; their current notebook links, not checkpoint placement, determine current state and location. Record new locations/dispositions in the manifest and notebook, leaving frozen receipts/statements unmodified.

Done when the user has approved the whole tree, including preservation and verification.

## 4. Apply and verify

1. Capture old paths and per-file SHA-256 digests, including ignored payloads, then perform the approved physical moves. The manifest records stable probe IDs, old/new relative locations, dispositions, directory/file inventory, digests and symlink targets; large inventories may be compressed. Preserve original numbered READMEs, frozen statements and captured receipts byte-for-byte. Add latest-location metadata separately and record intentional live-file changes without forced normalization.
2. Give each payload one physical home. Resolve relative links beside physical numbered directories; verify the rolled-over `probes/` is empty and no record/history disappeared. Earlier-cycle moves need explicit approval and updated current lookup. General source/prepared/reference datasets enter shared data only when approved, with provenance, licence and checksums. Workflow databases/run outputs stay with their workflow; ordinary fetched data remains with its probe until approved promotion.
3. Update necessary current consumers, including open work, notebook record links and dashboards. Keep historical commands unchanged; put replacement commands/locations in current metadata. Do not relocate shared study assets merely because a batch moved. Update destination heavy-output ignores and keep heavy payloads unstaged.
   If a frozen README's relative link no longer resolves after the move, record the old and current targets in the manifest. Resolve live navigation by stable ID and the current notebook href, without editing the frozen link or recreating its old path.
4. Check preservation digests and manifest completeness. Exercise relevant current consumers and the actual intended reuse. A relocation needs path/link and consumer checks, not a speculative scientific rerun; changed reusable logic needs relevant regression checks and agreed tolerances (`tdd` for code changes, then `code-review`). A failed criterion blocks that reuse; record it without changing the scientific verdict to fit the organization.

Done when preservation, current consumers and agreed reuse checks pass, or the user explicitly defers the affected scope.

## 5. Record and checkpoint

Update the notebook's stable-ID-to-current-record links, working homes and cycle links, plus a **Log** line. Keep unchosen alternatives in **Ideas**, following `lab-notebook`; organization does not execute them. Partial technical promotion leaves an unfinished probe **open**, continuing at its recorded cycle `active/` location under the same ID; physical placement alone changes no scientific state/outcome. Use `promoted` only for the agreed completed whole-probe transfer. Append a **Promoted** line in `STUDY.md` naming the cycle, physical dispositions, technical components, source IDs, current destinations, limits and tag (or pending checkpoint). Starting sections stay frozen; tags preserve historical states.

Invoke `scientific-map` after updating the records and before the checkpoint. Refresh the approved shared HTML from all in-scope studies and select this study's tab. Record the build, checks, evidence and limits in the cycle README.

Before staging, present Git readiness: exact paths, heavy-output exclusions, unrelated changes, branch/tag/worktree inventory and hook effects. Approval of a tree is not authorization to stage, commit, push or trigger a publishing hook. Follow repository authorization. Independent steps get separate commits; an agreed tightly coupled relocation may be one coherent cycle commit. Stage exact paths only, never the whole repository or heavy outputs.

When authorized, commit `<study>: promote NN: <title>` and tag the cycle checkpoint `<study>/promotions/<title>-<date>` without overwriting any tag; record which commits it covers. In pull-request mode, propose the exact branch/worktree flow and get authorization before creating either or opening the PR. Record pending versus merged homes truthfully. Never infer permission to switch, merge, pull, delete branches/worktrees or contact a remote. A specifically approved fast-forward or safe merged-ref cleanup is optional; preserve occupied worktrees, tags and unrelated work.

Done when the records and approved checkpoint agree, or the cycle explicitly records that Git actions await authorization. Return to `/experiment <study>` using current homes, globally continuing probe numbers and any still-open components, ready for another cycle.
