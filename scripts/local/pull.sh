#!/usr/bin/env bash
# Run by the systemd user timer from scripts/local/install.sh: fast-forward this clone to GitHub's
# main, which the weekly upstream Action keeps merged with mattpocock/skills. The post-merge hook
# then reports skill changes. Never merges: a clone that can't fast-forward is reported instead.
set -u
cd "$(dirname "$0")/../.." || exit 1
note() { echo "$1"; command -v notify-send >/dev/null && notify-send "real-scientist-skills" "$1"; }

git fetch --quiet origin main || { note "Weekly pull: fetching from GitHub failed."; exit 1; }
[ "$(git rev-parse HEAD)" = "$(git rev-parse origin/main)" ] && exit 0
git merge --ff-only --quiet origin/main ||
    { note "Weekly pull stopped: this clone has commits or changes GitHub doesn't. Pull by hand."; exit 1; }
