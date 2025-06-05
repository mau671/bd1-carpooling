/*
================================================================================
 CARPOOLING AUDIT TRAIL SYSTEM
================================================================================
 
 File: PRUEBA_LOGS.sql
 Purpose: Comprehensive audit trail system for carpooling database tables
 Project: IC4301 Database I - Project 01
 Version: 2.0
 Created: 2025
 Last Modified: June 5, 2025
 
 Description:
   This script provides a complete audit trail solution for the carpooling
   system database. It includes:
   - A stored procedure to create audit triggers for any table
   - Automatic tracking of record creation and modification
   - Field-level change logging to centralized LOGS table
   - Proper privilege management for different database schemas
 
 Components:
   1. Database configuration and context setup
   2. create_full_audit stored procedure
   3. Privilege grants for application users
 
 Prerequisites:
   - carpooling_adm.LOGS table must exist
   - Target tables should have audit columns (creator, creation_date, 
     modifier, modification_date)
   - Application users (pu_user, adm_user) must exist
 
 Usage:
   CALL carpooling_adm.create_full_audit('schema_name', 'table_name');
 
================================================================================
*/

/* =====================================================================
   1. BASIC CONFIGURATION
   ===================================================================== */
USE carpooling_adm;

/* =====================================================================
   2. AUDIT TRAIL STORED PROCEDURE
   =====================================================================
   
   Procedure: create_full_audit
   
   Purpose:
     Creates a complete set of audit triggers for any specified table:
     • BI (Before Insert): Sets creator and creation_date
     • BU (Before Update): Sets modifier and modification_date
     • AU (After Update): Logs field-level changes to LOGS table
   
   Parameters:
     @p_schema VARCHAR(64) - Target schema name containing the table
     @p_table  VARCHAR(64) - Target table name to be audited
   
   Security:
     SQL SECURITY INVOKER - Uses privileges of the calling user
   
   Features:
     • Automatically detects auditable columns (excludes virtual/stored)
     • Supports application user override via @app_user session variable
     • Logs all field changes with before/after values
     • Maintains referential integrity with schema information
   
   ===================================================================== */
DELIMITER $$

-- Drop the procedure if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS carpooling_adm.create_full_audit$$

