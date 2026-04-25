-- STEP-10 PART TO WHOLE ANALYSIS

-- Categories that contribute the most to overall sales
WITH Category_sales AS(
SELECT 	
	category,
	SUM(sales_amount) as total_sales
FROM gold.fact_sales as f
LEFT JOIN gold.dim_products as p
ON f.product_key = p.product_key 
GROUP BY category)

SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER() overall_sales,
	CONCAT(ROUND((total_sales/ SUM(total_sales) OVER()) *100,2),'%') AS percentage_of_total
	FROM category_sales



