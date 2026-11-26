---
name: maintain-science
description: Configure a science repo, migrate record formats, review a study or curate workflow records across studies and probes.
license: MIT
disable-model-invocation: true
---

# Maintain science

Start from what the user asked and what is on disk. Read the repository instructions, `.science/SETUP.md` if present, and the relevant study records. Finding a problem does not select a branch or authorize a write. With a bare invocation, use the context to suggest the useful next step; ask one focused question if the intent is unclear. No flags or sequence are required.

- **Set up or refresh the repo.** Follow [Setup](SETUP.md) for the stack, data homes, shared library and project conventions. An existing setup is the baseline, not a scaffold to replace.
- **Bring records to the current format.** Follow [Migration](MIGRATION.md) to propose format-only edits and reconstruct missing fields from dated sources. Apply only the approved plan. This does not select an interpretation or require a retrospective.
- **Review a study.** Follow [Review](REVIEW.md) to compare its question, evidence, decisions and trajectory and explain how to resume. Read older records as they stand. A review or an explanation of the flow can be entirely read-only.
- **Curate the workflow.** “Curate the workflow” is enough. Follow [Workflow curation](CURATE.md) to trace studies and probes, repair live records and account for outstanding `.science/` changes. Only `/curate-probe-tree` asks what a particular probe's file layout should make easier.

Combine only the branches the prompt calls for. For example, refresh configuration and review a study without migrating its records. Respect an explicit repo-wide or named scope. When a request calls for one study, use the one named or loaded; if several fit, list their questions, open/closed status and open probes and ask which to use.

For study formats and shared-checkout rules, consult `lab-notebook`. Keep frozen starting records, original expectations and criteria, evidence, receipts and attributed readings intact. Format changes do not move payloads, change states, settle scientific questions or promote work. Separate permission to edit from permission to checkpoint or publish. Report what changed, what remains unresolved and the next action that fits the request.
