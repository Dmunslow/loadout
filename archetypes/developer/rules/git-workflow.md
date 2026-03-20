# Git Workflow

<!-- Developer archetype defaults — inspired by Everything Claude Code
     https://github.com/affaan-m/everything-claude-code — MIT License, Affaan Mustafa -->

## Commits
- Write commit messages in the imperative: "Add login page", not "Added login page"
- Keep the subject line under 72 characters
- If the why isn't obvious from the what, add a body explaining it

## Branches
- Branch names: `<type>/<short-description>` — e.g. `feat/user-auth`, `fix/null-pointer`
- Delete branches after merging

## Pushing
- Never force-push to main or master
- Never push directly to a shared branch without a PR unless it's a solo project
- Always pull before pushing if others are working on the same branch

## History
- Prefer new commits over amending published commits
- Don't rewrite history that others have already pulled
