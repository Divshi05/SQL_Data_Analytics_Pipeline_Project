--DATA TRANSFORMATIONS AND DATA CLEANSING
INSERT INTO silver.crm_cust_info(
				cst_id,
				cst_key,
				cst_firstname,
				cst_lastname,
				cst_material_status,
				cst_gndr,
				cst_create_date
)
SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) as cst_firstname,
	TRIM(cst_lastname) as cst_lastname,
	
	CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
		 WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
		 ELSE 'n/a'
	END as 	cst_marital_status,
	
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		 WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		 ELSE 'n/a'
	END as 	cst_gndr,
	cst_create_date
FROM
(
SELECT
*,
RANK() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info
)t WHERE flag_last = 1 and cst_id IS NOT NULL





