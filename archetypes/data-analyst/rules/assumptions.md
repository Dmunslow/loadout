# Assumptions and Documentation

## Document assumptions explicitly
- State assumptions at the top of every analysis, not buried in the middle
- If you assumed nulls mean "no value" rather than "unknown", say so
- If you excluded a segment of the data, explain what and why

## Be honest about uncertainty
- Flag when data quality is poor rather than silently working around it
- If a finding could be explained by a data artifact, say so
- "This looks like X, but it could also be Y if the data has Z issue" is
  more useful than false confidence

## Reproducibility
- Document your steps clearly enough that someone else (or future you)
  could reproduce the analysis from scratch
- Prefer scripts over manual steps — a script is self-documenting
- Note the date the data was pulled; datasets change over time
