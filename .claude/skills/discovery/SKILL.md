---
name: discovery
description: How to run the Loadout discovery interview — what to ask, when to probe,
  how to read signals from a codebase and memory, and how to translate user answers
  into the right set of output files.
origin: loadout
---

# Discovery Interview Guide

This skill governs how to conduct the `/new-loadout` interview. The goal is to
gather enough context to generate a complete, useful loadout without overwhelming
the user or asking questions they have already answered.

---

## Before the Interview Starts

### 1. Create the project-context folder
Create a `project-context/` folder in the project root. Tell the user:

> "I've created a folder called `project-context` in your project. If you have
> any documents, briefs, screenshots, or notes about this project — drop them in
> there before we continue. I'll read everything in it. If you don't have anything
> yet, no worries — just let me know and we'll go from there."

Wait for the user to respond before moving on.

### 2. Read everything available
Before asking a single question, gather all available context:

**From the project folder:**
- Everything in `project-context/`
- `README.md` or any existing documentation
- `package.json`, `requirements.txt`, `go.mod`, or equivalent
- Folder and file structure
- Any existing `.claude/` files including `CLAUDE.md`

**From Claude's memory:**
- Check for any stored memory about this project or user
- Prior session context, decisions made, patterns noted

**From git history (if it exists):**
- Recent commit messages and PR titles
- Frequently modified files or folders
- Patterns in the type of work being done

**Note on chat history:** Claude does not have access to prior conversation
transcripts directly, but memory and `CLAUDE.md` serve as the persistent record
of past context. Prioritise those.

### 3. Decide which path to take

**Greenfield** (no codebase, no prior context):
- Run all interview questions in order
- You have no shortcuts — every answer matters

**Existing project** (codebase or prior context found):
- Form a summary before Q1
- Use git history to suggest repeated tasks in Q3
- Skip anything you already know with confidence

---

## The Interview Questions

### Q1 — The Project

**Purpose:** Understand what is being built, for whom, and why.

**Ask:**
> "Tell me about this project — what are you building, who is it for, and why
> does it need to exist?"

If you already have context, lead with what you know and ask specifically about
what is still missing:

> "Based on what I can see, it looks like [specific summary]. A few things I'm
> not sure about: [specific gap 1] and [specific gap 2]. Can you fill those in?"

Do not ask open-ended vague prompts. If something is unclear, ask about that
specific thing.

**Probe based on what is still missing:**
- If you don't know who it's for → "Who is the main person using this?"
- If you don't know the core problem → "What frustration or gap does this fix for them?"
- If you don't know the scope → "What are the two or three most important things it needs to do?"
- If too broad → "If you had to pick the single most important thing to get right first, what is it?"

**Before moving on — always do this:**
Summarise your understanding and ask for corrections before proceeding:

> "Let me make sure I've got this right: [2–3 sentence summary of the project,
> who it's for, and why it exists]. Is that accurate? Anything wrong or missing?"

Do not move on until the user confirms.

---

### Q2 — Existing Projects Only: Confirm Your Understanding

**Purpose:** Use what you read from the codebase, CLAUDE.md, and memory to
shortcut the interview.

**Ask:**
> "Here's what I've pieced together: [your summary]. What did I get wrong?
> What's missing?"

Include in your summary (where available):
- What the project does (from README, CLAUDE.md, memory, folder structure)
- The tech stack and major tools
- What the user has been working on recently (from git history or memory)
- Any decisions or conventions already established (from CLAUDE.md or memory)

**Probe if the correction is minimal:**
- "Is there context about why this project exists, or who it's for, that I
  wouldn't be able to see from the code or notes?"

---

### Q3 — Repeated Tasks

**Purpose:** Identify the workflows the user repeats most often.
These become commands and agents.

**Ask:**
> "What kinds of things do you find yourself asking Claude to do over and over?
> For example — writing copy or content, searching the web for research,
> reviewing your code before saving, or fixing errors.
> What's on your list?"

For existing projects, lead with suggestions from git history or memory:
> "Looking at your recent work, it seems like you've been spending a lot of time
> on [X]. Is that a regular part of your workflow? What else comes up repeatedly?"

**Probe if the answer is vague:**
- "Even something small counts — what did you ask Claude to do in your last session?"
- "Is there anything you wish Claude would just handle automatically?"

**Probe on each task mentioned:**
- "How often does that come up — every session, or a few times a week?"
- "When you ask Claude to do that, what does a good result look like for you?"

**Translate to output files:**
- A recurring task → Command + Agent
- A task needing deep expertise → dedicated Agent
- A task requiring specific knowledge → Skill

