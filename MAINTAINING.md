# Maintaining this fork

This repo is a fork of [mattpocock/skills](https://github.com/mattpocock/skills). It follows Matt's `main` every week, adds the `skills/science/` bucket, and keeps a few small edits to his skills, called customizations.

## Customizations

A customization changes one of Matt's skills without touching his files, so the weekly merge never conflicts with it.

- `skills/` stays exactly as Matt ships it, plus `skills/science/`. Don't edit Matt's skills there.
- `customizations/<skill>/customization.md` holds your edit. It's added to the end of that skill's `SKILL.md`. If its first line is `<!-- customization:anchor: <exact line> -->`, it goes right after that line instead.
- `scripts/build.sh` rebuilds `customized/<skill>/`: the skill folder with your edit applied. `customized/` is committed, so a plain clone has it. Don't edit it by hand.
- The build fails, instead of skipping, if Matt renames the skill or removes the anchor line.

Current customizations:

- **[grilling](./customizations/grilling/customization.md)**: asks each round's questions through the harness's question tool (Claude Code or Codex `AskUserQuestion`, OMP `ask`) when it has one.
- **[chief-of-staff](./customizations/chief-of-staff/customization.md)**, from Matt's `in-progress/`: agent routing for the OMP harness, and `.wiki/` as the default wiki location.

To add one, write `customizations/<skill>/customization.md`, run `scripts/build.sh`, and commit both.

## Weekly sync with Matt's repo

Every Monday at 06:00 UTC, `.github/workflows/sync-upstream.yml` runs `scripts/sync-upstream.sh`. You can also start it from the Actions tab. The script:

1. merges Matt's `main`;
2. keeps this fork's own `README.md`, `CHANGELOG.md` and `MAINTAINING.md`;
3. deletes again every path in `fork-removed.txt`: Matt's plugin packaging, release tooling and issue bots, which this fork doesn't use;
4. rebuilds `customized/`, commits the merge, and pushes it.

The run summary lists any new skills Matt added. The run fails and opens an issue if the merge leaves a conflict, a customization no longer applies, or GitHub refuses the push (which happens when Matt changes `.github/workflows/`). To finish a failed run, run `scripts/sync-upstream.sh` on your machine, then push.

## Hooks

Run this once in each clone:

```bash
git config core.hooksPath .githooks
```

After that:

- every commit on `main` is pushed automatically;
- every push is first checked with [gitleaks](https://github.com/gitleaks/gitleaks) and with an optional private list of names that must never be published. The list lives at `~/.config/real-scientist-skills/leak-patterns`, one regular expression per line, and is never committed. A match blocks the push.
