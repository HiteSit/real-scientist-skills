---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Format a round like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Word each question so "yes" accepts your recommended answer.

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent with a fresh context window to find it; don't ask the user for anything you could look up yourself. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the sub-agent to report; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Do not act on it until the user confirms you have reached a shared understanding.

## Asking through the harness GUI

If this session's harness exposes a GUI question tool (Claude Code / Codex `AskUserQuestion`, OMP `ask`), deliver every frontier question through it instead of as plain text. The question content does not change — same Q-number, title, body, choices, and ➡️ recommended answer — only the channel changes.

- One GUI call per round, one question entry per frontier question: `question` carries the ❓ Qn title and body verbatim, `options` carries the multiple choices with the recommended answer first and marked `(recommended)` in its label, `header` is `Round N`.
- `multi`-select only when the round genuinely asks several independent decisions; otherwise one question per call, in Q-number order.
- Wait for the GUI answers before recomputing the frontier, exactly as with text questions. The frontier, rounds, and completion criterion are unchanged.
- If no GUI question tool is available in this harness, fall back to the ❓/➡️ text format above. Never drop or reword a frontier question because the channel differs.
