/*
================================================================================
 PERSON & USER MANAGEMENT PROCEDURES - MySQL 8.4.5 (CONSOLIDATED)
================================================================================
 
 File: 04_Person_Consolidated.sql
 Purpose: Complete person and user management system with CRUD operations
 Project: IC4301 Database I - Project 01 (Migrated from Oracle to MySQL)
 Version: 3.0 - CONSOLIDATED VERSION
 Databases: carpooling_adm, carpooling_pu
 
 Description:
   This script contains ALL stored procedures for managing persons, users, authentication,
   user types, and photo management in the carpooling system. Consolidated from multiple
   files to eliminate redundancy and provide a single source of truth.
 
 SECTIONS:
   1. Basic Person CRUD Operations
   2. User Registration & Authentication
   3. User Type Management (Admin, Driver, Passenger)
   4. Photo Management (Profile Pictures)
   5. Search & Query Functions
   6. Utility Functions
   7. Update & Delete Operations
 
 Dependencies:
   - carpooling_adm database and tables (PERSON, ADMIN, GENDER, TYPE_IDENTIFICATION, etc.)
   - carpooling_pu database and tables (PERSONUSER, PHONE, EMAIL, PASSENGER, DRIVER, PHOTO, etc.)
 
 Migration Notes:
   - Consolidated from 03_UserAuth.sql and 04_Person.sql
   - Eliminated redundant procedures
   - Organized by functional sections
   - Single source of truth for person/user management
 
================================================================================
*/

-- Switch to ADM database
USE carpooling_adm;

-- Set delimiter for procedure creation
DELIMITER $$

-- ========================================
-- SECTION 1: BASIC PERSON CRUD OPERATIONS
-- ========================================

-- ========================================
-- PROCEDURE: create_person
-- Purpose: Creates a new person (basic info only)
-- ========================================
DROP PROCEDURE IF EXISTS create_person$$

