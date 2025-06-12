/*
================================================================================
 DOMAIN MANAGEMENT PROCEDURES - MySQL 8.4.5
================================================================================
 
 File: 01_Domain.sql
 Purpose: Stored procedures for domain management operations
 Project: IC4301 Database I - Project 01 (Migrated from Oracle to MySQL)
 Version: 2.0
 Database: carpooling_adm
 
 Description:
   This script contains stored procedures for managing domains in the carpooling system.
   Migrated from Oracle PL/SQL packages to MySQL stored procedures.
 
 Dependencies:
   - carpooling_adm database must exist
   - carpooling_adm.DOMAIN table must exist
   - carpooling_adm.INSTITUTION_DOMAIN table must exist
 
 Migration Notes:
   - Oracle packages converted to individual stored procedures
   - REF CURSOR replaced with result sets
   - RAISE_APPLICATION_ERROR replaced with SIGNAL
   - Oracle %TYPE replaced with explicit data types
   - Oracle DUP_VAL_ON_INDEX replaced with MySQL error handling
 
================================================================================
*/

-- Switch to ADM database
USE carpooling_adm;

-- Set delimiter for procedure creation
DELIMITER $$

-- ========================================
-- PROCEDURE: register_domain
-- Purpose: Registers a new domain in the system
-- ========================================
DROP PROCEDURE IF EXISTS register_domain$$

CREATE PROCEDURE register_domain(
    IN p_domain_name VARCHAR(100),
    OUT o_domain_id INT
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
    
    -- Validate and prepare domain name
    SET v_name = TRIM(LOWER(p_domain_name));
    
    IF v_name IS NULL OR v_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Domain name cannot be empty.';
    END IF;

    -- Check if domain already exists
    SELECT COUNT(*) INTO v_count 
    FROM DOMAIN 
    WHERE name = v_name;
    
    IF v_count > 0 THEN
        SET v_error_msg = CONCAT('Domain "', v_name, '" already exists.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Insert new domain
    INSERT INTO DOMAIN (name) VALUES (v_name);
    SET o_domain_id = LAST_INSERT_ID();
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_domain
-- Purpose: Updates an existing domain name
-- ========================================
DROP PROCEDURE IF EXISTS update_domain$$

CREATE PROCEDURE update_domain(
    IN p_domain_id INT,
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
    
    -- Validate and prepare domain name
    SET v_name = TRIM(LOWER(p_new_name));
    
    IF v_name IS NULL OR v_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Domain name cannot be empty.';
    END IF;

    -- Check if new name already exists for another domain
    SELECT COUNT(*) INTO v_count 
    FROM DOMAIN 
    WHERE name = v_name AND id != p_domain_id;
    
    IF v_count > 0 THEN
        SET v_error_msg = CONCAT('Domain name "', v_name, '" already exists.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Update domain
    UPDATE DOMAIN 
    SET name = v_name,
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_domain_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Domain with ID ', p_domain_id, ' not found for update.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_domain
-- Purpose: Deletes a domain from the system
-- ========================================
DROP PROCEDURE IF EXISTS delete_domain$$

CREATE PROCEDURE delete_domain(
    IN p_domain_id INT
)
BEGIN
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE v_association_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Check if domain is associated with institutions
    SELECT COUNT(*) INTO v_association_count
    FROM INSTITUTION_DOMAIN
    WHERE domain_id = p_domain_id;
    
    IF v_association_count > 0 THEN
        SET v_error_msg = CONCAT('Cannot delete domain ID ', p_domain_id, ' because it is associated with institutions.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Delete domain
    DELETE FROM DOMAIN WHERE id = p_domain_id;
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Domain with ID ', p_domain_id, ' not found for deletion.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: find_domain_by_id
-- Purpose: Retrieves a domain by its ID
-- ========================================
DROP PROCEDURE IF EXISTS find_domain_by_id$$

CREATE PROCEDURE find_domain_by_id(
    IN p_domain_id INT
)
BEGIN
    SELECT 
        id, 
        name,
        creation_date,
        creator,
        modification_date,
        modifier
    FROM DOMAIN
    WHERE id = p_domain_id;
END$$

-- ========================================
-- PROCEDURE: find_all_domains
-- Purpose: Retrieves all domains ordered by name
-- ========================================
DROP PROCEDURE IF EXISTS find_all_domains$$

CREATE PROCEDURE find_all_domains()
BEGIN
    SELECT 
        id, 
        name,
        creation_date,
        creator,
        modification_date,
        modifier
    FROM DOMAIN
    ORDER BY name;
END$$

-- ========================================
-- PROCEDURE: find_domains_by_institution
-- Purpose: Retrieves domains associated with a specific institution
-- ========================================
DROP PROCEDURE IF EXISTS find_domains_by_institution$$

CREATE PROCEDURE find_domains_by_institution(
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
-- PROCEDURE: check_domain_exists
-- Purpose: Checks if a domain exists by name
-- ========================================
DROP PROCEDURE IF EXISTS check_domain_exists$$

CREATE PROCEDURE check_domain_exists(
    IN p_domain_name VARCHAR(100),
    OUT o_exists BOOLEAN
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_name VARCHAR(100);
    
    SET v_name = TRIM(LOWER(p_domain_name));
    
    SELECT COUNT(*) INTO v_count 
    FROM DOMAIN 
    WHERE name = v_name;
    
    SET o_exists = (v_count > 0);
END$$

-- Reset delimiter
DELIMITER ;

/*
================================================================================
 USAGE EXAMPLES
================================================================================

-- Register a new domain
CALL register_domain('example.com', @domain_id);
SELECT @domain_id;

-- Update domain name
CALL update_domain(1, 'newexample.com');

-- Find domain by ID
CALL find_domain_by_id(1);

-- Find all domains
CALL find_all_domains();

-- Find domains by institution
CALL find_domains_by_institution(1);

-- Check if domain exists
CALL check_domain_exists('example.com', @exists);
SELECT @exists;

-- Delete domain
CALL delete_domain(1);

================================================================================
*/ 