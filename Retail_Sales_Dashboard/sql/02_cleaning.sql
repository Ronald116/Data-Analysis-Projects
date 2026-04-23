-- ============================================
-- RETAIL SALES DASHBOARD
-- File: 02_cleaning.sql
-- Purpose: Clean the raw dataset and produce
--          an analysis-ready table
-- Author: [Your Name]
-- Date: April 2026
-- ============================================


-- -----------------------------------------------
-- STEP 1: REMOVE DUPLICATES
-- Use ROW_NUMBER() to keep only the first
-- occurrence of each duplicate group
-- -----------------------------------------------

-- First, preview how many duplicates exist
SELECT
	COUNT(*),
	COUNT(DISTINCT (invoice_no, stock_code, description, quantity, invoice_date, unitprice, customer_id, country)) AS duplicates,
	COUNT(*) - COUNT(DISTINCT (invoice_no, stock_code, description, quantity, invoice_date, unitprice, customer_id, country)) AS no_duplicates
FROM retail_sales;

-- creating a deduplicated version of the original table
DROP TABLE IF EXISTS retail_sales_deduped;
CREATE TABLE retail_sales_deduped AS
WITH ranked AS (
	SELECT
		*,
		ROW_NUMBER() OVER(
			PARTITION BY invoice_no, stock_code, description, quantity, invoice_date, unitprice, customer_id, country
			ORDER BY invoice_no
		) AS row_num
	FROM retail_sales
)
SELECT
	*
FROM ranked
WHERE row_num = 1;

-- confirm row count after duplicate
SELECT
	COUNT(*) AS rows_after_dedep
FROM retail_sales_deduped;


- -----------------------------------------------
-- STEP 2: REMOVE CANCELLATIONS
-- Invoices starting with 'C' are cancellations
-- not sales — exclude from analysis
-- -----------------------------------------------

-- preview of cancellation rows
SELECT
	COUNT(*) AS cancellation_rows
FROM retail_sales_deduped
WHERE invoice_no LIKE 'C%';

-- create table without cancellations
CREATE TABLE retail_sales_no_cancellations AS
SELECT
	*
FROM retail_sales_deduped
WHERE invoice_no NOT LIKE 'C%';

-- confirm row count
SELECT COUNT(*) AS rows_after_removing_cancellations
FROM retail_sales_no_cancellations;


-- -----------------------------------------------
-- STEP 3: REMOVE NEGATIVE & ZERO QUANTITIES
-- These are returns or data errors
-- You already handled this in Excel but we
-- confirm and enforce it here in SQL too
-- -----------------------------------------------

SELECT COUNT(*) AS neg_quantity_rows
FROM retail_sales_no_cancellations
WHERE quantity <= 0;

CREATE TABLE retail_sales_pos_quantity AS
SELECT *
FROM retail_sales_no_cancellations
WHERE quantity > 0;

-- confirm new row count
SELECT COUNT(*) pos_quantity_rows
FROM retail_sales_pos_quantity;
