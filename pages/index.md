---
title: Overview
sidebar_label: Overview
sidebar_position: 1
icon: "🏠"
---

# Datablist Explorer

An interactive dashboard over the [Datablist sample CSV files](https://github.com/datablist/sample-csv-files) — **4,000,000 rows** across customers, organizations and products, queried live by an embedded **DuckDB**. The largest file alone is **2,000,000 customers / 333 MB of CSV**, yet every aggregation on this page returns in a fraction of a second. The [DuckDB Performance](/performance) page has the numbers.

<SiteSearch placeholder="Search customers, organizations, products…" />

<Grid cols=4>
  <Counter data={overview.totals} column="customers" label="Customers" format="number" />
  <Counter data={overview.totals} column="organizations" label="Organizations" format="number" />
  <Counter data={overview.totals} column="products" label="Products" format="number" />
  <Counter data={overview.totals} column="countries" label="Countries" format="number" />
</Grid>

## Customer growth

Monthly sign-ups across the full 2 M-row customer table — a `GROUP BY month` over 333 MB of CSV.

<LineChart data={customers.signups_by_month} x="month" y="signups" title="Customer sign-ups per month" date_format="MMM YYYY" format="number" />

<Ask data={customers.signups_by_month} ask="In 2-3 sentences, summarize the customer sign-up trend across these months: the overall trajectory, the busiest month, and any slowdown toward the end." label="AI read-out" />

## Dataset scale

Each dataset is one CSV, loaded into DuckDB as a table. Here is the row count behind every chart in this app.

<BarChart data={overview.rows_by_dataset} x="dataset" y="rows" title="Rows per dataset" format="number" />

## Product catalog at a glance

The 1 M-row product catalog, sized by how many SKUs sit in each of its 34 categories.

<TreemapChart data={products.by_category} x="category" y="products" title="Products by category" />

## Most represented industries

<BarChart data={organizations.top_industries} x="industry" y="organizations" horizontal title="Top 15 industries (of 1 M organizations)" format="number" />

---

Dive into a dataset: [Customers](/customers) · [Organizations](/organizations) · [Products](/products) — or see how fast this all loads on the [DuckDB Performance](/performance) page.
