-- Price histogram in $100 buckets (prices span $1–$999).
SELECT
  (floor("Price" / 100) * 100)::INT AS price_floor,
  count(*)                          AS products
FROM products
GROUP BY 1
ORDER BY 1
