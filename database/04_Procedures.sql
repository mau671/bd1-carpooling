-- Execute as ADM or a user with the right privileges
CREATE OR REPLACE TYPE ADM.ID_TABLE_TYPE AS TABLE OF NUMBER;
/
GRANT EXECUTE ON ADM.ID_TABLE_TYPE TO PU;
/

---------------------------------------------------------------------------
-- Package Specification: ADM_DOMAIN_MGMT_PKG
-- Purpose: Manages operations related to domains in the system
-- Author: System Administrator
-- Created: [Date]
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE ADM.ADM_DOMAIN_MGMT_PKG AS

  -- Cursor type for returning result sets
  TYPE ref_cursor_type IS REF CURSOR;

  /**
  * Registers a new domain in the system
  * 
  * @param p_domain_name  The name of the domain to register
  * @param o_domain_id    Output parameter returning the newly created domain ID
  */
  PROCEDURE register_domain (
    p_domain_name IN ADM.DOMAIN.name%TYPE,
    o_domain_id   OUT ADM.DOMAIN.id%TYPE
  );

  /**
  * Deletes a domain by its ID
  * 
  * @param p_domain_id    The ID of the domain to delete
  */
  PROCEDURE delete_domain (
    p_domain_id IN ADM.DOMAIN.id%TYPE
  );

  /**
  * Finds a domain by its ID and returns a cursor
  * 
  * @param p_domain_id    The ID of the domain to find
  * @return               A cursor containing the domain data
  */
  FUNCTION find_domain_by_id_cursor (
    p_domain_id IN ADM.DOMAIN.id%TYPE
  ) RETURN ref_cursor_type;

  /**
  * Retrieves all domains in the system
  * 
  * @return               A cursor containing all domains
  */
  FUNCTION find_all_domains_cursor
  RETURN ref_cursor_type;

END ADM_DOMAIN_MGMT_PKG;
/

