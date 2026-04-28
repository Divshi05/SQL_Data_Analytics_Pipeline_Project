INSERT INTO silver.erp_cust_az12(cid, bdate, gen)
SELECT
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4, LENGTH(cid))
		 ELSE cid
	END cid,

	CASE WHEN bdate> NOW() THEN NULL
		 ELSE bdate
	END as bdate,
	
	CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		 ELSE 'n/a'
	END as gen
FROM bronze.erp_cust_az12;

