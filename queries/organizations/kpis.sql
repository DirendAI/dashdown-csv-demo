-- Top-line organization KPIs (1M rows).
SELECT
  count(*)                          AS organizations,
  count(DISTINCT "Industry")        AS industries,
  count(DISTINCT "Country")         AS countries,
  round(avg("Number of employees")) AS avg_employees
FROM organizations
