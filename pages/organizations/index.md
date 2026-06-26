---
title: Organizations
sidebar_label: Organizations
sidebar_position: 3
icon: "🏢"
---

# Organizations

**1,000,000** organizations spanning **147** industries and **243** countries, founded between 1970 and 2022, with employee counts up to ~10,000.

<Grid cols=4>
  <Counter data={organizations.kpis} column="organizations" label="Organizations" format="number" />
  <Counter data={organizations.kpis} column="industries" label="Industries" format="number" />
  <Counter data={organizations.kpis} column="countries" label="Countries" format="number" />
  <Counter data={organizations.kpis} column="avg_employees" label="Avg. employees" format="number" />
</Grid>

## Founded over time

<BarChart data={organizations.founded_by_year} x="year" y="organizations" title="Organizations by founding year" format="number" />

## Most represented industries

<BarChart data={organizations.top_industries} x="industry" y="organizations" horizontal title="Top 15 industries" format="number" />

<Ask data={organizations.top_industries} ask="In two sentences, describe how evenly organizations are spread across these top industries and name the leaders." label="AI read-out" />

## Explore the raw records

:::note Live filter
The **Industry** control re-queries DuckDB on the live server; in this static deploy the table is baked to "all" — use its search box to filter client-side.
:::

<Dropdown name="industry" data={organizations.by_industry} column="industry" label="Industry" bar />

:::query name=org_filtered connector=main
SELECT
  "Index"               AS id,
  "Name"                AS name,
  "Industry"            AS industry,
  "Country"             AS country,
  "Founded"             AS founded,
  "Number of employees" AS employees,
  "Website"             AS website
FROM organizations
WHERE ('${industry}' = '' OR "Industry" = '${industry}')
ORDER BY "Number of employees" DESC
LIMIT 200
:::

<Table data={org_filtered} title="Largest 200 matching organizations" format="employees=number" />

## Drill down by industry

Click an industry for its founding trend, employee profile and top countries. (Industries whose name contains a `/` are omitted here — a slash can't be a single URL segment.)

<Table data={organizations.by_industry} title="Organizations by industry" row_link="/organizations/industry/{industry}" format="organizations=number, avg_employees=number" page-size=15 />
