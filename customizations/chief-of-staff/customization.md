<!-- customization:anchor: ## Subagents -->
## OMP agent routing (harness-aware dispatch)

When running under OMP, dispatch every piece of work through the routed worker roster by **agent name only** — `task` with `agent: "<name>"`. Never guess a model or effort label: the name is the whole routing decision.

Before the first dispatch, resolve the live routing and read it — do not cache a stale copy:

1. `~/.omp/agent/config.yml` → `modelRoles` (which model each role gets in the base config) and `task.disabledAgents`.
2. The active preset's `~/.omp/presets/<preset>.yml` + `~/.omp/presets/<preset>/rules/<preset>-orchestration.md` → the authoritative roster (allowed agent names) and each agent's model/effort. Detect the active preset from the session's launch config; do not assume one.
3. `~/.omp/agent/agents/<name>.md` for the shared worker definitions before briefing task-light / task-focused / task-heavy.

Selection rule (from the active orchestration rule, applied by you as Main):

- A **user-named agent is authoritative**: when the user says "use X" / "do it with X", dispatch exactly X and never substitute or second-guess the choice — this overrides the selection rule below for that request. Same for explicit refusals ("do it yourself", "no subagents"): they bind for that request.
- User cues bind: "simple/light/quick" → light tier, "careful/tricky/deep/critical" → task-heavy, "just rename/collect" → sonic, "double-check/review" → reviewer, "just look/map" → scout, "look at the page/screenshot" → task-visual.
- `task-light` — implementation path and programming pattern fixed by Main. `task-focused` — direction fully specified, implementation choices open. `task` — default substantive implementation. `task-heavy` — difficult diagnosis, cross-cutting design, security/concurrency/data-integrity risk, cost-sensitive scientific CLI investigation, ticket/spec ownership.
- `task-visual` — every interactive GUI/browser action. `reviewer` / `security-reviewer` — independent review. `commit-specialist` — scoped local commits after authorization.
- User cues bind: "simple/light/quick" → light tier, "careful/tricky/deep/critical" → task-heavy, "just rename/collect" → sonic, "double-check/review" → reviewer, "just look/map" → scout, "look at the page/screenshot" → task-visual, "do it with X" → exactly X.
- Upgrade when a cue understates the risk (interface, security, concurrency, data integrity) and say why in one line; never downgrade a heavy or review cue. With no cue, plain `task` is the default — route by uncertainty, coupling, consequences, and total expected cost, not file count.

Constraints: dispatch only agents on the active roster; no invocation-local model/effort overrides; never launch another OMP process to bypass routing; workers return orchestration decisions to you, they never spawn children. In a bare `omp` session without an orchestration preset, ask the user before delegating at all.

## Default wiki location: `.wiki/`

Resolution order for the wiki location:

1. **Existing wiki wins.** If a shared wiki already exists (user's own, another agent's, or a recognizable `wiki/` / `docs/wiki/` layout in the repo), write into it and follow its conventions, as above.
2. **Otherwise propose `.wiki/`.** When no wiki exists, ask the user once, before the first write, through the harness GUI question tool when available: "Use `.wiki/` at the repo root for the wiki?" with the recommended answer **yes** — on yes, create `.wiki/index.md` and write all pages there. On a different answer, use the location the user names.
3. **Never invent silently.** If the user is unreachable and no wiki exists, stop and say the wiki location is unsettled rather than picking a path on your own.

`.wiki/` follows the conventions in the Wiki section above (index.md, one topic per page, dated claims). Add `.wiki/` to the repo's ignore rules only if the user asks; by default the wiki is committed so it survives compaction and reaches other agents.
