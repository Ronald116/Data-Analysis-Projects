-- ========================================================================
-- RETAIL SALES DASHBOARD
-- PURPOSE: Understand the shape and quality
--          of the raw dataset before analysis
-- DATASET: UCI ONLINE RETAIL
-- AUTHOR: RONALD N. BOTCHWAY
-- DATE: 10TH APRIL, 2026
-- =========================================================================

-- -------------------------------------------------------------------------
-- SECTION 1: TABLE CREATION
-- -------------------------------------------------------------------------	
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

-- ----------------------------------------------------------------------------
-- SECTION 2: BASIC SHAPE
-- How big is the data?
-- ----------------------------------------------------------------------------

-- Total number of rows
SELECT
	COUNT(*) AS total_rows
FROM retail_sales;

-- Total number of columns
SELECT
	column_name,
	data_type
FROM information_schema.COLUMNS
WHERE table_name = 'retail_sales';

-- Preview the first 10 rows
SELECT 
	*
FROM retail_sales
LIMIT 10;


