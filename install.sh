#!/usr/bin/env bash
# Usage: ./install.sh <target-repo-dir> [--force]
# Copies template/ into the target repo without overwriting existing files
# (unless --force), preserving symlinks. Prints the placeholders that still need filling.
set -euo pipefail
target="${1:?usage: install.sh <target-repo-dir> [--force]}"
force="${2:-}"
src="$(cd "$(dirname "$0")/template" && pwd)"
[ -d "$target" ] || { echo "target not found: $target" >&2; exit 1; }
cd "$src"

# Copy regular files and directories first (skipping symlinks to avoid duplicate work)
find . -type f | while read -r f; do
  dest="$target/${f#./}"
  if [ -e "$dest" ] && [ "$force" != "--force" ]; then
    echo "skip   $dest (exists)"; continue
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$f" "$dest"
  echo "copied $dest"
done

# Copy or create relative symlinks
find . -type l | while read -r l; do
  dest="$target/${l#./}"
  link_target="$(readlink "$l")"
  if [ -L "$dest" ] || [ -e "$dest" ]; then
    if [ "$force" != "--force" ]; then
      echo "skip   $dest (exists)"; continue
    fi
    rm -rf "$dest"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$link_target" "$dest"
  echo "symlink $dest -> $link_target"
done

echo
echo "Placeholders left to fill:"
grep -rn '<[^>]*>' "$target/AGENTS.md" "$target/CLAUDE.md" "$target/.agents/agents/developer.md" 2>/dev/null | grep -E '<(uma|pasta|tarefa|link|idioma|build|nome|Co-Author|Linguagem|Regras|Comandos)' | cut -c1-120 || true
