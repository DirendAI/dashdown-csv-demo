-- Organizations by founding year (1970–2022) — the headline trend.
SELECT "Founded" AS year, count(*) AS organizations
FROM organizations
GROUP BY 1
ORDER BY 1