---

### Q4 — Rules

**Purpose:** Capture the user's non-negotiables and recurring frustrations.

**Ask:**
> "Now let's talk about rules — the things you want Claude to always do, and
> the things you never want it to do. For example: never push code to GitHub
> before you've had a chance to review it, always ask before editing CLAUDE.md,
> never delete a file without confirming first. What are the rules for your project?"

Give concrete examples upfront so the user immediately understands what kind
of answers are useful here.

**Probe if the answer is thin:**
- "Has Claude ever done something on this project that you had to undo or
  correct? That's usually a rule waiting to be written."
- "Are there any style, tone, or formatting preferences that matter to you?"
- "Anything it should never do, even if you accidentally ask it to?"

**Probe for specificity:**
- If vague → "What does that mean specifically for this project?"
- If "don't break things" → "What's the most important part of the project
  to protect?"

---

### Q5 — External Tools and Integrations

**Purpose:** Identify tools the user works with alongside Claude so that
direct integrations can be suggested where they add clear value.

**Ask:**
> "What other tools and apps are part of your workflow on this project?
> For example — Figma for design, Notion for notes, Linear for tasks,
> Airtable or Google Sheets for data, or anything else you switch between regularly."

**After the user responds:**

For each tool mentioned, search for a corresponding MCP server or trusted
integration. Present relevant findings in plain terms:

> "For [tool], there's an integration available that would let me connect
> to it directly — meaning I could [specific concrete capability] without
> you having to copy and paste anything. Want me to include that?"

Only suggest integrations that are:
- From a trusted, maintained source (official MCP registry, Anthropic docs,
  well-maintained open source repositories)
- Genuinely useful for this specific project
- Something that provides a clear, explainable capability improvement

If no MCP exists for a tool, consider whether a Skill makes sense instead.

**Probe if the answer is thin:**
- "What do you have open in other tabs when you're working on this?"
- "Is there a tool where you often find yourself copying something out to
  paste into Claude? That's usually a sign an integration would help."

---

### Q6 — Model Preference

**Purpose:** Let the user decide how much power to give their agents.

**Ask:**
> "One last thing — the agents I create for you can run on different AI models,
> which affects how fast they respond and how deeply they think. Here are your
> options:
>
> - **Smart defaults** *(recommended)*: I'll pick the right model for each agent
>   based on what it does. Simple tasks get a faster model, complex ones get
>   a more powerful one.
> - **Best quality**: Use the most powerful model (Opus) for everything. Slower
>   and costs more, but highest quality across the board.
> - **Fastest**: Use the quickest model (Haiku) for everything. Great for
>   straightforward work where speed matters more than depth.
> - **I'll choose**: I'll ask you which model you want after showing you each agent.
>
> Which sounds right for you?"

---

## After the Interview: Synthesis

Before generating any files, do the following:

### Map answers to file types

| What the user said | What to generate |
|--------------------|-----------------|
| Recurring task | Command + Agent |
| Frustration or repeated correction | Rule |
| Domain knowledge Claude needs | Skill |
| External tool mentioned | MCP config or Skill |
| Tech stack detected | Hooks (auto-inferred) |

### Check for gaps

- Do you have enough for at least one rule? If not, probe more on Q4.
- Do you have at least one clear recurring task? If not, probe more on Q3.
- Do you understand the project well enough to write a skill? If not, probe Q1.

### Present the plan

Before writing any files, summarise what you are about to create:

> "Here's what I'm going to set up for you:
>
> **Rules** — [X rules covering Y and Z]
> **Skills** — [skill names and what they cover]
> **Agents** — [agent names and what they do]
> **Commands** — [slash command names and when to use them]
> **Hooks** — [what runs automatically and when]
> **Integrations** — [any MCP servers or external tool connections]
>
> Does that sound right? Anything you'd add or change before I start?"

Wait for confirmation before generating anything.

---

## Reading Signals Throughout

| Signal | Likely output |
|--------|--------------|
| "I always have to remind Claude that..." | Rule |
| "I wish Claude would just..." | Command |
| "Claude keeps getting X wrong..." | Rule + Skill |
| "I spend a lot of time doing X..." | Command + Agent |
| "Everything needs to look/sound like..." | Rule + Skill |
| "We use X tool / framework / app" | Skill or MCP |
| "I'm worried about getting X right" | Agent focused on X |
| "I keep switching between Claude and [app]" | MCP integration |
| "I always have to copy from [app] into Claude" | MCP integration |
| "The most important part of this project is X" | Skill for X domain |
