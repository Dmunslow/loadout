# Coding Style

<!-- Developer archetype defaults — inspired by Everything Claude Code
     https://github.com/affaan-m/everything-claude-code — MIT License, Affaan Mustafa -->

## Immutability
- Always create new objects or data structures rather than mutating existing ones
- Treat function arguments as read-only; never modify a parameter in place

## File organisation
- Keep files between 200 and 400 lines; 800 is the absolute maximum
- Organise by feature, not by file type — keep related things together
- One clear responsibility per file

## Functions
- Keep functions under 50 lines
- Maximum 4 levels of nesting — extract if you go deeper
- Prefer explicit return types

## Error handling
- Show user-friendly messages on the client side
- Log detailed error information server-side with enough context to debug
- Never swallow errors silently

## Configuration
- No hardcoded values — use environment variables or config files
- No magic numbers — name constants clearly
