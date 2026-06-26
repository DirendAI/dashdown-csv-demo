-- Total rows across all three DuckDB tables (the headline "scale" number).
SELECT
  (SELECT count(*) FROM customers)
  + (SELECT count(*) FROM organizations)
  + (SELECT count(*) FROM products) AS total_rows
