#!/usr/bin/env bash
# Orient-grep demo for ADR-003 (a doc's orientation summary is a positional opening intro).
#
# A doc's "opening intro" is everything between its H1 (# ) and the first H2 (## ).
# We extract it by POSITION (no leading '>'), so it is form-agnostic and never
# collides with body callouts / alerts / admonitions (which are '>' blockquotes too).
#
# Usage:  ./orient-grep.sh /path/to/docs        (defaults to ./docs)

DOCS="${1:-./docs}"

intro() { awk 'f && /^## /{exit} /^# /{f=1; next} f' "$1"; }

echo "================================================================"
echo " STEP 1 - orient at the root: read its intro, decide where to go"
echo "================================================================"
intro "$(find "$DOCS" -maxdepth 1 -name '_README*.md' | head -1)"

echo
echo "================================================================"
echo " STEP 2 - drill into one folder: each child's intro"
echo "================================================================"
for f in "$DOCS"/*/_README*.md; do
  echo; echo "==> ${f#"$DOCS"/}"
  intro "$f"
done

echo
echo "================================================================"
echo " STEP 3a - names only: do the names orient you - and where not, could a better name fix it? (names are WIP)"
echo "================================================================"
find "$DOCS" -name "_README*.md" | sort | sed "s|$DOCS/||"

echo
echo "================================================================"
echo " STEP 3b - names + first line of each intro = an on-demand TOC (never stored)"
echo "================================================================"
find "$DOCS" -name "_README*.md" | sort | while read -r f; do
  first=$(intro "$f" | sed 's/^>[[:space:]]*//' | grep -v '^[[:space:]]*$' | head -1)
  printf '%-52s %s\n' "${f#"$DOCS"/}" "$first"
done

echo
echo "================================================================"
echo " STEP 4 - full intros of one subtree: the real summaries, narrowed in"
echo "================================================================"
find "$DOCS" -path "*/_README*.md" | sort | head -8 | while read -r f; do
  echo; echo "==> ${f#"$DOCS"/}"
  intro "$f"
done

# To test ALL doc names (not just _README), swap -name "_README*.md" -> -name "*.md".
