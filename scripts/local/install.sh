#!/usr/bin/env bash
# Make this clone follow GitHub on its own: a systemd user timer runs scripts/local/pull.sh every
# Monday at 12:00 (or at the next boot if the machine was off), and the post-merge hook reports
# skill changes against a skills folder that links into this clone.
# Usage: scripts/local/install.sh [skills-folder]    e.g. scripts/local/install.sh ~/.agents/skills
set -euo pipefail
repo=$(cd "$(dirname "$0")/../.." && pwd)
units="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
mkdir -p "$units"

cat >"$units/real-scientist-skills-pull.service" <<EOF
[Unit]
Description=Pull real-scientist-skills, following the weekly upstream merge on GitHub

[Service]
Type=oneshot
ExecStart=$repo/scripts/local/pull.sh
EOF

cat >"$units/real-scientist-skills-pull.timer" <<EOF
[Unit]
Description=Weekly pull of real-scientist-skills

[Timer]
OnCalendar=Mon *-*-* 12:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

git -C "$repo" config core.hooksPath .githooks

if [ $# -ge 1 ]; then
    conf="${XDG_CONFIG_HOME:-$HOME/.config}/real-scientist-skills"
    mkdir -p "$conf"
    printf 'SKILLS_POOL=%q\n' "$(cd "$1" && pwd)" >"$conf/env"
fi

systemctl --user daemon-reload
systemctl --user enable --now real-scientist-skills-pull.timer
systemctl --user list-timers real-scientist-skills-pull.timer --no-pager
