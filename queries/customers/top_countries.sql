-- The 15 countries with the most customers (horizontal bar).
SELECT "Country" AS country, count(*) AS customers
FROM customers
GROUP BY 1
ORDER BY customers DESC
LIMIT 15
