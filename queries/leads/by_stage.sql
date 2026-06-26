-- Leads in each deal stage (all 10 stages).
SELECT "Deal Stage" AS stage, count(*) AS leads
FROM leads
GROUP BY 1
ORDER BY leads DESC
