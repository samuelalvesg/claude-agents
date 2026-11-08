#!/usr/bin/env bash
# Validates frontmatter of every agent/skill and that install.sh is idempotent.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
fail=0
check() { # file, required keys...
  local f="$1"; shift
  [ "$(sed -n 1p "$f")" = "---" ] || { echo "no frontmatter: $f"; fail=1; return; }
  local fm; fm="$(awk 'NR>1 && /^---$/{exit} NR>1{print}' "$f")"
  for k in "$@"; do echo "$fm" | grep -q "^$k:" || { echo "missing $k: $f"; fail=1; }; done
}
for f in "$root"/template/.claude/agents/*.md; do check "$f" name description tools model; done
for f in "$root"/template/.claude/skills/*/SKILL.md; do check "$f" name description; done
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
"$root/install.sh" "$tmp" >/dev/null
echo "keep" > "$tmp/AGENTS.md"
"$root/install.sh" "$tmp" >/dev/null
[ "$(cat "$tmp/AGENTS.md")" = "keep" ] || { echo "install overwrote existing file"; fail=1; }
exit $fail
