-- Top-line lead / pipeline KPIs.
SELECT
  count(*)                                                                  AS leads,
  count(DISTINCT "Source")                                                  AS sources,
  count(*) FILTER (WHERE "Deal Stage" = 'Closed Won')                       AS closed_won,
  round(100.0 * count(*) FILTER (WHERE "Deal Stage" = 'Closed Won') / count(*), 1) AS won_rate
FROM leads
