# Security

<!-- Developer archetype defaults — inspired by Everything Claude Code
     https://github.com/affaan-m/everything-claude-code — MIT License, Affaan Mustafa -->

## Secrets
- Never hardcode API keys, passwords, or tokens in source code
- Use environment variables for all credentials
- Never commit `.env` files — add them to `.gitignore`

## Input validation
- Validate all input at system boundaries — never trust data from external sources
- Sanitise before rendering to prevent XSS
- Use parameterised queries — never concatenate user input into SQL strings

## Dependencies
- Keep dependencies up to date; old packages are the most common attack vector
- Check for known vulnerabilities before adding a new package

## General
- Apply the principle of least privilege — request only the permissions actually needed
- Never log sensitive data (passwords, tokens, PII)
