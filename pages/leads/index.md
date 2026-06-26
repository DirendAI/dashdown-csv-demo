---
title: Leads
sidebar_label: Leads
sidebar_position: 5
icon: "🎯"
---

# Leads & pipeline

**100,000** sales leads across **20** acquisition sources and **10** deal stages — a CRM-style
view that shows off a funnel, a matrix heatmap, a heatmap-shaded crosstab, and an interactive
pivot table.

<Grid cols=4>
  <Counter data={leads.kpis} column="leads" label="Leads" format="number" />
  <Counter data={leads.kpis} column="sources" label="Sources" format="number" />
  <Counter data={leads.kpis} column="closed_won" label="Closed won" format="number" />
  <Counter data={leads.kpis} column="won_rate" label="Win rate" format="percent" />
</Grid>

## Pipeline funnel

How many leads have reached at least each stage of the forward pipeline.

<FunnelChart data={leads.funnel} x="stage" y="leads" title="Sales pipeline" format="number" />

<Ask data={leads.funnel} ask="In two sentences, describe the drop-off through this sales funnel from New Lead to Closed Won and the approximate conversion rate end to end." label="AI read-out" />

## Where leads come from

<BarChart data={leads.by_source} x="source" y="leads" horizontal sort_by="y" title="Leads by source" format="number" />

## Source × stage heatmap

Every source against every deal stage — darker cells hold more leads.

<HeatmapChart data={leads.source_stage} x="source" y="stage" value="leads" title="Leads by source × stage" height=420 />

## The same data as a heatmap table

A `<Table>` with `heatmap` shading, built from a DuckDB `PIVOT` (one column per stage).

<Table data={leads.crosstab} heatmap title="Source × stage matrix" search=false page-size=20 />

## Pivot it yourself

Drag **source** and **stage** between the row and column axes.

<PivotTable data={leads.source_stage} values="leads" agg="sum" title="Interactive pivot" />

## Explore the raw records

:::note Live filters
**Source** and **Stage** re-query DuckDB on the live server; in this static deploy they're baked
to "all" — use the table's search box to filter client-side.
:::

<Dropdown name="source" data={leads.by_source} column="source" label="Source" bar />
<Dropdown name="stage" data={leads.by_stage} column="stage" label="Deal stage" bar />

:::query name=leads_filtered connector=main
SELECT
  "Account Id"  AS account_id,
  "First Name"  AS first_name,
  "Last Name"   AS last_name,
  "Company"     AS company,
  "Source"      AS source,
  "Deal Stage"  AS stage,
  "Email 1"     AS email
FROM leads
WHERE ('${source}' = '' OR "Source" = '${source}')
  AND ('${stage}' = ''  OR "Deal Stage" = '${stage}')
ORDER BY "Company"
LIMIT 200
:::

<Table data={leads_filtered} title="200 matching leads" />

## Drill down by source

<Table data={leads.by_source} title="Leads by source" row_link="/leads/{source}" format="leads=number, closed_won=number" page-size=20 />
