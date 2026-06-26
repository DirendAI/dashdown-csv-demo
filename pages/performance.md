---
title: DuckDB Performance
sidebar_label: DuckDB Performance
sidebar_position: 6
icon: "⚡"
---

# How fast is DuckDB on these files?

This dashboard reads the **raw Datablist CSVs directly** — no database to stand up, no ETL. Dashdown's `csv` connector loads each file into an embedded [DuckDB](https://duckdb.org) as a table, and every chart you see is a SQL query DuckDB runs over those tables.

<Grid cols=4>
  <Counter data={overview.scale} column="total_rows" label="Rows in DuckDB" format="number" />
  <Counter data={overview.totals} column="customers" label="Customers · 333 MB CSV" format="number" />
  <Counter data={overview.totals} column="organizations" label="Organizations · 135 MB CSV" format="number" />
  <Counter data={overview.totals} column="products" label="Products · 155 MB CSV" format="number" />
</Grid>

<BarChart data={overview.rows_by_dataset} x="dataset" y="rows" horizontal title="Rows per dataset" format="number" />

## Measured on the 2 M-row customer file

Running a few representative aggregations over the 333 MB / 2,000,000-row `customers.csv` with DuckDB (Apple Silicon, multi-threaded):

| Query | Rows scanned | Time |
| ----- | -----------: | ---: |
| `count(*)` | 2,000,000 | **~0.14 s** |
| Top countries (`GROUP BY country`) | 2,000,000 | **~0.12 s** |
| Sign-ups per month (`date_trunc` + `GROUP BY`) | 2,000,000 | **~0.13 s** |
| Top companies (`GROUP BY company`, 1.16 M distinct) | 2,000,000 | **~0.14 s** |

The one-time cost of loading all three CSVs (≈ 620 MB) into DuckDB tables is **~2 s**; after that, aggregations are sub-second.

:::tip Try it live
Run `dashdown serve .` and change a filter on any dataset page — DuckDB re-runs the SQL on the full dataset between keystrokes. On this **statically deployed** copy, every query was pre-computed once at build time and the result snapshots ship as JSON, so the page loads instantly with no server in the loop.
:::

## Why it's quick

- **Columnar + vectorized.** DuckDB reads only the columns a query touches and processes them in batches, so a `GROUP BY` over one column never pays for the other eleven.
- **Multi-threaded scans.** A single aggregation fans out across cores — the 333 MB scan is shared, not serial.
- **No copy, no server.** The CSV is the database. There's no load step into Postgres, no network round-trip — DuckDB runs in-process next to the dashboard.
