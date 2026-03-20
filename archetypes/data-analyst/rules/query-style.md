# Query and Code Style

## Readability over cleverness
- Write queries and code that someone unfamiliar with the dataset can follow
- Break complex logic into steps with clear intermediate names
- A subquery with a descriptive alias is better than a one-liner that requires decoding

## Comments
- Comment any non-obvious logic: why a filter exists, why a join is structured a certain way
- If you're working around a known data quality issue, document it in the code

## Validation
- Before running analysis, check: nulls in key columns, unexpected value ranges,
  duplicate rows where uniqueness is expected, join fanout (are you accidentally
  multiplying rows?)
- A quick `COUNT(*)` and `COUNT(DISTINCT key)` before diving in saves a lot of pain

## Naming
- Use descriptive column aliases — `total_revenue` not `tr`, `user_count` not `n`
- Follow the naming conventions of the existing codebase or data warehouse
