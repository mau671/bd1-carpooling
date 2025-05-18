-- ============================================================================
-- TYPES
-- ============================================================================
CREATE OR REPLACE TYPE ADM.ID_TABLE_TYPE AS TABLE OF NUMBER;
/

-- ============================================================================
-- PACKAGE: ADM_GENDER_PKG
-- Purpose: Manages operations related to genders in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_GENDER_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    FUNCTION get_all_genders
    RETURN ref_cursor_type;
END ADM_GENDER_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_GENDER_PKG AS
    FUNCTION get_all_genders
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.GENDER
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_all_genders;
END ADM_GENDER_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_ID_TYPE_PKG
-- Purpose: Manages operations related to identification types in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_ID_TYPE_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    FUNCTION get_all_id_types
    RETURN ref_cursor_type;
END ADM_ID_TYPE_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_ID_TYPE_PKG AS
    FUNCTION get_all_id_types
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.TYPE_IDENTIFICATION
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_all_id_types;
END ADM_ID_TYPE_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_PHONE_TYPE_PKG
-- Purpose: Manages operations related to phone types in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_PHONE_TYPE_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    FUNCTION get_all_phone_types
    RETURN ref_cursor_type;
END ADM_PHONE_TYPE_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_PHONE_TYPE_PKG AS
    FUNCTION get_all_phone_types
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.TYPE_PHONE
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_all_phone_types;
END ADM_PHONE_TYPE_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_DOMAIN_MGMT_PKG
-- Purpose: Manages operations related to domains in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_DOMAIN_MGMT_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    PROCEDURE register_domain (
        p_domain_name IN ADM.DOMAIN.name%TYPE,
        o_domain_id   OUT ADM.DOMAIN.id%TYPE
    );

    PROCEDURE delete_domain (
        p_domain_id IN ADM.DOMAIN.id%TYPE
    );

    FUNCTION find_domain_by_id_cursor (
        p_domain_id IN ADM.DOMAIN.id%TYPE
    ) RETURN ref_cursor_type;

    FUNCTION find_all_domains_cursor
    RETURN ref_cursor_type;
