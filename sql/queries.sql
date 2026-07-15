-- Block 1: SQL – Datenaufbereitung
-- 1.1. Umsatz, Bestellungen und Ø-Warenkorb nach Region und Jahr 

SELECT
    c.region,
    o.order_date,
    SUM(o.net_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    AVG(o.net_amount) AS avg_order_value
FROM shopsphere_orders o
LEFT JOIN shopsphere_customers c
    ON o.customer_id = c.customer_id
GROUP BY
    c.region,
    o.order_date
ORDER BY
    o.order_date,
    c.region;

-- 1.2. Top-10 Kunden nach Ausgaben

SELECT
    c.customer_id,
    c.region,
    c.acquisition_chan,
    SUM(o.net_amount) AS total_spent,
    COUNT(DISTINCT o.order_id) AS orders_count
FROM shopsphere_customers c
JOIN shopsphere_orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.region,
    c.acquisition_chan
ORDER BY
    total_spent DESC
LIMIT 10;

-- 1.3. Kategorien: Umsatz, Marge und Retouren
-- 1.4. Kunden über Durchschnittsausgaben
-- 1.5. Marketingkanäle: Budget, Umsatz und ROI
