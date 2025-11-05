/*
===============================================================================
Quality Checks for Silver Layer
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardisation across the 'silver' layer. It includes checks for:
      - Null or duplicate primary keys.
      - Unwanted spaces in string fields.
      - Data standardisation and consistency.
      - Invalid date ranges and orders.
      - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- ===================================================================
-- CHECKING TABLE: silver.crm_cust_info
-- ===================================================================

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
    cst_id, COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT 
    cst_firstname, cst_lastname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname);

-- Data Standardisation & Consistency
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info;

-- Final Data Review
SELECT * FROM silver.crm_cust_info;



-- ===================================================================
-- CHECKING TABLE: silver.crm_prd_info
-- ===================================================================

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
    prd_id, COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT 
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative Numbers
-- Expectation: No Result
SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardisation & Consistency
SELECT DISTINCT prd_line FROM silver.crm_prd_info;

-- Check for Invalid Date Orders
-- Expectation: No Result
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Final Data Review
SELECT * FROM silver.crm_prd_info;



-- ===================================================================
-- CHECKING TABLE: silver.crm_sales_details
-- ===================================================================

-- Check for Null or Duplicate Order Numbers
-- Expectation: No Result
SELECT 
    sls_ord_num, COUNT(*)
FROM silver.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1 OR sls_ord_num IS NULL;

-- Check for Invalid Date Orders
-- Expectation: No Result
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check Data Consistency Between Sales, Quantity, and Price
-- Expectation: No Result
-- Rule:
--   Sales = Quantity * Price
--   Values must not be NULL, Zero, or Negative
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- Final Data Review
SELECT * FROM silver.crm_sales_details;



-- ===================================================================
-- CHECKING TABLE: silver.erp_cust_az12
-- ===================================================================

-- Check for Null or Duplicate Customer IDs
-- Expectation: No Result
SELECT 
    cid, COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;

-- Identify Out-of-Range Dates
-- Expectation: Birthdates between 1924-01-01 and Current Date
SELECT DISTINCT 
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > CURRENT_DATE();

-- Data Standardisation & Consistency
SELECT DISTINCT gen FROM silver.erp_cust_az12;

-- Final Data Review
SELECT * FROM silver.erp_cust_az12;



-- ===================================================================
-- CHECKING TABLE: silver.erp_loc_a101
-- ===================================================================

-- Check for Null or Duplicate IDs
-- Expectation: No Result
SELECT 
    cid, COUNT(*)
FROM silver.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;

-- Data Standardisation & Consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- Final Data Review
SELECT * FROM silver.erp_loc_a101;



-- ===================================================================
-- CHECKING TABLE: silver.erp_px_cat_g1v2
-- ===================================================================

-- Check for Null or Duplicate IDs
-- Expectation: No Result
SELECT 
    id, COUNT(*)
FROM silver.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1 OR id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat)
   OR maintenence != TRIM(maintenence);

-- Data Standardisation & Consistency
SELECT DISTINCT cat FROM silver.erp_px_cat_g1v2;
SELECT DISTINCT subcat FROM silver.erp_px_cat_g1v2;
SELECT DISTINCT maintenence FROM silver.erp_px_cat_g1v2;

-- Final Data Review
SELECT * FROM silver.erp_px_cat_g1v2;



/*
===============================================================================
End of Silver Layer Quality Checks
===============================================================================
*/
