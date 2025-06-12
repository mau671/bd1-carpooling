/*
================================================================================
 GENDER MANAGEMENT PROCEDURES - MySQL 8.4.5
================================================================================
 
 File: 07_Gender.sql
 Purpose: Stored procedures for gender management operations (CRUD)
 Project: IC4301 Database I - Project 01 (Migrated from Oracle to MySQL)
 Version: 2.0
 Database: carpooling_adm
 
 Description:
   This script contains stored procedures for managing gender data in the carpooling system.
   Provides complete CRUD operations for the GENDER table.
 
 Dependencies:
   - carpooling_adm database must exist
   - carpooling_adm.GENDER table must exist
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
-- PROCEDURE: insert_gender
-- Purpose: Inserts a new gender
-- ========================================
DROP PROCEDURE IF EXISTS insert_gender$$

CREATE PROCEDURE insert_gender(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Gender name cannot be empty.';
    END IF;
    
    INSERT INTO GENDER (name) VALUES (TRIM(p_name));
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_gender
-- Purpose: Updates an existing gender
-- ========================================
DROP PROCEDURE IF EXISTS update_gender$$

CREATE PROCEDURE update_gender(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Gender name cannot be empty.';
    END IF;
    
    UPDATE GENDER
    SET name = TRIM(p_name),
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Gender not found with ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_gender
-- Purpose: Deletes a gender after checking dependencies
-- ========================================
DROP PROCEDURE IF EXISTS delete_gender$$

CREATE PROCEDURE delete_gender(
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
    
    -- Check if gender is used in persons
    SELECT COUNT(*) INTO v_count
    FROM PERSON
    WHERE gender_id = p_id;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete gender that is used in persons.';
    END IF;
    
    DELETE FROM GENDER
    WHERE id = p_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Gender not found with ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: get_gender
-- Purpose: Retrieves a specific gender by ID
-- ========================================
DROP PROCEDURE IF EXISTS get_gender$$

CREATE PROCEDURE get_gender(
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
    FROM GENDER
    WHERE id = p_id;
END$$

-- ========================================
-- PROCEDURE: list_genders
-- Purpose: Lists all genders ordered by name
-- ========================================
DROP PROCEDURE IF EXISTS list_genders$$

CREATE PROCEDURE list_genders()
BEGIN
    SELECT 
        id, 
        name, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM GENDER
    ORDER BY name;
END$$

-- ========================================
-- PROCEDURE: find_gender_by_name
-- Purpose: Finds a gender by name (useful for validation)
-- ========================================
DROP PROCEDURE IF EXISTS find_gender_by_name$$

CREATE PROCEDURE find_gender_by_name(
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
    FROM GENDER
    WHERE name = TRIM(p_name);
END$$

-- ========================================
-- PROCEDURE: check_gender_exists
-- Purpose: Checks if a gender exists by name
-- ========================================
DROP PROCEDURE IF EXISTS check_gender_exists$$

CREATE PROCEDURE check_gender_exists(
    IN p_name VARCHAR(50),
    OUT o_exists BOOLEAN,
    OUT o_gender_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    
    SELECT COUNT(*), COALESCE(MAX(id), 0) INTO v_count, o_gender_id
    FROM GENDER
    WHERE name = TRIM(p_name);
    
    SET o_exists = (v_count > 0);
    
    IF NOT o_exists THEN
        SET o_gender_id = NULL;
    END IF;
END$$

-- ========================================
-- PROCEDURE: get_gender_usage_count
-- Purpose: Gets the count of persons using a specific gender
-- ========================================
DROP PROCEDURE IF EXISTS get_gender_usage_count$$

CREATE PROCEDURE get_gender_usage_count(
    IN p_gender_id INT,
    OUT o_usage_count INT
)
BEGIN
    SELECT COUNT(*) INTO o_usage_count
    FROM PERSON
    WHERE gender_id = p_gender_id;
END$$

-- Reset delimiter
DELIMITER ;

/*
================================================================================
 USAGE EXAMPLES
================================================================================

-- Insert a new gender
CALL insert_gender('Masculino');
CALL insert_gender('Femenino');
CALL insert_gender('No binario');

-- Update a gender
CALL update_gender(1, 'Masculino');

-- Get a specific gender
CALL get_gender(1);

-- List all genders
CALL list_genders();

-- Find gender by name
CALL find_gender_by_name('Femenino');

-- Check if gender exists
CALL check_gender_exists('Masculino', @exists, @gender_id);
SELECT @exists, @gender_id;

-- Get usage count
CALL get_gender_usage_count(1, @usage_count);
SELECT @usage_count;

-- Delete a gender (only if not used)
CALL delete_gender(3);

================================================================================
*/ 