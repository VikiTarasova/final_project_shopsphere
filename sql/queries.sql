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
SELECT
    p.category,
    SUM(oi.line_total) AS category_revenue,
    AVG(p.margin_pct) / 100 AS avg_margin,
    AVG(o.is_returned) AS return_rate
FROM shopsphere_order_items oi

JOIN shopsphere_products p
    ON oi.product_id = p.product_id

JOIN shopsphere_orders o
    ON oi.order_id = o.order_id

GROUP BY
    p.category
ORDER BY
    category_revenue DESC;

-- 1.4. Kunden über Durchschnittsausgaben
SELECT
    c.customer_id,
    c.region,
    c.country,
    c.acquisition_chan,
    customer_sales.total_spent
FROM shopsphere_customers c
JOIN
(
    SELECT
        customer_id,
        SUM(net_amount) AS total_spent
    FROM shopsphere_orders
    GROUP BY customer_id
) AS customer_sales
ON c.customer_id = customer_sales.customer_id

WHERE customer_sales.total_spent >
(
    SELECT AVG(total_spent)
    FROM
    (
        SELECT
            customer_id,
            SUM(net_amount) AS total_spent
        FROM shopsphere_orders
        GROUP BY customer_id
    ) AS avg_sales
)
ORDER BY customer_sales.total_spent DESC;

-- 1.5. Marketingkanäle: Budget, Umsatz und ROI

SELECT
    channel,
    SUM(budget) AS total_budget,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    SUM(attributed_reven) AS total_revenue,
    ROUND(
        SUM(attributed_reven) * 1.0 / SUM(budget),
        2
    ) AS ROI,
    ROUND(
        SUM(clicks) * 1.00 / SUM(impressions),
        4
    ) AS ctr_percent,
    ROUND(
        SUM(conversions) * 1.0 / SUM(clicks),
        4
    ) AS conversion_rate_percent,
    ROUND(
        SUM(budget) * 1.0 / SUM(conversions),
        2
    ) AS cost_per_conversion
FROM shopsphere_marketing
GROUP BY channel
ORDER BY ROI DESC;
