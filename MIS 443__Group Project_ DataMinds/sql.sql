/*==========================================================
SECTION 1: BUSINESS OVERVIEW
==========================================================*/

/*----------------------------------------------------------
Query 1: Business KPI Overview
----------------------------------------------------------*/

SELECT ROUND(SUM(sales), 2) AS total_sales
FROM OrderItems;

SELECT ROUND(SUM(profit), 2) AS total_profit
FROM OrderItems;

SELECT
    ROUND(AVG(item_total),2) AS average_order_value
FROM OrderItems;

/*==========================================================
SECTION 2: PRODUCT PERFORMANCE
==========================================================*/

/*----------------------------------------------------------
Query 2.1: Top 10 Best-selling Products
----------------------------------------------------------*/

SELECT
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM OrderItems oi
JOIN Products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY quantity_sold DESC
LIMIT 10;

/*----------------------------------------------------------
Query 2.2: Bottom 10 Least-selling Products
----------------------------------------------------------*/

SELECT
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM OrderItems oi
JOIN Products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY quantity_sold ASC
LIMIT 10;

/*----------------------------------------------------------
Query 2.3: Revenue by Product Category
----------------------------------------------------------*/

SELECT
    ca.category_name,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM OrderItems oi
JOIN Products p
    ON oi.product_id = p.product_id
JOIN Categories ca
    ON p.category_id = ca.category_id
GROUP BY ca.category_name
ORDER BY total_sales DESC;

/*----------------------------------------------------------
Query 2.4: Revenue by Department
----------------------------------------------------------*/

SELECT
    d.department_name,
    ROUND(SUM(oi.sales),2) AS revenue
FROM Departments d
JOIN Categories c
ON d.department_id = c.department_id
JOIN Products p
ON c.category_id = p.category_id
JOIN OrderItems oi
ON p.product_id = oi.product_id
GROUP BY d.department_name
ORDER BY revenue DESC;

/*==========================================================
SECTION 3: CUSTOMER ANALYSIS
==========================================================*/

/*----------------------------------------------------------
Query 3.1: Sales by Customer Segment
----------------------------------------------------------*/

SELECT
    c.segment,
    ROUND(SUM(oi.sales),2) AS total_sales
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN OrderItems oi
ON o.order_id = oi.order_id
GROUP BY c.segment
ORDER BY total_sales DESC;

/*----------------------------------------------------------
Query 3.2: Top 10 States by Sales
----------------------------------------------------------*/

SELECT
    c.state,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY c.state
ORDER BY total_sales DESC
LIMIT 10;

/*==========================================================
SECTION 4: LOGISTICS ANALYSIS
==========================================================*/

/*----------------------------------------------------------
Query 4.1: Shipping Mode Distribution
----------------------------------------------------------*/

SELECT
    o.shipping_mode,
    COUNT(oi.order_item_id) AS total_items
FROM OrderItems oi
JOIN Orders o
    ON oi.order_id = o.order_id
GROUP BY o.shipping_mode
ORDER BY total_items DESC;

/*----------------------------------------------------------
Query 4.2: Delivery Status Distribution
----------------------------------------------------------*/

SELECT
    o.delivery_status,
    COUNT(oi.order_item_id) AS total_items
FROM OrderItems oi
JOIN Orders o
    ON oi.order_id = o.order_id
GROUP BY o.delivery_status
ORDER BY total_items DESC;

/*----------------------------------------------------------
Query 4.3: On-time vs Delayed Deliveries
----------------------------------------------------------*/

SELECT
    CASE
        WHEN oi.shipping_real_days <= oi.shipping_scheduled_days
            THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_performance,
    COUNT(*) AS total_orders
FROM OrderItems oi
GROUP BY delivery_performance
ORDER BY total_orders DESC;

/*==========================================================
SECTION 5: TIME ANALYSIS
==========================================================*/

/*----------------------------------------------------------
Query 5.1: Monthly Sales and Profit Comparision
----------------------------------------------------------*/

SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM Orders o
JOIN OrderItems oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month;

--Download dataset to convert into python
SELECT
    oi.order_item_id,
    o.order_id,
    o.order_date,
    o.shipping_date,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.segment,
    c.city,
    c.state,
    c.country,
    d.department_name,
    ca.category_name,
    p.product_name,
    p.product_price,
    oi.quantity,
    oi.sales,
    oi.item_total,
    oi.profit,
    oi.discount,
    oi.discount_rate,
    oi.shipping_real_days,
    oi.shipping_scheduled_days,
    o.shipping_mode,
    o.delivery_status,
    o.order_status
FROM OrderItems oi
JOIN Orders o
    ON oi.order_id = o.order_id
JOIN Customers c
    ON o.customer_id = c.customer_id
JOIN Products p
    ON oi.product_id = p.product_id
JOIN Categories ca
    ON p.category_id = ca.category_id
JOIN Departments d
    ON ca.department_id = d.department_id;


