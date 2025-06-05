/*
================================================================================
 CARPOOLING AUDIT TRIGGERS - COMPLETE SCRIPT
================================================================================
 
 File: Triggers.sql
 Purpose: Complete set of audit triggers for all carpooling database tables
 Project: IC4301 Database I - Project 01
 Version: 2.0
 Generated: 2025-06-05 12:12:33
 
 Description:
   This script contains audit triggers for all tables in the carpooling system.
   Each table with audit columns gets three triggers:
   - BEFORE INSERT: Sets creator and creation_date automatically
   - BEFORE UPDATE: Sets modifier and modification_date automatically  
   - AFTER UPDATE: Logs field-level changes to carpooling_adm.LOGS table
 
 Prerequisites:
   - carpooling_adm.LOGS table must exist
   - Tables must have audit columns (creator, creation_date, modifier, modification_date)
   - Users must have TRIGGER privilege on respective databases
   - For application use, set @app_user session variable before operations
 
 Usage Instructions:
   1. Execute this script in MySQL as a user with TRIGGER privileges
   2. Verify triggers were created: SHOW TRIGGERS;
   3. Test with INSERT/UPDATE operations
   4. Check audit logs: SELECT * FROM carpooling_adm.LOGS;
 
 Application Usage:
   -- Set application user context
   SET @app_user = 'your_application_user';
   
   -- Perform database operations
   INSERT INTO carpooling_adm.GENDER (name) VALUES ('Male');
   UPDATE carpooling_adm.GENDER SET name = 'Masculine' WHERE name = 'Male';
   
   -- Check logs
   SELECT * FROM carpooling_adm.LOGS WHERE table_name = 'GENDER';
 
================================================================================
*/

-- Enable binary logging for triggers (execute as root/admin if needed)
-- SET GLOBAL log_bin_trust_function_creators = 1;


-- =====================================================================
-- ADM DATABASE TRIGGERS (carpooling_adm)
-- =====================================================================
-- Administrative and master data tables

-- =====================================================================
-- PU DATABASE TRIGGERS (carpooling_pu)
-- =====================================================================
-- Public user and operational data tables

-- =====================================================================
-- VERIFICATION AND TESTING
-- =====================================================================

-- Show all created triggers
SHOW TRIGGERS FROM carpooling_adm;
SHOW TRIGGERS FROM carpooling_pu;

-- Test example (uncomment to test):
/*
-- Set application user
SET @app_user = 'test_user';

-- Test insert (creator and creation_date should be auto-set)
INSERT INTO carpooling_adm.GENDER (name) VALUES ('Test Gender');

-- Test update (modifier, modification_date auto-set, changes logged)
UPDATE carpooling_adm.GENDER 
SET name = 'Updated Test Gender' 
WHERE name = 'Test Gender';

-- Check audit logs
SELECT * FROM carpooling_adm.LOGS 
WHERE table_name = 'GENDER' 
ORDER BY creation_date DESC, id DESC;

-- Cleanup test data
DELETE FROM carpooling_adm.GENDER WHERE name LIKE '%Test%';
DELETE FROM carpooling_adm.LOGS WHERE table_name = 'GENDER' AND creator = 'test_user';
*/

-- =====================================================================
-- SUMMARY
-- =====================================================================
/*
 * Triggers created for 0 ADM tables and 0 PU tables
 * Total triggers: 0 
 * (0 ADM + 0 PU)
 * 
 * Each table has 3 triggers:
 * - tablename_bi (BEFORE INSERT)
 * - tablename_bu (BEFORE UPDATE) 
 * - tablename_au (AFTER UPDATE)
 */

