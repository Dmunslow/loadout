#!/bin/bash
# Loadout Uninstaller
# Removes only the files that Loadout installed — leaves everything else in ~/.claude/ untouched

set -e

CLAUDE_DIR="$HOME/.claude"
MANIFEST="$CLAUDE_DIR/.loadout-manifest"

if [ ! -f "$MANIFEST" ]; then
  echo "No Loadout installation found (missing manifest)."
  echo "Nothing to uninstall."
  exit 0
fi

echo "Uninstalling Loadout..."
echo ""

while IFS= read -r file; do
  filepath="$CLAUDE_DIR/$file"
  if [ -f "$filepath" ]; then
    rm "$filepath"
    echo "  ✗ Removed $file"
  else
    echo "  - Skipped $file (already gone)"
  fi
done < "$MANIFEST"

# Clean up empty directories that Loadout created
rmdir "$CLAUDE_DIR/skills/loadout-format" 2>/dev/null || true
rmdir "$CLAUDE_DIR/skills/discovery" 2>/dev/null || true
rmdir "$CLAUDE_DIR/skills/loadout-design" 2>/dev/null || true

# Remove the manifest itself
rm "$MANIFEST"

echo ""
echo "Loadout uninstalled. Your other ~/.claude/ files are untouched."