CREATE PROCEDURE carpooling_adm.create_full_audit(
        IN p_schema VARCHAR(64),      -- Schema name containing the target table
        IN p_table  VARCHAR(64)       -- Table name to be audited
)
SQL SECURITY INVOKER                  -- Apply privileges of the calling user
BEGIN
    /* =================================================================
       VARIABLE DECLARATIONS (Must be at the beginning in MySQL)
       ================================================================= */
    
    -- Variables for cursor-based column iteration
    DECLARE done INT DEFAULT 0;              -- Loop control flag
    DECLARE v_col VARCHAR(64);               -- Current column name
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    /* =================================================================
       STEP 1: Identify columns to audit
       ================================================================= */
    
    -- Clean up any existing temporary table from previous executions
    DROP TEMPORARY TABLE IF EXISTS tmp_cols;
    
    -- Create temporary table with auditable columns
    -- Excludes: virtual columns, stored columns, and existing audit fields
    CREATE TEMPORARY TABLE tmp_cols AS
        SELECT COLUMN_NAME
        FROM   information_schema.columns
        WHERE  TABLE_SCHEMA = p_schema
          AND  TABLE_NAME   = p_table
          AND  EXTRA NOT LIKE '%VIRTUAL%'    -- Exclude virtual columns
          AND  EXTRA NOT LIKE '%STORED%'     -- Exclude stored columns
          AND  COLUMN_NAME NOT IN ('creator','creation_date',
                                   'modifier','modification_date');

    /* =================================================================
       STEP 2: Create BEFORE INSERT trigger
       ================================================================= */
    
    -- Build trigger SQL for automatic audit field population on INSERT
    -- Sets creator to @app_user (if set) or current database user
    -- Sets creation_date to provided value or current date
    SET @sql_bi = CONCAT(
        'CREATE TRIGGER ', p_table, '_bi ',
        'BEFORE INSERT ON ', p_schema, '.', p_table, ' ',
        'FOR EACH ROW ',
        'SET NEW.creator       = COALESCE(@app_user, CURRENT_USER()), ',
        '    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE());'
    );

    /* =================================================================
       STEP 3: Create BEFORE UPDATE trigger
       ================================================================= */
    
    -- Build trigger SQL for automatic audit field population on UPDATE
    -- Sets modifier to @app_user (if set) or current database user
    -- Always updates modification_date to current date
    SET @sql_bu = CONCAT(
        'CREATE TRIGGER ', p_table, '_bu ',
        'BEFORE UPDATE ON ', p_schema, '.', p_table, ' ',
        'FOR EACH ROW ',
        'SET NEW.modifier           = COALESCE(@app_user, CURRENT_USER()), ',
        '    NEW.modification_date  = CURRENT_DATE();'
    );

    /* =================================================================
       STEP 4: Create AFTER UPDATE trigger for change logging
       ================================================================= */
    
    -- Initialize AFTER UPDATE trigger SQL
    -- This trigger logs detailed field-level changes to the LOGS table
    SET @sql_au = CONCAT(
        'CREATE TRIGGER ', p_table, '_au ',
        'AFTER UPDATE ON ', p_schema, '.', p_table, ' ',
        'FOR EACH ROW BEGIN ',
        'DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());'
    );

    -- Build the column comparison logic using a safer approach
    -- Get the column logic and handle NULL case
    SET @column_logic = (
        SELECT GROUP_CONCAT(
            CONCAT(
                'IF NOT (OLD.`', COLUMN_NAME, '` <=> NEW.`', COLUMN_NAME, '`) THEN ',
                'INSERT INTO carpooling_adm.LOGS ',
                '(schema_name, table_name, field_name, previous_value, current_value, ',
                ' creator, creation_date, modifier, modification_date) VALUES (',
                QUOTE(p_schema), ',',
                QUOTE(p_table), ',',
                QUOTE(COLUMN_NAME), ',',
                'OLD.`', COLUMN_NAME, '`, NEW.`', COLUMN_NAME, '`,',
                'v_user, CURRENT_DATE(), v_user, CURRENT_DATE()); ',
                'END IF;'
            )
            SEPARATOR ' '
        )
        FROM tmp_cols
    );
    
    -- Complete the trigger with column logic (handle NULL case)
    SET @sql_au = CONCAT(
        @sql_au, 
        IFNULL(@column_logic, ''), 
        'END'
    );

    /* =================================================================
       STEP 5: Generate complete SQL script as single output
       ================================================================= */
    
    -- Build the complete SQL script in a single variable
    SET @complete_script = CONCAT(
        '-- ========================================\n',
        '-- AUDIT TRIGGERS FOR: ', p_schema, '.', p_table, '\n',
        '-- Generated: ', NOW(), '\n',
        '-- ========================================\n\n',
        
        '-- Step 1: Remove existing triggers\n',
        'DROP TRIGGER IF EXISTS ', p_schema, '.', p_table, '_bi;\n',
        'DROP TRIGGER IF EXISTS ', p_schema, '.', p_table, '_bu;\n',
        'DROP TRIGGER IF EXISTS ', p_schema, '.', p_table, '_au;\n\n',
        
        '-- Step 2: Create BEFORE INSERT trigger\n',
        'DELIMITER $$\n',
        'CREATE TRIGGER ', p_table, '_bi\n',
        'BEFORE INSERT ON ', p_schema, '.', p_table, '\n',
        'FOR EACH ROW\n',
        'SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),\n',
        '    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$\n',
        'DELIMITER ;\n\n',
        
        '-- Step 3: Create BEFORE UPDATE trigger\n',
        'DELIMITER $$\n',
        'CREATE TRIGGER ', p_table, '_bu\n',
        'BEFORE UPDATE ON ', p_schema, '.', p_table, '\n',
        'FOR EACH ROW\n',
        'SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),\n',
        '    NEW.modification_date = CURRENT_DATE()$$\n',
        'DELIMITER ;\n\n'
    );
    
    -- Add AFTER UPDATE trigger only if we have auditable columns
    IF @column_logic IS NOT NULL AND LENGTH(@column_logic) > 0 THEN
        SET @complete_script = CONCAT(@complete_script,
            '-- Step 4: Create AFTER UPDATE trigger for audit logging\n',
            'DELIMITER $$\n',
            'CREATE TRIGGER ', p_table, '_au\n',
            'AFTER UPDATE ON ', p_schema, '.', p_table, '\n',
            'FOR EACH ROW\n',
            'BEGIN\n',
            '    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());\n'
        );
        
        -- Add individual column checks using the pre-built logic
        SET @formatted_logic = REPLACE(@column_logic, ' ', '\n    ');
        SET @formatted_logic = REPLACE(@formatted_logic, 'END IF;IF', 'END IF;\n    IF');
        
        SET @complete_script = CONCAT(@complete_script,
            '    ', @formatted_logic, '\n',
            'END$$\n',
            'DELIMITER ;\n\n'
        );
    END IF;
    
    -- Add instructions
    SET @complete_script = CONCAT(@complete_script,
        '-- INSTRUCTIONS:\n',
        '-- 1. Copy the entire script above\n',
        '-- 2. Execute it line by line in your MySQL client\n',
        '-- 3. Verify with: SHOW TRIGGERS;\n',
        '-- 4. Test with INSERT/UPDATE operations\n'
    );
    
    -- Output the complete script in a single result
    SELECT @complete_script AS 'COMPLETE_SQL_SCRIPT';

    -- Clean up temporary resources
    DROP TEMPORARY TABLE tmp_cols;
