-- Olist E-commerce Sales Analytics
-- SQL Analysis Queries
-- Database: olist_ecommerce
-- Tool: MySQL Workbench / MariaDB

-- 1. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM olist_orders_dataset;


-- 2. Total Sales
SELECT ROUND(SUM(price), 2) AS total_sales
FROM olist_order_items_dataset;


-- 3. Average Order Value
SELECT ROUND(
    SUM(price) / COUNT(DISTINCT order_id), 2
) AS average_order_value
FROM olist_order_items_dataset;


-- 4. Monthly Sales
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price), 2) AS monthly_sales
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY month;


-- 5. Top Product Categories
SELECT
    t.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_sales DESC
LIMIT 10;


-- 6. Top Customers by Order Frequency
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;
