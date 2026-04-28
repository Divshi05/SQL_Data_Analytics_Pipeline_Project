-- Identify Out-of-Range Dates

SELECT DISTINCT
	bdate
FROM bronze.erp_cust_az12
WHERE bdate<'1925-01-01' OR bdate>NOW();

-- Data Standardization & Consistency
SELECT DISTINCT gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		 ELSE 'n/a'
	END as gen
FROM bronze.erp_cust_az12;

---QUALITY CHECK AFTER TRANSFORMATION---

SELECT DISTINCT
	bdate
FROM silver.erp_cust_az12
WHERE bdate<'1925-01-01' OR bdate>NOW();

-- Data Standardization & Consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12;

SELECT * FROM silver.erp_cust_az12;