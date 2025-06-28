/*
================================================================================
 TYPE PHONE MANAGEMENT PROCEDURES - MySQL 8.4.5
================================================================================
 
 File: 09_Type_Phone.sql
 Purpose: Stored procedures for type phone management operations (CRUD)
 Project: IC4301 Database I - Project 01 (Migrated from Oracle to MySQL)
 Version: 2.0
 Database: carpooling_adm
 
 Description:
   This script contains stored procedures for managing type phone data in the carpooling system.
   Provides complete CRUD operations for the TYPE_PHONE table.
 
 Dependencies:
   - carpooling_adm database must exist
   - carpooling_adm.TYPE_PHONE table must exist
   - carpooling_pu.PHONE table must exist (for dependency checks)
 
 Migration Notes:
   - Oracle CREATE OR REPLACE PROCEDURE → MySQL DROP/CREATE PROCEDURE
   - Oracle SYS_REFCURSOR → MySQL result sets
   - Oracle RAISE_APPLICATION_ERROR → MySQL SIGNAL
   - Oracle %ROWCOUNT → MySQL ROW_COUNT()
   - Oracle ADM schema → MySQL carpooling_adm database
   - Oracle PU schema → MySQL carpooling_pu database
 
 Author: Mauricio González Prendas (Original Oracle version)
 Migrated to MySQL: Assistant
 Date: June 2024
 Version: 2.0
 
================================================================================
*/

-- Switch to ADM database
USE carpooling_adm;

-- Set delimiter for procedure creation
DELIMITER $$

-- ========================================
-- PROCEDURE: insert_type_phone
-- Purpose: Inserts a new type phone
-- ========================================
DROP PROCEDURE IF EXISTS insert_type_phone$$

CREATE PROCEDURE insert_type_phone(
    IN p_name VARCHAR(50)
)
BEGIN
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate name
    IF p_name IS NULL OR TRIM(p_name) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Type phone name cannot be empty.';
    END IF;
    
    INSERT INTO TYPE_PHONE (name) VALUES (TRIM(p_name));
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_type_phone
-- Purpose: Updates an existing type phone
-- ========================================
DROP PROCEDURE IF EXISTS update_type_phone$$

CREATE PROCEDURE update_type_phone(
    IN p_id INT,
    IN p_name VARCHAR(50)
)
BEGIN
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate name
    IF p_name IS NULL OR TRIM(p_name) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Type phone name cannot be empty.';
    END IF;
    
    UPDATE TYPE_PHONE
    SET name = TRIM(p_name),
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Type phone not found with ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_type_phone
-- Purpose: Deletes a type phone after checking dependencies
-- ========================================
DROP PROCEDURE IF EXISTS delete_type_phone$$

CREATE PROCEDURE delete_type_phone(
    IN p_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Check if type phone is used in phones
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.PHONE
    WHERE type_phone_id = p_id;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete type phone that is used in phones.';
    END IF;
    
    DELETE FROM TYPE_PHONE
    WHERE id = p_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Type phone not found with ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: get_type_phone
-- Purpose: Retrieves a specific type phone by ID
-- ========================================
DROP PROCEDURE IF EXISTS get_type_phone$$

CREATE PROCEDURE get_type_phone(
    IN p_id INT
)
BEGIN
    SELECT 
        id, 
        name, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM TYPE_PHONE
    WHERE id = p_id;
END$$

-- ========================================
-- PROCEDURE: list_type_phones
-- Purpose: Lists all type phones ordered by name
-- ========================================
DROP PROCEDURE IF EXISTS list_type_phones$$

CREATE PROCEDURE list_type_phones()
BEGIN
    SELECT 
        id, 
        name, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM TYPE_PHONE
    ORDER BY name;
END$$

-- ========================================
-- PROCEDURE: find_type_phone_by_name
-- Purpose: Finds a type phone by name (useful for validation)
-- ========================================
DROP PROCEDURE IF EXISTS find_type_phone_by_name$$

CREATE PROCEDURE find_type_phone_by_name(
    IN p_name VARCHAR(50)
)
BEGIN
    SELECT 
        id, 
        name, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM TYPE_PHONE
    WHERE name = TRIM(p_name);
END$$

-- ========================================
-- PROCEDURE: check_type_phone_exists
-- Purpose: Checks if a type phone exists by name
-- ========================================
DROP PROCEDURE IF EXISTS check_type_phone_exists$$

CREATE PROCEDURE check_type_phone_exists(
    IN p_name VARCHAR(50),
    OUT o_exists BOOLEAN,
    OUT o_type_phone_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    
    SELECT COUNT(*), COALESCE(MAX(id), 0) INTO v_count, o_type_phone_id
    FROM TYPE_PHONE
    WHERE name = TRIM(p_name);
    
    SET o_exists = (v_count > 0);
    
    IF NOT o_exists THEN
        SET o_type_phone_id = NULL;
    END IF;
END$$

-- ========================================
-- PROCEDURE: get_type_phone_usage_count
-- Purpose: Gets the count of phones using a specific type phone
-- ========================================
DROP PROCEDURE IF EXISTS get_type_phone_usage_count$$

CREATE PROCEDURE get_type_phone_usage_count(
    IN p_type_phone_id INT,
    OUT o_usage_count INT
)
BEGIN
    SELECT COUNT(*) INTO o_usage_count
    FROM carpooling_pu.PHONE
    WHERE type_phone_id = p_type_phone_id;
END$$

-- Reset delimiter
DELIMITER ;

/*
================================================================================
 USAGE EXAMPLES
================================================================================

-- Insert new type phones
CALL insert_type_phone('Móvil');
CALL insert_type_phone('Fijo');
CALL insert_type_phone('Trabajo');
CALL insert_type_phone('Casa');

-- Update a type phone
CALL update_type_phone(1, 'Teléfono Móvil');

-- Get a specific type phone
CALL get_type_phone(1);

-- List all type phones
CALL list_type_phones();

-- Find type phone by name
CALL find_type_phone_by_name('Móvil');

-- Check if type phone exists
CALL check_type_phone_exists('Fijo', @exists, @type_phone_id);
SELECT @exists, @type_phone_id;

-- Get usage count
CALL get_type_phone_usage_count(1, @usage_count);
SELECT @usage_count;

-- Delete a type phone (only if not used)
CALL delete_type_phone(4);

================================================================================
*/ 