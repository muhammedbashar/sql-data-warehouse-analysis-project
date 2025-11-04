/*
===============================================================================
Script Name: Load Bronze Layer (Source → Bronze)
===============================================================================
Script Purpose:
    This MySQL script replicates the Bronze Layer data-loading process 
    Originally implemented in MS SQL Server using a stored procedure.
    It performs the following actions:
    - Truncates all bronze tables before loading data.
    - Loads fresh data from CSV files into each corresponding table 
      using MySQL's Table Data Import Wizard (due to secure-file-priv limitations).

Implementation Notes:
    Since MySQL does not support the BULK INSERT command or multiple schemas 
    in the same way as SQL Server, this process was adapted to use:
      - Table Data Import Wizard in MySQL Workbench for importing data.
      - Prefixed table names (crm_, erp_) to represent the bronze layer.

Parameters:
    None. 
    This script is manually executed step-by-step in MySQL Workbench 
    and does not accept parameters or return values.

Usage Example:
    -- Step 1: Run truncation commands to clear existing data.
    -- Step 2: Import CSV files via Table Data Import Wizard.
    -- Step 3: Verify the first few rows of each table using SELECT queries.

===============================================================================
*/



-- ===============================================
--     STEP 1: TRUNCATE ALL BRONZE TABLES
-- ===============================================

TRUNCATE TABLE crm_cust_info;
TRUNCATE TABLE crm_prd_info;
TRUNCATE TABLE crm_sales_details;
TRUNCATE TABLE erp_cust_az12;
TRUNCATE TABLE erp_loc_a101;
TRUNCATE TABLE erp_px_cat_g1v2;


-- ===============================================
--     STEP 2: LOAD DATA USING IMPORT WIZARD
-- ===============================================

-- Since MySQL has secure-file-priv restrictions, 
-- data was imported using the Table Data Import Wizard.
-- Each CSV file from the datasets folder was loaded 
-- into its respective table.

-- Example: 
-- File: cust_info.csv  →  Table: crm_cust_info
-- File: prd_info.csv   →  Table: crm_prd_info
-- File: sales_details.csv → Table: crm_sales_details
-- File: cust_az12.csv  →  Table: erp_cust_az12
-- File: loc_a101.csv   →  Table: erp_loc_a101
-- File: px_cat_g1v2.csv → Table: erp_px_cat_g1v2


-- ===============================================
--     STEP 3: VERIFY DATA LOAD
-- ===============================================

SELECT * FROM crm_cust_info LIMIT 10;
SELECT * FROM crm_prd_info LIMIT 10;
SELECT * FROM crm_sales_details LIMIT 10;
SELECT * FROM erp_cust_az12 LIMIT 10;
SELECT * FROM erp_loc_a101 LIMIT 10;
SELECT * FROM erp_px_cat_g1v2 LIMIT 10;
