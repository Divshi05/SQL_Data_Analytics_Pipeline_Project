-- Checking for Invalid Dates

SELECT 
	NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 OR LENGTH(CAST((sls_order_dt) AS VARCHAR)) !=8  
OR sls_order_dt> 20500101 OR sls_order_dt < 1900101;

-- Checking for Invalid Dates

SELECT 
	NULLIF(sls_ship_dt,0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt<= 0 OR LENGTH(CAST((sls_ship_dt) AS VARCHAR)) !=8  
OR sls_ship_dt> 20500101 OR sls_ship_dt < 1900101;

-- Checking for Invalid Date Orders

SELECT 
	*
FROM bronze.crm_sales_details
WHERE sls_ship_dt<= 0 OR LENGTH(CAST((sls_ship_dt) AS VARCHAR)) !=8  
OR sls_ship_dt> 20500101 OR sls_ship_dt < 1900101;

-- Check Data Consistency : Between Sales, Quantity and Price
-- Sales = Quantity * Price
-- Values must not be NULL, zero, or negative

SELECT DISTINCT
	sls_sales AS old_sls_sales,
	sls_quantity,
	sls_price AS old_sls_price,

	CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
		 THEN sls_quantity * ABS(sls_price)
		 ELSE sls_sales
	END AS sls_sales,

	CASE WHEN sls_price IS NULL OR sls_price <=0
		 THEN sls_sales/ NULLIF(sls_quantity,0)
		 ELSE sls_price
	END AS sls_price
	
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR  sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR  sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales,
	sls_quantity,
	sls_price;

