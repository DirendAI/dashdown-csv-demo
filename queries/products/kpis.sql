-- Top-line product KPIs (1M rows). Inventory value = Σ(price × stock).
SELECT
  count(*)                      AS products,
  count(DISTINCT "Category")    AS categories,
  count(DISTINCT "Brand")       AS brands,
  round(avg("Price"), 2)        AS avg_price,
  round(sum("Price" * "Stock")) AS inventory_value
FROM products
