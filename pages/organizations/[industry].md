---
title: Industry detail
static_paths:
  connector: main
  query: SELECT "Industry" AS industry FROM organizations WHERE "Industry" NOT LIKE '%/%' GROUP BY 1 ORDER BY count(*) DESC LIMIT 24
---

# Industry detail

:::query name=industry_summary connector=main
SELECT
  ANY_VALUE("Industry")             AS industry,
  count(*)                          AS organizations,
  count(DISTINCT "Country")         AS countries,
  round(avg("Number of employees")) AS avg_employees,
  max("Number of employees")        AS max_employees,
  min("Founded")                    AS earliest_founded
FROM organizations
WHERE "Industry" = '${industry}'
:::

Every organization in the **<Value data={industry_summary} column="industry" />** industry.

<Grid cols=4>
  <Counter data={industry_summary} column="organizations" label="Organizations" format="number" />
  <Counter data={industry_summary} column="countries" label="Countries" format="number" />
  <Counter data={industry_summary} column="avg_employees" label="Avg. employees" format="number" />
  <Counter data={industry_summary} column="max_employees" label="Largest (employees)" format="number" />
</Grid>

## Founded over time

:::query name=industry_founded connector=main
SELECT "Founded" AS year, count(*) AS organizations
FROM organizations
WHERE "Industry" = '${industry}'
GROUP BY 1
ORDER BY 1
:::

<BarChart data={industry_founded} x="year" y="organizations" title="Organizations by founding year" format="number" />

## Top countries

:::query name=industry_countries connector=main
SELECT "Country" AS country, count(*) AS organizations
FROM organizations
WHERE "Industry" = '${industry}'
GROUP BY 1
ORDER BY organizations DESC
LIMIT 15
:::

<BarChart data={industry_countries} x="country" y="organizations" horizontal title="Top countries" format="number" />

[← All industries](/organizations)
