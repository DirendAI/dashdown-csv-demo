---
title: Category detail
static_paths:
  connector: main
  query: SELECT "Category" AS category FROM products GROUP BY 1 ORDER BY count(*) DESC LIMIT 40
---

# Category detail

:::query name=category_summary connector=main
SELECT
  ANY_VALUE("Category")         AS category,
  count(*)                      AS products,
  count(DISTINCT "Brand")       AS brands,
  round(avg("Price"), 2)        AS avg_price,
  round(sum("Price" * "Stock")) AS inventory_value
FROM products
WHERE "Category" = '${category}'
:::

Every SKU in the **<Value data={category_summary} column="category" />** category.

<Grid cols=4>
  <Counter data={category_summary} column="products" label="Products" format="number" />
  <Counter data={category_summary} column="brands" label="Brands" format="number" />
  <Counter data={category_summary} column="avg_price" label="Avg. price" format="currency" />
  <Counter data={category_summary} column="inventory_value" label="Inventory value" format="currency" decimals=0 />
</Grid>

## Price & availability

:::query name=category_price connector=main
SELECT (floor("Price" / 100) * 100)::INT AS price_floor, count(*) AS products
FROM products
WHERE "Category" = '${category}'
GROUP BY 1
ORDER BY 1
:::

:::query name=category_availability connector=main
SELECT "Availability" AS availability, count(*) AS products
FROM products
WHERE "Category" = '${category}'
GROUP BY 1
ORDER BY products DESC
:::

<Grid cols=2>
  <BarChart data={category_price} x="price_floor" y="products" title="Price distribution ($100 buckets)" format="number" />
  <PieChart data={category_availability} x="availability" y="products" donut title="Availability mix" format="number" />
</Grid>

## Top brands

:::query name=category_brands connector=main
SELECT "Brand" AS brand, count(*) AS products, round(avg("Price"), 2) AS avg_price
FROM products
WHERE "Category" = '${category}'
GROUP BY 1
ORDER BY products DESC
LIMIT 15
:::

<Table data={category_brands} title="Top brands" format="products=number, avg_price=currency" search=false />

[← All categories](/products)
