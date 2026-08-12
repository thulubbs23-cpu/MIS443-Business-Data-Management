/*====================================================================
                    BUSINESS DATA MANAGEMENT PROJECT
              DataCo Supply Chain Performance Analysis
======================================================================

Group: DataMinds
Database: PostgreSQL
Dataset: DataCo Supply Chain Dataset

Project Overview
----------------
This project analyzes the DataCo Supply Chain dataset using PostgreSQL.
The original raw dataset was normalized into six relational tables to
reduce data redundancy and improve database integrity.

Normalized Tables:
1. Customers
2. Orders
3. OrderItems
4. Products
5. Categories
6. Departments

====================================================================*/

DROP TABLE IF EXISTS raw_supplychain;

CREATE TABLE raw_supplychain (
"Days for shipping (real)" INTEGER,
"Days for shipment (scheduled)" INTEGER,
"Benefit per order" NUMERIC(10,2),
"Sales per customer" NUMERIC(10,2),
"Delivery Status" VARCHAR(50),
"Category Id" INTEGER,
"Category Name" VARCHAR(100),
"Customer City" VARCHAR(100),
"Customer Country" VARCHAR(100),
"Customer Fname" VARCHAR(100),
"Customer Id" INTEGER,
"Customer Lname" VARCHAR(100),
"Customer Segment" VARCHAR(50),
"Customer State" VARCHAR(100),
"Department Id" INTEGER,
"Department Name" VARCHAR(100),
"Market" VARCHAR(100),
"Order City" VARCHAR(100),
"Order Country" VARCHAR(100),
"order date (DateOrders)" TIMESTAMP,
"Order Id" INTEGER,
"Order Item Cardprod Id" INTEGER,
"Order Item Discount" NUMERIC(10,2),
"Order Item Discount Rate" NUMERIC(10,4),
"Order Item Id" INTEGER,
"Order Item Product Price" NUMERIC(10,2),
"Order Item Profit Ratio" NUMERIC(10,4),
"Order Item Quantity" INTEGER,
"Sales" NUMERIC(10,2),
"Order Item Total" NUMERIC(10,2),
"Order Profit Per Order" NUMERIC(10,2),
"Order State" VARCHAR(100),
"Order Status" VARCHAR(50),
"Product Card Id" INTEGER,
"Product Category Id" INTEGER,
"Product Name" VARCHAR(255),
"Product Price" NUMERIC(10,2),
"shipping date (DateOrders)" TIMESTAMP,
"Shipping Mode" VARCHAR(50)
);

SELECT COUNT(*)
FROM information_schema.columns
WHERE table_name='raw_supplychain';

SELECT COUNT(*)
FROM raw_supplychain;

SELECT *
FROM raw_supplychain
LIMIT 10;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    segment VARCHAR(50)
);

INSERT INTO Customers
SELECT DISTINCT
    "Customer Id",
    "Customer Fname",
    "Customer Lname",
    "Customer City",
    "Customer State",
    "Customer Country",
    "Customer Segment"
FROM raw_supplychain;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO Departments
SELECT DISTINCT
    "Department Id",
    "Department Name"
FROM raw_supplychain;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    department_id INT REFERENCES Departments(department_id)
);

INSERT INTO Categories
SELECT DISTINCT
    "Category Id",
    "Category Name",
    "Department Id"
FROM raw_supplychain;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    category_id INT REFERENCES Categories(category_id),
    product_name VARCHAR(255),
    product_price NUMERIC(10,2)
);

INSERT INTO Products
SELECT DISTINCT
    "Product Card Id",
    "Product Category Id",
    "Product Name",
    "Product Price"
FROM raw_supplychain;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    order_date TIMESTAMP,
    shipping_date TIMESTAMP,
    order_city VARCHAR(100),
    order_state VARCHAR(100),
    order_country VARCHAR(100),
    shipping_mode VARCHAR(50),
    delivery_status VARCHAR(50),
    order_status VARCHAR(50)
);

INSERT INTO Orders
SELECT DISTINCT
    "Order Id",
    "Customer Id",
    "order date (DateOrders)",
    "shipping date (DateOrders)",
    "Order City",
    "Order State",
    "Order Country",
    "Shipping Mode",
    "Delivery Status",
    "Order Status"
FROM raw_supplychain;

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    product_id INT REFERENCES Products(product_id),
    quantity INT,
    discount NUMERIC(10,2),
    discount_rate NUMERIC(10,4),
    product_price NUMERIC(10,2),
    sales NUMERIC(10,2),
    item_total NUMERIC(10,2),
    profit NUMERIC(10,2),
    benefit_per_order NUMERIC(10,2),
    profit_ratio NUMERIC(10,4),
    shipping_real_days INT,
    shipping_scheduled_days INT
);

INSERT INTO OrderItems
SELECT DISTINCT
    "Order Item Id",
    "Order Id",
    "Product Card Id",
    "Order Item Quantity",
    "Order Item Discount",
    "Order Item Discount Rate",
    "Order Item Product Price",
    "Sales",
    "Order Item Total",
    "Order Profit Per Order",
    "Benefit per order",
    "Order Item Profit Ratio",
    "Days for shipping (real)",
    "Days for shipment (scheduled)"
FROM raw_supplychain;

SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Departments;
SELECT COUNT(*) FROM Categories;
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM OrderItems;