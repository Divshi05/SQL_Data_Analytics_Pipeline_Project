-- STEP-3 MEASURES EXPLORATION

-- Total Sales
SELECT SUM(sales_amount) as total_sales FROM gold.fact_sales;

--Items Sold
SELECT SUM(quantity) as total_quantity FROM gold.fact_sales;

-- Average selling price
SELECT AVG(price) as average_selling_price FROM gold.fact_sales;

--Total number of orders
SELECT COUNT(order_number) as total_orders FROM gold.fact_sales;
SELECT COUNT(DISTINCT order_number) as total_orders FROM gold.fact_sales;

-- Total Number of Products
SELECT COUNT(product_key) as total_products FROM gold.dim_products;
SELECT COUNT(DISTINCT product_key) as total_products FROM gold.dim_products;

-- Total Number of Customers
SELECT COUNT(customer_id) as total_customers FROM gold.dim_customers;
SELECT COUNT(DISTINCT customer_id) as total_customers FROM gold.dim_customers;

-- Total Number of Customers that placed an order
SELECT COUNT( DISTINCT c.customer_key) as total_customers
	FROM gold.dim_customers as c
	JOIN gold.fact_sales as s
ON c.customer_key = s.customer_key;

SELECT COUNT(DISTINCT customer_key) as total_customers FROM gold.fact_sales;

-- GENERATING A REPORT THAT SHOWS ALL KEY METRICS OF THE BUSINESS
SELECT 'Total Sales' as measure_name, SUM(sales_amount) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' , SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price)  FROM gold.fact_sales
UNION ALL
SELECT 'Total Number of Orders' , COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Number of Products' , COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Number of Customers' , COUNT(customer_key) FROM gold.dim_customers;

