# Testing

<!-- Developer archetype defaults — inspired by Everything Claude Code
     https://github.com/affaan-m/everything-claude-code — MIT License, Affaan Mustafa -->

## Coverage
- Aim for 80%+ test coverage across the codebase
- Critical paths (auth, payments, data mutations) should be at or near 100%

## What to test
- Happy paths — the expected successful flow
- Edge cases — empty inputs, boundary values, max/min
- Error conditions — what happens when things fail
- Integration points — where your code meets external systems

## Test structure
- Each test should test one thing and have a clear name that describes what it's checking
- Arrange → Act → Assert — keep tests readable with this structure
- Tests should be independent — no test should depend on another running first

## Discipline
- Write the test before the implementation when possible (red → green → refactor)
- Never disable or skip a test without a comment explaining why and a plan to fix it
- A failing test is a blocker — don't ship with known failures
