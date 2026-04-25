-- =========================
-- Load Data
-- =========================

COPY gold.dim_customers
FROM 'D:/Data Analyst Job Ready/SQL_By_DataWithBara_EDA_Project_Basic/sql-data-analytics-project-main/datasets/csv-files/gold.dim_customers.csv'
DELIMITER ','
CSV HEADER;

COPY gold.dim_products
FROM 'D:/Data Analyst Job Ready/SQL_By_DataWithBara_EDA_Project_Basic/sql-data-analytics-project-main/datasets/csv-files/gold.dim_products.csv'
DELIMITER ','
CSV HEADER;

COPY gold.fact_sales
FROM 'D:/Data Analyst Job Ready/SQL_By_DataWithBara_EDA_Project_Basic/sql-data-analytics-project-main/datasets/csv-files/gold.fact_sales.csv'
DELIMITER ','
CSV HEADER;