-- Data Standardization & Consistency
SELECT DISTINCT cntry as old_cntry,
CASE WHEN TRIM(cntry) ='DE' THEN 'Germany'
		 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		 ELSE TRIM(cntry)
	END as cntry
FROM bronze.erp_loc_a101
ORDER BY cntry;

----QUALITY CHECK AFTER TRANSFORMATION-----
SELECT DISTINCT cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

SELECT *
FROM silver.erp_loc_a101;