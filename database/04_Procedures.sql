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
-- PACKAGE: ADM_GENDER_PKG
-- Purpose: Gestiona operaciones relacionadas con géneros en el sistema
-- ============================================================================
/**
 * Paquete para la gestión de géneros en el sistema.
 * Proporciona funcionalidades para consultar la información de géneros.
 */
CREATE OR REPLACE PACKAGE ADM.ADM_GENDER_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    /**
     * Obtiene todos los géneros disponibles en el sistema.
     * @return Cursor con la lista de géneros ordenados por nombre
     */
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
-- PACKAGE: ADM_USER_REGISTRATION_PKG
-- Purpose: Gestiona operaciones relacionadas con el registro de usuarios
-- ============================================================================
/**
 * Paquete para la gestión del registro de usuarios en el sistema.
 * Proporciona funcionalidades para registrar nuevos usuarios y sus datos relacionados.
 */
CREATE OR REPLACE PACKAGE ADM.ADM_USER_REGISTRATION_PKG AS
    /**
     * Registra un nuevo usuario en el sistema.
     * 
     * @param p_first_name Nombre del usuario
     * @param p_second_name Segundo nombre del usuario (opcional)
     * @param p_first_surname Primer apellido del usuario
     * @param p_second_surname Segundo apellido del usuario (opcional)
     * @param p_id_type_id ID del tipo de identificación
     * @param p_id_number Número de identificación
     * @param p_phone_type_id ID del tipo de teléfono
     * @param p_phone_number Número de teléfono
     * @param p_email Correo electrónico
     * @param p_date_of_birth Fecha de nacimiento
     * @param p_gender_id ID del género
     * @param p_institution_id ID de la institución
     * @param p_domain_id ID del dominio de correo
     * @param p_username Nombre de usuario
     * @param p_password Contraseña
     * @param p_person_id OUT ID de la persona creada
     * @param p_user_id OUT ID del usuario creado
     */
    PROCEDURE register_user(
        p_first_name IN VARCHAR2,
        p_second_name IN VARCHAR2,
        p_first_surname IN VARCHAR2,
        p_second_surname IN VARCHAR2,
        p_id_type_id IN NUMBER,
        p_id_number IN VARCHAR2,
        p_phone_type_id IN NUMBER,
        p_phone_number IN VARCHAR2,
        p_email IN VARCHAR2,
        p_date_of_birth IN DATE,
        p_gender_id IN NUMBER,
        p_institution_id IN NUMBER,
        p_domain_id IN NUMBER,
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_person_id OUT NUMBER,
        p_user_id OUT NUMBER
    );
END ADM_USER_REGISTRATION_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_USER_REGISTRATION_PKG AS
    PROCEDURE register_user(
        p_first_name IN VARCHAR2,
        p_second_name IN VARCHAR2,
        p_first_surname IN VARCHAR2,
        p_second_surname IN VARCHAR2,
        p_id_type_id IN NUMBER,
        p_id_number IN VARCHAR2,
        p_phone_type_id IN NUMBER,
        p_phone_number IN VARCHAR2,
        p_email IN VARCHAR2,
        p_date_of_birth IN DATE,
        p_gender_id IN NUMBER,
        p_institution_id IN NUMBER,
        p_domain_id IN NUMBER,
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_person_id OUT NUMBER,
        p_user_id OUT NUMBER
    ) IS
        v_person_id NUMBER;
        v_user_id NUMBER;
        v_phone_id NUMBER;
        v_email_id NUMBER;
    BEGIN
        -- Validar que la institución existe
        DECLARE
            v_institution_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_institution_count
            FROM ADM.INSTITUTION
            WHERE id = p_institution_id;
            
            IF v_institution_count = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'Institution with ID ' || p_institution_id || ' does not exist.');
            END IF;
        END;

        -- Validar que el dominio existe y está asociado a la institución
        DECLARE
            v_domain_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_domain_count
            FROM ADM.INSTITUTION_DOMAIN
            WHERE institution_id = p_institution_id
            AND domain_id = p_domain_id;
            
            IF v_domain_count = 0 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Domain with ID ' || p_domain_id || ' is not associated with institution ' || p_institution_id);
            END IF;
        END;

        -- Insert person
        INSERT INTO ADM.PERSON (
            first_name,
            second_name,
            first_surname,
            second_surname,
            identification_number,
            date_of_birth,
            gender_id,
            type_identification_id
        ) VALUES (
            p_first_name,
            p_second_name,
            p_first_surname,
            p_second_surname,
            p_id_number,
            p_date_of_birth,
            p_gender_id,
            p_id_type_id
        ) RETURNING id INTO v_person_id;

        -- Insert user account
        INSERT INTO PU.PERSONUSER (
            username,
            password,
            person_id
        ) VALUES (
            p_username,
            p_password,
            v_person_id
        ) RETURNING id INTO v_user_id;

        -- Insert phone
        INSERT INTO PU.PHONE (
            phone_number,
            type_phone_id
        ) VALUES (
            p_phone_number,
            p_phone_type_id
        ) RETURNING id INTO v_phone_id;

        -- Insert phone-person relationship
        INSERT INTO PU.PHONE_PERSON (
            phone_id,
            person_id
        ) VALUES (
            v_phone_id,
            v_person_id
        );

        -- Insert email
        INSERT INTO PU.EMAIL (
            name,
            domain_id,
            person_id
        ) VALUES (
            p_email,
            p_domain_id,
            v_person_id
        ) RETURNING id INTO v_email_id;

        -- Insert institution-person relationship
        INSERT INTO PU.INSTITUTION_PERSON (
            institution_id,
            person_id
        ) VALUES (
            p_institution_id,
            v_person_id
        );

        -- Set output parameters
        p_person_id := v_person_id;
        p_user_id := v_user_id;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END register_user;
