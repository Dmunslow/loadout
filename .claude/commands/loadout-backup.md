---
description: Create a backup of your project's .claude/ configuration, or restore
  from a previous backup.
agent: loadout-backup
subtask: true
---

# Loadout Backup

Save a snapshot of your current project loadout before making changes, or restore
a previous snapshot if something went wrong.

## What it does

- **Backup:** Copies everything in `.claude/` to `.claude/backups/<timestamp>/`
- **Restore:** Lists available backups and lets you pick one to restore from

## When to use

- Before running `/update-rules` or `/add-agent` if you want a safety net
- Before making significant manual changes to your loadout
- To roll back after a change you don't like
