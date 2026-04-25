-- STEP-3 DATE EXPLORATION

--Date of first and last order
-- Available sales in years
SELECT 
	MIN(order_date) as first_orderdate,
	MAX(order_date) as last_order_date,
	EXTRACT(YEAR FROM MAX(order_date)) - EXTRACT(YEAR FROM MIN(order_date)) + 1 as order_range_years,
    ((EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12) +
	EXTRACT(MONTH FROM AGE(MAX(order_date),MIN(order_date)))+1) as order_range_months
FROM gold.fact_sales;

--Youngest and Oldest Customer
SELECT
	MIN(birthdate),
	EXTRACT(YEAR FROM AGE(NOW(),MIN(birthdate))) as oldest_customer,
	MAX(birthdate),
	EXTRACT(YEAR FROM AGE(NOW(),MAX(birthdate))) as youngest_customer
FROM gold.dim_Customers;


