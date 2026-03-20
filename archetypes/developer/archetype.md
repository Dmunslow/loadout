---
name: developer
label: Developer
description: Software engineer writing and shipping application code. Covers planning, code review, TDD, security, and git workflow.
attribution: Developer defaults inspired by Everything Claude Code (https://github.com/affaan-m/everything-claude-code) — MIT License, Affaan Mustafa
interview_hints:
  - Ask what languages and frameworks they use to tailor language-specific rules
  - Ask if they work solo or in a team to calibrate git workflow strictness
  - Ask if they have a test framework preference for the TDD agent
---

# Developer Archetype

Default rules and agents for software engineers. Covers the full development
loop: planning, writing code, reviewing it, testing it, and shipping it safely.

Inspired by Everything Claude Code (https://github.com/affaan-m/everything-claude-code)
by Affaan Mustafa, MIT License.

## What's included

**Rules**
- `coding-style` — immutability, file size limits, function length, error handling
- `development-workflow` — plan before coding, one concern per PR, no TODOs in merged code
- `git-workflow` — commit message format, branch naming, when to push
- `security` — no hardcoded secrets, input validation, parameterized queries
- `testing` — 80%+ coverage target, test structure, what must be tested

**Agents**
- `planner` — breaks features into phased implementation steps before any code is written
- `code-reviewer` — reviews diffs for correctness, security, and style
- `tdd-guide` — runs the red/green/refactor loop, enforces test-first discipline
