#!/usr/bin/env bash
# Rebuild customized/<skill>/ from the pristine skills/*/<skill>/ plus
# customizations/<skill>/customization.md. customized/ is generated: never edit it by hand.
#
# An optional first line `<!-- customization:anchor: <exact line> -->` inserts the
# customization right after that line of SKILL.md; without it, it is appended.
# A skill that is missing (or ambiguous) under skills/ and an anchor that no longer
# matches are hard errors: re-home the customization deliberately, never skip it.
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf customized
shopt -s nullglob
for c in customizations/*/customization.md; do
    skill=$(basename "$(dirname "$c")")
    src=(skills/*/"$skill")
    if [ ${#src[@]} -ne 1 ]; then
        echo "ERROR: $skill matches ${#src[@]} dirs under skills/*/ (renamed or removed upstream?)" >&2
        exit 1
    fi
    dst=customized/$skill
    mkdir -p customized
    cp -r "${src[0]}" "$dst"

    if [[ $(head -n1 "$c") =~ ^'<!-- customization:anchor: '(.*)' -->'$ ]]; then
        anchor=${BASH_REMATCH[1]}
        if ! grep -qxF -- "$anchor" "$dst/SKILL.md"; then
            echo "ERROR: $skill: anchor line not found upstream: $anchor" >&2
            exit 1
        fi
        A="$anchor" B="$(tail -n +2 "$c")" awk '
            { print }
            $0 == ENVIRON["A"] && !done { print ""; print ENVIRON["B"]; print ""; done = 1 }
        ' "$dst/SKILL.md" > "$dst/SKILL.md.new"
        mv "$dst/SKILL.md.new" "$dst/SKILL.md"
        echo "customized: $skill <- ${src[0]} (after: $anchor)"
    else
        { printf '\n'; cat "$c"; } >> "$dst/SKILL.md"
        echo "customized: $skill <- ${src[0]} (appended)"
    fi
done
