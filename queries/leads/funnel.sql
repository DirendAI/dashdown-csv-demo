-- Sales pipeline as a funnel: how many leads have reached at least each stage.
-- The six "forward" stages are ranked in pipeline order; the value at each stage
-- is the cumulative count of that stage and everything beyond it, so the series
-- descends like a real funnel (the off-pipeline outcomes are excluded).
WITH base AS (
  SELECT "Deal Stage" AS stage, count(*) AS n
  FROM leads
  WHERE "Deal Stage" IN ('New Lead', 'Contacted', 'Qualified', 'Proposal Sent', 'Negotiation', 'Closed Won')
  GROUP BY 1
), ranked AS (
  SELECT stage, n, CASE stage
      WHEN 'New Lead'      THEN 1
      WHEN 'Contacted'     THEN 2
      WHEN 'Qualified'     THEN 3
      WHEN 'Proposal Sent' THEN 4
      WHEN 'Negotiation'   THEN 5
      WHEN 'Closed Won'    THEN 6
    END AS step
  FROM base
)
SELECT stage, SUM(n) OVER (ORDER BY step DESC) AS leads
FROM ranked
ORDER BY step
