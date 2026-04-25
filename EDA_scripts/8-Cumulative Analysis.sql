-- STEP-8 CUMULATIVE ANALYSIS

-- Total Sales per Month
-- and the running total of sales over time

SELECT
	order_month,
	total_sales,
	SUM(total_sales) OVER (PARTITION BY EXTRACT(YEAR FROM order_month) ORDER BY order_month) AS running_total_sales,
	AVG(avg_price) OVER (PARTITION BY EXTRACT(YEAR FROM order_month) ORDER BY order_month) AS avg_price

FROM
(
SELECT
	DATE_TRUNC('Month', order_date) as order_month,
	SUM(sales_amount) as total_sales,
	AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('Month', order_date) 
)t  ;
