---
name: curate-probe
description: Reorganize one science probe around what you wanted to learn and what you want to use next.
license: MIT
disable-model-invocation: true
---

# Curate probe

`/curate-probe [probe]` arranges one existing probe for a purpose the user specifies: for instance, put two alternatives side by side for inspection, or make a chosen result the entry point. The distinction from `/experiment` is **why** the files are being organized, not where they live. Routine naming, moves, link repairs and documentation needed to carry out a probe are experiment work. Neither workflow promotes a component or rolls over a batch.

## 1. Read the direction

Resolve the probe through the study notebook, including records in a promotion cycle. Read the README and relevant conversation. Use earlier turns for context, not as fresh instructions. The current request must supply or explicitly adopt the direction: what should be easy to find, compare or use, and for whom? If the user only says “curate this” or the target is ambiguous, ask for the missing purpose or probe before moving anything. When they have already told you, proceed; do not ask them to approve your restatement.

## 2. Inventory by role

Map the whole probe unless the user explicitly narrows the scope. Inventory the filesystem, including dotfiles, ignored outputs, and untracked files; Git status alone is not enough. Account for every in-scope root entry and every distinct group below it. Summarize large uniform trees by run or generation and file count. Inventory mixed directories by role rather than as one group.

Classify by what the material is for, not by its extension or current folder name. Use these roles where they fit; keep names and nesting specific to the probe:

- **Execution**: inputs and preparation, launch and continuation, verification, cluster-side processing, and collection. Keep scripts, configs, and tests with the step they support.
- **Analysis**: local derivations, reports, figures, dashboards and viewer sessions. Keep a standalone analysis with its own scripts, tables and figures.
- **Evidence**: logs, receipts, manifests and verification records. Keep them with the stage or run they document. Mark captured records as immutable.
- **Published runs**: named deliveries and their assets. Treat each generation as a unit, distinct from working outputs, scratch and caches.

For every item or group, record its role, proposed home, and disposition: **move**, **keep** (why), or **blocked** (which dependency or active writer). A blocked move still gets a proposed home. Finish the inventory before choosing which moves to apply: no unexplained root entries and no omitted groups in scope.

## 3. Design the tree for that use

Resolve any remaining choice that affects the user's purpose, not implementation details. Show the target tree and exact old → new move map, including what stays put, what is blocked and what to open first for each task. Flag cross-role entry points instead of refactoring them. Keep alternatives together when the user is comparing rather than choosing. Use the existing README for navigation.

Move or rename only ordinary files within this probe. Keep the numbered record name, `README.md`, `.gitignore` and `figures/` in place. Preserve every file; use moves that fail if the destination exists. No deletion, replacement of destination files, copies, or compatibility aliases. Leave scientific content, frozen records and captured receipts untouched. Keep unrelated or concurrently changing work in place.

## 4. Check the projected paths

Test the projected tree before changing the checkout. Check for collisions, missing sources, and paths that escape the probe through symlinks. Check references in both directions: where the repo points to a moved path, and where a moved file's own relative paths resolve from its new home. Inspect affected links, symlinks, configs, scripts, globs, and active jobs. For globs, compare the matched files, not just the pattern text. Use existing read-only project checks in a disposable preview where practical. A search with no hits does not clear dynamic paths, opaque formats, or running jobs. Leave a move blocked if its affected consumers cannot be checked safely.

Compare tracked and ignored status, including anchored `.gitignore` rules. Preserve ignore behavior and document necessary live path repairs. If an outside reference needs an edit, check ownership and write scope: block the dependent move unless that repair is authorized. The user's settled direction covers safe moves, necessary in-scope reference repairs and navigation documentation. Do not seek another sign-off on a path list or diff. New purpose, expanded scope, or unresolved ownership is a different question.

## 5. Record, apply, and verify

Recheck sources, destinations and active writers against the plan. Before the first checkout change, create a private temporary directory and write `tree.md` there. Give the user its absolute path. Include the probe path, before and projected trees, move map, directories to create, intended path repairs and pre-change fingerprints. Keep this recovery file outside Git; temporary storage may be cleared.

Apply the safe part of the plan, recording each operation in `tree.md` as it lands; stop if the record cannot be updated. Verify identical bytes except for intended live-reference or navigation edits. Exercise affected consumers, recheck paths and ignores, and inspect the final tree and diff for unintended changes. Record results and blockers.

If interrupted, reconcile the record with both old and new paths on disk before deciding what landed. On a failed move, edit, or check, stop and record what landed, what did not, and what is uncertain. Show exact undo steps for the verified changes and any blockers. Before undoing anything, get fresh approval and recheck for collisions, changed files, and active writers.

Report what to open first, what moved, which references changed, what stayed blocked, and the recovery file path if one was created. Curating does not change probe state, run analyses or jobs, or authorize a commit or push.
