-- Top-line customer KPIs (2M rows scanned by DuckDB).
SELECT
  count(*)                  AS customers,
  count(DISTINCT "Country") AS countries,
  count(DISTINCT "City")    AS cities,
  count(DISTINCT "Company") AS companies,
  max("Subscription Date")  AS latest_signup
FROM customers
