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


-- 2.1 Pareto-Analyse: Top-Kunden

WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.region,
        SUM(o.net_amount) AS total_revenue
    FROM shopsphere_customers c
    JOIN shopsphere_orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.region
)
SELECT
    customer_id,
    region,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS customer_rank,
    ROUND(
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) * 1.0
        / SUM(total_revenue) OVER (), 4
    ) AS cumulative_revenue_percent,
    ROUND(
        RANK() OVER (ORDER BY total_revenue DESC) * 1.0
        / COUNT(*) OVER (), 4
    ) AS customer_percent,
    CASE
        WHEN RANK() OVER (ORDER BY total_revenue DESC) <= COUNT(*) OVER () * 0.05
        THEN 'Top 5%'
        ELSE 'Other'
    END AS customer_group
FROM customer_revenue
ORDER BY customer_rank;

-- 2.2 Einfluss von Kanal und Endgerät auf den durchschnittlichen Bestellwert

SELECT
    c.region,
    o.channel,
    o.device,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.net_amount) AS total_revenue,
    ROUND(AVG(o.net_amount), 2) AS avg_order_value,
    ROUND(AVG(o.discount_pct), 2) AS avg_discount_pct,
    ROUND(
        AVG(o.is_returned),
        2
    ) AS return_rate_percent
FROM shopsphere_orders o
JOIN shopsphere_customers c ON o.customer_id = c.customer_id
GROUP BY
    c.region,
    o.channel,
    o.device
ORDER BY
    c.region,
    o.channel,
    avg_order_value DESC;


-- 2.3 Einfluss von Rabatten auf den Kundenwert
WITH customer_stats AS (
    SELECT
        customer_id,
        AVG(discount_pct) AS avg_discount,
        COUNT(order_id) AS orders_count
    FROM shopsphere_orders
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN avg_discount > 20 THEN 'Discount-oriented'
        ELSE 'Regular'
    END AS customer_group,

    COUNT(customer_id) AS customers_count,
    ROUND(AVG(orders_count), 2) AS avg_orders_per_customer,
    MIN(orders_count) AS min_orders,
    MAX(orders_count) AS max_orders
FROM customer_stats
GROUP BY customer_group;

-- 2.4 A/B-Test: Ø Bestellwert – Neukunden vs. Bestandskunden

WITH first_order AS
(
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM shopsphere_orders
    GROUP BY customer_id
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.ab_variant,
    o.net_amount,
    c.signup_date,
    CASE
        WHEN o.order_date = f.first_order_date
             AND julianday(o.order_date) - julianday(c.signup_date) <= 60
        THEN 'New'
        ELSE 'Returning'
    END AS customer_type
FROM shopsphere_orders o
JOIN shopsphere_customers c ON o.customer_id = c.customer_id
JOIN first_order f ON o.customer_id = f.customer_id
WHERE
    o.ab_variant IN ('A','B')
    AND o.order_date >= '2024-06-01';