END ADM_USER_REGISTRATION_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_USER_AUTH_PKG
-- Purpose: Gestiona operaciones relacionadas con la autenticación de usuarios
-- ============================================================================
/**
 * Paquete para la gestión de la autenticación de usuarios en el sistema.
 * Proporciona funcionalidades para verificar las credenciales de los usuarios.
 */
CREATE OR REPLACE PACKAGE ADM.ADM_USER_AUTH_PKG AS
    /**
     * Autentica un usuario con el nombre de usuario y contraseña proporcionados.
     * 
     * @param p_username Nombre de usuario
     * @param p_hashed_password Contraseña hasheada
     * @return Cursor con la información del usuario si la autenticación es exitosa
     */
    FUNCTION authenticate_user(
        p_username IN VARCHAR2,
        p_hashed_password IN VARCHAR2
    ) RETURN SYS_REFCURSOR;
END ADM_USER_AUTH_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_USER_AUTH_PKG AS
    FUNCTION authenticate_user(
        p_username IN VARCHAR2,
        p_hashed_password IN VARCHAR2
    ) RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT u.id, u.username, u.person_id
            FROM PU.PERSONUSER u
            WHERE u.username = p_username
            AND u.password = p_hashed_password;
            
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END authenticate_user;
END ADM_USER_AUTH_PKG;
/

-- ============================================================================
-- PACKAGE: ADM_USER_TYPE_PKG
-- Purpose: Gestiona operaciones relacionadas con el tipo de usuario
-- ============================================================================
/**
 * Paquete para la gestión del tipo de usuario en el sistema.
 * Proporciona funcionalidades para registrar y consultar el tipo de usuario.
 */
CREATE OR REPLACE PACKAGE ADM.ADM_USER_TYPE_PKG AS
    /**
     * Registra un usuario como conductor
     * 
     * @param p_user_id ID del usuario a registrar como conductor
     */
    PROCEDURE register_as_driver(p_user_id IN NUMBER);
    
    /**
     * Registra un usuario como pasajero
     * 
     * @param p_user_id ID del usuario a registrar como pasajero
     */
    PROCEDURE register_as_passenger(p_user_id IN NUMBER);
    
    /**
     * Verifica si un usuario es administrador
     * 
     * @param p_user_id ID del usuario a verificar
     * @param p_is_admin OUT 1 si es administrador, 0 si no lo es
     */
    PROCEDURE is_admin(p_user_id IN NUMBER, p_is_admin OUT NUMBER);
    
    /**
     * Obtiene el tipo de usuario actual
     * 
     * @param p_user_id ID del usuario
     * @param p_user_type OUT Tipo de usuario (ADMIN, DRIVER, PASSENGER)
     */
    PROCEDURE get_user_type(p_user_id IN NUMBER, p_user_type OUT VARCHAR2);
