-- Customer sign-ups per month — the headline time series.
SELECT
  date_trunc('month', "Subscription Date") AS month,
  count(*)                                 AS signups
FROM customers
GROUP BY 1
ORDER BY 1
