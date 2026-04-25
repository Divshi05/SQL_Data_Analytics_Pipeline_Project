 -- Top 5 products that generate the highest revenue
SELECT 
	p.product_name,
	SUM(f.sales_amount) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Top 5 products that have the worst sales
SELECT 
	p.product_name,
	SUM(f.sales_amount) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
LIMIT 5;

 -- Top 5 products that generate the highest revenue using Window functions
SELECT 
	p.product_name,
	SUM(f.sales_amount) total_revenue,
	RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) as rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Top 10 customers who have generate the highest revenue
SELECT 
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY c.customer_key,
		c.first_name,
		c.last_name
ORDER BY total_revenue DESC
LIMIT 10;

-- The 3 customers with fewest orders placed
SELECT 
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) total_revenue 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY c.customer_key,
		c.first_name,
		c.last_name
ORDER BY total_revenue 
LIMIT 3;
