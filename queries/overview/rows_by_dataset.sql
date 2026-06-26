-- Row counts per dataset — feeds the "scale" bar and the performance page.
SELECT 'Customers'     AS dataset, count(*) AS rows FROM customers
UNION ALL
SELECT 'Organizations' AS dataset, count(*) AS rows FROM organizations
UNION ALL
SELECT 'Products'      AS dataset, count(*) AS rows FROM products
ORDER BY rows DESC
