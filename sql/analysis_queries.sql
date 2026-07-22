create database sales_dashboard;
use sales_dashboard;
SELECT * FROM sales LIMIT 10;

-- 1 Query
SELECT 
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY region, category
ORDER BY total_profit DESC;

-- 2 query
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS year_months,
    ROUND(SUM(sales), 2) AS monthly_sales,
    ROUND(SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')), 2) AS mom_change
FROM sales
GROUP BY year_months
ORDER BY year_months;

-- 3 query
SELECT 
    customer_name,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- 4 auery
SELECT 
    discount,
    ROUND(AVG(profit), 2) AS avg_profit,
    COUNT(*) AS num_orders
FROM sales
GROUP BY discount
ORDER BY discount;

-- 5 query
SELECT 
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

-- 6 query
SELECT 
    ship_mode,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 1) AS avg_ship_days,
    COUNT(*) AS num_orders
FROM sales
GROUP BY ship_mode
ORDER BY avg_ship_days;