END ADM_DOMAIN_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_DOMAIN_MGMT_PKG AS
    PROCEDURE register_domain (
        p_domain_name IN ADM.DOMAIN.name%TYPE,
        o_domain_id   OUT ADM.DOMAIN.id%TYPE
    ) AS
        v_name ADM.DOMAIN.name%TYPE;
    BEGIN
        v_name := TRIM(LOWER(p_domain_name));
        
        IF v_name IS NULL THEN
           RAISE_APPLICATION_ERROR(-20101, 'Domain name cannot be empty.');
        END IF;

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
        DELETE FROM ADM.DOMAIN WHERE id = p_domain_id;
        
        IF SQL%ROWCOUNT = 0 THEN
             RAISE_APPLICATION_ERROR(-20111, 'Domain with ID ' || p_domain_id || ' not found for deletion.');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
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
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.DOMAIN
            WHERE id = p_domain_id;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END find_domain_by_id_cursor;

    FUNCTION find_all_domains_cursor
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.DOMAIN
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END find_all_domains_cursor;
END ADM_DOMAIN_MGMT_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_INSTITUTION_MGMT_PKG
-- Purpose: Manages operations related to institutions in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_INSTITUTION_MGMT_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    PROCEDURE create_institution (
        p_institution_name IN ADM.INSTITUTION.name%TYPE,
        o_institution_id   OUT ADM.INSTITUTION.id%TYPE
    );

    PROCEDURE update_institution_name (
        p_institution_id   IN ADM.INSTITUTION.id%TYPE,
        p_new_name         IN ADM.INSTITUTION.name%TYPE
    );

    PROCEDURE delete_institution (
        p_institution_id IN ADM.INSTITUTION.id%TYPE
    );

    FUNCTION find_institution_by_id_cursor (
        p_institution_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type;

    FUNCTION find_all_institutions_cursor
    RETURN ref_cursor_type;

    PROCEDURE update_institution_domains (
        p_institution_id IN ADM.INSTITUTION.id%TYPE,
        p_new_domain_ids IN ADM.ID_TABLE_TYPE
    );

    FUNCTION get_assoc_domain_ids_cur (
        p_institution_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type;
END ADM_INSTITUTION_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_INSTITUTION_MGMT_PKG AS
    PROCEDURE create_institution (
        p_institution_name IN ADM.INSTITUTION.name%TYPE,
        o_institution_id   OUT ADM.INSTITUTION.id%TYPE
    ) AS
    BEGIN
        IF p_institution_name IS NULL OR TRIM(p_institution_name) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20041, 'Institution name cannot be empty.');
        END IF;
        
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
        v_name := TRIM(p_new_name);
        IF v_name IS NULL THEN 
            RAISE_APPLICATION_ERROR(-20051, 'New institution name cannot be empty.'); 
        END IF;
        
        UPDATE ADM.INSTITUTION 
        SET name = v_name 
        WHERE id = p_institution_id;
        
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
        DELETE FROM ADM.INSTITUTION_DOMAIN WHERE institution_id = p_institution_id;
        DELETE FROM ADM.INSTITUTION WHERE id = p_institution_id;
        
        IF SQL%ROWCOUNT = 0 THEN 
            RAISE_APPLICATION_ERROR(-20061, 'Institution with ID ' || p_institution_id || ' not found for deletion.'); 
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN 
                ROLLBACK; 
                RAISE_APPLICATION_ERROR(-20062, 'Cannot delete institution ID ' || p_institution_id || ' because it is associated with users or other data.');
            ELSE 
                ROLLBACK; 
                RAISE; 
            END IF;
    END delete_institution;

    FUNCTION find_institution_by_id_cursor (
        p_institution_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR 
            SELECT id, name 
            FROM ADM.INSTITUTION 
            WHERE id = p_institution_id;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN 
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
            RAISE;
    END find_institution_by_id_cursor;

    FUNCTION find_all_institutions_cursor
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR 
            SELECT id, name 
            FROM ADM.INSTITUTION 
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN 
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
            RAISE;
    END find_all_institutions_cursor;

    PROCEDURE update_institution_domains (
        p_institution_id IN ADM.INSTITUTION.id%TYPE,
        p_new_domain_ids IN ADM.ID_TABLE_TYPE
    ) AS
        v_inst_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_inst_count 
        FROM ADM.INSTITUTION 
        WHERE id = p_institution_id;
        
        IF v_inst_count = 0 THEN 
            RAISE_APPLICATION_ERROR(-20031, 'Institution with ID ' || p_institution_id || ' does not exist.'); 
        END IF;
        
        DELETE FROM ADM.INSTITUTION_DOMAIN WHERE institution_id = p_institution_id;
        
        IF p_new_domain_ids IS NOT NULL AND p_new_domain_ids.COUNT > 0 THEN
            BEGIN
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
        OPEN v_cursor FOR
            SELECT domain_id 
            FROM ADM.INSTITUTION_DOMAIN 
            WHERE institution_id = p_institution_id;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN 
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
            RAISE;
    END get_assoc_domain_ids_cur;
END ADM_INSTITUTION_MGMT_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_CATALOG_MGMT_PKG
-- Purpose: Manages operations related to catalog data in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_CATALOG_MGMT_PKG AS
    FUNCTION find_all_genders_cursor RETURN SYS_REFCURSOR;
    FUNCTION find_all_institutions_cursor RETURN SYS_REFCURSOR;
    FUNCTION find_all_id_types_cursor RETURN SYS_REFCURSOR;
    FUNCTION find_all_phone_types_cursor RETURN SYS_REFCURSOR;
    FUNCTION find_domains_by_inst_cursor(p_institution_id IN NUMBER) RETURN SYS_REFCURSOR;
END ADM_CATALOG_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_CATALOG_MGMT_PKG AS
    FUNCTION find_all_genders_cursor RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.GENDER
            ORDER BY name;
        RETURN v_cursor;
    END find_all_genders_cursor;
    
    FUNCTION find_all_institutions_cursor RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.INSTITUTION
            ORDER BY name;
        RETURN v_cursor;
    END find_all_institutions_cursor;
    
    FUNCTION find_all_id_types_cursor RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.TYPE_IDENTIFICATION
            ORDER BY name;
        RETURN v_cursor;
    END find_all_id_types_cursor;
    
    FUNCTION find_all_phone_types_cursor RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.TYPE_PHONE
            ORDER BY name;
        RETURN v_cursor;
    END find_all_phone_types_cursor;
    
    FUNCTION find_domains_by_inst_cursor(
        p_institution_id IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT d.id, d.name
            FROM ADM.DOMAIN d
            JOIN ADM.INSTITUTION_DOMAIN id ON d.id = id.domain_id
            WHERE id.institution_id = p_institution_id
            ORDER BY d.name;
        RETURN v_cursor;
    END find_domains_by_inst_cursor;
END ADM_CATALOG_MGMT_PKG;
/

-- ============================================================================
-- GRANTS
-- ============================================================================
-- Package execution grants
GRANT EXECUTE ON ADM.ADM_DOMAIN_MGMT_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_INSTITUTION_MGMT_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_CATALOG_MGMT_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_GENDER_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_ID_TYPE_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_PHONE_TYPE_PKG TO PU;

-- Data type grants
GRANT EXECUTE ON ADM.ID_TABLE_TYPE TO PU;

-- Table grants
GRANT SELECT ON ADM.GENDER TO PU;
GRANT SELECT ON ADM.INSTITUTION TO PU;
GRANT SELECT ON ADM.TYPE_IDENTIFICATION TO PU;
GRANT SELECT ON ADM.TYPE_PHONE TO PU;
GRANT SELECT ON ADM.DOMAIN TO PU;
GRANT SELECT ON ADM.INSTITUTION_DOMAIN TO PU;
GRANT SELECT ON ADM.PERSON TO PU;

-- Sequence grants
GRANT SELECT ON ADM.GENDER_SEQ TO PU;
GRANT SELECT ON ADM.INSTITUTION_SEQ TO PU;
GRANT SELECT ON ADM.TYPE_IDENTIFICATION_SEQ TO PU;
GRANT SELECT ON ADM.TYPE_PHONE_SEQ TO PU;
GRANT SELECT ON ADM.DOMAIN_SEQ TO PU;
GRANT SELECT ON ADM.PERSON_SEQ TO PU;