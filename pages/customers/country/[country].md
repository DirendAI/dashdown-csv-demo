---
title: Country detail
static_paths:
  connector: main
  query: SELECT "Country" AS country FROM customers GROUP BY 1 ORDER BY count(*) DESC LIMIT 24
---

# Country detail

:::query name=country_summary connector=main
SELECT
  ANY_VALUE("Country")      AS country,
  count(*)                  AS customers,
  count(DISTINCT "City")    AS cities,
  count(DISTINCT "Company") AS companies,
  min("Subscription Date")  AS first_signup,
  max("Subscription Date")  AS latest_signup
FROM customers
WHERE "Country" = '${country}'
:::

A focused view of every customer in **<Value data={country_summary} column="country" />**.

<Grid cols=4>
  <Counter data={country_summary} column="customers" label="Customers" format="number" />
  <Counter data={country_summary} column="cities" label="Cities" format="number" />
  <Counter data={country_summary} column="companies" label="Companies" format="number" />
  <Counter data={country_summary} column="latest_signup" label="Latest sign-up" format="date" />
</Grid>

## Sign-ups over time

:::query name=country_signups connector=main
WITH monthly AS (
  SELECT date_trunc('month', "Subscription Date") AS month_date, count(*) AS signups
  FROM customers
  WHERE "Country" = '${country}'
  GROUP BY 1
)
SELECT strftime(month_date, '%b %Y') AS month, signups
FROM monthly
ORDER BY month_date
:::

<LineChart data={country_signups} x="month" y="signups" title="Sign-ups per month" format="number" />

## Top cities & companies

:::query name=country_cities connector=main
SELECT "City" AS city, count(*) AS customers
FROM customers
WHERE "Country" = '${country}'
GROUP BY 1
ORDER BY customers DESC
LIMIT 15
:::

:::query name=country_companies connector=main
SELECT "Company" AS company, count(*) AS customers
FROM customers
WHERE "Country" = '${country}'
GROUP BY 1
ORDER BY customers DESC
LIMIT 15
:::

<Grid cols=2>
  <BarChart data={country_cities} x="city" y="customers" horizontal title="Top cities" format="number" />
  <Table data={country_companies} title="Top companies" format="customers=number" search=false />
</Grid>

[← All countries](/customers)
