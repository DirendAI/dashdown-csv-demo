---
title: Source detail
static_paths:
  connector: main
  query: SELECT "Source" AS source FROM leads GROUP BY 1 ORDER BY count(*) DESC LIMIT 20
---

# Source detail

:::query name=source_summary connector=main
SELECT
  ANY_VALUE("Source")                                                       AS source,
  count(*)                                                                  AS leads,
  count(*) FILTER (WHERE "Deal Stage" = 'Closed Won')                       AS closed_won,
  round(100.0 * count(*) FILTER (WHERE "Deal Stage" = 'Closed Won') / count(*), 1) AS won_rate,
  count(DISTINCT "Company")                                                 AS companies
FROM leads
WHERE "Source" = '${source}'
:::

Leads acquired through **<Value data={source_summary} column="source" />**.

<Grid cols=4>
  <Counter data={source_summary} column="leads" label="Leads" format="number" />
  <Counter data={source_summary} column="closed_won" label="Closed won" format="number" />
  <Counter data={source_summary} column="won_rate" label="Win rate" format="percent" />
  <Counter data={source_summary} column="companies" label="Companies" format="number" />
</Grid>

## Stage breakdown

:::query name=source_stages connector=main
SELECT "Deal Stage" AS stage, count(*) AS leads
FROM leads
WHERE "Source" = '${source}'
GROUP BY 1
ORDER BY leads DESC
:::

<BarChart data={source_stages} x="stage" y="leads" horizontal title="Leads by deal stage" format="number" />

## Top companies

:::query name=source_companies connector=main
SELECT "Company" AS company, count(*) AS leads
FROM leads
WHERE "Source" = '${source}'
GROUP BY 1
ORDER BY leads DESC
LIMIT 15
:::

<Table data={source_companies} title="Top companies" format="leads=number" search=false />

[← All sources](/leads)
