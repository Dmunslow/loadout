---
name: loadout-design
description: Decision-making framework for translating interview answers into the
  right combination of loadout files. Use this after the discovery interview to
  decide what to build before building anything.
---

# Loadout Design Framework

Use this skill after the discovery interview is complete and confirmed. It answers
the question: given what the user told me, what exactly should I build, and why?

---

## The Core Question for Each File Type

Before creating any file, ask yourself whether it passes its test:

| File type | The test |
|-----------|----------|
| Rule | Would the project break, or would the user be frustrated, if Claude ignored this? |
| Skill | Would Claude do this task meaningfully worse without this reference material? |
| Agent | Does this task benefit from a focused specialist rather than general Claude? |
| Command | Does the user do this often enough to deserve a single-word trigger? |
| Hook | Can this be automated without the user ever needing to think about it? |
| MCP | Would this integration save the user from repeated copy-paste between tools? |

If the answer is no, don't create it. A smaller, sharper loadout beats a bloated
one every time.

---

## Rules: What to Build and When

### Build a rule when:
- The user expressed a strong preference or non-negotiable
- The user described something Claude has done wrong before
- There is a consistent style, tone, or format the project must follow
- There is a safety concern (don't delete without asking, don't push without review)

### Do not build a rule when:
- The preference is so obvious it goes without saying
- It would only apply to one very specific situation (that's a skill or agent instead)
- The user mentioned it once in passing without emphasis

### If the interview produced few rules:
Don't invent rules to fill space. Instead, suggest universally useful defaults
and ask the user if they apply:

- "Always ask before deleting any file"
- "Never push to GitHub without the user reviewing the changes first"
- "Always ask before editing CLAUDE.md"
- "Never make changes outside the scope of what was asked"

Present these as suggestions, not assumptions. Only add them if the user agrees.

### Rule quality check:
Every rule should pass this test — could a new person read this rule and know
exactly what to do and what not to do? If it requires interpretation, make it
more specific.

---

## Skills: What to Build and When

### Build a skill when:
- The project operates in a specific domain Claude wouldn't know well by default
- There are patterns, conventions, or examples specific to this project
- The user has provided reference material in `project-context/` to draw from
- Claude would repeatedly make the same type of mistake without this knowledge

### Do not build a skill when:
- The knowledge is general and Claude already has it well
- The information fits better as a rule (short, directive) or in CLAUDE.md
- You'd be writing a skill with no real project-specific content or examples

### How many skills:
One skill per distinct domain. Don't merge unrelated topics into one file.
Most projects need 1–3 skills. More than 5 usually signals overlap or over-engineering.

### Skill quality check:
A skill should answer "how do we do X in this project?" not "what is X?"
If the skill reads like a Wikipedia article, it's too generic.

---

## Agents: What to Build and When

### Build an agent when:
- A recurring task benefits from deep, focused attention
- The task has a clear, repeatable process that can be written as instructions
- The task requires specific tools (reading files, searching the web, running commands)
- The user would benefit from a specialist who approaches this domain consistently

### Build an agent when an MCP is included:
Every MCP integration should have a corresponding agent that knows how to use it.
The agent defines the persona, the workflow, and what good output looks like when
working with that tool. An MCP without an agent is a connection with no one on
the other end.

### Do not build an agent when:
- The task is simple enough that a command alone would suffice
- The task is so varied that a fixed persona would be too limiting
- You'd be creating an agent that just does what general Claude already does

### Common agent archetypes:
These are starting points, not a closed list. Build whatever the project needs —
if none of these fit, create something specific to the user's domain.

**Reviewer** — reads work and gives structured feedback
- Tools: Read, Grep, Glob, Bash
- Good for: code review, content review, design critique

**Planner** — breaks down goals into steps before any work begins
- Tools: Read, Glob
- Good for: feature planning, project scoping, task breakdown

**Researcher** — searches for information and synthesises findings
- Tools: WebSearch, WebFetch, Read
- Good for: competitor research, technical investigation, market research

**Builder** — writes or generates output based on a spec
- Tools: Read, Write, Edit, Bash
- Good for: code generation, content writing, document creation

**Debugger** — investigates problems and finds root causes
- Tools: Read, Grep, Glob, Bash
- Good for: error investigation, bug fixing, performance analysis

**Domain specialist** — deep expert in a specific area of the project
- Tools: vary by domain
- Good for: anything the above archetypes don't cover

When in doubt: if the user described a type of work that doesn't fit neatly
into an existing archetype, create an agent named for the work itself.

### Model selection (apply user's stated preference first):

| Task complexity | Default model |
|----------------|---------------|
| Simple, repetitive | haiku |
| Most tasks | sonnet |
| Complex reasoning | opus |

---

## Commands: What to Build and When

### Build a command when:
- The user mentioned doing something repeatedly in Q3
- There is a clear workflow that always follows the same steps
- The user would benefit from a single trigger

### Do not build a command when:
- The task happens rarely
- The task is too varied to follow a consistent workflow

### Command ↔ Agent relationship:
Every command should map to an agent. If you're building a command, the
corresponding agent must also exist.

Command names should be short, obvious, and verb-led:
- `/review` not `/run-a-code-review`
- `/plan` not `/create-implementation-plan`
- `/research` not `/do-some-research-on-this`

---

## Hooks: What to Build and When

### Always include for any project:
- **Session log** — records when sessions start and end

### Include based on detected stack:

| Stack signal | Hook to add |
|-------------|-------------|
| TypeScript / JavaScript | TypeScript typecheck after Edit |
| Prettier in package.json | Auto-format after Edit |
| ESLint in package.json | Lint check after Edit |
| Python + black or ruff | Auto-format after Edit |
| Any git project | Warn before Bash commands containing `git push` |

### Do not add hooks for:
- Actions the user should consciously decide
- Complex shell scripts that require setup the user hasn't done
- Nice-to-haves that add noise without clear value

---

## MCPs: What to Build and When

### Suggest an MCP when:
- The user mentioned a tool they regularly switch to and from
- An official or well-maintained MCP exists for that tool
- The integration enables a concrete, describable capability improvement

### Always pair an MCP with an agent:
An MCP provides the connection. The agent provides the expertise. Build both
or build neither. The agent should be written specifically for working with
that tool — what it can access, how to use it well, and what good output looks like.

### Do not suggest an MCP when:
- The integration is experimental or poorly maintained
- The benefit is marginal or speculative
- Setup requires steps beyond what the user can reasonably follow

### If no MCP exists:
Consider a Skill instead. A skill describing how to work with a tool — its
conventions, what to export, how to structure inputs — is often 80% as useful
as a direct integration.

---

## Sizing the Loadout

| Project type | Typical loadout size |
|-------------|---------------------|
| Simple personal project | 1 rules file, 1 skill, 1–2 agents, 1–2 commands |
| Side project with a clear domain | 1 rules file, 2–3 skills, 2–3 agents, 2–4 commands |
| Product being actively built | 1 rules file, 3–5 skills, 3–5 agents, 4–6 commands, hooks |
| Complex multi-domain project | 2 rules files, 4–6 skills, 4–6 agents, 5–8 commands, hooks, MCPs |

When in doubt, build less. Users can always add more later. A bloated loadout
is harder to maintain and harder to reason about.

---

## The Final Checklist Before Generating

- [ ] Every rule is specific enough to follow unambiguously
- [ ] Every skill contains project-specific content, not just general knowledge
- [ ] Every agent has a clear, focused job
- [ ] Every command maps to an agent and has a short, verb-led name
- [ ] Every MCP has a corresponding agent
- [ ] Hooks are inferred from the stack — not invented
- [ ] MCPs are only suggested if a trusted integration exists
- [ ] The total number of files feels proportionate to the project's complexity
- [ ] Nothing overlaps or duplicates another file's purpose
