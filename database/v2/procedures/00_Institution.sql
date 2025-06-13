/*
================================================================================
 INSTITUTION MANAGEMENT PROCEDURES - MySQL 8.4.5
================================================================================
 
 File: 02_Institution.sql
 Purpose: Stored procedures for institution management operations
 Project: IC4301 Database I - Project 01 (Migrated from Oracle to MySQL)
 Version: 2.0
 Database: carpooling_adm
 
 Description:
   This script contains stored procedures for managing institutions in the carpooling system.
   Migrated from Oracle PL/SQL packages to MySQL stored procedures.
 
 Dependencies:
   - carpooling_adm database must exist
   - carpooling_adm.INSTITUTION table must exist
   - carpooling_adm.INSTITUTION_DOMAIN table must exist
   - carpooling_adm.DOMAIN table must exist
 
 Migration Notes:
   - Oracle packages converted to individual stored procedures
   - REF CURSOR replaced with result sets
   - RAISE_APPLICATION_ERROR replaced with SIGNAL
   - Oracle %TYPE replaced with explicit data types
   - Oracle ID_TABLE_TYPE replaced with JSON parameter for domain IDs
 
================================================================================
*/

-- Switch to ADM database
USE carpooling_adm;

-- Set delimiter for procedure creation
DELIMITER $$

-- ========================================
-- PROCEDURE: create_institution
-- Purpose: Creates a new institution in the system
-- ========================================
DROP PROCEDURE IF EXISTS create_institution$$