END ADM_USER_TYPE_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_USER_TYPE_PKG AS
    PROCEDURE register_as_driver(p_user_id IN NUMBER) IS
        v_person_id NUMBER;
    BEGIN
        -- Obtener el person_id del usuario
        SELECT person_id INTO v_person_id
        FROM PU.PERSONUSER
        WHERE id = p_user_id;
        
        -- Eliminar registro anterior si existe
        DELETE FROM PU.PASSENGER WHERE person_id = v_person_id;
        
        -- Verificar si ya es conductor
        DECLARE
            v_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_count
            FROM PU.DRIVER
            WHERE person_id = v_person_id;
            
            IF v_count > 0 THEN
                RETURN; -- Ya es conductor, no necesita hacer nada
            END IF;
        END;
        
        -- Insertar como conductor
        INSERT INTO PU.DRIVER (person_id)
        VALUES (v_person_id);
        
        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'User not found.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END register_as_driver;
    
    PROCEDURE register_as_passenger(p_user_id IN NUMBER) IS
        v_person_id NUMBER;
    BEGIN
        -- Obtener el person_id del usuario
        SELECT person_id INTO v_person_id
        FROM PU.PERSONUSER
        WHERE id = p_user_id;
        
        -- Eliminar registro anterior si existe
        DELETE FROM PU.DRIVER WHERE person_id = v_person_id;
        
        -- Verificar si ya es pasajero
        DECLARE
            v_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_count
            FROM PU.PASSENGER
            WHERE person_id = v_person_id;
            
            IF v_count > 0 THEN
                RETURN; -- Ya es pasajero, no necesita hacer nada
            END IF;
        END;
        
        -- Insertar como pasajero
        INSERT INTO PU.PASSENGER (person_id)
        VALUES (v_person_id);
        
        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'User not found.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END register_as_passenger;
    
    PROCEDURE is_admin(p_user_id IN NUMBER, p_is_admin OUT NUMBER) IS
        v_person_id NUMBER;
        v_count NUMBER;
    BEGIN
        -- Obtener el person_id del usuario
        SELECT person_id INTO v_person_id
        FROM PU.PERSONUSER
        WHERE id = p_user_id;
        
        -- Verificar si es administrador
        SELECT COUNT(*) INTO v_count
        FROM ADM.ADMIN
        WHERE person_id = v_person_id;
        
        p_is_admin := CASE WHEN v_count > 0 THEN 1 ELSE 0 END;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_is_admin := 0;
        WHEN OTHERS THEN
            RAISE;
    END is_admin;
    
    PROCEDURE get_user_type(p_user_id IN NUMBER, p_user_type OUT VARCHAR2) IS
        v_person_id NUMBER;
        v_is_admin NUMBER;
        v_is_driver NUMBER;
        v_is_passenger NUMBER;
    BEGIN
        -- Obtener el person_id del usuario
        SELECT person_id INTO v_person_id
        FROM PU.PERSONUSER
        WHERE id = p_user_id;
        
        -- Verificar si es admin
        SELECT COUNT(*) INTO v_is_admin
        FROM ADM.ADMIN
        WHERE person_id = v_person_id;
        
        IF v_is_admin > 0 THEN
            p_user_type := 'ADMIN';
            RETURN;
        END IF;
        
        -- Verificar si es conductor
        SELECT COUNT(*) INTO v_is_driver
        FROM PU.DRIVER
        WHERE person_id = v_person_id;
        
        IF v_is_driver > 0 THEN
            p_user_type := 'DRIVER';
            RETURN;
        END IF;
        
        -- Verificar si es pasajero
        SELECT COUNT(*) INTO v_is_passenger
        FROM PU.PASSENGER
        WHERE person_id = v_person_id;
        
        IF v_is_passenger > 0 THEN
            p_user_type := 'PASSENGER';
            RETURN;
        END IF;
        
        p_user_type := NULL;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_user_type := NULL;
        WHEN OTHERS THEN
            RAISE;
    END get_user_type;
END ADM_USER_TYPE_PKG;
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

-- Grants for user registration package
GRANT EXECUTE ON ADM.ADM_USER_REGISTRATION_PKG TO PU;

-- Package execution grants
GRANT EXECUTE ON ADM.ADM_USER_AUTH_PKG TO PU;

-- Grants para el paquete de tipo de usuario
GRANT EXECUTE ON ADM.ADM_USER_TYPE_PKG TO PU;