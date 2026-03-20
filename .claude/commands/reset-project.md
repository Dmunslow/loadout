---
description: Remove loadout-generated files from this project. Always backs up first and shows you exactly what will be deleted before touching anything.
agent: loadout-reset
subtask: true
---

# Reset Project Loadout

Remove the files that loadout created for this project, so you can start fresh
or cleanly hand the project to someone else.

## What it does

1. Finds the list of loadout-created files (from the project manifest, or by
   scanning if no manifest exists)
2. Shows you exactly what will be removed — nothing is deleted without your say-so
3. Creates a backup of your current `.claude/` config before touching anything
4. Removes only the loadout files, leaving everything else untouched

## What it never touches

- `CLAUDE.md` — always left alone, even if you ask
- Any file you created manually that isn't in the loadout manifest
- Anything outside `.claude/`

## When to use

- Starting over with a fresh `/new-loadout` for a project that has evolved
- Cleaning up a project before handing it off
- Removing a loadout that no longer fits how you're working
