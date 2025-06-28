/*
================================================================================
 TYPE IDENTIFICATION MANAGEMENT PROCEDURES - MySQL 8.4.5
================================================================================
 
 File: 08_Type_Identification.sql
 Purpose: Stored procedures for type identification management operations (CRUD)
 Project: IC4301 Database I - Project 01 (Migrated from Oracle to MySQL)
 Version: 2.0
 Database: carpooling_adm
 
 Description:
   This script contains stored procedures for managing type identification data in the carpooling system.
   Provides complete CRUD operations for the TYPE_IDENTIFICATION table.
 
 Dependencies:
   - carpooling_adm database must exist
   - carpooling_adm.TYPE_IDENTIFICATION table must exist
   - carpooling_adm.PERSON table must exist (for dependency checks)
 
 Migration Notes:
   - Oracle CREATE OR REPLACE PROCEDURE → MySQL DROP/CREATE PROCEDURE
   - Oracle SYS_REFCURSOR → MySQL result sets
   - Oracle RAISE_APPLICATION_ERROR → MySQL SIGNAL
   - Oracle %ROWCOUNT → MySQL ROW_COUNT()
   - Oracle ADM schema → MySQL carpooling_adm database
 
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
-- PROCEDURE: insert_type_identification
-- Purpose: Inserts a new type identification
-- ========================================
DROP PROCEDURE IF EXISTS insert_type_identification$$

CREATE PROCEDURE insert_type_identification(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Type identification name cannot be empty.';
    END IF;
    
    INSERT INTO TYPE_IDENTIFICATION (name) VALUES (TRIM(p_name));
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_type_identification
-- Purpose: Updates an existing type identification
-- ========================================
DROP PROCEDURE IF EXISTS update_type_identification$$

CREATE PROCEDURE update_type_identification(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Type identification name cannot be empty.';
    END IF;
    
    UPDATE TYPE_IDENTIFICATION
    SET name = TRIM(p_name),
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Type identification not found with ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_type_identification
-- Purpose: Deletes a type identification after checking dependencies
-- ========================================
DROP PROCEDURE IF EXISTS delete_type_identification$$

CREATE PROCEDURE delete_type_identification(
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
    
    -- Check if type identification is used in persons
    SELECT COUNT(*) INTO v_count
    FROM PERSON
    WHERE type_identification_id = p_id;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete type identification that is used in persons.';
    END IF;
    
    DELETE FROM TYPE_IDENTIFICATION
    WHERE id = p_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Type identification not found with ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: get_type_identification
-- Purpose: Retrieves a specific type identification by ID
-- ========================================
DROP PROCEDURE IF EXISTS get_type_identification$$

CREATE PROCEDURE get_type_identification(
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
    FROM TYPE_IDENTIFICATION
    WHERE id = p_id;
END$$

-- ========================================
-- PROCEDURE: list_type_identifications
-- Purpose: Lists all type identifications ordered by name
-- ========================================
DROP PROCEDURE IF EXISTS list_type_identifications$$

CREATE PROCEDURE list_type_identifications()
BEGIN
    SELECT 
        id, 
        name, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM TYPE_IDENTIFICATION
    ORDER BY name;
END$$

-- ========================================
-- PROCEDURE: find_type_identification_by_name
-- Purpose: Finds a type identification by name (useful for validation)
-- ========================================
DROP PROCEDURE IF EXISTS find_type_identification_by_name$$

CREATE PROCEDURE find_type_identification_by_name(
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
    FROM TYPE_IDENTIFICATION
    WHERE name = TRIM(p_name);
END$$

-- ========================================
-- PROCEDURE: check_type_identification_exists
-- Purpose: Checks if a type identification exists by name
-- ========================================
DROP PROCEDURE IF EXISTS check_type_identification_exists$$

CREATE PROCEDURE check_type_identification_exists(
    IN p_name VARCHAR(50),
    OUT o_exists BOOLEAN,
    OUT o_type_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    
    SELECT COUNT(*), COALESCE(MAX(id), 0) INTO v_count, o_type_id
    FROM TYPE_IDENTIFICATION
    WHERE name = TRIM(p_name);
    
    SET o_exists = (v_count > 0);
    
    IF NOT o_exists THEN
        SET o_type_id = NULL;
    END IF;
END$$

-- ========================================
-- PROCEDURE: get_type_identification_usage_count
-- Purpose: Gets the count of persons using a specific type identification
-- ========================================
DROP PROCEDURE IF EXISTS get_type_identification_usage_count$$

CREATE PROCEDURE get_type_identification_usage_count(
    IN p_type_id INT,
    OUT o_usage_count INT
)
BEGIN
    SELECT COUNT(*) INTO o_usage_count
    FROM PERSON
    WHERE type_identification_id = p_type_id;
END$$

-- Reset delimiter
DELIMITER ;

/*
================================================================================
 USAGE EXAMPLES
================================================================================

-- Insert new type identifications
CALL insert_type_identification('Cédula Nacional');
CALL insert_type_identification('Pasaporte');
CALL insert_type_identification('Cédula de Residencia');
CALL insert_type_identification('Carnet de Refugiado');

-- Update a type identification
CALL update_type_identification(1, 'Cédula de Identidad Nacional');

-- Get a specific type identification
CALL get_type_identification(1);

-- List all type identifications
CALL list_type_identifications();

-- Find type identification by name
CALL find_type_identification_by_name('Pasaporte');

-- Check if type identification exists
CALL check_type_identification_exists('Cédula Nacional', @exists, @type_id);
SELECT @exists, @type_id;

-- Get usage count
CALL get_type_identification_usage_count(1, @usage_count);
SELECT @usage_count;

-- Delete a type identification (only if not used)
CALL delete_type_identification(4);

================================================================================
*/ 