-- Leads per acquisition source, with won count — bar + drill-down table.
-- Each row links to /leads/source/<source>.
SELECT
  "Source"                                            AS source,
  count(*)                                            AS leads,
  count(*) FILTER (WHERE "Deal Stage" = 'Closed Won') AS closed_won
FROM leads
GROUP BY 1
ORDER BY leads DESC
