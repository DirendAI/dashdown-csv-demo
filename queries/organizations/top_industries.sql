-- The 15 most represented industries (horizontal bar).
SELECT "Industry" AS industry, count(*) AS organizations
FROM organizations
GROUP BY 1
ORDER BY organizations DESC
LIMIT 15
