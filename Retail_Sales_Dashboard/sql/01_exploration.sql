-- TABLE CREATION	
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
	invoice_no	varchar,
	stock_code	varchar,
	description	varchar,
	quantity	integer,
	invoice_date	timestamp,
	unitprice	numeric,
	customer_id	integer,
	country		varchar
);

-- DATA IMPORT
COPY retail_sales
FROM 'E:\DATA_ANALYTICS\Data-Analysis-Projects\Data-Analysis-Projects\Retail_Sales_Dashboard\data\cleaned\Online_retail_cleaned.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM retail_sales;