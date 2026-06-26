-- Every country with rollups — drives the clickable drill-down table.
-- Each row links to /customers/country/<country>.
SELECT
  "Country"                 AS country,
  count(*)                  AS customers,
  count(DISTINCT "City")    AS cities,
  count(DISTINCT "Company") AS companies
FROM customers
GROUP BY 1
ORDER BY customers DESC
