-- Daily customer sign-ups — feeds the GitHub-style calendar heatmap (~880 days).
SELECT "Subscription Date"::DATE AS day, count(*) AS signups
FROM customers
GROUP BY 1
ORDER BY 1
