#!/bin/bash
# Loadout Installer
# Copies Loadout's meta-tool files into ~/.claude/ so /new-loadout works from any project

set -e

LOADOUT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
MANIFEST="$CLAUDE_DIR/.loadout-manifest"

echo "Installing Loadout..."
echo ""

# Track installed files so uninstall knows what to remove
> "$MANIFEST"

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
cp "$LOADOUT_DIR/.claude/agents/loadout-architect.md" "$CLAUDE_DIR/agents/loadout-architect.md"
echo "agents/loadout-architect.md" >> "$MANIFEST"

# Install commands
mkdir -p "$CLAUDE_DIR/commands"
cp "$LOADOUT_DIR/.claude/commands/new-loadout.md" "$CLAUDE_DIR/commands/new-loadout.md"
echo "commands/new-loadout.md" >> "$MANIFEST"

echo "Installed files:"
cat "$MANIFEST" | sed 's/^/  ✓ /'
echo ""
echo "Loadout installed. Open any project and run /new-loadout to get started."
