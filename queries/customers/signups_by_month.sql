-- Customer sign-ups per month — the headline time series. The label is
-- pre-formatted ("Jan 2020") and ordered by the real date so the category axis
-- reads cleanly instead of showing raw timestamps.
WITH monthly AS (
  SELECT date_trunc('month', "Subscription Date") AS month_date, count(*) AS signups
  FROM customers
  GROUP BY 1
)
SELECT strftime(month_date, '%b %Y') AS month, signups
FROM monthly
ORDER BY month_date
