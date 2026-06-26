-- Wide source × stage matrix (one column per deal stage) via DuckDB's PIVOT —
-- rendered as a heatmap-shaded <Table>.
PIVOT leads
  ON "Deal Stage"
  USING count(*)
  GROUP BY "Source"
ORDER BY "Source"
