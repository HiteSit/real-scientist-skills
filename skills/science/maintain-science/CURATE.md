# Curate the workflow

Can a reader follow each probe from the question that prompted it to the work, evidence and decisions actually recorded? Repair that trail in the live records. Leave files where they are: no payload moves, renames or restructuring, within a probe or between probes or studies.

## Account for the scope

“Curate the workflow” is enough to start. Unless the request limits the scope, inventory every study under `.science/`, open or closed. Look for study records, probe folders and cycle records as well as notebooks: a study missing its notebook still counts. For named studies or probes, stay within that scope; a dependency may be read for context without taking ownership of its records.

For each scoped study, reconcile the notebook's stable IDs and current links with the numbered directories in the current batch and every relevant promotion cycle, including `active/`. Check cycle READMEs and manifests in both directions: what recorded ID has no matching directory, and what directory has no notebook entry? An empty current batch can be correct. Account for each scoped probe once by study and ID; flag duplicate IDs, unlinked records and missing sources rather than picking a likely home.

Before editing, inspect the index, working tree and untracked files under `.science/` within scope. Check the paths and diffs of existing commits against the probe records and notebook log, including commits that lack the expected study prefix. An existing commit is evidence, not something to redo. If its milestone is missing from the live trail, add a dated reference to its hash where supported; leave the commit and its message intact.

For a substantial pass, the lead may assign separate studies or read-only traces to workers if available. Give each the record paths, write boundaries and checks. Keep a single writer for shared notebook sections. Workers return source locations, repairs, checks and unresolved choices to the lead; otherwise do the same work inline.

## Follow the evidence and repair the trail

Start with `STUDY.md` and the notebook's current direction. For each probe, follow **Asked**, **Builds on**, the original expectation and any pre-run criterion through **Method**, receipts and **Result** to the dated **Reading**. Check what the notebook **Map** and **Log** say happened, what remains open, and which later decisions or probes relied on it. Use the [review checklist](REVIEW.md#resolve-disagreements) to spot contradictions, not to issue a trajectory verdict. Judge the record against the work's stage: a planned probe need not have a result, and a recorded observation need not have a user decision.

A request to curate authorizes routine, unambiguous repairs to live workflow records in scope. For example, if a notebook still links to `probes/` but the cycle manifest and numbered README identify the same moved record, correct the notebook href. Restore a missing live provenance or log link when the receipt identifies its source. Follow the corrected link from the reader's entry point and verify the ID and revision or run it names, not just that the file exists. Preserve frozen records, original expectations, historical log entries, manifests, receipts and attributed readings; add a current locator or dated correction rather than changing what the earlier record said.

If a required record is absent, sources conflict, or ownership is unclear, report the paths, what is missing and what would settle it. Do not manufacture a record or infer an observation, interpretation, verdict, state, decision or owner. Finish independent repairs. The lead groups only consequential questions for the user, at most three at a time, citing the alternatives and their consequences. A single agreed decision can cover several probes: record its date, who made it, its basis and the affected IDs using the [cross-probe decision rules](../experiment/SKILL.md#compare-or-decide-when-asked). Keep an earlier reading visible and use the live notebook for a frozen probe.

## Settle pending changes and hand back

Group pending changes by the milestone they document, not by folder or staged status. For each unit, identify its study/probe or shared record, its source and owner, whether the work is complete, and which checks establish that. A complete observation can be checkpointed while the probe stays open. Paths, timestamps and commit authorship alone do not establish ownership of today's edits. If an earlier session's verified work needs an explicit handoff under repo policy, get that confirmation before including it.

Check each repair against its source and verify affected live links. At each coherent boundary, checkpoint eligible work under [Commits and tags](../lab-notebook/SKILL.md#commits-and-tags) when local staging and committing are authorized. Use only verified, owned paths or hunks; exclude heavy outputs and preserve other sessions' staged and unstaged work. If a draft, mixed hunk, active writer, unknown owner or failed check prevents isolating a unit safely, leave it in place and continue with other units. A broad cleanup grants no Git rights: no blanket staging, rewriting history, pushing or triggering a publishing hook without separate authority.

Report coverage by study and probe, the repairs and checks, and which milestones were already committed or checkpointed, with hashes. Identify every remaining in-scope change or group by path and say why it remains pending and what would unblock it. An empty queue of *eligible* checkpoints need not mean a clean checkout.

Stop at the records. Use `/experiment` for running or revising a probe, `/curate-probe-tree` for rearranging files within one probe for a stated purpose, [Migration](MIGRATION.md) for an approved format conversion, and `/promote` for reuse or batch rollover. None is implied by curation.
