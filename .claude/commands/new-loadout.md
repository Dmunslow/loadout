---
description: Set up a personalised Claude Code environment for your project. Runs
  a short discovery interview then generates all the configuration files your project needs.
agent: loadout-architect
subtask: true
---

# New Loadout

Set up a personalised Claude Code environment for this project.

Loadout will ask you a few questions about what you're building and how you work,
then generate a set of configuration files that make Claude significantly more
useful for your specific project — with the right rules, specialist agents,
knowledge, and automations built in from the start.

## What happens

1. A `project-context` folder is created — drop in any docs or briefs you have
2. A short interview covers your project, your workflow, and your rules
3. A plan is presented for your review before anything is written
4. Files are generated one at a time, with a chance to adjust each one

## What gets created

Depending on your project, some combination of:
- **Rules** — what Claude should always and never do on this project
- **Skills** — domain knowledge specific to your work
- **Agents** — specialists for the tasks you do most often
- **Commands** — single-word triggers for your most common workflows
- **Hooks** — automations that run in the background without you thinking about them
- **Integrations** — connections to other tools you use alongside Claude

## Usage

Just run `/new-loadout` from inside your project folder. Everything else is
handled through conversation.
