## Asking through the harness GUI

If this session's harness exposes a GUI question tool (Claude Code / Codex `AskUserQuestion`, OMP `ask`), deliver every frontier question through it instead of as plain text. The question content does not change — same Q-number, title, body, choices, and ➡️ recommended answer — only the channel changes.

- One GUI call per round, one question entry per frontier question: `question` carries the ❓ Qn title and body verbatim, `options` carries the multiple choices with the recommended answer first and marked `(recommended)` in its label, `header` is `Round N`.
- `multi`-select only when the round genuinely asks several independent decisions; otherwise one question per call, in Q-number order.
- Wait for the GUI answers before recomputing the frontier, exactly as with text questions. The frontier, rounds, and completion criterion are unchanged.
- If no GUI question tool is available in this harness, fall back to the ❓/➡️ text format above. Never drop or reword a frontier question because the channel differs.
