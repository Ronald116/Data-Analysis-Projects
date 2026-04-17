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

-- ---------------------------------------------------------------------------
-- SECTION 3: DATE RANGE
-- What time period does the data cover?
-- ---------------------------------------------------------------------------

SELECT
	MIN(DATE(invoice_date)) AS earliest_date,
	MAX(DATE(invoice_date)) AS latest_date
FROM retail_sales;

-- ---------------------------------------------------------------------------
-- SECTION 4: MISSING VALUES
-- Check each columns for NULLS
-- ---------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE invoice_no IS NULL)    AS null_invoiceno,
    COUNT(*) FILTER (WHERE stock_code IS NULL)    AS null_stockcode,
    COUNT(*) FILTER (WHERE description IS NULL)  AS null_description,
    COUNT(*) FILTER (WHERE quantity IS NULL)     AS null_quantity,
    COUNT(*) FILTER (WHERE invoice_date IS NULL)  AS null_invoicedate,
    COUNT(*) FILTER (WHERE unitprice IS NULL)    AS null_unitprice,
    COUNT(*) FILTER (WHERE customer_id IS NULL)   AS null_customerid,
    COUNT(*) FILTER (WHERE country IS NULL)      AS null_country
FROM retail_sales;

-- -----------------------------------------------
-- SECTION 5: DUPLICATES
-- Are there exact duplicate rows?
-- -----------------------------------------------

SELECT
    invoice_no, stock_code, invoice_date, quantity, unitprice, customer_id,
    COUNT(*) AS occurrences
FROM retail_sales
GROUP BY invoice_no, stock_code, invoice_date, quantity, unitprice, customer_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC
LIMIT 20;