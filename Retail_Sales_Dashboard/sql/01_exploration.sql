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

-- -----------------------------------------------
-- SECTION 6: NEGATIVE & ZERO VALUES
-- Spot returns, refunds, and junk data
-- -----------------------------------------------

-- How many rows have negative quantity?
SELECT COUNT(*) AS negative_quantity_rows
FROM retail_sales
WHERE quantity < 0;

-- How many rows have zero or negative unit price?
SELECT COUNT(*) AS zero_or_negative_price_rows
FROM retail_sales
WHERE unitprice <= 0;

-- Quick look at what negative quantity rows look like
SELECT *
FROM retail_sales
WHERE quantity < 0
LIMIT 10;


-- -----------------------------------------------
-- SECTION 7: CANCELLATIONS
-- Invoices starting with 'C' are cancellations
-- -----------------------------------------------

-- How many cancelled invoices are there?
SELECT COUNT(*) AS cancelled_invoices
FROM retail_sales
WHERE invoice_no LIKE 'C%';

-- What do cancellation rows look like?
SELECT *
FROM retail_sales
WHERE invoice_no LIKE 'C%'
LIMIT 10;

-- -----------------------------------------------
-- SECTION 8: COUNTRIES
-- How many unique countries, and where is most data from?
-- -----------------------------------------------

-- Number of unique countries
SELECT COUNT(DISTINCT country) AS unique_countries
FROM retail_sales;

-- Row count by country (top 10)
SELECT
    country,
    COUNT(*) AS row_count
FROM retail_sales
GROUP BY country
ORDER BY row_count DESC
LIMIT 10;

-- -----------------------------------------------
-- SECTION 9: CUSTOMERS
-- How many unique customers are in the dataset?
-- -----------------------------------------------

-- Unique customer count
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;

-- Customers with the most transactions
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM retail_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- -----------------------------------------------
-- SECTION 10: PRODUCTS
-- How many unique products exist?
-- -----------------------------------------------

-- Unique product count
SELECT COUNT(DISTINCT stock_code) AS unique_products
FROM retail_sales;

-- Top 10 most frequently ordered products
SELECT
    stock_code,
    description,
    COUNT(*) AS times_ordered
FROM retail_sales
GROUP BY stock_code, description
ORDER BY times_ordered DESC
LIMIT 10;

-- Check for non-product stock codes (junk rows)
-- These are service/admin entries, not real products
SELECT DISTINCT stock_code, description
FROM retail_sales
WHERE stock_code IN ('POST', 'DOT', 'M', 'BANK CHARGES', 'PADS', 'C2')
ORDER BY stock_code;