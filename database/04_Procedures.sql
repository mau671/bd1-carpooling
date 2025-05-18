-- ============================================================================
-- GRANTS NECESARIOS PARA LA EJECUCIÓN DEL SCRIPT
-- ============================================================================
-- Grants para el esquema ADM
GRANT CREATE PROCEDURE TO ADM;
GRANT CREATE TYPE TO ADM;
GRANT CREATE SESSION TO ADM;
GRANT UNLIMITED TABLESPACE TO ADM;

-- Grants para el esquema PU
GRANT CREATE PROCEDURE TO PU;
GRANT CREATE TYPE TO PU;
GRANT CREATE SESSION TO PU;
GRANT UNLIMITED TABLESPACE TO PU;

-- Grants de tablas para ADM
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.PERSON TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.GENDER TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.INSTITUTION TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.TYPE_IDENTIFICATION TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.TYPE_PHONE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.DOMAIN TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.INSTITUTION_DOMAIN TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.ADMIN TO PU;

-- Grants de tablas para PU
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PERSONUSER TO ADM;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PHONE TO ADM;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.EMAIL TO ADM;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PHONE_PERSON TO ADM;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.INSTITUTION_PERSON TO ADM;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.DRIVER TO ADM;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PASSENGER TO ADM;

-- Grants de secuencias
GRANT SELECT ON ADM.GENDER_SEQ TO PU;
GRANT SELECT ON ADM.INSTITUTION_SEQ TO PU;
GRANT SELECT ON ADM.TYPE_IDENTIFICATION_SEQ TO PU;
GRANT SELECT ON ADM.TYPE_PHONE_SEQ TO PU;
GRANT SELECT ON ADM.DOMAIN_SEQ TO PU;
GRANT SELECT ON ADM.PERSON_SEQ TO PU;
GRANT SELECT ON PU.PERSONUSER_SEQ TO ADM;
GRANT SELECT ON PU.PHONE_SEQ TO ADM;
GRANT SELECT ON PU.EMAIL_SEQ TO ADM;

-- ============================================================================
-- TYPES
-- ============================================================================
/**
 * Tipo de tabla para almacenar IDs numéricos.
 * Utilizado principalmente para operaciones en lote con múltiples IDs.
 */
CREATE OR REPLACE TYPE ADM.ID_TABLE_TYPE AS TABLE OF NUMBER;
/

