---
description: Check the health of your global Loadout installation — verifies all files
  are intact and reports any issues.
agent: loadout-doctor
subtask: true
---

# Loadout Doctor

Run a health check on your global Loadout installation to make sure everything
is working correctly.

## What it checks

1. The manifest file exists at `~/.claude/.loadout-manifest`
2. Version metadata is present (version hash, install date, source path)
3. Every file listed in the manifest actually exists
4. Agent files referenced by commands are present
5. Frontmatter in agents, skills, and commands is valid

## When to use

- After installing or updating Loadout
- If a Loadout command isn't working as expected
- Before running `/update-loadout` to see your current state
