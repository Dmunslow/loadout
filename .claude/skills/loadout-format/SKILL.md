---
name: loadout-format
description: The exact file format, frontmatter fields, and structure for every file type that Loadout generates — agents, skills, commands, rules, and hooks.
origin: loadout
---

# Loadout File Formats

Reference this skill whenever generating any Loadout output file. Every file must
match these formats exactly. No additional fields, no missing fields.

---

## Rules

**Location:** `.claude/rules/common/<name>.md`
**Format:** Plain markdown. No frontmatter. No special structure required.

Rules are always active — Claude reads them at the start of every session and
follows them throughout. Write them as clear, direct instructions.

```markdown
# <Title>

## <Category>
- <Rule>
- <Rule>

## <Category>
- <Rule>
```

**Tips for writing good rules:**
- Use plain language. Rules should read like instructions from a person, not a
  policy document.
- Be specific. "Always write a test for every new function" is better than
  "write tests".
- Group related rules under headings so they are easy to scan.
- Include both positive rules (always do X) and negative rules (never do Y).

**Example:**
```markdown
# Project Rules

## Always Do
- Ask before creating any new file
- Write a test for every new function
- Keep functions under 40 lines

## Never Do
- Add console.log or print statements unless explicitly asked
- Rewrite code that wasn't part of the request
- Use emoji in code or comments
```

---

## Skills

**Location:** `.claude/skills/<topic>/SKILL.md`
**Format:** Markdown with YAML frontmatter.

Skills are domain knowledge — patterns, conventions, examples, and reference
material for a specific topic. Claude loads them when the subject is relevant.

```markdown
---
name: <topic-slug>
description: <One sentence describing what this skill covers and when it is useful>
origin: loadout
---

# <Topic Title>

## When to Use This
- <Situation where this skill is relevant>
- <Situation where this skill is relevant>

## <Key Concept>
<Explanation, patterns, or conventions>

## Examples
<Concrete examples, ideally from the actual project>
```

**Tips for writing good skills:**
- The description field is important — Claude uses it to decide when to load the
  skill. Make it specific about both the topic AND the situations it applies to.
- Real examples from the user's actual project are far more valuable than
  generic ones. Use them wherever possible.
- Skills should answer the question "how do we do X in this project?" not
  "what is X in general?"

**Example:**
```markdown
---
name: api-conventions
description: How API endpoints are structured in this project — naming, response
  format, error handling, and authentication patterns.
origin: loadout
---

# API Conventions

## When to Use This
- Adding a new API endpoint
- Reviewing existing endpoints
- Handling errors from the API

## Endpoint Structure
All endpoints follow REST conventions...

## Examples
\`\`\`typescript
// Standard response format used in this project
\`\`\`
```

---

## Agents

**Location:** `.claude/agents/<name>.md`
**Format:** Markdown with YAML frontmatter.

Agents are specialist personas. When invoked, Claude Code runs this file as the
system prompt for a focused subagent with specific tools and a specific model.

```markdown
---
name: <agent-slug>
description: <What this agent does and when to use it. Be specific — this is what
  Claude reads to decide whether to invoke this agent.>
tools: [<Tool>, <Tool>]
model: <haiku|sonnet|opus>
---

You are a <role> for <project type or context>.

## Your Job
<Clear description of what this agent is responsible for>

## How You Work
<Step by step approach this agent takes>

## What Good Output Looks Like
<Description or example of the expected output format>
```

**Available tools:**
- `Read` — read files
- `Grep` — search file contents
- `Glob` — find files by pattern
- `Bash` — run terminal commands
- `Write` — create files
- `Edit` — modify files
- `WebSearch` — search the web
- `WebFetch` — fetch a specific URL

**Model guidance** — use the user's stated preference, or apply this default logic:
- `haiku` — fast, cheap. Good for simple, repetitive tasks (formatting, summarising)
- `sonnet` — balanced. Good for most tasks (reviewing, planning, writing)
- `opus` — powerful, slower. Good for complex reasoning (architecture, deep analysis)