CREATE PROCEDURE create_institution(
    IN p_institution_name VARCHAR(100),
    OUT o_institution_id INT
)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate institution name
    SET v_name = TRIM(p_institution_name);
    
    IF v_name IS NULL OR v_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Institution name cannot be empty.';
    END IF;

    -- Check if institution already exists
    SELECT COUNT(*) INTO v_count 
    FROM INSTITUTION 
    WHERE name = v_name;
    
    IF v_count > 0 THEN
        SET v_error_msg = CONCAT('Institution "', v_name, '" already exists.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Insert new institution
    INSERT INTO INSTITUTION (name) VALUES (v_name);
    SET o_institution_id = LAST_INSERT_ID();
    
    COMMIT;
END$$

DROP PROCEDURE IF EXISTS DELETE_INSTITUTION_BY_NAME$$

CREATE PROCEDURE DELETE_INSTITUTION_BY_NAME(
    IN p_institution_name VARCHAR(100)
)
BEGIN
    DELETE FROM carpooling_adm.INSTITUTION 
    WHERE name = p_institution_name;
END $$

-- ========================================
-- PROCEDURE: update_institution_name
-- Purpose: Updates an existing institution name
-- ========================================
DROP PROCEDURE IF EXISTS update_institution_name$$

CREATE PROCEDURE update_institution_name(
    IN p_institution_id INT,
    IN p_new_name VARCHAR(100)
)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate new name
    SET v_name = TRIM(p_new_name);
    
    IF v_name IS NULL OR v_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'New institution name cannot be empty.';
    END IF;

    -- Check if new name already exists for another institution
    SELECT COUNT(*) INTO v_count 
    FROM INSTITUTION 
    WHERE name = v_name AND id != p_institution_id;
    
    IF v_count > 0 THEN
        SET v_error_msg = CONCAT('The name "', v_name, '" is already in use.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Update institution
    UPDATE INSTITUTION 
    SET name = v_name,
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_institution_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Institution with ID ', p_institution_id, ' not found for update.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_institution
-- Purpose: Deletes an institution and its domain associations
-- ========================================
DROP PROCEDURE IF EXISTS delete_institution$$

CREATE PROCEDURE delete_institution(
    IN p_institution_id INT
)
BEGIN
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE v_person_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Check if institution is associated with users
    SELECT COUNT(*) INTO v_person_count
    FROM carpooling_pu.INSTITUTION_PERSON
    WHERE institution_id = p_institution_id;
    
    IF v_person_count > 0 THEN
        SET v_error_msg = CONCAT('Cannot delete institution ID ', p_institution_id, ' because it is associated with users or other data.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Delete domain associations first
    DELETE FROM INSTITUTION_DOMAIN WHERE institution_id = p_institution_id;
    
    -- Delete institution
    DELETE FROM INSTITUTION WHERE id = p_institution_id;
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Institution with ID ', p_institution_id, ' not found for deletion.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: find_institution_by_id
-- Purpose: Retrieves an institution by its ID
-- ========================================
DROP PROCEDURE IF EXISTS find_institution_by_id$$

CREATE PROCEDURE find_institution_by_id(
    IN p_institution_id INT
)
BEGIN
    SELECT 
        id, 
        name,
        creation_date,
        creator,
        modification_date,
        modifier
    FROM INSTITUTION
    WHERE id = p_institution_id;
END$$

-- ========================================
-- PROCEDURE: find_all_institutions
-- Purpose: Retrieves all institutions ordered by name
-- ========================================
DROP PROCEDURE IF EXISTS find_all_institutions$$

CREATE PROCEDURE find_all_institutions()
BEGIN
    SELECT 
        id, 
        name,
        creation_date,
        creator,
        modification_date,
        modifier
    FROM INSTITUTION
    ORDER BY name;
END$$

-- ========================================
-- PROCEDURE: update_institution_domains
-- Purpose: Updates domain associations for an institution
-- ========================================
DROP PROCEDURE IF EXISTS update_institution_domains$$

CREATE PROCEDURE update_institution_domains(
    IN p_institution_id INT,
    IN p_domain_ids JSON
)
BEGIN
    DECLARE v_inst_count INT DEFAULT 0;
    DECLARE v_domain_count INT DEFAULT 0;
    DECLARE v_domain_id INT;
    DECLARE v_array_length INT DEFAULT 0;
    DECLARE v_counter INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Check if institution exists
    SELECT COUNT(*) INTO v_inst_count 
    FROM INSTITUTION 
    WHERE id = p_institution_id;
    
    IF v_inst_count = 0 THEN
        SET v_error_msg = CONCAT('Institution with ID ', p_institution_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Delete existing domain associations
    DELETE FROM INSTITUTION_DOMAIN WHERE institution_id = p_institution_id;
    
    -- If domain IDs are provided, insert new associations
    IF p_domain_ids IS NOT NULL THEN
        SET v_array_length = JSON_LENGTH(p_domain_ids);
        
        WHILE v_counter < v_array_length DO
            SET v_domain_id = JSON_UNQUOTE(JSON_EXTRACT(p_domain_ids, CONCAT('$[', v_counter, ']')));
            
            -- Verify domain exists
            SELECT COUNT(*) INTO v_domain_count
            FROM DOMAIN
            WHERE id = v_domain_id;
            
            IF v_domain_count = 0 THEN
                SET v_error_msg = CONCAT('Domain with ID ', v_domain_id, ' does not exist.');
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
            END IF;
            
            -- Insert association
            INSERT INTO INSTITUTION_DOMAIN (institution_id, domain_id) 
            VALUES (p_institution_id, v_domain_id);
            
            SET v_counter = v_counter + 1;
        END WHILE;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: get_associated_domain_ids
-- Purpose: Gets domain IDs associated with an institution
-- ========================================
DROP PROCEDURE IF EXISTS get_associated_domain_ids$$

CREATE PROCEDURE get_associated_domain_ids(
    IN p_institution_id INT
)
BEGIN
    SELECT domain_id 
    FROM INSTITUTION_DOMAIN 
    WHERE institution_id = p_institution_id
    ORDER BY domain_id;
END$$

-- ========================================
-- PROCEDURE: get_institution_domains_detail
-- Purpose: Gets detailed domain information for an institution
-- ========================================
DROP PROCEDURE IF EXISTS get_institution_domains_detail$$

CREATE PROCEDURE get_institution_domains_detail(
    IN p_institution_id INT
)
BEGIN
    SELECT 
        d.id,
        d.name,
        d.creation_date,
        d.creator,
        d.modification_date,
        d.modifier
    FROM DOMAIN d
    INNER JOIN INSTITUTION_DOMAIN id ON d.id = id.domain_id
    WHERE id.institution_id = p_institution_id
    ORDER BY d.name;
END$$

-- ========================================
-- PROCEDURE: check_institution_exists
-- Purpose: Checks if an institution exists by name
-- ========================================
DROP PROCEDURE IF EXISTS check_institution_exists$$

CREATE PROCEDURE check_institution_exists(
    IN p_institution_name VARCHAR(100),
    OUT o_exists BOOLEAN
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_name VARCHAR(100);
    
    SET v_name = TRIM(p_institution_name);
    
    SELECT COUNT(*) INTO v_count 
    FROM INSTITUTION 
    WHERE name = v_name;
    
    SET o_exists = (v_count > 0);
END$$

-- ========================================
-- PROCEDURE: add_domain_to_institution
-- Purpose: Adds a single domain to an institution
-- ========================================
DROP PROCEDURE IF EXISTS add_domain_to_institution$$

CREATE PROCEDURE add_domain_to_institution(
    IN p_institution_id INT,
    IN p_domain_id INT
)
BEGIN
    DECLARE v_inst_count INT DEFAULT 0;
    DECLARE v_domain_count INT DEFAULT 0;
    DECLARE v_association_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Check if institution exists
    SELECT COUNT(*) INTO v_inst_count 
    FROM INSTITUTION 
    WHERE id = p_institution_id;
    
    IF v_inst_count = 0 THEN
        SET v_error_msg = CONCAT('Institution with ID ', p_institution_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Check if domain exists
    SELECT COUNT(*) INTO v_domain_count 
    FROM DOMAIN 
    WHERE id = p_domain_id;
    
    IF v_domain_count = 0 THEN
        SET v_error_msg = CONCAT('Domain with ID ', p_domain_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Check if association already exists
    SELECT COUNT(*) INTO v_association_count
    FROM INSTITUTION_DOMAIN
    WHERE institution_id = p_institution_id AND domain_id = p_domain_id;
    
    IF v_association_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Domain is already associated with this institution.';
    END IF;
    
    -- Insert association
    INSERT INTO INSTITUTION_DOMAIN (institution_id, domain_id) 
    VALUES (p_institution_id, p_domain_id);
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: remove_domain_from_institution
-- Purpose: Removes a domain from an institution
-- ========================================
DROP PROCEDURE IF EXISTS remove_domain_from_institution$$

CREATE PROCEDURE remove_domain_from_institution(
    IN p_institution_id INT,
    IN p_domain_id INT
)
BEGIN
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Delete association
    DELETE FROM INSTITUTION_DOMAIN 
    WHERE institution_id = p_institution_id AND domain_id = p_domain_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Domain association not found for removal.';
    END IF;
    
    COMMIT;
END$$

-- Reset delimiter
DELIMITER ;

/*
================================================================================
 USAGE EXAMPLES
================================================================================

-- Create a new institution
CALL create_institution('Universidad Tecnológica', @institution_id);
SELECT @institution_id;

-- Update institution name
CALL update_institution_name(1, 'Universidad Tecnológica de Costa Rica');

-- Find institution by ID
CALL find_institution_by_id(1);

-- Find all institutions
CALL find_all_institutions();

-- Update institution domains (using JSON array)
CALL update_institution_domains(1, '[1, 2, 3]');

-- Get associated domain IDs
CALL get_associated_domain_ids(1);

-- Get detailed domain information
CALL get_institution_domains_detail(1);

-- Add single domain to institution
CALL add_domain_to_institution(1, 4);

-- Remove domain from institution
CALL remove_domain_from_institution(1, 4);

-- Check if institution exists
CALL check_institution_exists('Universidad Tecnológica', @exists);
SELECT @exists;

-- Delete institution
CALL delete_institution(1);

================================================================================
*/
