-- Long-form source × stage counts — feeds the matrix heatmap and the pivot table.
SELECT
  "Source"     AS source,
  "Deal Stage" AS stage,
  count(*)     AS leads
FROM leads
GROUP BY 1, 2
ORDER BY 1, 2