**Tips for writing good agents:**
- The description field determines when Claude invokes this agent automatically.
  Write it as a clear statement of the agent's job and the situations that
  trigger it.
- Keep each agent focused on one domain. A code reviewer should only review.
  A planner should only plan.
- The body is the full system prompt — write it as direct instructions to the
  agent, not as documentation about it.

**Example:**
```markdown
---
name: code-reviewer
description: Reviews code changes for quality, correctness, and consistency with
  project conventions. Use after writing or modifying any code.
tools: [Read, Grep, Glob, Bash]
model: sonnet
---

You are a senior code reviewer for this project.

## Your Job
Review code changes and report issues by severity before anything is committed.

## How You Work
1. Run git diff to see what changed
2. Read each changed file in full
3. Check against project rules and conventions
4. Report findings grouped by severity: CRITICAL, WARNING, NOTE

## What Good Output Looks Like
A clear list of issues with file name, line number, what is wrong, and how
to fix it. End with a verdict: approve, approve with notes, or needs changes.
```

---

## Commands

**Location:** `.claude/commands/<name>.md`
**Format:** Markdown with YAML frontmatter.

Commands are slash commands the user types to trigger a workflow. They are thin
wrappers — they describe what to do and which agent handles it. The real work
happens in the agent.

```markdown
---
description: <One sentence describing what this command does>
agent: <agent-slug>
subtask: true
---

# <Command Title>

<Brief description of what this command does and when to use it>

## Steps
1. <Step>
2. <Step>
3. <Step>
```

**Tips for writing good commands:**
- The `agent` field must exactly match the `name` field in the corresponding
  agent file.
- Keep the steps high level — the agent file contains the detailed instructions.
- The command name (filename without .md) becomes the slash command.
  `code-review.md` → `/code-review`

**Example:**
```markdown
---
description: Review all code changes before committing
agent: code-reviewer
subtask: true
---

# Code Review

Run a full review of all uncommitted changes before you commit anything.

## Steps
1. Check what has changed since the last commit
2. Review each changed file for issues
3. Report findings and give a verdict
```

---

## Hooks

**Location:** `.claude/hooks/hooks.json`
**Format:** JSON

Hooks are the only component that runs real code. They fire automatically when
Claude uses certain tools or when the session starts or ends. The user never
has to think about them — they just work in the background.

```json
{
  "hooks": {
    "<LifecycleEvent>": [
      {
        "matcher": "<ToolName or *>",
        "hooks": [
          {
            "type": "command",
            "command": "<shell command to run>",
            "async": true,
            "timeout": 30
          }
        ],
        "description": "<What this hook does in plain English>"
      }
    ]
  }
}
```

**Lifecycle events:**
- `SessionStart` — fires when a new Claude Code session opens
- `PreToolUse` — fires before Claude uses a tool
- `PostToolUse` — fires after Claude uses a tool
- `Stop` — fires after each Claude response
- `SessionEnd` — fires when the session closes
- `PreCompact` — fires before Claude compresses context

**Matchers:**
- `*` — matches any tool
- `Bash` — matches terminal commands
- `Edit` — matches file edits
- `Write` — matches file creation
- `Edit|Write` — matches either

**Common hook recipes by stack:**

TypeScript / JavaScript:
```json
{
  "matcher": "Edit",
  "hooks": [{"type": "command", "command": "npx tsc --noEmit 2>&1 | head -20"}],
  "description": "TypeScript check after editing .ts files"
}
```

Prettier:
```json
{
  "matcher": "Edit",
  "hooks": [{"type": "command", "command": "npx prettier --write \"$CLAUDE_TOOL_INPUT_FILE_PATH\""}],
  "description": "Auto-format file after every edit"
}
```

Session save (any project):
```json
{
  "matcher": "*",
  "hooks": [{"type": "command", "command": "echo \"Session ended at $(date)\" >> .claude/session-log.txt", "async": true}],
  "description": "Log session end time"
}
```