END$$
DELIMITER ;

/* =====================================================================
   3. SECURITY AND PRIVILEGE MANAGEMENT
   =====================================================================
   
   Purpose:
     Grants necessary privileges to application users for audit trail
     functionality. Uses the principle of least privilege - each user
     gets only the permissions needed for their schema operations.
   
   Security Model:
     • Each user creates triggers in their own schema
     • All users can insert audit logs to carpooling_adm.LOGS
     • All users can execute the audit procedure
   
   Users:
     • pu_user: Public schema application user
     • adm_user: Administrative schema application user
   
   Note: CREATE TRIGGER privilege must be granted at the database level
         using GRANT ALL or by granting TRIGGER privilege specifically.
   
   ===================================================================== */

-- Privileges for Public Schema Application User (pu_user)
-- Grant TRIGGER privilege on carpooling_pu database
GRANT TRIGGER ON carpooling_pu.* TO 'pu_user'@'%';

-- Allows inserting audit records into centralized LOGS table
GRANT INSERT ON carpooling_adm.LOGS TO 'pu_user'@'%';

-- Allows execution of the audit procedure
GRANT EXECUTE ON PROCEDURE carpooling_adm.create_full_audit TO 'pu_user'@'%';

-- Privileges for Administrative Schema Application User (adm_user)  
-- Grant TRIGGER privilege on carpooling_adm database
GRANT TRIGGER ON carpooling_adm.* TO 'adm_user'@'%';

-- Allows inserting audit records into centralized LOGS table
GRANT INSERT ON carpooling_adm.LOGS TO 'adm_user'@'%';

-- Allows execution of the audit procedure
GRANT EXECUTE ON PROCEDURE carpooling_adm.create_full_audit TO 'adm_user'@'%';

SET GLOBAL log_bin_trust_function_creators = 1; -- Enable trigger creation without SUPER privilege

/*
================================================================================
 USAGE EXAMPLES AND TESTING
================================================================================

 Step 1: Generate triggers for your table
   CALL carpooling_adm.create_full_audit('carpooling_adm', 'DISTRICT');

 Step 2: Copy and execute the SQL commands shown in the results
   -- The procedure will output the exact SQL commands you need to run
   -- Copy each command and execute them one by one

 Step 3: Verify triggers were created
   SHOW TRIGGERS FROM carpooling_adm WHERE `Table` = 'DISTRICT';

 Step 4: Test the audit system (assuming DISTRICT table exists)
   -- Insert a record
   INSERT INTO carpooling_adm.DISTRICT (district_name, province) 
   VALUES ('San José Centro', 'San José');
   
   -- Update the record with user context
   SET @app_user = 'test_user';
   UPDATE carpooling_adm.DISTRICT 
   SET district_name = 'Centro de San José', country = 'Costa Rica' 
   WHERE district_name = 'San José Centro';
   
   -- Check audit logs
   SELECT * FROM carpooling_adm.LOGS 
   WHERE table_name = 'DISTRICT' 
   ORDER BY creation_date DESC, log_id DESC;

 Other examples:
   CALL carpooling_adm.create_full_audit('carpooling_pu', 'PHOTO');
   CALL carpooling_adm.create_full_audit('carpooling_adm', 'USERS');

================================================================================
 TROUBLESHOOTING
================================================================================

 Common Issues:
 
 1. Permission Denied Errors / Binary Logging Issues:
    - Error: "You do not have the SUPER privilege and binary logging is enabled"
    - Solution: Execute as root/admin: SET GLOBAL log_bin_trust_function_creators = 1;
    - Alternative: Add to MySQL config file [mysqld] section: log_bin_trust_function_creators = 1
    - Note: The warning about deprecation can be ignored for now
 
 2. Syntax Errors:
    - Make sure to execute each command individually from the procedure output
    - Pay attention to DELIMITER commands - they must be executed separately
    - Don't copy empty lines or comment-only lines
 
 3. Trigger Already Exists:
    - The procedure automatically drops existing triggers
    - Check for manual triggers with same naming pattern
 
 4. Missing Audit Columns:
    - Target tables must have: creator, creation_date, modifier, modification_date
    - Add these columns before running the procedure
 
 5. LOGS Table Issues:
    - Ensure carpooling_adm.LOGS table exists with proper structure
    - Check INSERT permissions on LOGS table

 MySQL Configuration Commands (execute as root/admin):
   -- Enable trigger creation without SUPER privilege
   SET GLOBAL log_bin_trust_function_creators = 1;
   
   -- Check current setting
   SHOW VARIABLES LIKE 'log_bin_trust_function_creators';
   
   -- Make permanent (add to MySQL config file):
   -- [mysqld]
   -- log_bin_trust_function_creators = 1
 
================================================================================
*/