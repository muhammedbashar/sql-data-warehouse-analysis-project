/*
===============================================================================
Quality Checks for Gold Layer
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and the accuracy of the Gold Layer in the data warehouse.

    These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Run this script after the Gold Layer has been successfully created.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking: gold.dim_customers
-- ====================================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No Results
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking: gold.dim_products
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No Results
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking: gold.fact_sales
-- ====================================================================
-- Check Referential Integrity between Fact and Dimension Tables
-- Expectation: No Orphan Records (No NULL Keys in Joined Dimensions)
SELECT 
    f.order_number,
    f.customer_key,
    f.product_key
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products AS p
    ON p.product_key = f.product_key
WHERE c.customer_key IS NULL 
   OR p.product_key IS NULL;

-- ====================================================================
-- End of Quality Checks for Gold Layer
-- ====================================================================
