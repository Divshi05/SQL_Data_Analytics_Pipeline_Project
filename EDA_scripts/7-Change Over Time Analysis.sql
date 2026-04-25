-- STEP-7 CHANGE OVER TIME ANALYSIS

-- Analysing Sales Over Time
SELECT
	EXTRACT ('Year' FROM order_date) as order_year,
	EXTRACT ('Month' FROM order_date) as order_month,
	SUM(sales_amount) as total_sales,
	COUNT(DISTINCT customer_key) as total_customers,
	SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY EXTRACT ('Year' FROM order_date),
	EXTRACT ('Month' FROM order_date) 
ORDER BY EXTRACT ('Year' FROM order_date),
	EXTRACT ('Month' FROM order_date) ;

--------------------

SELECT
	DATE_TRUNC('Month', order_date) as order_month,
	SUM(sales_amount) as total_sales,
	COUNT(DISTINCT customer_key) as total_customers,
	SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('Month', order_date) 
ORDER BY DATE_TRUNC('Month', order_date)  ;

-------------------------------

SELECT
	TO_CHAR(order_date, 'yyyy-MON') as order_month,
	SUM(sales_amount) as total_sales,
	COUNT(DISTINCT customer_key) as total_customers,
	SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY TO_CHAR(order_date, 'yyyy-MON') 
ORDER BY TO_CHAR(order_date, 'yyyy-MON')  ;