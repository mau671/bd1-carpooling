/*
================================================================================
 CARPOOLING AUDIT TRIGGERS - COMPLETE SCRIPT
================================================================================
 
 File: Triggers.sql
 Purpose: Complete set of audit triggers for all carpooling database tables
 Project: IC4301 Database I - Project 01
 Version: 2.0
 Generated: 2025-06-11 15:45:54
 
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

-- Switch to ADM database context
USE carpooling_adm;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.GENDER
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS GENDER_bi;
DROP TRIGGER IF EXISTS GENDER_bu;
DROP TRIGGER IF EXISTS GENDER_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER GENDER_bi
BEFORE INSERT ON GENDER
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER GENDER_bu
BEFORE UPDATE ON GENDER
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER GENDER_au
AFTER UPDATE ON GENDER
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'GENDER', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'GENDER', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.TYPE_IDENTIFICATION
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS TYPE_IDENTIFICATION_bi;
DROP TRIGGER IF EXISTS TYPE_IDENTIFICATION_bu;
DROP TRIGGER IF EXISTS TYPE_IDENTIFICATION_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER TYPE_IDENTIFICATION_bi
BEFORE INSERT ON TYPE_IDENTIFICATION
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER TYPE_IDENTIFICATION_bu
BEFORE UPDATE ON TYPE_IDENTIFICATION
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER TYPE_IDENTIFICATION_au
AFTER UPDATE ON TYPE_IDENTIFICATION
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'TYPE_IDENTIFICATION', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'TYPE_IDENTIFICATION', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.TYPE_PHONE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS TYPE_PHONE_bi;
DROP TRIGGER IF EXISTS TYPE_PHONE_bu;
DROP TRIGGER IF EXISTS TYPE_PHONE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER TYPE_PHONE_bi
BEFORE INSERT ON TYPE_PHONE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER TYPE_PHONE_bu
BEFORE UPDATE ON TYPE_PHONE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER TYPE_PHONE_au
AFTER UPDATE ON TYPE_PHONE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'TYPE_PHONE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'TYPE_PHONE', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.COUNTRY
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS COUNTRY_bi;
DROP TRIGGER IF EXISTS COUNTRY_bu;
DROP TRIGGER IF EXISTS COUNTRY_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER COUNTRY_bi
BEFORE INSERT ON COUNTRY
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER COUNTRY_bu
BEFORE UPDATE ON COUNTRY
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER COUNTRY_au
AFTER UPDATE ON COUNTRY
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'COUNTRY', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'COUNTRY', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.PROVINCE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PROVINCE_bi;
DROP TRIGGER IF EXISTS PROVINCE_bu;
DROP TRIGGER IF EXISTS PROVINCE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PROVINCE_bi
BEFORE INSERT ON PROVINCE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PROVINCE_bu
BEFORE UPDATE ON PROVINCE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PROVINCE_au
AFTER UPDATE ON PROVINCE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PROVINCE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`country_id` <=> NEW.`country_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PROVINCE', 'country_id', 
         OLD.`country_id`, NEW.`country_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PROVINCE', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.CANTON
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS CANTON_bi;
DROP TRIGGER IF EXISTS CANTON_bu;
DROP TRIGGER IF EXISTS CANTON_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER CANTON_bi
BEFORE INSERT ON CANTON
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER CANTON_bu
BEFORE UPDATE ON CANTON
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER CANTON_au
AFTER UPDATE ON CANTON
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CANTON', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`province_id` <=> NEW.`province_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CANTON', 'province_id', 
         OLD.`province_id`, NEW.`province_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CANTON', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.DISTRICT
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS DISTRICT_bi;
DROP TRIGGER IF EXISTS DISTRICT_bu;
DROP TRIGGER IF EXISTS DISTRICT_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER DISTRICT_bi
BEFORE INSERT ON DISTRICT
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER DISTRICT_bu
BEFORE UPDATE ON DISTRICT
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER DISTRICT_au
AFTER UPDATE ON DISTRICT
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'DISTRICT', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`canton_id` <=> NEW.`canton_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'DISTRICT', 'canton_id', 
         OLD.`canton_id`, NEW.`canton_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'DISTRICT', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.STATUS
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS STATUS_bi;
DROP TRIGGER IF EXISTS STATUS_bu;
DROP TRIGGER IF EXISTS STATUS_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER STATUS_bi
BEFORE INSERT ON STATUS
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER STATUS_bu
BEFORE UPDATE ON STATUS
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER STATUS_au
AFTER UPDATE ON STATUS
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'STATUS', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'STATUS', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.MAXCAPACITY
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS MAXCAPACITY_bi;
DROP TRIGGER IF EXISTS MAXCAPACITY_bu;
DROP TRIGGER IF EXISTS MAXCAPACITY_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER MAXCAPACITY_bi
BEFORE INSERT ON MAXCAPACITY
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER MAXCAPACITY_bu
BEFORE UPDATE ON MAXCAPACITY
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER MAXCAPACITY_au
AFTER UPDATE ON MAXCAPACITY
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'MAXCAPACITY', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`capacity_number` <=> NEW.`capacity_number`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'MAXCAPACITY', 'capacity_number', 
         OLD.`capacity_number`, NEW.`capacity_number`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.LOGS
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS LOGS_bi;
DROP TRIGGER IF EXISTS LOGS_bu;
DROP TRIGGER IF EXISTS LOGS_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER LOGS_bi
BEFORE INSERT ON LOGS
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER LOGS_bu
BEFORE UPDATE ON LOGS
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER LOGS_au
AFTER UPDATE ON LOGS
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'LOGS', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`schema_name` <=> NEW.`schema_name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'LOGS', 'schema_name', 
         OLD.`schema_name`, NEW.`schema_name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`table_name` <=> NEW.`table_name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'LOGS', 'table_name', 
         OLD.`table_name`, NEW.`table_name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`field_name` <=> NEW.`field_name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'LOGS', 'field_name', 
         OLD.`field_name`, NEW.`field_name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`previous_value` <=> NEW.`previous_value`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'LOGS', 'previous_value', 
         OLD.`previous_value`, NEW.`previous_value`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`current_value` <=> NEW.`current_value`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'LOGS', 'current_value', 
         OLD.`current_value`, NEW.`current_value`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.PERSON
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PERSON_bi;
DROP TRIGGER IF EXISTS PERSON_bu;
DROP TRIGGER IF EXISTS PERSON_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PERSON_bi
BEFORE INSERT ON PERSON
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PERSON_bu
BEFORE UPDATE ON PERSON
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PERSON_au
AFTER UPDATE ON PERSON
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`first_name` <=> NEW.`first_name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'first_name', 
         OLD.`first_name`, NEW.`first_name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`second_name` <=> NEW.`second_name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'second_name', 
         OLD.`second_name`, NEW.`second_name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`first_surname` <=> NEW.`first_surname`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'first_surname', 
         OLD.`first_surname`, NEW.`first_surname`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`second_surname` <=> NEW.`second_surname`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'second_surname', 
         OLD.`second_surname`, NEW.`second_surname`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`identification_number` <=> NEW.`identification_number`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'identification_number', 
         OLD.`identification_number`, NEW.`identification_number`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`date_of_birth` <=> NEW.`date_of_birth`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'date_of_birth', 
         OLD.`date_of_birth`, NEW.`date_of_birth`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`gender_id` <=> NEW.`gender_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'gender_id', 
         OLD.`gender_id`, NEW.`gender_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`type_identification_id` <=> NEW.`type_identification_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PERSON', 'type_identification_id', 
         OLD.`type_identification_id`, NEW.`type_identification_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.ADMIN
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS ADMIN_bi;
DROP TRIGGER IF EXISTS ADMIN_bu;
DROP TRIGGER IF EXISTS ADMIN_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER ADMIN_bi
BEFORE INSERT ON ADMIN
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER ADMIN_bu
BEFORE UPDATE ON ADMIN
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER ADMIN_au
AFTER UPDATE ON ADMIN
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'ADMIN', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.PAYMENTMETHOD
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PAYMENTMETHOD_bi;
DROP TRIGGER IF EXISTS PAYMENTMETHOD_bu;
DROP TRIGGER IF EXISTS PAYMENTMETHOD_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PAYMENTMETHOD_bi
BEFORE INSERT ON PAYMENTMETHOD
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PAYMENTMETHOD_bu
BEFORE UPDATE ON PAYMENTMETHOD
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PAYMENTMETHOD_au
AFTER UPDATE ON PAYMENTMETHOD
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PAYMENTMETHOD', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'PAYMENTMETHOD', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.CURRENCY
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS CURRENCY_bi;
DROP TRIGGER IF EXISTS CURRENCY_bu;
DROP TRIGGER IF EXISTS CURRENCY_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER CURRENCY_bi
BEFORE INSERT ON CURRENCY
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER CURRENCY_bu
BEFORE UPDATE ON CURRENCY
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER CURRENCY_au
AFTER UPDATE ON CURRENCY
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CURRENCY', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CURRENCY', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.INSTITUTION
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS INSTITUTION_bi;
DROP TRIGGER IF EXISTS INSTITUTION_bu;
DROP TRIGGER IF EXISTS INSTITUTION_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_bi
BEFORE INSERT ON INSTITUTION
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_bu
BEFORE UPDATE ON INSTITUTION
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER INSTITUTION_au
AFTER UPDATE ON INSTITUTION
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.DOMAIN
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS DOMAIN_bi;
DROP TRIGGER IF EXISTS DOMAIN_bu;
DROP TRIGGER IF EXISTS DOMAIN_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER DOMAIN_bi
BEFORE INSERT ON DOMAIN
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER DOMAIN_bu
BEFORE UPDATE ON DOMAIN
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER DOMAIN_au
AFTER UPDATE ON DOMAIN
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'DOMAIN', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'DOMAIN', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.INSTITUTION_DOMAIN
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS INSTITUTION_DOMAIN_bi;
DROP TRIGGER IF EXISTS INSTITUTION_DOMAIN_bu;
DROP TRIGGER IF EXISTS INSTITUTION_DOMAIN_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_DOMAIN_bi
BEFORE INSERT ON INSTITUTION_DOMAIN
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_DOMAIN_bu
BEFORE UPDATE ON INSTITUTION_DOMAIN
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER INSTITUTION_DOMAIN_au
AFTER UPDATE ON INSTITUTION_DOMAIN
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`institution_id` <=> NEW.`institution_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_DOMAIN', 'institution_id', 
         OLD.`institution_id`, NEW.`institution_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`domain_id` <=> NEW.`domain_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_DOMAIN', 'domain_id', 
         OLD.`domain_id`, NEW.`domain_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.CHOSENCAPACITY
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS CHOSENCAPACITY_bi;
DROP TRIGGER IF EXISTS CHOSENCAPACITY_bu;
DROP TRIGGER IF EXISTS CHOSENCAPACITY_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER CHOSENCAPACITY_bi
BEFORE INSERT ON CHOSENCAPACITY
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER CHOSENCAPACITY_bu
BEFORE UPDATE ON CHOSENCAPACITY
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER CHOSENCAPACITY_au
AFTER UPDATE ON CHOSENCAPACITY
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CHOSENCAPACITY', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`vehicle_x_route_id` <=> NEW.`vehicle_x_route_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CHOSENCAPACITY', 'vehicle_x_route_id', 
         OLD.`vehicle_x_route_id`, NEW.`vehicle_x_route_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`chosen_number` <=> NEW.`chosen_number`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'CHOSENCAPACITY', 'chosen_number', 
         OLD.`chosen_number`, NEW.`chosen_number`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_adm.INSTITUTION_REPORT
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS INSTITUTION_REPORT_bi;
DROP TRIGGER IF EXISTS INSTITUTION_REPORT_bu;
DROP TRIGGER IF EXISTS INSTITUTION_REPORT_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_REPORT_bi
BEFORE INSERT ON INSTITUTION_REPORT
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_REPORT_bu
BEFORE UPDATE ON INSTITUTION_REPORT
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER INSTITUTION_REPORT_au
AFTER UPDATE ON INSTITUTION_REPORT
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_REPORT', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`institution_id` <=> NEW.`institution_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_REPORT', 'institution_id', 
         OLD.`institution_id`, NEW.`institution_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`report_date` <=> NEW.`report_date`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_REPORT', 'report_date', 
         OLD.`report_date`, NEW.`report_date`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`total_trips` <=> NEW.`total_trips`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_REPORT', 'total_trips', 
         OLD.`total_trips`, NEW.`total_trips`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`total_passengers` <=> NEW.`total_passengers`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_REPORT', 'total_passengers', 
         OLD.`total_passengers`, NEW.`total_passengers`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`total_revenue` <=> NEW.`total_revenue`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_adm', 'INSTITUTION_REPORT', 'total_revenue', 
         OLD.`total_revenue`, NEW.`total_revenue`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- =====================================================================
-- PU DATABASE TRIGGERS (carpooling_pu) 
-- =====================================================================
-- Public user and operational data tables

-- Switch to PU database context
USE carpooling_pu;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PHOTO
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PHOTO_bi;
DROP TRIGGER IF EXISTS PHOTO_bu;
DROP TRIGGER IF EXISTS PHOTO_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PHOTO_bi
BEFORE INSERT ON PHOTO
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PHOTO_bu
BEFORE UPDATE ON PHOTO
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PHOTO_au
AFTER UPDATE ON PHOTO
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHOTO', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`image` <=> NEW.`image`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHOTO', 'image', 
         OLD.`image`, NEW.`image`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHOTO', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PHONE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PHONE_bi;
DROP TRIGGER IF EXISTS PHONE_bu;
DROP TRIGGER IF EXISTS PHONE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PHONE_bi
BEFORE INSERT ON PHONE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PHONE_bu
BEFORE UPDATE ON PHONE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PHONE_au
AFTER UPDATE ON PHONE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHONE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`phone_number` <=> NEW.`phone_number`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHONE', 'phone_number', 
         OLD.`phone_number`, NEW.`phone_number`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`type_phone_id` <=> NEW.`type_phone_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHONE', 'type_phone_id', 
         OLD.`type_phone_id`, NEW.`type_phone_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.EMAIL
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS EMAIL_bi;
DROP TRIGGER IF EXISTS EMAIL_bu;
DROP TRIGGER IF EXISTS EMAIL_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER EMAIL_bi
BEFORE INSERT ON EMAIL
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER EMAIL_bu
BEFORE UPDATE ON EMAIL
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER EMAIL_au
AFTER UPDATE ON EMAIL
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'EMAIL', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`name` <=> NEW.`name`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'EMAIL', 'name', 
         OLD.`name`, NEW.`name`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'EMAIL', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`domain_id` <=> NEW.`domain_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'EMAIL', 'domain_id', 
         OLD.`domain_id`, NEW.`domain_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.VEHICLE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS VEHICLE_bi;
DROP TRIGGER IF EXISTS VEHICLE_bu;
DROP TRIGGER IF EXISTS VEHICLE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER VEHICLE_bi
BEFORE INSERT ON VEHICLE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER VEHICLE_bu
BEFORE UPDATE ON VEHICLE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER VEHICLE_au
AFTER UPDATE ON VEHICLE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'VEHICLE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`plate` <=> NEW.`plate`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'VEHICLE', 'plate', 
         OLD.`plate`, NEW.`plate`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PHONE_PERSON
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PHONE_PERSON_bi;
DROP TRIGGER IF EXISTS PHONE_PERSON_bu;
DROP TRIGGER IF EXISTS PHONE_PERSON_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PHONE_PERSON_bi
BEFORE INSERT ON PHONE_PERSON
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PHONE_PERSON_bu
BEFORE UPDATE ON PHONE_PERSON
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PHONE_PERSON_au
AFTER UPDATE ON PHONE_PERSON
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHONE_PERSON', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`phone_id` <=> NEW.`phone_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PHONE_PERSON', 'phone_id', 
         OLD.`phone_id`, NEW.`phone_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.INSTITUTION_PERSON
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS INSTITUTION_PERSON_bi;
DROP TRIGGER IF EXISTS INSTITUTION_PERSON_bu;
DROP TRIGGER IF EXISTS INSTITUTION_PERSON_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_PERSON_bi
BEFORE INSERT ON INSTITUTION_PERSON
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER INSTITUTION_PERSON_bu
BEFORE UPDATE ON INSTITUTION_PERSON
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER INSTITUTION_PERSON_au
AFTER UPDATE ON INSTITUTION_PERSON
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`institution_id` <=> NEW.`institution_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'INSTITUTION_PERSON', 'institution_id', 
         OLD.`institution_id`, NEW.`institution_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'INSTITUTION_PERSON', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PERSONUSER
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PERSONUSER_bi;
DROP TRIGGER IF EXISTS PERSONUSER_bu;
DROP TRIGGER IF EXISTS PERSONUSER_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PERSONUSER_bi
BEFORE INSERT ON PERSONUSER
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PERSONUSER_bu
BEFORE UPDATE ON PERSONUSER
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PERSONUSER_au
AFTER UPDATE ON PERSONUSER
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PERSONUSER', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`username` <=> NEW.`username`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PERSONUSER', 'username', 
         OLD.`username`, NEW.`username`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`password` <=> NEW.`password`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PERSONUSER', 'password', 
         OLD.`password`, NEW.`password`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PERSONUSER', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.ROUTE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS ROUTE_bi;
DROP TRIGGER IF EXISTS ROUTE_bu;
DROP TRIGGER IF EXISTS ROUTE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER ROUTE_bi
BEFORE INSERT ON ROUTE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER ROUTE_bu
BEFORE UPDATE ON ROUTE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER ROUTE_au
AFTER UPDATE ON ROUTE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'ROUTE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`start_time` <=> NEW.`start_time`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'ROUTE', 'start_time', 
         OLD.`start_time`, NEW.`start_time`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`end_time` <=> NEW.`end_time`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'ROUTE', 'end_time', 
         OLD.`end_time`, NEW.`end_time`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`programming_date` <=> NEW.`programming_date`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'ROUTE', 'programming_date', 
         OLD.`programming_date`, NEW.`programming_date`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.VEHICLEXROUTE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS VEHICLEXROUTE_bi;
DROP TRIGGER IF EXISTS VEHICLEXROUTE_bu;
DROP TRIGGER IF EXISTS VEHICLEXROUTE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER VEHICLEXROUTE_bi
BEFORE INSERT ON VEHICLEXROUTE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER VEHICLEXROUTE_bu
BEFORE UPDATE ON VEHICLEXROUTE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER VEHICLEXROUTE_au
AFTER UPDATE ON VEHICLEXROUTE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'VEHICLEXROUTE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`vehicle_id` <=> NEW.`vehicle_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'VEHICLEXROUTE', 'vehicle_id', 
         OLD.`vehicle_id`, NEW.`vehicle_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`route_id` <=> NEW.`route_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'VEHICLEXROUTE', 'route_id', 
         OLD.`route_id`, NEW.`route_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.WAYPOINT
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS WAYPOINT_bi;
DROP TRIGGER IF EXISTS WAYPOINT_bu;
DROP TRIGGER IF EXISTS WAYPOINT_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER WAYPOINT_bi
BEFORE INSERT ON WAYPOINT
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER WAYPOINT_bu
BEFORE UPDATE ON WAYPOINT
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER WAYPOINT_au
AFTER UPDATE ON WAYPOINT
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'WAYPOINT', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`district_id` <=> NEW.`district_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'WAYPOINT', 'district_id', 
         OLD.`district_id`, NEW.`district_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`route_id` <=> NEW.`route_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'WAYPOINT', 'route_id', 
         OLD.`route_id`, NEW.`route_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`latitude` <=> NEW.`latitude`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'WAYPOINT', 'latitude', 
         OLD.`latitude`, NEW.`latitude`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`longitude` <=> NEW.`longitude`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'WAYPOINT', 'longitude', 
         OLD.`longitude`, NEW.`longitude`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.TRIP
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS TRIP_bi;
DROP TRIGGER IF EXISTS TRIP_bu;
DROP TRIGGER IF EXISTS TRIP_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER TRIP_bi
BEFORE INSERT ON TRIP
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER TRIP_bu
BEFORE UPDATE ON TRIP
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER TRIP_au
AFTER UPDATE ON TRIP
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'TRIP', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`vehicle_id` <=> NEW.`vehicle_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'TRIP', 'vehicle_id', 
         OLD.`vehicle_id`, NEW.`vehicle_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`route_id` <=> NEW.`route_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'TRIP', 'route_id', 
         OLD.`route_id`, NEW.`route_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`id_currency` <=> NEW.`id_currency`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'TRIP', 'id_currency', 
         OLD.`id_currency`, NEW.`id_currency`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`price_per_passenger` <=> NEW.`price_per_passenger`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'TRIP', 'price_per_passenger', 
         OLD.`price_per_passenger`, NEW.`price_per_passenger`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.STATUSXTRIP
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS STATUSXTRIP_bi;
DROP TRIGGER IF EXISTS STATUSXTRIP_bu;
DROP TRIGGER IF EXISTS STATUSXTRIP_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER STATUSXTRIP_bi
BEFORE INSERT ON STATUSXTRIP
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER STATUSXTRIP_bu
BEFORE UPDATE ON STATUSXTRIP
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER STATUSXTRIP_au
AFTER UPDATE ON STATUSXTRIP
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`trip_id` <=> NEW.`trip_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'STATUSXTRIP', 'trip_id', 
         OLD.`trip_id`, NEW.`trip_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`status_id` <=> NEW.`status_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'STATUSXTRIP', 'status_id', 
         OLD.`status_id`, NEW.`status_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PASSENGER
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PASSENGER_bi;
DROP TRIGGER IF EXISTS PASSENGER_bu;
DROP TRIGGER IF EXISTS PASSENGER_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PASSENGER_bi
BEFORE INSERT ON PASSENGER
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PASSENGER_bu
BEFORE UPDATE ON PASSENGER
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PASSENGER_au
AFTER UPDATE ON PASSENGER
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGER', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.DRIVER
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS DRIVER_bi;
DROP TRIGGER IF EXISTS DRIVER_bu;
DROP TRIGGER IF EXISTS DRIVER_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER DRIVER_bi
BEFORE INSERT ON DRIVER
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER DRIVER_bu
BEFORE UPDATE ON DRIVER
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER DRIVER_au
AFTER UPDATE ON DRIVER
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`person_id` <=> NEW.`person_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'DRIVER', 'person_id', 
         OLD.`person_id`, NEW.`person_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PASSENGERXWAYPOINT
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PASSENGERXWAYPOINT_bi;
DROP TRIGGER IF EXISTS PASSENGERXWAYPOINT_bu;
DROP TRIGGER IF EXISTS PASSENGERXWAYPOINT_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PASSENGERXWAYPOINT_bi
BEFORE INSERT ON PASSENGERXWAYPOINT
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PASSENGERXWAYPOINT_bu
BEFORE UPDATE ON PASSENGERXWAYPOINT
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PASSENGERXWAYPOINT_au
AFTER UPDATE ON PASSENGERXWAYPOINT
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`passenger_id` <=> NEW.`passenger_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXWAYPOINT', 'passenger_id', 
         OLD.`passenger_id`, NEW.`passenger_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`waypoint_id` <=> NEW.`waypoint_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXWAYPOINT', 'waypoint_id', 
         OLD.`waypoint_id`, NEW.`waypoint_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.DRIVERXVEHICLE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS DRIVERXVEHICLE_bi;
DROP TRIGGER IF EXISTS DRIVERXVEHICLE_bu;
DROP TRIGGER IF EXISTS DRIVERXVEHICLE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER DRIVERXVEHICLE_bi
BEFORE INSERT ON DRIVERXVEHICLE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER DRIVERXVEHICLE_bu
BEFORE UPDATE ON DRIVERXVEHICLE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER DRIVERXVEHICLE_au
AFTER UPDATE ON DRIVERXVEHICLE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'DRIVERXVEHICLE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`vehicle_id` <=> NEW.`vehicle_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'DRIVERXVEHICLE', 'vehicle_id', 
         OLD.`vehicle_id`, NEW.`vehicle_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`driver_id` <=> NEW.`driver_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'DRIVERXVEHICLE', 'driver_id', 
         OLD.`driver_id`, NEW.`driver_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.MAXCAPACITYXVEHICLE
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS MAXCAPACITYXVEHICLE_bi;
DROP TRIGGER IF EXISTS MAXCAPACITYXVEHICLE_bu;
DROP TRIGGER IF EXISTS MAXCAPACITYXVEHICLE_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER MAXCAPACITYXVEHICLE_bi
BEFORE INSERT ON MAXCAPACITYXVEHICLE
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER MAXCAPACITYXVEHICLE_bu
BEFORE UPDATE ON MAXCAPACITYXVEHICLE
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER MAXCAPACITYXVEHICLE_au
AFTER UPDATE ON MAXCAPACITYXVEHICLE
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'MAXCAPACITYXVEHICLE', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`max_capacity_id` <=> NEW.`max_capacity_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'MAXCAPACITYXVEHICLE', 'max_capacity_id', 
         OLD.`max_capacity_id`, NEW.`max_capacity_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`vehicle_id` <=> NEW.`vehicle_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'MAXCAPACITYXVEHICLE', 'vehicle_id', 
         OLD.`vehicle_id`, NEW.`vehicle_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PASSENGERXTRIP
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PASSENGERXTRIP_bi;
DROP TRIGGER IF EXISTS PASSENGERXTRIP_bu;
DROP TRIGGER IF EXISTS PASSENGERXTRIP_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PASSENGERXTRIP_bi
BEFORE INSERT ON PASSENGERXTRIP
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PASSENGERXTRIP_bu
BEFORE UPDATE ON PASSENGERXTRIP
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PASSENGERXTRIP_au
AFTER UPDATE ON PASSENGERXTRIP
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXTRIP', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`passenger_id` <=> NEW.`passenger_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXTRIP', 'passenger_id', 
         OLD.`passenger_id`, NEW.`passenger_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`trip_id` <=> NEW.`trip_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXTRIP', 'trip_id', 
         OLD.`trip_id`, NEW.`trip_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

-- ========================================
-- AUDIT TRIGGERS FOR: carpooling_pu.PASSENGERXTRIPXPAYMENT
-- Generated: 2025-06-11 15:45:54
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS PASSENGERXTRIPXPAYMENT_bi;
DROP TRIGGER IF EXISTS PASSENGERXTRIPXPAYMENT_bu;
DROP TRIGGER IF EXISTS PASSENGERXTRIPXPAYMENT_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER PASSENGERXTRIPXPAYMENT_bi
BEFORE INSERT ON PASSENGERXTRIPXPAYMENT
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER PASSENGERXTRIPXPAYMENT_bu
BEFORE UPDATE ON PASSENGERXTRIPXPAYMENT
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;

-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER PASSENGERXTRIPXPAYMENT_au
AFTER UPDATE ON PASSENGERXTRIPXPAYMENT
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());

    IF NOT (OLD.`id` <=> NEW.`id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXTRIPXPAYMENT', 'id', 
         OLD.`id`, NEW.`id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`passenger_x_trip_id` <=> NEW.`passenger_x_trip_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXTRIPXPAYMENT', 'passenger_x_trip_id', 
         OLD.`passenger_x_trip_id`, NEW.`passenger_x_trip_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
    IF NOT (OLD.`payment_method_id` <=> NEW.`payment_method_id`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('carpooling_pu', 'PASSENGERXTRIPXPAYMENT', 'payment_method_id', 
         OLD.`payment_method_id`, NEW.`payment_method_id`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;
END$$
DELIMITER ;

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
 * Triggers created for 19 ADM tables:
 * GENDER, TYPE_IDENTIFICATION, TYPE_PHONE, COUNTRY, PROVINCE, CANTON, DISTRICT, STATUS, MAXCAPACITY, LOGS, PERSON, ADMIN, PAYMENTMETHOD, CURRENCY, INSTITUTION, DOMAIN, INSTITUTION_DOMAIN, CHOSENCAPACITY, INSTITUTION_REPORT
 * 
 * Triggers created for 19 PU tables:
 * PHOTO, PHONE, EMAIL, VEHICLE, PHONE_PERSON, INSTITUTION_PERSON, PERSONUSER, ROUTE, VEHICLEXROUTE, WAYPOINT, TRIP, STATUSXTRIP, PASSENGER, DRIVER, PASSENGERXWAYPOINT, DRIVERXVEHICLE, MAXCAPACITYXVEHICLE, PASSENGERXTRIP, PASSENGERXTRIPXPAYMENT
 * 
 * Total triggers: 114 
 * (57 ADM + 57 PU)
 * 
 * Each table has 3 triggers:
 * - tablename_bi (BEFORE INSERT)
 * - tablename_bu (BEFORE UPDATE) 
 * - tablename_au (AFTER UPDATE)
 */
