-- Industry rollups for the clickable drill-down table. Industries containing a
-- "/" (e.g. "Logistics / Procurement") are excluded because a slash can't be a
-- single URL segment — static_paths would skip them and the row link would break.
SELECT
  "Industry"                        AS industry,
  count(*)                          AS organizations,
  count(DISTINCT "Country")         AS countries,
  round(avg("Number of employees")) AS avg_employees
FROM organizations
WHERE "Industry" NOT LIKE '%/%'
GROUP BY 1
ORDER BY organizations DESC
