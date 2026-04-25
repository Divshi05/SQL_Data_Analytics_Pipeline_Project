--Data Quality Check

-- Checking for Nulls and Duplicates in the Primary Key

SELECT
cst_id,
COUNT(*) as count
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id IS NULL;

-- Checking for unwanted spaces

SELECT cst_firstname
FROM 
bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

  

SELECT cst_lastname
FROM 
bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM
bronze.crm_cust_info

--=======================================================================
-- Checking for Nulls and Duplicates in the Primary Key AFTER TRANFORMATION
--=======================================================================

SELECT
cst_id,
COUNT(*) as count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id IS NULL;


-- Checking for unwanted spaces

SELECT cst_lastname
FROM 
silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM
silver.crm_cust_info

-- FINAL LOOK
SELECT *
FROM
silver.crm_cust_info