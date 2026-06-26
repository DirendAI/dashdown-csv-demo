---
title: Customers
sidebar_label: Customers
sidebar_position: 2
icon: "👥"
---

# Customers

**2,000,000** customer records — sign-ups from January 2020 to May 2022 across **243** countries and ~120,000 cities. This is the largest file in the demo (333 MB of CSV).

<Grid cols=4>
  <Counter data={customers.kpis} column="customers" label="Customers" format="number" />
  <Counter data={customers.kpis} column="countries" label="Countries" format="number" />
  <Counter data={customers.kpis} column="cities" label="Cities" format="number" />
  <Counter data={customers.kpis} column="latest_signup" label="Latest sign-up" format="date" />
</Grid>

## Sign-ups over time

<LineChart data={customers.signups_by_month} x="month" y="signups" title="Customer sign-ups per month" format="number" />

Daily sign-ups as a GitHub-style calendar — each cell is one of ~880 days, shaded by volume.

<CalendarHeatmap data={customers.signups_by_day} date="day" value="signups" title="Daily sign-ups" />

## Where customers are

<BarChart data={customers.top_countries} x="country" y="customers" horizontal title="Top 15 countries" format="number" />

## Explore the raw records

:::note Live filters
The **Country** and **Company** controls below re-query DuckDB over all 2 M rows on the live server (`dashdown serve`). In this static deploy they're baked to "all"; use the table's own search box to filter the loaded rows client-side.
:::

<Dropdown name="country" data={customers.by_country} column="country" label="Country" bar />
<Search name="company_q" placeholder="Filter by company…" label="Company" bar />

:::query name=customers_filtered connector=main
SELECT
  "Index"             AS id,
  "First Name"        AS first_name,
  "Last Name"         AS last_name,
  "Company"           AS company,
  "City"              AS city,
  "Country"           AS country,
  "Subscription Date" AS subscribed,
  "Email"             AS email
FROM customers
WHERE ('${country}' = '' OR "Country" = '${country}')
  AND ('${company_q}' = '' OR "Company" ILIKE '%' || '${company_q}' || '%')
ORDER BY "Subscription Date" DESC
LIMIT 200
:::

<Table data={customers_filtered} title="Latest 200 matching customers" format="subscribed=date" />

## Drill down by country

Click any country to open its own page — sign-up trend, top cities and top companies for that market.

<Table data={customers.by_country} title="Customers by country" row_link="/customers/country/{country}" format="customers=number, cities=number, companies=number" page-size=15 />
