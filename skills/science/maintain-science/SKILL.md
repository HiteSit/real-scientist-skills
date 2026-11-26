---
name: maintain-science
description: Configure a science repo, update older record formats, or review where a study stands.
license: MIT
disable-model-invocation: true
---

# Maintain science

Start from what the user asked and what is on disk. Read the repository instructions, `.science/SETUP.md` if present, and the relevant study records. A missing setup, an old format, or a disagreement is a finding, not permission to fix it. With a bare invocation, use the context to suggest the useful next step; ask one focused question if the intent is unclear. No flags or sequence are required.

- **Set up or refresh the repo.** Follow [Setup](SETUP.md) for the stack, data homes, shared library and project conventions. An existing setup is the baseline, not a scaffold to replace.
- **Bring records to the current format.** Follow [Migration](MIGRATION.md) to propose format-only edits and reconstruct missing fields from dated sources. Apply only the approved plan. This does not select an interpretation or require a retrospective.
- **Review a study.** Follow [Review](REVIEW.md) to compare its question, evidence, decisions and trajectory and explain how to resume. Read older records as they stand. A review or an explanation of the flow can be entirely read-only.

Combine the branches the prompt calls for. For example, if asked to refresh configuration and review a study, do both without migrating its records. If a requested repair depends on a disputed fact, resolve that fact or leave it explicitly open before writing. For multiple possible studies, use the one named or loaded; otherwise list each question, open/closed status and open probes and ask which to use.

For study formats and shared-checkout rules, consult `lab-notebook`. Keep frozen starting records, original expectations and criteria, evidence, receipts and attributed readings intact. Format changes do not move payloads, change states, settle scientific questions or promote work. Separate permission to edit from permission to checkpoint or publish. Report what changed, what remains unresolved and the next action that fits the request.
