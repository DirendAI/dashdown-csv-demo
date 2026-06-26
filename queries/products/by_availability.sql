-- Catalog split across the six availability states (pie/donut).
SELECT "Availability" AS availability, count(*) AS products
FROM products
GROUP BY 1
ORDER BY products DESC