-- ============================================================================
-- PACKAGE: ADM_INST_PKG
-- Purpose: Gestiona operaciones relacionadas con instituciones
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_INST_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    PROCEDURE create_inst (
        p_name IN ADM.INSTITUTION.name%TYPE,
        o_id   OUT ADM.INSTITUTION.id%TYPE
    );

    PROCEDURE update_inst_name (
        p_id   IN ADM.INSTITUTION.id%TYPE,
        p_name IN ADM.INSTITUTION.name%TYPE
    );

    PROCEDURE delete_inst (
        p_id IN ADM.INSTITUTION.id%TYPE
    );

    FUNCTION find_inst_by_id (
        p_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type;

    FUNCTION find_all_inst RETURN ref_cursor_type;
END ADM_INST_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_INST_PKG AS
    PROCEDURE create_inst (
        p_name IN ADM.INSTITUTION.name%TYPE,
        o_id   OUT ADM.INSTITUTION.id%TYPE
    ) AS
    BEGIN
        IF p_name IS NULL OR TRIM(p_name) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20041, 'Institution name cannot be empty.');
        END IF;
        
        INSERT INTO ADM.INSTITUTION (name) 
        VALUES (TRIM(p_name)) 
        RETURNING id INTO o_id;
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN 
            ROLLBACK; 
            RAISE_APPLICATION_ERROR(-20042, 'Institution ''' || TRIM(p_name) || ''' already exists.');
        WHEN OTHERS THEN 
            ROLLBACK; 
            RAISE;
    END create_inst;

    PROCEDURE update_inst_name (
        p_id   IN ADM.INSTITUTION.id%TYPE,
        p_name IN ADM.INSTITUTION.name%TYPE
    ) AS
        v_name ADM.INSTITUTION.name%TYPE;
    BEGIN
        v_name := TRIM(p_name);
        IF v_name IS NULL THEN 
            RAISE_APPLICATION_ERROR(-20051, 'New institution name cannot be empty.'); 
        END IF;
        
        UPDATE ADM.INSTITUTION 
        SET name = v_name 
        WHERE id = p_id;
        
        IF SQL%ROWCOUNT = 0 THEN 
            RAISE_APPLICATION_ERROR(-20052, 'Institution with ID ' || p_id || ' not found for update.'); 
        END IF;
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN 
            ROLLBACK; 
            RAISE_APPLICATION_ERROR(-20053, 'The name ''' || v_name || ''' is already in use.');
        WHEN OTHERS THEN 
            ROLLBACK; 
            RAISE;
    END update_inst_name;

    PROCEDURE delete_inst (
        p_id IN ADM.INSTITUTION.id%TYPE
    ) AS
    BEGIN
        DELETE FROM ADM.INSTITUTION_DOMAIN WHERE institution_id = p_id;
        DELETE FROM ADM.INSTITUTION WHERE id = p_id;
        
        IF SQL%ROWCOUNT = 0 THEN 
            RAISE_APPLICATION_ERROR(-20061, 'Institution with ID ' || p_id || ' not found for deletion.'); 
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN 
                ROLLBACK; 
                RAISE_APPLICATION_ERROR(-20062, 'Cannot delete institution ID ' || p_id || ' because it is associated with users or other data.');
            ELSE 
                ROLLBACK; 
                RAISE; 
            END IF;
    END delete_inst;

    FUNCTION find_inst_by_id (
        p_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR 
            SELECT id, name 
            FROM ADM.INSTITUTION 
            WHERE id = p_id;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN 
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF; 
            RAISE;
    END find_inst_by_id;

    FUNCTION find_all_inst RETURN ref_cursor_type
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
    END find_all_inst;
END ADM_INST_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_DOM_PKG
-- Purpose: Gestiona operaciones relacionadas con dominios
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_DOM_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    PROCEDURE create_dom (
        p_name IN ADM.DOMAIN.name%TYPE,
        o_id   OUT ADM.DOMAIN.id%TYPE
    );

    PROCEDURE delete_dom (
        p_id IN ADM.DOMAIN.id%TYPE
    );

    FUNCTION find_dom_by_id (
        p_id IN ADM.DOMAIN.id%TYPE
    ) RETURN ref_cursor_type;

    FUNCTION find_all_dom
    RETURN ref_cursor_type;
END ADM_DOM_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_DOM_PKG AS
    PROCEDURE create_dom (
        p_name IN ADM.DOMAIN.name%TYPE,
        o_id   OUT ADM.DOMAIN.id%TYPE
    ) AS
        v_name ADM.DOMAIN.name%TYPE;
    BEGIN
        v_name := TRIM(LOWER(p_name));
        
        IF v_name IS NULL THEN
           RAISE_APPLICATION_ERROR(-20101, 'Domain name cannot be empty.');
        END IF;

        INSERT INTO ADM.DOMAIN (name) VALUES (v_name) RETURNING id INTO o_id;
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK; 
            RAISE_APPLICATION_ERROR(-20102, 'Domain ''' || v_name || ''' already exists.');
        WHEN OTHERS THEN
            ROLLBACK; 
            RAISE;
    END create_dom;

    PROCEDURE delete_dom (
        p_id IN ADM.DOMAIN.id%TYPE
    ) AS
    BEGIN
        DELETE FROM ADM.DOMAIN WHERE id = p_id;
        
        IF SQL%ROWCOUNT = 0 THEN
             RAISE_APPLICATION_ERROR(-20111, 'Domain with ID ' || p_id || ' not found for deletion.');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                 ROLLBACK; 
                 RAISE_APPLICATION_ERROR(-20112, 'Cannot delete domain ID ' || p_id || ' because it is associated with institutions.');
            ELSE
                 ROLLBACK; 
                 RAISE;
            END IF;
    END delete_dom;

    FUNCTION find_dom_by_id (
        p_id IN ADM.DOMAIN.id%TYPE
    ) RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.DOMAIN
            WHERE id = p_id;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END find_dom_by_id;

    FUNCTION find_all_dom
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
    END find_all_dom;
END ADM_DOM_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_INST_DOM_PKG
-- Purpose: Gestiona operaciones relacionadas con dominios de instituciones
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_INST_DOM_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    PROCEDURE add_dom_to_inst (
        p_inst_id IN ADM.INSTITUTION.id%TYPE,
        p_dom_id IN ADM.DOMAIN.id%TYPE
    );

    PROCEDURE rem_dom_from_inst (
        p_inst_id IN ADM.INSTITUTION.id%TYPE,
        p_dom_id IN ADM.DOMAIN.id%TYPE
    );

    FUNCTION get_inst_dom (
        p_inst_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type;

    FUNCTION get_avail_dom (
        p_inst_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type;
END ADM_INST_DOM_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_INST_DOM_PKG AS
    PROCEDURE add_dom_to_inst (
        p_inst_id IN ADM.INSTITUTION.id%TYPE,
        p_dom_id IN ADM.DOMAIN.id%TYPE
    ) AS
    BEGIN
        INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id)
        VALUES (p_inst_id, p_dom_id);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20201, 'Domain is already associated with this institution.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END add_dom_to_inst;

    PROCEDURE rem_dom_from_inst (
        p_inst_id IN ADM.INSTITUTION.id%TYPE,
        p_dom_id IN ADM.DOMAIN.id%TYPE
    ) AS
    BEGIN
        DELETE FROM ADM.INSTITUTION_DOMAIN
        WHERE institution_id = p_inst_id
        AND domain_id = p_dom_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20202, 'Domain is not associated with this institution.');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END rem_dom_from_inst;

    FUNCTION get_inst_dom (
        p_inst_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT d.id, d.name, 1 as enabled
            FROM ADM.DOMAIN d
            INNER JOIN ADM.INSTITUTION_DOMAIN id ON d.id = id.domain_id
            WHERE id.institution_id = p_inst_id
            ORDER BY d.name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_inst_dom;

    FUNCTION get_avail_dom (
        p_inst_id IN ADM.INSTITUTION.id%TYPE
    ) RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT d.id, d.name, 
                   CASE WHEN id.domain_id IS NOT NULL THEN 1 ELSE 0 END as enabled
            FROM ADM.DOMAIN d
            LEFT JOIN ADM.INSTITUTION_DOMAIN id ON d.id = id.domain_id 
                AND id.institution_id = p_inst_id
            ORDER BY d.name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_avail_dom;
END ADM_INST_DOM_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_GEN_PKG
-- Purpose: Gestiona operaciones relacionadas con géneros
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_GEN_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    FUNCTION get_all_gen
    RETURN ref_cursor_type;
END ADM_GEN_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_GEN_PKG AS
    FUNCTION get_all_gen
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
    END get_all_gen;
END ADM_GEN_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_PHONE_TYPE_PKG
-- Purpose: Gestiona operaciones relacionadas con tipos de teléfono
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_PHONE_TYPE_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    FUNCTION get_all_phone_type
    RETURN ref_cursor_type;
END ADM_PHONE_TYPE_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_PHONE_TYPE_PKG AS
    FUNCTION get_all_phone_type
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
    END get_all_phone_type;
END ADM_PHONE_TYPE_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_ID_TYPE_PKG
-- Purpose: Gestiona operaciones relacionadas con tipos de identificación
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_ID_TYPE_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    FUNCTION get_all_id_type
    RETURN ref_cursor_type;
END ADM_ID_TYPE_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_ID_TYPE_PKG AS
    FUNCTION get_all_id_type
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
    END get_all_id_type;
END ADM_ID_TYPE_PKG;
/

-- ============================================================================
-- GRANTS
-- ============================================================================
-- Package execution grants
GRANT EXECUTE ON ADM.ADM_INST_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_DOM_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_INST_DOM_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_GEN_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_PHONE_TYPE_PKG TO PU;
GRANT EXECUTE ON ADM.ADM_ID_TYPE_PKG TO PU;

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