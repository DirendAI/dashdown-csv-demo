-- Headline totals across all three Datablist datasets (one DuckDB pass each).
SELECT
  (SELECT count(*) FROM customers)                      AS customers,
  (SELECT count(*) FROM organizations)                  AS organizations,
  (SELECT count(*) FROM products)                       AS products,
  (SELECT count(*) FROM leads)                          AS leads,
  (SELECT count(DISTINCT "Country") FROM customers)     AS countries,
  (SELECT round(sum("Price" * "Stock")) FROM products)  AS inventory_value
