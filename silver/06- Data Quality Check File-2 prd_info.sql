--Data Quality Check

-- Checking for Nulls and Duplicates in the Primary Key
-- Expectation : No Result

SELECT
prd_id,
COUNT(*) as count
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 OR prd_id IS NULL;

-- Checking for unwanted spaces

SELECT prd_nm
FROM 
bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Checking for NULLs or Negative Numbers
-- Expectation: No results

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL or prd_cost <0;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM
bronze.crm_prd_info

-- Checking for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt< prd_start_dt;

-- FINAL CHECK
SELECT * FROM silver.crm_prd_info