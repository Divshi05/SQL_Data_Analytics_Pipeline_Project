-- STEP-11 DATA SEGMENTATION Part:2

/* Grouping customers into 3 segments based on their spending behaviour:
	1. VIP: Customers with at least 12 months of history and spending more than 5000$
	2. Regular: Customers with at least 12 months of history but spending 5000$ or less
	3. New: Customers with a lifespan less than 12 months

And find the total number of customers by each group 
*/


WITH customer_spending AS(
SELECT
c.customer_key, 
SUM(f.sales_amount) as total_spending,
MIN(order_date) as first_order,
MAX(order_date) as last_order,
(EXTRACT(YEAR FROM MAX(order_date)) - EXTRACT(YEAR FROM MIN(order_date))) * 12 +
(EXTRACT(MONTH FROM MAX(order_date)) - EXTRACT(MONTH FROM MIN(order_date)))as lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)

SELECT customer_segments,
		COUNT(customer_key) as total_customers
	FROM(
SELECT 
customer_key,
CASE WHEN lifespan>= 12 AND total_spending > 5000 THEN 'VIP'
	 WHEN lifespan>= 12 AND total_spending <= 5000 THEN 'Regular'
	 ELSE 'New'
END customer_segments
FROM customer_spending
)
GROUP BY customer_segments
ORDER BY total_customers DESC;