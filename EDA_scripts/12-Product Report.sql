-- PRODUCT REPORT

/* Purpose:
     	- This report consolidates key product metrics and behaviors.

	Highlights:
	    1. Gathers essential fields such as product name, category, subcategory, and cost.
	    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
	    3. Aggregates product-level metrics:
	       - total orders
	       - total sales
	       - total quantity sold
	       - total customers (unique)
	       - lifespan (in months)
	    4. Calculates valuable KPIs:
	       - recency (months since last sale)
	       - average order revenue (AOR)
	       - average monthly revenue
	*/

---------------------------------------

CREATE VIEW gold.report_products AS
WITH base_query AS(
/*  
	1) Base Query: Retrieving core columns from tables */

SELECT
	f.order_number ,
	f.product_key,
	f.customer_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
)

, product_aggregation AS(
/*
	2) Product Aggregations: Summarizes key metrics at the product level
*/
SELECT  
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	COUNT(DISTINCT order_number) as total_orders,
	SUM(sales_amount) as total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT customer_key) as total_customers,
	MAX(order_date) as last_sale_date,
	(EXTRACT(YEAR FROM MAX(order_date)) - EXTRACT(YEAR FROM MIN(order_date))) * 12 +
(EXTRACT(MONTH FROM MAX(order_date)) - EXTRACT(MONTH FROM MIN(order_date)))as lifespan,
	ROUND(AVG(sales_amount/ NULLIF(quantity, 0)), 2) AS average_selling_price
FROM base_query
GROUP BY 
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

/*
	3) Final Query : Combines all product results into one output
*/
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	CASE WHEN total_sales>50000 THEN 'High Performer'
		WHEN total_sales BETWEEN 10000 AND 50000 THEN 'Mid-Range'
		ELSE 'Low Performer'
	END product_segment,
	last_sale_date,
	(EXTRACT(YEAR FROM age(NOW(), (last_sale_date))) * 12) + 
         EXTRACT(MONTH FROM age(NOW(),(last_sale_date))) as recency_in_months,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	lifespan,
	average_selling_price,
	-- Compute Average Order Revenue (AVO)
	CASE WHEN total_orders = 0 THEN 0
		 ELSE total_sales/ total_orders 
	END AS avg_order_revenue,

	-- Compute Average Monthly Revenue
	CASE WHEN lifespan = 0 THEN total_sales
		 ELSE ROUND(total_sales/ lifespan,0)
	END AS avg_monthly_revenue
FROM product_aggregation;


														
	