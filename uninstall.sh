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

cat << 'LOGO'

   ▛▀▀                    ▀▀▜
   ▌                         ▐
   ▌   ████████████          ▐
   ▌                         ▐
   ▌   ████  ████████  ██    ▐
   ▌                         ▐
   ▌   ██████████            ▐
   ▌                         ▐
   ▙▄▄                    ▄▄▟

           l o a d o u t

LOGO
echo "Uninstalling Loadout..."
echo ""

while IFS= read -r file; do
  # Skip metadata header lines
  [[ "$file" == \#* ]] && continue
  filepath="$CLAUDE_DIR/$file"
  if [ -f "$filepath" ]; then
    rm "$filepath"
    echo "  ✗ Removed $file"
  else
    echo "  - Skipped $file (already gone)"
  fi
done < "$MANIFEST"

# Clean up empty directories that Loadout created
for dir in skills/loadout-format skills/discovery skills/loadout-design; do
  rmdir "$CLAUDE_DIR/$dir" 2>/dev/null || true
done
# Clean up parent directories if empty (only removes if empty)
for dir in skills agents commands rules; do
  rmdir "$CLAUDE_DIR/$dir" 2>/dev/null || true
done

# Remove the manifest itself
rm "$MANIFEST"

echo ""
echo "Loadout uninstalled. Your other ~/.claude/ files are untouched."
