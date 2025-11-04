/*
===============================================================================
Script Name: Load Bronze Layer (Source → Bronze)
===============================================================================
Script Purpose:
    This script is designed to load data into the Bronze Layer of the 
    Data Warehouse. It ensures that all staging (bronze) tables are refreshed 
    with clean and updated data from external CSV sources.

    The process includes:
    - Truncating all Bronze Layer tables before each load.
    - Importing fresh data from CSV files into each corresponding table
      using MySQL’s Table Data Import Wizard (used due to secure-file-priv limitations).

Implementation Notes:
    - Data loading is performed using the Table Data Import Wizard in MySQL Workbench.
    - Table names are prefixed (e.g., crm_, erp_) to represent the Bronze Layer.
    - This approach maintains a clean and consistent structure for staging data.

Parameters:
    None.
    This script is executed manually in MySQL Workbench 
    and does not accept parameters or return values.

Usage Example:
    -- Step 1: Run truncation commands to clear existing data.
    -- Step 2: Import CSV files using the Table Data Import Wizard.
    -- Step 3: Verify data load using SELECT queries.

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