---------------------------------------------------------------------------
-- Package Body: ADM_DOMAIN_MGMT_PKG
-- Implementation of domain management functionality
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY ADM.ADM_DOMAIN_MGMT_PKG AS

  PROCEDURE register_domain (
    p_domain_name IN ADM.DOMAIN.name%TYPE,
    o_domain_id   OUT ADM.DOMAIN.id%TYPE
  ) AS
    v_name ADM.DOMAIN.name%TYPE;
  BEGIN
    -- Normalize the domain name (trim and lowercase)
    v_name := TRIM(LOWER(p_domain_name));
    
    -- Validate input
    IF v_name IS NULL THEN
       RAISE_APPLICATION_ERROR(-20101, 'Domain name cannot be empty.');
    END IF;

    -- Insert the new domain and return the ID
    INSERT INTO ADM.DOMAIN (name) VALUES (v_name) RETURNING id INTO o_domain_id;
    COMMIT;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      ROLLBACK; 
      RAISE_APPLICATION_ERROR(-20102, 'Domain ''' || v_name || ''' already exists.');
    WHEN OTHERS THEN
      ROLLBACK; 
      RAISE;
  END register_domain;

  PROCEDURE delete_domain (
    p_domain_id IN ADM.DOMAIN.id%TYPE
  ) AS
  BEGIN
    -- Delete the domain with the specified ID
    DELETE FROM ADM.DOMAIN WHERE id = p_domain_id;
    
    -- Check if a domain was actually deleted
    IF SQL%ROWCOUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20111, 'Domain with ID ' || p_domain_id || ' not found for deletion.');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      -- Handle foreign key constraint violation
      IF SQLCODE = -2292 THEN
         ROLLBACK; 
         RAISE_APPLICATION_ERROR(-20112, 'Cannot delete domain ID ' || p_domain_id || ' because it is associated with institutions.');
      ELSE
         ROLLBACK; 
         RAISE;
      END IF;
  END delete_domain;

  FUNCTION find_domain_by_id_cursor (
    p_domain_id IN ADM.DOMAIN.id%TYPE
  ) RETURN ref_cursor_type
  AS
    v_cursor ref_cursor_type;
  BEGIN
    -- Open a cursor with domain information
    OPEN v_cursor FOR
      SELECT id, name
      FROM ADM.DOMAIN
      WHERE id = p_domain_id;
    RETURN v_cursor;
  EXCEPTION
     WHEN OTHERS THEN
       -- Ensure cursor is closed on error
       IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
       RAISE;
  END find_domain_by_id_cursor;

  FUNCTION find_all_domains_cursor
  RETURN ref_cursor_type
  AS
    v_cursor ref_cursor_type;
  BEGIN
    -- Open a cursor with all domains, sorted by name
    OPEN v_cursor FOR
      SELECT id, name
      FROM ADM.DOMAIN
      ORDER BY name;
    RETURN v_cursor;
  EXCEPTION
    WHEN OTHERS THEN
       -- Ensure cursor is closed on error
       IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
       RAISE;
  END find_all_domains_cursor;

END ADM_DOMAIN_MGMT_PKG;
/

-- Grant execution permission to the application user
GRANT EXECUTE ON ADM.ADM_DOMAIN_MGMT_PKG TO PU;
/

---------------------------------------------------------------------------
-- Package Specification: ADM_INSTITUTION_MGMT_PKG
-- Purpose: Manages operations related to institutions in the system
-- Author: System Administrator
-- Created: [Date]
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE ADM.ADM_INSTITUTION_MGMT_PKG AS

  -- Types
  TYPE ref_cursor_type IS REF CURSOR; -- Cursor Type

  -- *** BASIC CRUD OPERATIONS FOR INSTITUTION ***
  
  /**
  * Creates a new institution
  * 
  * @param p_institution_name  The name of the institution to create
  * @param o_institution_id    Output parameter returning the newly created institution ID
  */
  PROCEDURE create_institution (
      p_institution_name IN ADM.INSTITUTION.name%TYPE,
      o_institution_id   OUT ADM.INSTITUTION.id%TYPE
  );

  /**
  * Updates an institution's name
  * 
  * @param p_institution_id    The ID of the institution to update
  * @param p_new_name          The new name for the institution
  */
  PROCEDURE update_institution_name (
      p_institution_id   IN ADM.INSTITUTION.id%TYPE,
      p_new_name         IN ADM.INSTITUTION.name%TYPE
  );

  /**
  * Deletes an institution by its ID
  * 
  * @param p_institution_id    The ID of the institution to delete
  */
  PROCEDURE delete_institution (
      p_institution_id IN ADM.INSTITUTION.id%TYPE
  );

  -- *** QUERY FUNCTIONS (Return Cursors) ***
  
  /**
  * Finds an institution by its ID
  * 
  * @param p_institution_id    The ID of the institution to find
  * @return                    A cursor containing the institution data
  */
  FUNCTION find_institution_by_id_cursor (
      p_institution_id IN ADM.INSTITUTION.id%TYPE
  ) RETURN ref_cursor_type;

  /**
  * Retrieves all institutions in the system
  * 
  * @return    A cursor containing all institutions
  */
  FUNCTION find_all_institutions_cursor
  RETURN ref_cursor_type;

  -- *** DOMAIN MANAGEMENT ***
   
  /**
  * Updates the domains associated with an institution
  * 
  * @param p_institution_id    The ID of the institution to update
  * @param p_new_domain_ids    Table of domain IDs to associate with the institution
  */
  PROCEDURE update_institution_domains (
     p_institution_id IN ADM.INSTITUTION.id%TYPE,
     p_new_domain_ids IN ADM.ID_TABLE_TYPE
  );

  /**
  * Gets all domain IDs associated with an institution
  * 
  * @param p_institution_id    The ID of the institution
  * @return                    A cursor containing the associated domain IDs
  */
  FUNCTION get_assoc_domain_ids_cur (
     p_institution_id IN ADM.INSTITUTION.id%TYPE
  ) RETURN ref_cursor_type;

END ADM_INSTITUTION_MGMT_PKG;
/


---------------------------------------------------------------------------
-- Package Body: ADM_INSTITUTION_MGMT_PKG
-- Implementation of institution management functionality
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY ADM.ADM_INSTITUTION_MGMT_PKG AS

  -- *** IMPLEMENTATION OF BASIC INSTITUTION CRUD OPERATIONS ***
  PROCEDURE create_institution (
      p_institution_name IN ADM.INSTITUTION.name%TYPE,
      o_institution_id   OUT ADM.INSTITUTION.id%TYPE
  ) AS
  BEGIN
      -- Validate input
      IF p_institution_name IS NULL OR TRIM(p_institution_name) IS NULL THEN
          RAISE_APPLICATION_ERROR(-20041, 'Institution name cannot be empty.');
      END IF;
      
      -- Insert the new institution and return the ID
      INSERT INTO ADM.INSTITUTION (name) 
      VALUES (TRIM(p_institution_name)) 
      RETURNING id INTO o_institution_id;
      COMMIT;
  EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN 
          ROLLBACK; 
          RAISE_APPLICATION_ERROR(-20042, 'Institution ''' || TRIM(p_institution_name) || ''' already exists.');
      WHEN OTHERS THEN 
          ROLLBACK; 
          RAISE;
  END create_institution;

  PROCEDURE update_institution_name (
      p_institution_id   IN ADM.INSTITUTION.id%TYPE,
      p_new_name         IN ADM.INSTITUTION.name%TYPE
  ) AS
    v_name ADM.INSTITUTION.name%TYPE;
  BEGIN
      -- Normalize and validate the new name
      v_name := TRIM(p_new_name);
      IF v_name IS NULL THEN 
          RAISE_APPLICATION_ERROR(-20051, 'New institution name cannot be empty.'); 
      END IF;
      
      -- Update the institution name
      UPDATE ADM.INSTITUTION 
      SET name = v_name 
      WHERE id = p_institution_id;
      
      -- Check if an institution was actually updated
      IF SQL%ROWCOUNT = 0 THEN 
          RAISE_APPLICATION_ERROR(-20052, 'Institution with ID ' || p_institution_id || ' not found for update.'); 
      END IF;
      COMMIT;
  EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN 
          ROLLBACK; 
          RAISE_APPLICATION_ERROR(-20053, 'The name ''' || v_name || ''' is already in use.');
      WHEN OTHERS THEN 
          ROLLBACK; 
          RAISE;
  END update_institution_name;

  PROCEDURE delete_institution (
      p_institution_id IN ADM.INSTITUTION.id%TYPE
  ) AS
  BEGIN
      -- First delete associated domain relations
      DELETE FROM ADM.INSTITUTION_DOMAIN WHERE institution_id = p_institution_id;
      
      -- Then delete the institution itself
      DELETE FROM ADM.INSTITUTION WHERE id = p_institution_id;
      
      -- Check if an institution was actually deleted
      IF SQL%ROWCOUNT = 0 THEN 
          RAISE_APPLICATION_ERROR(-20061, 'Institution with ID ' || p_institution_id || ' not found for deletion.'); 
      END IF;
      COMMIT;
  EXCEPTION
      WHEN OTHERS THEN
          -- Handle foreign key constraint violation
          IF SQLCODE = -2292 THEN 
              ROLLBACK; 
              RAISE_APPLICATION_ERROR(-20062, 'Cannot delete institution ID ' || p_institution_id || ' because it is associated with users or other data.');
          ELSE 
              ROLLBACK; 
              RAISE; 
          END IF;
  END delete_institution;

  -- *** IMPLEMENTATION OF INSTITUTION QUERY FUNCTIONS (WITH CURSOR) ***
  FUNCTION find_institution_by_id_cursor (
      p_institution_id IN ADM.INSTITUTION.id%TYPE
  ) RETURN ref_cursor_type
  AS
      v_cursor ref_cursor_type;
  BEGIN
      -- Open a cursor with institution information
      OPEN v_cursor FOR 
          SELECT id, name 
          FROM ADM.INSTITUTION 
          WHERE id = p_institution_id;
      RETURN v_cursor;
  EXCEPTION
      WHEN OTHERS THEN 
          -- Ensure cursor is closed on error
          IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
          RAISE;
  END find_institution_by_id_cursor;

  FUNCTION find_all_institutions_cursor
  RETURN ref_cursor_type
  AS
      v_cursor ref_cursor_type;
  BEGIN
      -- Open a cursor with all institutions, sorted by name
      OPEN v_cursor FOR 
          SELECT id, name 
          FROM ADM.INSTITUTION 
          ORDER BY name;
      RETURN v_cursor;
  EXCEPTION
      WHEN OTHERS THEN 
          -- Ensure cursor is closed on error
          IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
          RAISE;
  END find_all_institutions_cursor;

  -- *** IMPLEMENTATION OF DOMAIN MANAGEMENT (WITH CURSOR AND ARRAY) ***
  PROCEDURE update_institution_domains (
     p_institution_id IN ADM.INSTITUTION.id%TYPE,
     p_new_domain_ids IN ADM.ID_TABLE_TYPE
  ) AS
     v_inst_count NUMBER;
  BEGIN
     -- Verify that the institution exists
     SELECT COUNT(*) INTO v_inst_count 
     FROM ADM.INSTITUTION 
     WHERE id = p_institution_id;
     
     IF v_inst_count = 0 THEN 
         RAISE_APPLICATION_ERROR(-20031, 'Institution with ID ' || p_institution_id || ' does not exist.'); 
     END IF;
     
     -- Remove all current domain associations
     DELETE FROM ADM.INSTITUTION_DOMAIN WHERE institution_id = p_institution_id;
     
     -- Add new domain associations if provided
     IF p_new_domain_ids IS NOT NULL AND p_new_domain_ids.COUNT > 0 THEN
       BEGIN
         -- Use FORALL for bulk insert of new domain associations
         FORALL i IN 1..p_new_domain_ids.COUNT
           INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) 
           VALUES (p_institution_id, p_new_domain_ids(i));
       EXCEPTION
         WHEN OTHERS THEN 
             ROLLBACK; 
             RAISE_APPLICATION_ERROR(-20032, 'Error inserting new domain associations for Institution ID ' || 
                                     p_institution_id || '. Verify domain IDs. Error: ' || SQLERRM);
       END;
     END IF;
     COMMIT;
  EXCEPTION 
     WHEN OTHERS THEN 
         ROLLBACK; 
         RAISE;
  END update_institution_domains;

  FUNCTION get_assoc_domain_ids_cur (
     p_institution_id IN ADM.INSTITUTION.id%TYPE
  ) RETURN ref_cursor_type
  AS
     v_cursor ref_cursor_type;
  BEGIN
     -- Open a cursor with domain IDs associated with the institution
     OPEN v_cursor FOR
       SELECT domain_id 
       FROM ADM.INSTITUTION_DOMAIN 
       WHERE institution_id = p_institution_id;
     RETURN v_cursor;
  EXCEPTION
     WHEN OTHERS THEN 
         -- Ensure cursor is closed on error
         IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
         RAISE;
  END get_assoc_domain_ids_cur;

END ADM_INSTITUTION_MGMT_PKG;
/

-- Grant execution permission to the application user
GRANT EXECUTE ON ADM.ADM_INSTITUTION_MGMT_PKG TO PU;
/

-- Package for user authentication and management
CREATE OR REPLACE PACKAGE PU.USER_AUTH_PKG AS
    -- Constants for status codes
    GC_SUCCESS CONSTANT NUMBER := 1;
    GC_FAILURE CONSTANT NUMBER := 0;
    
    -- Procedure to register a new user
    PROCEDURE REGISTER_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_person_id IN NUMBER,
        p_user_id OUT NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to validate user credentials
    PROCEDURE VALIDATE_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_user_id OUT NUMBER,
        p_person_id OUT NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to check if user is a driver
    PROCEDURE CHECK_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_is_driver OUT NUMBER
    );
    
    -- Procedure to check if user is a passenger
    PROCEDURE CHECK_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_is_passenger OUT NUMBER
    );
END USER_AUTH_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.USER_AUTH_PKG AS
    PROCEDURE REGISTER_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_person_id IN NUMBER,
        p_user_id OUT NUMBER,
        p_success OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        -- Check if username already exists
        SELECT COUNT(*) INTO v_count
        FROM PU.PERSONUSER
        WHERE USERNAME = p_username;
        
        IF v_count > 0 THEN
            p_success := GC_FAILURE; -- Username already exists
            RETURN;
        END IF;
        
        -- Insert new user
        INSERT INTO PU.PERSONUSER (USERNAME, PASSWORD, PERSONID)
        VALUES (p_username, p_password, p_person_id)
        RETURNING ID INTO p_user_id;
        
        p_success := GC_SUCCESS; -- Registration successful
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := GC_FAILURE;
            ROLLBACK;
            RAISE;
    END REGISTER_USER;
    
    PROCEDURE VALIDATE_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_user_id OUT NUMBER,
        p_person_id OUT NUMBER,
        p_success OUT NUMBER
    ) IS
    BEGIN
        SELECT ID, PERSONID INTO p_user_id, p_person_id
        FROM PU.PERSONUSER
        WHERE USERNAME = p_username
        AND PASSWORD = p_password;
        
        p_success := GC_SUCCESS; -- Authentication successful
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_success := GC_FAILURE; -- Invalid credentials
            p_user_id := NULL;
            p_person_id := NULL;
        WHEN OTHERS THEN
            p_success := GC_FAILURE;
            RAISE;
    END VALIDATE_USER;
    
    PROCEDURE CHECK_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_is_driver OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM PU.DRIVER
        WHERE PERSONID = p_person_id;
        
        p_is_driver := CASE WHEN v_count > 0 THEN GC_SUCCESS ELSE GC_FAILURE END;
    EXCEPTION
        WHEN OTHERS THEN
            p_is_driver := GC_FAILURE;
            RAISE;
    END CHECK_DRIVER_ROLE;
    
    PROCEDURE CHECK_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_is_passenger OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM PU.PASSENGER
        WHERE PERSONID = p_person_id;
        
        p_is_passenger := CASE WHEN v_count > 0 THEN GC_SUCCESS ELSE GC_FAILURE END;
    EXCEPTION
        WHEN OTHERS THEN
            p_is_passenger := GC_FAILURE;
            RAISE;
    END CHECK_PASSENGER_ROLE;
END USER_AUTH_PKG;
/