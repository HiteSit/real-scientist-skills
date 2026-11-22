## Asking through a question tool

When the harness has a tool for asking the user questions (Claude Code's or Codex's `AskUserQuestion`, OMP's `ask`), ask each round through it; the ❓/➡️ content moves into the tool unchanged.

- **One block per round.** Split it only at the tool's per-call question limit.
- **Fit the input to the question**: single choice, multiple choice, free text, number.
- **Recommended answer**: listed first, labelled `(recommended)`, and preselected wherever the tool allows.
- **Additional notes** closes every block: an optional free-text field, or, in a tool without one, a last question "Anything to add?" with "Nothing to add" recommended, whose write-in carries the note. It takes one slot of the per-call limit.
- Read **Additional notes** as answers: they can override a choice or open new branches when you recompute the frontier.

Without a question tool, end each text round with a `📝 **Additional notes:**` line inviting anything else.
