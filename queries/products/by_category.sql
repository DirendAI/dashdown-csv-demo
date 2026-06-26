-- Per-category rollups — feeds the category chart and the drill-down table.
-- Each row links to /products/category/<category>.
SELECT
  "Category"             AS category,
  count(*)              AS products,
  round(avg("Price"), 2) AS avg_price,
  sum("Stock")          AS total_stock
FROM products
GROUP BY 1
ORDER BY products DESC
