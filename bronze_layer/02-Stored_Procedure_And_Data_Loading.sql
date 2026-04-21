-- Loading Data From CSV Files
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
BEGIN
	RAISE NOTICE '==========================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '==========================================';


	RAISE NOTICE '------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables';
    RAISE NOTICE '------------------------------------------';

	RAISE NOTICE '>> Truncating : bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;
	RAISE NOTICE '>> Loading : bronze.crm_cust_info';
	COPY bronze.crm_cust_info
	FROM 'D:\Data Analyst Job Ready\SQL_By_DataWithBara_Data_Warehouse\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
	WITH (
	    FORMAT CSV,
	    HEADER true,
	    DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.crm_prd_info;
	
	COPY bronze.crm_prd_info
	FROM 'D:\Data Analyst Job Ready\SQL_By_DataWithBara_Data_Warehouse\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
	WITH (
	    FORMAT CSV,
	    HEADER true,
	    DELIMITER ','
	);
	
	TRUNCATE TABLE bronze.crm_sales_details;
	
	COPY bronze.crm_sales_details
	FROM 'D:\Data Analyst Job Ready\SQL_By_DataWithBara_Data_Warehouse\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
	WITH (
	    FORMAT CSV,
	    HEADER true,
	    DELIMITER ','
	);
	
	-- --------------ERP------------------
	RAISE NOTICE '------------------------------------------';
    RAISE NOTICE 'Loading ERP Tables';
    RAISE NOTICE '------------------------------------------';
	TRUNCATE TABLE bronze.erp_cust_az12;
	
	COPY bronze.erp_cust_az12
	FROM 'D:\Data Analyst Job Ready\SQL_By_DataWithBara_Data_Warehouse\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
	WITH (
	    FORMAT CSV,
	    HEADER true,
	    DELIMITER ','
	);
	
	
	TRUNCATE TABLE bronze.erp_loc_a101;
	
	COPY bronze.erp_loc_a101
	FROM 'D:\Data Analyst Job Ready\SQL_By_DataWithBara_Data_Warehouse\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
	WITH (
	    FORMAT CSV,
	    HEADER true,
	    DELIMITER ','
	);
	
	
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	
	COPY bronze.erp_px_cat_g1v2
	FROM 'D:\Data Analyst Job Ready\SQL_By_DataWithBara_Data_Warehouse\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
	    FORMAT CSV,
	    HEADER true,
	    DELIMITER ','
	);
	
	
END;
$$;