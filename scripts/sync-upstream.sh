#!/usr/bin/env bash
# Merge mattpocock/skills main into this fork, then:
#   - keep the fork's own README.md, CHANGELOG.md and MAINTAINING.md,
#   - delete every path in fork-removed.txt again,
#   - rebuild customized/ with scripts/build.sh,
# and commit the merge. Exits non-zero, leaving the merge in progress, on any
# conflict it cannot resolve or a build failure. Run by .github/workflows/sync-upstream.yml;
# safe to run locally too. Never pushes.
set -euo pipefail
cd "$(dirname "$0")/.."

OWNED=(README.md CHANGELOG.md MAINTAINING.md)
git remote get-url upstream >/dev/null 2>&1 || git remote add upstream https://github.com/mattpocock/skills.git
git fetch --quiet upstream main

if git merge-base --is-ancestor upstream/main HEAD; then
    echo "already up to date with upstream/main"
    exit 0
fi

before=$(git rev-parse HEAD)
git merge --no-ff --no-commit upstream/main || true

git checkout "$before" -- "${OWNED[@]}"
mapfile -t removed < <(grep -vE '^[[:space:]]*(#|$)' fork-removed.txt)
git rm -r -q --cached --ignore-unmatch -- "${removed[@]}"
rm -rf -- "${removed[@]}"

conflicts=$(git diff --name-only --diff-filter=U)
if [ -n "$conflicts" ]; then
    echo "ERROR: unresolved conflicts:" >&2
    echo "$conflicts" >&2
    exit 1
fi

scripts/build.sh
git add -A customized
git commit --quiet --no-edit
echo "merged upstream/main $(git rev-parse --short upstream/main)"

new=$(git diff --name-only --diff-filter=A "$before" HEAD -- 'skills/*/*/SKILL.md')
if [ -n "$new" ]; then
    echo "NEW UPSTREAM SKILLS (link them into your skills dir if you want them):"
    echo "$new"
fi
