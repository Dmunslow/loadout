#!/bin/bash
# Loadout Installer
# Copies Loadout's meta-tool files into ~/.claude/ so /new-loadout works from any project

set -e

LOADOUT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
MANIFEST="$CLAUDE_DIR/.loadout-manifest"

echo "Installing Loadout..."
echo ""

# Capture version info
VERSION=$(git -C "$LOADOUT_DIR" rev-parse HEAD 2>/dev/null || echo "unknown")
SOURCE_REPO=$(git -C "$LOADOUT_DIR" remote get-url origin 2>/dev/null || echo "unknown")
INSTALLED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%S")

# Write manifest with metadata headers
> "$MANIFEST"
echo "# loadout-version: $VERSION" >> "$MANIFEST"
echo "# installed-at: $INSTALLED_AT" >> "$MANIFEST"
echo "# source-path: $LOADOUT_DIR" >> "$MANIFEST"
echo "# source-repo: $SOURCE_REPO" >> "$MANIFEST"

# Install rules
mkdir -p "$CLAUDE_DIR/rules"
cp "$LOADOUT_DIR/.claude/rules/loadout-rules.md" "$CLAUDE_DIR/rules/loadout-rules.md"
echo "rules/loadout-rules.md" >> "$MANIFEST"

# Install skills
mkdir -p "$CLAUDE_DIR/skills/loadout-format"
mkdir -p "$CLAUDE_DIR/skills/discovery"
mkdir -p "$CLAUDE_DIR/skills/loadout-design"
cp "$LOADOUT_DIR/.claude/skills/loadout-format/SKILL.md" "$CLAUDE_DIR/skills/loadout-format/SKILL.md"
cp "$LOADOUT_DIR/.claude/skills/discovery/SKILL.md" "$CLAUDE_DIR/skills/discovery/SKILL.md"
cp "$LOADOUT_DIR/.claude/skills/loadout-design/SKILL.md" "$CLAUDE_DIR/skills/loadout-design/SKILL.md"
echo "skills/loadout-format/SKILL.md" >> "$MANIFEST"
echo "skills/discovery/SKILL.md" >> "$MANIFEST"
echo "skills/loadout-design/SKILL.md" >> "$MANIFEST"

# Install agents
mkdir -p "$CLAUDE_DIR/agents"
for agent in loadout-architect loadout-doctor loadout-describer loadout-differ loadout-backup rules-editor agent-manager loadout-updater loadout-reset; do
  cp "$LOADOUT_DIR/.claude/agents/$agent.md" "$CLAUDE_DIR/agents/$agent.md"
  echo "agents/$agent.md" >> "$MANIFEST"
done

# Install commands
mkdir -p "$CLAUDE_DIR/commands"
for cmd in new-loadout loadout-doctor loadout-description loadout-diff loadout-backup update-rules add-agent remove-agent update-loadout reset-project; do
  cp "$LOADOUT_DIR/.claude/commands/$cmd.md" "$CLAUDE_DIR/commands/$cmd.md"
  echo "commands/$cmd.md" >> "$MANIFEST"
done

echo "Installed files:"
grep -v '^#' "$MANIFEST" | sed 's/^/  ✓ /'
echo ""
echo "Loadout installed (version: ${VERSION:0:7})."
echo "Open any project and run /new-loadout to get started."
echo ""
echo "Available commands:"
echo "  /new-loadout          Set up a new project loadout"
echo "  /loadout-description  See what's in your current project's loadout"
echo "  /update-rules         Add or remove rules"
echo "  /add-agent            Create a new specialist agent"
echo "  /remove-agent         Remove an agent"
echo "  /loadout-backup       Backup or restore your loadout"
echo "  /loadout-doctor       Check installation health"
echo "  /loadout-diff         See what's changed in the repo"
echo "  /update-loadout       Update to the latest version"
echo "  /reset-project        Remove loadout files from a project"
