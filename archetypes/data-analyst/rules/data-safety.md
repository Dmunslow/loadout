# Data Safety

## Protect source data
- Never overwrite raw or source data files — always write outputs to a separate location
- Treat source files as read-only; if you need to clean them, save the cleaned version elsewhere
- Use clear naming to distinguish raw from processed: `users_raw.csv` vs `users_cleaned.csv`

## Reversibility
- Prefer transformations that can be rerun from source rather than in-place edits
- Keep a record of what you did — a script is better than a manual change, because it can be rerun
- If something must be done manually, document exactly what was done and why

## Permissions
- Only access data you're authorised to access
- Don't export or share data beyond what the task requires
- Be aware of PII — handle it carefully and don't log it unnecessarily
