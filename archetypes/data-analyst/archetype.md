---
name: data-analyst
label: Data Analyst
description: Data analyst querying, cleaning, analysing, and communicating findings from data.
interview_hints:
  - Ask what tools they use (SQL, Python/pandas, R, BI tools) to tailor agents and rules
  - Ask if they work with raw source data or processed datasets to calibrate the safety rules
  - Ask what they typically deliver — ad hoc queries, dashboards, reports — to prioritise agents
---

# Data Analyst Archetype

Default rules and agents for data analysts. Covers querying, cleaning,
reshaping, and communicating findings clearly.

## What's included

**Rules**
- `data-safety` — never overwrite source/raw data; always write outputs to a separate location
- `assumptions` — document assumptions explicitly at the top of every analysis
- `validation` — check for nulls, duplicates, outliers, and schema mismatches before analysing
- `query-style` — readable structure over cleverness; comment non-obvious logic

**Agents**
- `query-builder` — writes and explains SQL or pandas/R queries from plain English descriptions
- `data-cleaner` — cleans and reshapes datasets; handles nulls, type coercion, deduplication, pivots
- `report-writer` — takes analysis output and writes a clear narrative summary for stakeholders