CREATE PROCEDURE create_person(
    IN p_first_name VARCHAR(50),
    IN p_second_name VARCHAR(50),
    IN p_first_surname VARCHAR(50),
    IN p_second_surname VARCHAR(50),
    IN p_identification_number VARCHAR(50),
    IN p_date_of_birth DATE,
    IN p_gender_id INT,
    IN p_type_identification_id INT,
    OUT o_person_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate required fields
    IF p_first_name IS NULL OR TRIM(p_first_name) = '' THEN
        SET v_error_msg = 'First name is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_first_surname IS NULL OR TRIM(p_first_surname) = '' THEN
        SET v_error_msg = 'First surname is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_identification_number IS NULL OR TRIM(p_identification_number) = '' THEN
        SET v_error_msg = 'Identification number is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_date_of_birth IS NULL THEN
        SET v_error_msg = 'Date of birth is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_gender_id IS NULL THEN
        SET v_error_msg = 'Gender is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_type_identification_id IS NULL THEN
        SET v_error_msg = 'Identification type is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Check if identification number already exists
    SELECT COUNT(*) INTO v_count
    FROM PERSON
    WHERE identification_number = p_identification_number;
    
    IF v_count > 0 THEN
        SET v_error_msg = 'Identification number already exists.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Validate gender exists
    SELECT COUNT(*) INTO v_count
    FROM GENDER
    WHERE id = p_gender_id;
    
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('Gender with ID ', p_gender_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Validate identification type exists
    SELECT COUNT(*) INTO v_count
    FROM TYPE_IDENTIFICATION
    WHERE id = p_type_identification_id;
    
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('Identification type with ID ', p_type_identification_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Insert new person
    INSERT INTO PERSON (
        first_name,
        second_name,
        first_surname,
        second_surname,
        identification_number,
        date_of_birth,
        gender_id,
        type_identification_id
    ) VALUES (
        TRIM(p_first_name),
        CASE WHEN p_second_name IS NULL THEN NULL ELSE TRIM(p_second_name) END,
        TRIM(p_first_surname),
        CASE WHEN p_second_surname IS NULL THEN NULL ELSE TRIM(p_second_surname) END,
        p_identification_number,
        p_date_of_birth,
        p_gender_id,
        p_type_identification_id
    );
    
    SET o_person_id = LAST_INSERT_ID();
    
    COMMIT;
END$$

-- ========================================
-- SECTION 2: USER REGISTRATION & AUTHENTICATION
-- ========================================

-- ========================================
-- PROCEDURE: register_complete_user
-- Purpose: Registers a new user with person, account, phone, email, and institution
-- ========================================
DROP PROCEDURE IF EXISTS register_complete_user$$

CREATE PROCEDURE register_complete_user(
    IN p_first_name VARCHAR(50),
    IN p_second_name VARCHAR(50),
    IN p_first_surname VARCHAR(50),
    IN p_second_surname VARCHAR(50),
    IN p_id_type_id INT,
    IN p_id_number VARCHAR(50),
    IN p_phone_type_id INT,
    IN p_phone_number VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_date_of_birth DATE,
    IN p_gender_id INT,
    IN p_institution_id INT,
    IN p_domain_id INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(50),
    OUT o_person_id INT,
    OUT o_user_id INT
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_user_id INT;
    DECLARE v_phone_id INT;
    DECLARE v_email_id INT;
    DECLARE v_institution_count INT DEFAULT 0;
    DECLARE v_domain_count INT DEFAULT 0;
    DECLARE v_username_count INT DEFAULT 0;
    DECLARE v_id_number_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate required fields
    IF p_first_name IS NULL OR TRIM(p_first_name) = '' THEN
        SET v_error_msg = 'First name is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_first_surname IS NULL OR TRIM(p_first_surname) = '' THEN
        SET v_error_msg = 'First surname is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_id_number IS NULL OR TRIM(p_id_number) = '' THEN
        SET v_error_msg = 'Identification number is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_username IS NULL OR TRIM(p_username) = '' THEN
        SET v_error_msg = 'Username is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    IF p_password IS NULL OR TRIM(p_password) = '' THEN
        SET v_error_msg = 'Password is required.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Check if identification number already exists
    SELECT COUNT(*) INTO v_id_number_count
    FROM PERSON
    WHERE identification_number = p_id_number;
    
    IF v_id_number_count > 0 THEN
        SET v_error_msg = 'Identification number already exists.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Check if username already exists
    SELECT COUNT(*) INTO v_username_count
    FROM carpooling_pu.PERSONUSER
    WHERE username = p_username;
    
    IF v_username_count > 0 THEN
        SET v_error_msg = 'Username already exists.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Validate that institution exists
    SELECT COUNT(*) INTO v_institution_count
    FROM INSTITUTION
    WHERE id = p_institution_id;
    
    IF v_institution_count = 0 THEN
        SET v_error_msg = CONCAT('Institution with ID ', p_institution_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Validate that domain exists and is associated with the institution
    SELECT COUNT(*) INTO v_domain_count
    FROM INSTITUTION_DOMAIN
    WHERE institution_id = p_institution_id AND domain_id = p_domain_id;
    
    IF v_domain_count = 0 THEN
        SET v_error_msg = CONCAT('Domain with ID ', p_domain_id, ' is not associated with institution ', p_institution_id, '.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Insert person
    INSERT INTO PERSON (
        first_name,
        second_name,
        first_surname,
        second_surname,
        identification_number,
        date_of_birth,
        gender_id,
        type_identification_id
    ) VALUES (
        TRIM(p_first_name),
        CASE WHEN p_second_name IS NULL THEN NULL ELSE TRIM(p_second_name) END,
        TRIM(p_first_surname),
        CASE WHEN p_second_surname IS NULL THEN NULL ELSE TRIM(p_second_surname) END,
        p_id_number,
        p_date_of_birth,
        p_gender_id,
        p_id_type_id
    );
    
    SET v_person_id = LAST_INSERT_ID();

    -- Insert user account
    INSERT INTO carpooling_pu.PERSONUSER (
        username,
        password,
        person_id
    ) VALUES (
        p_username,
        p_password,
        v_person_id
    );
    
    SET v_user_id = LAST_INSERT_ID();

    -- Insert phone
    INSERT INTO carpooling_pu.PHONE (
        phone_number,
        type_phone_id
    ) VALUES (
        p_phone_number,
        p_phone_type_id
    );
    
    SET v_phone_id = LAST_INSERT_ID();

    -- Insert phone-person relationship
    INSERT INTO carpooling_pu.PHONE_PERSON (
        phone_id,
        person_id
    ) VALUES (
        v_phone_id,
        v_person_id
    );

    -- Insert email
    INSERT INTO carpooling_pu.EMAIL (
        name,
        domain_id,
        person_id
    ) VALUES (
        p_email,
        p_domain_id,
        v_person_id
    );

    -- Insert institution-person relationship
    INSERT INTO carpooling_pu.INSTITUTION_PERSON (
        institution_id,
        person_id
    ) VALUES (
        p_institution_id,
        v_person_id
    );

    -- Set output parameters
    SET o_person_id = v_person_id;
    SET o_user_id = v_user_id;

    COMMIT;
END$$

-- ========================================
-- PROCEDURE: authenticate_user
-- Purpose: Authenticates a user with username and password
-- ========================================
DROP PROCEDURE IF EXISTS authenticate_user$$

CREATE PROCEDURE authenticate_user(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(50)
)
BEGIN
    SELECT 
        u.id as user_id,
        u.username,
        u.person_id,
        p.first_name,
        p.first_surname,
        p.identification_number
    FROM carpooling_pu.PERSONUSER u
    INNER JOIN PERSON p ON u.person_id = p.id
    WHERE u.username = p_username
    AND u.password = p_password;
END$$

-- ========================================
-- SECTION 3: USER TYPE MANAGEMENT
-- ========================================

-- ========================================
-- PROCEDURE: register_as_driver
-- Purpose: Registers an existing user as a driver
-- ========================================
DROP PROCEDURE IF EXISTS register_as_driver$$

CREATE PROCEDURE register_as_driver(
    IN p_user_id INT
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_count INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found.';
    END IF;
    
    -- Check if already a driver
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.DRIVER
    WHERE person_id = v_person_id;
    
    IF v_count > 0 THEN
        -- Already a driver, nothing to do
        COMMIT;
    ELSE
        -- Insert as driver
        INSERT INTO carpooling_pu.DRIVER (person_id)
        VALUES (v_person_id);
        
        COMMIT;
    END IF;
END$$

-- ========================================
-- PROCEDURE: register_as_passenger
-- Purpose: Registers an existing user as a passenger
-- ========================================
DROP PROCEDURE IF EXISTS register_as_passenger$$

CREATE PROCEDURE register_as_passenger(
    IN p_user_id INT
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_count INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found.';
    END IF;
    
    -- Check if already a passenger
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.PASSENGER
    WHERE person_id = v_person_id;
    
    IF v_count > 0 THEN
        -- Already a passenger, nothing to do
        COMMIT;
    ELSE
        -- Insert as passenger
        INSERT INTO carpooling_pu.PASSENGER (person_id)
        VALUES (v_person_id);
        
        COMMIT;
    END IF;
END$$

-- ========================================
-- PROCEDURE: is_admin
-- Purpose: Checks if a user is an administrator
-- ========================================
DROP PROCEDURE IF EXISTS is_admin$$

CREATE PROCEDURE is_admin(
    IN p_user_id INT,
    OUT o_is_admin BOOLEAN
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_count INT DEFAULT 0;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SET o_is_admin = FALSE;
    ELSE
        -- Check if is admin
        SELECT COUNT(*) INTO v_count
        FROM ADMIN
        WHERE person_id = v_person_id;
        
        SET o_is_admin = (v_count > 0);
    END IF;
END$$

-- ========================================
-- PROCEDURE: get_user_type
-- Purpose: Gets the user type (ADMIN, DRIVER, PASSENGER, or NULL)
-- ========================================
DROP PROCEDURE IF EXISTS get_user_type$$

CREATE PROCEDURE get_user_type(
    IN p_user_id INT,
    OUT o_user_type VARCHAR(20)
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_is_admin INT DEFAULT 0;
    DECLARE v_is_driver INT DEFAULT 0;
    DECLARE v_is_passenger INT DEFAULT 0;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SET o_user_type = NULL;
    ELSE
        -- Check if is admin (highest priority)
        SELECT COUNT(*) INTO v_is_admin
        FROM ADMIN
        WHERE person_id = v_person_id;
        
        IF v_is_admin > 0 THEN
            SET o_user_type = 'ADMIN';
        ELSE
            -- Check if is driver
            SELECT COUNT(*) INTO v_is_driver
            FROM carpooling_pu.DRIVER
            WHERE person_id = v_person_id;
            
            IF v_is_driver > 0 THEN
                SET o_user_type = 'DRIVER';
            ELSE
                -- Check if is passenger
                SELECT COUNT(*) INTO v_is_passenger
                FROM carpooling_pu.PASSENGER
                WHERE person_id = v_person_id;
                
                IF v_is_passenger > 0 THEN
                    SET o_user_type = 'PASSENGER';
                ELSE
                    SET o_user_type = NULL;
                END IF;
            END IF;
        END IF;
    END IF;
END$$

-- ========================================
-- PROCEDURE: is_driver
-- Purpose: Checks if a user is registered as a driver
-- ========================================
DROP PROCEDURE IF EXISTS is_driver$$

CREATE PROCEDURE is_driver(
    IN p_user_id INT,
    OUT o_is_driver BOOLEAN
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_count INT DEFAULT 0;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SET o_is_driver = FALSE;
    ELSE
        -- Check if is driver
        SELECT COUNT(*) INTO v_count
        FROM carpooling_pu.DRIVER
        WHERE person_id = v_person_id;
        
        SET o_is_driver = (v_count > 0);
    END IF;
END$$

-- ========================================
-- PROCEDURE: is_passenger
-- Purpose: Checks if a user is registered as a passenger
-- ========================================
DROP PROCEDURE IF EXISTS is_passenger$$

CREATE PROCEDURE is_passenger(
    IN p_user_id INT,
    OUT o_is_passenger BOOLEAN
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_count INT DEFAULT 0;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SET o_is_passenger = FALSE;
    ELSE
        -- Check if is passenger
        SELECT COUNT(*) INTO v_count
        FROM carpooling_pu.PASSENGER
        WHERE person_id = v_person_id;
        
        SET o_is_passenger = (v_count > 0);
    END IF;
END$$

-- ========================================
-- PROCEDURE: get_user_types_all
-- Purpose: Gets all user types for a user (can be multiple)
-- ========================================
DROP PROCEDURE IF EXISTS get_user_types_all$$

CREATE PROCEDURE get_user_types_all(
    IN p_user_id INT,
    OUT o_is_admin BOOLEAN,
    OUT o_is_driver BOOLEAN,
    OUT o_is_passenger BOOLEAN
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_admin_count INT DEFAULT 0;
    DECLARE v_driver_count INT DEFAULT 0;
    DECLARE v_passenger_count INT DEFAULT 0;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SET o_is_admin = FALSE;
        SET o_is_driver = FALSE;
        SET o_is_passenger = FALSE;
    ELSE
        -- Check all types
        SELECT COUNT(*) INTO v_admin_count
        FROM ADMIN
        WHERE person_id = v_person_id;
        
        SELECT COUNT(*) INTO v_driver_count
        FROM carpooling_pu.DRIVER
        WHERE person_id = v_person_id;
        
        SELECT COUNT(*) INTO v_passenger_count
        FROM carpooling_pu.PASSENGER
        WHERE person_id = v_person_id;
        
        SET o_is_admin = (v_admin_count > 0);
        SET o_is_driver = (v_driver_count > 0);
        SET o_is_passenger = (v_passenger_count > 0);
    END IF;
END$$

-- ========================================
-- SECTION 4: PHOTO MANAGEMENT
-- ========================================

-- ========================================
-- PROCEDURE: add_photo
-- Purpose: Adds a photo to a person (can be called by person_id or user_id)
-- ========================================
DROP PROCEDURE IF EXISTS add_photo$$

CREATE PROCEDURE add_photo(
    IN p_person_id INT,
    IN p_image LONGBLOB,
    OUT o_photo_id INT
)
BEGIN
    DECLARE v_person_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate that person exists
    SELECT COUNT(*) INTO v_person_count
    FROM PERSON
    WHERE id = p_person_id;
    
    IF v_person_count = 0 THEN
        SET v_error_msg = CONCAT('Person with ID ', p_person_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Validate image data
    IF p_image IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Image data cannot be null.';
    END IF;
    
    -- Insert photo
    INSERT INTO carpooling_pu.PHOTO (
        image,
        person_id,
        creation_date,
        creator
    ) VALUES (
        p_image,
        p_person_id,
        CURDATE(),
        COALESCE(@app_user, USER())
    );
    
    SET o_photo_id = LAST_INSERT_ID();
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: add_user_photo
-- Purpose: Adds a photo to a user (wrapper that gets person_id from user_id)
-- ========================================
DROP PROCEDURE IF EXISTS add_user_photo$$

CREATE PROCEDURE add_user_photo(
    IN p_user_id INT,
    IN p_image LONGBLOB,
    OUT o_photo_id INT
)
BEGIN
    DECLARE v_person_id INT;
    
    -- Get person_id from user
    SELECT person_id INTO v_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_person_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found.';
    END IF;
    
    -- Call the main add_photo procedure
    CALL add_photo(v_person_id, p_image, o_photo_id);
END$$

-- ========================================
-- PROCEDURE: get_photos
-- Purpose: Gets all photos for a person
-- ========================================
DROP PROCEDURE IF EXISTS get_photos$$

CREATE PROCEDURE get_photos(
    IN p_person_id INT
)
BEGIN
    SELECT 
        ph.id,
        ph.image,
        ph.creation_date,
        ph.creator,
        ph.modification_date,
        ph.modifier
    FROM carpooling_pu.PHOTO ph
    WHERE ph.person_id = p_person_id
    ORDER BY ph.creation_date DESC;
END$$

-- ========================================
-- PROCEDURE: get_user_photos
-- Purpose: Gets all photos for a user
-- ========================================
DROP PROCEDURE IF EXISTS get_user_photos$$

CREATE PROCEDURE get_user_photos(
    IN p_user_id INT
)
BEGIN
    SELECT 
        ph.id,
        ph.image,
        ph.creation_date,
        ph.creator,
        ph.modification_date,
        ph.modifier
    FROM carpooling_pu.PERSONUSER u
    INNER JOIN carpooling_pu.PHOTO ph ON u.person_id = ph.person_id
    WHERE u.id = p_user_id
    ORDER BY ph.creation_date DESC;
END$$

-- ========================================
-- PROCEDURE: get_latest_photo
-- Purpose: Gets the most recent photo for a person (profile picture)
-- ========================================
DROP PROCEDURE IF EXISTS get_latest_photo$$

CREATE PROCEDURE get_latest_photo(
    IN p_person_id INT
)
BEGIN
    SELECT 
        ph.id,
        ph.image,
        ph.creation_date,
        ph.creator,
        ph.modification_date,
        ph.modifier
    FROM carpooling_pu.PHOTO ph
    WHERE ph.person_id = p_person_id
    ORDER BY ph.creation_date DESC, ph.id DESC
    LIMIT 1;
END$$

-- ========================================
-- PROCEDURE: delete_photo
-- Purpose: Deletes a specific photo
-- ========================================
DROP PROCEDURE IF EXISTS delete_photo$$

CREATE PROCEDURE delete_photo(
    IN p_photo_id INT
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
    
    -- Delete photo
    DELETE FROM carpooling_pu.PHOTO 
    WHERE id = p_photo_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Photo with ID ', p_photo_id, ' not found for deletion.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- SECTION 5: SEARCH & QUERY FUNCTIONS
-- ========================================

-- ========================================
-- PROCEDURE: find_person_by_id
-- Purpose: Retrieves a person by their ID with related information
-- ========================================
DROP PROCEDURE IF EXISTS find_person_by_id$$

CREATE PROCEDURE find_person_by_id(
    IN p_person_id INT
)
BEGIN
    SELECT 
        p.id,
        p.first_name,
        p.second_name,
        p.first_surname,
        p.second_surname,
        p.identification_number,
        p.date_of_birth,
        p.creation_date,
        p.creator,
        p.modification_date,
        p.modifier,
        g.id as gender_id,
        g.name as gender_name,
        ti.id as type_identification_id,
        ti.name as type_identification_name
    FROM PERSON p
    INNER JOIN GENDER g ON p.gender_id = g.id
    INNER JOIN TYPE_IDENTIFICATION ti ON p.type_identification_id = ti.id
    WHERE p.id = p_person_id;
END$$

-- ========================================
-- PROCEDURE: get_user_profile_data
-- Purpose: Gets complete profile data for a user
-- ========================================
DROP PROCEDURE IF EXISTS get_user_profile_data$$

CREATE PROCEDURE get_user_profile_data(
    IN p_user_id INT
)
BEGIN
    SELECT 
        p.first_name,
        p.second_name,
        p.first_surname,
        p.second_surname,
        p.identification_number,
        ti.name as id_type_name,
        p.date_of_birth,
        g.name as gender_name,
        i.name as institution_name,
        u.username,
        u.creation_date as user_creation_date
    FROM carpooling_pu.PERSONUSER u
    INNER JOIN PERSON p ON u.person_id = p.id
    INNER JOIN TYPE_IDENTIFICATION ti ON p.type_identification_id = ti.id
    INNER JOIN GENDER g ON p.gender_id = g.id
    INNER JOIN carpooling_pu.INSTITUTION_PERSON ip ON p.id = ip.person_id
    INNER JOIN INSTITUTION i ON ip.institution_id = i.id
    WHERE u.id = p_user_id;
END$$

-- ========================================
-- SECTION 6: UTILITY FUNCTIONS
-- ========================================

-- ========================================
-- PROCEDURE: change_password
-- Purpose: Changes a user's password
-- ========================================
DROP PROCEDURE IF EXISTS change_password$$

CREATE PROCEDURE change_password(
    IN p_user_id INT,
    IN p_old_password VARCHAR(50),
    IN p_new_password VARCHAR(50)
)
BEGIN
    DECLARE v_current_password VARCHAR(50);
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Validate new password
    IF p_new_password IS NULL OR TRIM(p_new_password) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'New password cannot be empty.';
    END IF;
    
    -- Get current password
    SELECT password INTO v_current_password
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
    
    IF v_current_password IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found.';
    END IF;
    
    -- Verify old password
    IF v_current_password != p_old_password THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Current password is incorrect.';
    END IF;
    
    -- Update password
    UPDATE carpooling_pu.PERSONUSER 
    SET password = p_new_password,
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_user_id;
    
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Failed to update password.';
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: check_username_available
-- Purpose: Checks if a username is available
-- ========================================
DROP PROCEDURE IF EXISTS check_username_available$$

CREATE PROCEDURE check_username_available(
    IN p_username VARCHAR(50),
    OUT o_available BOOLEAN
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.PERSONUSER
    WHERE username = p_username;
    
    SET o_available = (v_count = 0);
END$$

-- ========================================
-- PROCEDURE: delete_person_complete
-- Purpose: Deletes a person and all associated data (cascading delete)
-- ========================================
DROP PROCEDURE IF EXISTS delete_person_complete$$

CREATE PROCEDURE delete_person_complete(
    IN p_person_id INT
)
BEGIN
    DECLARE v_rows_affected INT DEFAULT 0;
    DECLARE v_user_count INT DEFAULT 0;
    DECLARE v_admin_count INT DEFAULT 0;
    DECLARE v_driver_count INT DEFAULT 0;
    DECLARE v_passenger_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Check if person has associated user account
    SELECT COUNT(*) INTO v_user_count
    FROM carpooling_pu.PERSONUSER
    WHERE person_id = p_person_id;
    
    -- Check if person is admin
    SELECT COUNT(*) INTO v_admin_count
    FROM ADMIN
    WHERE person_id = p_person_id;
    
    -- Check if person is driver
    SELECT COUNT(*) INTO v_driver_count
    FROM carpooling_pu.DRIVER
    WHERE person_id = p_person_id;
    
    -- Check if person is passenger
    SELECT COUNT(*) INTO v_passenger_count
    FROM carpooling_pu.PASSENGER
    WHERE person_id = p_person_id;
    
    IF v_user_count > 0 OR v_admin_count > 0 OR v_driver_count > 0 OR v_passenger_count > 0 THEN
        SET v_error_msg = CONCAT('Cannot delete person ID ', p_person_id, ' because it has associated user data.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    -- Delete associated photos first (cascade delete)
    DELETE FROM carpooling_pu.PHOTO WHERE person_id = p_person_id;
    
    -- Delete person
    DELETE FROM PERSON WHERE id = p_person_id;
    SET v_rows_affected = ROW_COUNT();
    
    IF v_rows_affected = 0 THEN
        SET v_error_msg = CONCAT('Person with ID ', p_person_id, ' not found for deletion.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    
    COMMIT;
END$$

-- ========================================
-- SECTION 7: PERSON RELATIONSHIP DATA
-- ========================================

-- ========================================
-- PROCEDURE: get_person_emails
-- Purpose: Gets all email addresses for a person with their domains
-- ========================================
DROP PROCEDURE IF EXISTS get_person_emails$$

CREATE PROCEDURE get_person_emails(
    IN p_person_id INT
)
BEGIN
    SELECT 
        e.id,
        e.name as email_name,
        d.name as domain_name,
        CONCAT(e.name, '@', d.name) as full_email,
        e.creation_date,
        e.creator,
        e.modification_date,
        e.modifier
    FROM carpooling_pu.EMAIL e
    INNER JOIN carpooling_adm.DOMAIN d ON e.domain_id = d.id
    WHERE e.person_id = p_person_id
    ORDER BY e.creation_date DESC;
END$$

-- ========================================
-- PROCEDURE: get_person_emails_detail
-- Purpose: Obtiene emails con domain_id (para edición)
-- ========================================
DROP PROCEDURE IF EXISTS get_person_emails_detail$$

CREATE PROCEDURE get_person_emails_detail(
    IN p_person_id INT
)
BEGIN
    SELECT 
        e.id,
        e.name           AS email_name,
        d.id             AS domain_id,
        d.name           AS domain_name,
        CONCAT(e.name, '@', d.name) AS full_email,
        e.creation_date
    FROM carpooling_pu.EMAIL e
    INNER JOIN carpooling_adm.DOMAIN d ON e.domain_id = d.id
    WHERE e.person_id = p_person_id
    ORDER BY e.creation_date DESC;
END$$

-- ========================================
-- PROCEDURE: get_person_phones
-- Purpose: Gets all phone numbers for a person with their types
-- ========================================
DROP PROCEDURE IF EXISTS get_person_phones$$

CREATE PROCEDURE get_person_phones(
    IN p_person_id INT
)
BEGIN
    SELECT 
        p.id,
        p.phone_number,
        tp.id as type_phone_id,
        tp.name as type_phone_name,
        p.creation_date,
        p.creator,
        p.modification_date,
        p.modifier
    FROM carpooling_pu.PHONE p
    INNER JOIN carpooling_adm.TYPE_PHONE tp ON p.type_phone_id = tp.id
    INNER JOIN carpooling_pu.PHONE_PERSON pp ON p.id = pp.phone_id
    WHERE pp.person_id = p_person_id
    ORDER BY p.creation_date DESC;
END$$

-- ========================================
-- PROCEDURE: get_person_institutions
-- Purpose: Gets all institutions associated with a person
-- ========================================
DROP PROCEDURE IF EXISTS get_person_institutions$$

CREATE PROCEDURE get_person_institutions(
    IN p_person_id INT
)
BEGIN
    SELECT 
        i.id,
        i.name,
        i.creation_date,
        i.creator,
        i.modification_date,
        i.modifier,
        ip.creation_date as association_date
    FROM carpooling_adm.INSTITUTION i
    INNER JOIN carpooling_pu.INSTITUTION_PERSON ip ON i.id = ip.institution_id
    WHERE ip.person_id = p_person_id
    ORDER BY ip.creation_date DESC;
END$$

-- ========================================
-- PROCEDURE: get_person_complete_profile
-- Purpose: Gets complete profile information for a person including related data
-- ========================================
DROP PROCEDURE IF EXISTS get_person_complete_profile$$

CREATE PROCEDURE get_person_complete_profile(
    IN p_person_id INT
)
BEGIN
    -- First result set: Basic person information
    SELECT 
        p.id,
        p.first_name,
        p.second_name,
        p.first_surname,
        p.second_surname,
        p.identification_number,
        p.date_of_birth,
        p.creation_date,
        p.creator,
        p.modification_date,
        p.modifier,
        g.id as gender_id,
        g.name as gender_name,
        ti.id as type_identification_id,
        ti.name as type_identification_name
    FROM PERSON p
    INNER JOIN GENDER g ON p.gender_id = g.id
    INNER JOIN TYPE_IDENTIFICATION ti ON p.type_identification_id = ti.id
    WHERE p.id = p_person_id;
    
    -- Second result set: Emails
    SELECT 
        e.id,
        e.name as email_name,
        d.name as domain_name,
        CONCAT(e.name, '@', d.name) as full_email
    FROM carpooling_pu.EMAIL e
    INNER JOIN carpooling_adm.DOMAIN d ON e.domain_id = d.id
    WHERE e.person_id = p_person_id
    ORDER BY e.creation_date DESC;
    
    -- Third result set: Phones
    SELECT 
        p.id,
        p.phone_number,
        tp.name as type_phone_name
    FROM carpooling_pu.PHONE p
    INNER JOIN carpooling_adm.TYPE_PHONE tp ON p.type_phone_id = tp.id
    INNER JOIN carpooling_pu.PHONE_PERSON pp ON p.id = pp.phone_id
    WHERE pp.person_id = p_person_id
    ORDER BY p.creation_date DESC;
    
    -- Fourth result set: Institutions
    SELECT 
        i.id,
        i.name
    FROM carpooling_adm.INSTITUTION i
    INNER JOIN carpooling_pu.INSTITUTION_PERSON ip ON i.id = ip.institution_id
    WHERE ip.person_id = p_person_id
    ORDER BY ip.creation_date DESC;
END$$

-- ========================================
-- SECTION 8: UPDATE & DELETE OPERATIONS
-- ========================================

-- ========================================
-- PROCEDURE: update_person
-- Purpose: Updates an existing person record
-- ========================================
DROP PROCEDURE IF EXISTS update_person$$

CREATE PROCEDURE update_person(
    IN p_person_id INT,
    IN p_first_name VARCHAR(50),
    IN p_second_name VARCHAR(50),
    IN p_first_surname VARCHAR(50),
    IN p_second_surname VARCHAR(50),
    IN p_id_type_id INT,
    IN p_id_number VARCHAR(50),
    IN p_date_of_birth DATE,
    IN p_gender_id INT
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    DECLARE v_dup_id INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Check person exists
    SELECT COUNT(*) INTO v_exists FROM PERSON WHERE id = p_person_id;
    IF v_exists = 0 THEN
        SET v_error_msg = CONCAT('Person with ID ', p_person_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Validate unique identification number (excluding current person)
    IF p_id_number IS NOT NULL AND TRIM(p_id_number) <> '' THEN
        SELECT COUNT(*) INTO v_dup_id FROM PERSON 
        WHERE identification_number = p_id_number AND id <> p_person_id;
        IF v_dup_id > 0 THEN
            SET v_error_msg = 'Identification number already exists for another person.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
        END IF;
    END IF;

    -- Validate referenced data exists
    IF p_gender_id IS NOT NULL THEN
        SELECT COUNT(*) INTO v_exists FROM GENDER WHERE id = p_gender_id;
        IF v_exists = 0 THEN
            SET v_error_msg = CONCAT('Gender with ID ', p_gender_id, ' does not exist.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
        END IF;
    END IF;

    IF p_id_type_id IS NOT NULL THEN
        SELECT COUNT(*) INTO v_exists FROM TYPE_IDENTIFICATION WHERE id = p_id_type_id;
        IF v_exists = 0 THEN
            SET v_error_msg = CONCAT('Identification type with ID ', p_id_type_id, ' does not exist.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
        END IF;
    END IF;

    -- Perform update
    UPDATE PERSON
    SET first_name            = TRIM(p_first_name),
        second_name           = CASE WHEN p_second_name IS NULL THEN NULL ELSE TRIM(p_second_name) END,
        first_surname         = TRIM(p_first_surname),
        second_surname        = CASE WHEN p_second_surname IS NULL THEN NULL ELSE TRIM(p_second_surname) END,
        identification_number = p_id_number,
        date_of_birth         = p_date_of_birth,
        gender_id             = p_gender_id,
        type_identification_id= p_id_type_id,
        modification_date     = CURDATE(),
        modifier              = COALESCE(@app_user, USER())
    WHERE id = p_person_id;

    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_user_username
-- Purpose: Updates username of an existing user (password handled separately)
-- ========================================
DROP PROCEDURE IF EXISTS update_user_username$$

CREATE PROCEDURE update_user_username(
    IN p_user_id INT,
    IN p_new_username VARCHAR(50)
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Validate new username
    IF p_new_username IS NULL OR TRIM(p_new_username) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'New username cannot be empty.';
    END IF;

    -- Check if user exists
    SELECT COUNT(*) INTO v_count FROM carpooling_pu.PERSONUSER WHERE id = p_user_id;
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('User with ID ', p_user_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Check if new username already exists
    SELECT COUNT(*) INTO v_count FROM carpooling_pu.PERSONUSER WHERE username = p_new_username AND id <> p_user_id;
    IF v_count > 0 THEN
        SET v_error_msg = 'Username already taken.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Update username
    UPDATE carpooling_pu.PERSONUSER
    SET username = p_new_username,
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_user_id;

    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_email
-- Purpose: Updates an email record (name and/or domain)
-- ========================================
DROP PROCEDURE IF EXISTS update_email$$

CREATE PROCEDURE update_email(
    IN p_email_id INT,
    IN p_new_name VARCHAR(100),
    IN p_new_domain_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Validate email exists
    SELECT COUNT(*) INTO v_count FROM carpooling_pu.EMAIL WHERE id = p_email_id;
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('Email with ID ', p_email_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Validate domain exists
    SELECT COUNT(*) INTO v_count FROM carpooling_adm.DOMAIN WHERE id = p_new_domain_id;
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('Domain with ID ', p_new_domain_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    UPDATE carpooling_pu.EMAIL
    SET name = TRIM(p_new_name),
        domain_id = p_new_domain_id,
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_email_id;

    COMMIT;
END$$

-- ========================================
-- PROCEDURE: update_phone
-- Purpose: Updates a phone record (number and/or type)
-- ========================================
DROP PROCEDURE IF EXISTS update_phone$$

CREATE PROCEDURE update_phone(
    IN p_phone_id INT,
    IN p_new_number VARCHAR(20),
    IN p_new_type_phone_id INT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Validate phone exists
    SELECT COUNT(*) INTO v_count FROM carpooling_pu.PHONE WHERE id = p_phone_id;
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('Phone with ID ', p_phone_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Validate phone type exists
    SELECT COUNT(*) INTO v_count FROM carpooling_adm.TYPE_PHONE WHERE id = p_new_type_phone_id;
    IF v_count = 0 THEN
        SET v_error_msg = CONCAT('Type phone with ID ', p_new_type_phone_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    UPDATE carpooling_pu.PHONE
    SET phone_number = p_new_number,
        type_phone_id = p_new_type_phone_id,
        modification_date = CURDATE(),
        modifier = COALESCE(@app_user, USER())
    WHERE id = p_phone_id;

    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_user
-- Purpose: Deletes a user account (PERSONUSER) if not admin, driver or passenger
-- ========================================
DROP PROCEDURE IF EXISTS delete_user$$

CREATE PROCEDURE delete_user(
    IN p_user_id INT
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_admin_cnt INT DEFAULT 0;
    DECLARE v_driver_cnt INT DEFAULT 0;
    DECLARE v_passenger_cnt INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Get person_id
    SELECT person_id INTO v_person_id FROM carpooling_pu.PERSONUSER WHERE id = p_user_id;
    IF v_person_id IS NULL THEN
        SET v_error_msg = CONCAT('User with ID ', p_user_id, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    -- Cannot delete if admin/driver/passenger
    SELECT COUNT(*) INTO v_admin_cnt FROM ADMIN WHERE person_id = v_person_id;
    SELECT COUNT(*) INTO v_driver_cnt FROM carpooling_pu.DRIVER WHERE person_id = v_person_id;
    SELECT COUNT(*) INTO v_passenger_cnt FROM carpooling_pu.PASSENGER WHERE person_id = v_person_id;

    IF v_admin_cnt > 0 OR v_driver_cnt > 0 OR v_passenger_cnt > 0 THEN
        SET v_error_msg = 'Cannot delete user because person has role assignments.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;

    DELETE FROM carpooling_pu.PERSONUSER WHERE id = p_user_id;

    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_email
-- Purpose: Deletes a single email record
-- ========================================
DROP PROCEDURE IF EXISTS delete_email$$

CREATE PROCEDURE delete_email(
    IN p_email_id INT
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    DELETE FROM carpooling_pu.EMAIL WHERE id = p_email_id;
    SET v_rows = ROW_COUNT();
    IF v_rows = 0 THEN
        SET v_error_msg = CONCAT('Email with ID ', p_email_id, ' not found for deletion.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: delete_phone
-- Purpose: Deletes a single phone record (and relationship)
-- ========================================
DROP PROCEDURE IF EXISTS delete_phone$$

CREATE PROCEDURE delete_phone(
    IN p_phone_id INT
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE v_error_msg VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    -- Delete relationship first
    DELETE FROM carpooling_pu.PHONE_PERSON WHERE phone_id = p_phone_id;
    -- Delete phone itself
    DELETE FROM carpooling_pu.PHONE WHERE id = p_phone_id;
    SET v_rows = ROW_COUNT();
    IF v_rows = 0 THEN
        SET v_error_msg = CONCAT('Phone with ID ', p_phone_id, ' not found for deletion.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
    END IF;
    COMMIT;
END$$

-- ========================================
-- PROCEDURE: list_users_basic
-- Purpose: Devuelve ID de usuario y nombre completo (para listados rápidos)
-- ========================================
DROP PROCEDURE IF EXISTS list_users_basic$$

CREATE PROCEDURE list_users_basic()
BEGIN
    SELECT 
        u.id          AS user_id,
        CONCAT(p.first_name, ' ', p.first_surname) AS full_name
    FROM carpooling_pu.PERSONUSER u
    INNER JOIN PERSON p ON p.id = u.person_id
    ORDER BY full_name;
END$$

-- ========================================
-- PROCEDURE: get_person_id_by_user
-- Purpose: Obtiene el person_id a partir del user_id (OUT)
-- ========================================
DROP PROCEDURE IF EXISTS get_person_id_by_user$$

CREATE PROCEDURE get_person_id_by_user(
    IN p_user_id INT,
    OUT o_person_id INT
)
BEGIN
    SELECT person_id INTO o_person_id
    FROM carpooling_pu.PERSONUSER
    WHERE id = p_user_id;
END$$

-- Reset delimiter
DELIMITER ;

/*
================================================================================
 USAGE EXAMPLES
================================================================================

-- ========================================
-- SECTION 1: BASIC PERSON OPERATIONS
-- ========================================

-- Create a basic person
CALL create_person(
    'María', 'Elena', 'González', 'López',
    '987654321', '1995-03-15', 2, 1, @person_id
);

-- ========================================
-- SECTION 2: COMPLETE USER REGISTRATION
-- ========================================

-- Register a complete user with all data
CALL register_complete_user(
    'Juan', 'Carlos', 'Pérez', 'González',
    1, '123456789', 1, '88888888', 'juan.perez',
    '1990-01-01', 1, 1, 1, 'jperez', 'password123',
    @person_id, @user_id
);

-- Authenticate user
CALL authenticate_user('jperez', 'password123');

-- ========================================
-- SECTION 3: USER TYPE MANAGEMENT
-- ========================================

-- Register user as driver
CALL register_as_driver(@user_id);

-- Register user as passenger
CALL register_as_passenger(@user_id);

-- Check if user is admin
CALL is_admin(@user_id, @is_admin);

-- Get user type (primary type)
CALL get_user_type(@user_id, @user_type);

-- Check specific user types
CALL is_driver(@user_id, @is_driver);
CALL is_passenger(@user_id, @is_passenger);

-- Get all user types at once
CALL get_user_types_all(@user_id, @is_admin, @is_driver, @is_passenger);

-- ========================================
-- SECTION 4: PHOTO MANAGEMENT
-- ========================================

-- Add photo to user
SET @image_data = 'dummy_binary_image_data';
CALL add_user_photo(@user_id, @image_data, @photo_id);

-- Get all user photos
CALL get_user_photos(@user_id);

-- Get latest photo (profile picture)
CALL get_latest_photo(@person_id);

-- Delete photo
CALL delete_photo(@photo_id);

-- ========================================
-- SECTION 5: PROFILE & UTILITY FUNCTIONS
-- ========================================

-- Get user profile data
CALL get_user_profile_data(@user_id);

-- Find person by ID
CALL find_person_by_id(@person_id);

-- Change password
CALL change_password(@user_id, 'password123', 'newpassword456');

-- Check username availability
CALL check_username_available('newusername', @available);

-- Delete person completely (only if no dependencies)
CALL delete_person_complete(@person_id);

-- ========================================
-- SECTION 6: PERSON RELATIONSHIP DATA
-- ========================================

-- Get person emails
CALL get_person_emails(@person_id);

-- Get person phones
CALL get_person_phones(@person_id);

-- Get person institutions
CALL get_person_institutions(@person_id);

-- Get complete profile with all related data
CALL get_person_complete_profile(@person_id);

================================================================================
*/ 