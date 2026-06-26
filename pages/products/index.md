---
title: Products
sidebar_label: Products
sidebar_position: 4
icon: "📦"
---

# Products

**1,000,000** products across **34** categories and 600k+ brands, priced $1–$999, with stock and availability — a combined inventory worth a quarter of a trillion dollars on paper.

<Grid cols=4>
  <Counter data={products.kpis} column="products" label="Products" format="number" />
  <Counter data={products.kpis} column="categories" label="Categories" format="number" />
  <Counter data={products.kpis} column="avg_price" label="Avg. price" format="currency" />
  <Counter data={products.kpis} column="inventory_value" label="Inventory value" format="currency" decimals=0 />
</Grid>

## Catalog by category

<TreemapChart data={products.by_category} x="category" y="products" title="Products by category" />

<Ask data={products.by_category} ask="In 2-3 sentences, say which product categories hold the most SKUs and which carry the highest average price. Keep it concrete." label="AI read-out" />

## Price & availability

<Grid cols=2>
  <PieChart data={products.by_availability} x="availability" y="products" donut title="Availability mix" format="number" />
  <BarChart data={products.price_distribution} x="price_floor" y="products" title="Price distribution ($100 buckets)" format="number" />
</Grid>

## Average price by category

<BarChart data={products.by_category} x="category" y="avg_price" horizontal sort_by="y" title="Average price by category" format="currency" />

## Explore the raw records

:::note Live filters
**Category** and **Availability** re-query DuckDB on the live server; static deploy bakes them to "all". Use the table search to filter client-side.
:::

<Dropdown name="category" data={products.by_category} column="category" label="Category" bar />
<Dropdown name="availability" data={products.by_availability} column="availability" label="Availability" bar />

:::query name=products_filtered connector=main
SELECT
  "Index"        AS id,
  "Name"         AS name,
  "Brand"        AS brand,
  "Category"     AS category,
  "Price"        AS price,
  "Stock"        AS stock,
  "Availability" AS availability,
  "Color"        AS color
FROM products
WHERE ('${category}' = '' OR "Category" = '${category}')
  AND ('${availability}' = '' OR "Availability" = '${availability}')
ORDER BY "Price" DESC
LIMIT 200
:::

<Table data={products_filtered} title="Top 200 matching products by price" format="price=currency, stock=number" />

## Drill down by category

<Table data={products.by_category} title="Products by category" row_link="/products/{category}" format="products=number, avg_price=currency, total_stock=number" page-size=15 />
