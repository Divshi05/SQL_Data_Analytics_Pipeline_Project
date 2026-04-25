INSERT INTO silver.crm_prd_info(
    prd_id,
	cat_id ,
    prd_key, 
    prd_nm ,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt 
)

SELECT 
	prd_id, 
	REPLACE(SUBSTRING(prd_key,1, 5),'-','_') as cat_id,
	SUBSTRING(prd_key, 7, LENGTH(prd_key)) as prd_key,
	prd_nm, 
	COALESCE(prd_cost,0) as prd_cost, 
	
	CASE UPPER(TRIM(prd_line))
		 WHEN 'M' THEN 'Mountain'
		 WHEN 'R' THEN 'Road'
		 WHEN 'S' THEN 'Other Sales'
		 WHEN 'T' THEN 'Touring'
		 ELSE 'n/a'
	END as 	prd_line, 
	
	prd_start_dt, 
	LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 as prd_end_dt
	FROM bronze.crm_prd_info;
