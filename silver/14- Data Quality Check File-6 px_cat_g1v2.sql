--Check for unwanted spaces
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat!= TRIM(cat) OR subcat!= TRIM(subcat);

-- Data Standardization & Consistency

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;

---SILVER TABLE---
SELECT * FROM silver.erp_px_cat_g1v2;