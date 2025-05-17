-- =====================================================================
-- Package: PU_USER_REGISTRATION_PKG
-- Description: Contains procedures for registering new users
--              in the system, interacting with PU and ADM schemas.
-- Author: Mauricio González
-- Creation Date: 04/05/2025
-- =====================================================================
CREATE OR REPLACE PACKAGE PU.PU_USER_REGISTRATION_PKG AS

    -- Procedure to register a new user
    -- Note: Assumes that sequences and audit triggers are active
    --       for ADM.PERSON, PU.PERSONUSER, PU.EMAIL, PU.PHONE, PU.PHOTO,
    --       PU.PHONE_PERSON, PU.INSTITUTION_PERSON.
    PROCEDURE register_user (
        -- Institution and Email data (for validation)
        p_institution_id    IN ADM.INSTITUTION.id%TYPE,
        p_email             IN PU.EMAIL.name%TYPE,

        -- Personal Data (for ADM.PERSON)
        p_first_name        IN ADM.PERSON.first_name%TYPE,
        p_second_name       IN ADM.PERSON.second_name%TYPE DEFAULT NULL,
        p_first_surname     IN ADM.PERSON.first_surname%TYPE,
        p_second_surname    IN ADM.PERSON.second_surname%TYPE DEFAULT NULL,
        p_id_number         IN ADM.PERSON.identification_number%TYPE,
        p_dob               IN ADM.PERSON.date_of_birth%TYPE,
        p_gender_id         IN ADM.PERSON.gender_id%TYPE,
        p_type_id_id        IN ADM.PERSON.type_identification_id%TYPE,

        -- User Account Data (for PU.PERSONUSER)
        p_username          IN PU.PERSONUSER.username%TYPE,
        p_hashed_password   IN PU.PERSONUSER.password%TYPE, -- Already hashed password

        -- Contact Data (for PU.PHONE and PU.PHONE_PERSON)
        p_phone_number      IN PU.PHONE.phone_number%TYPE,
        p_type_phone_id     IN PU.PHONE.type_phone_id%TYPE,

        -- Photo Data (for PU.PHOTO)
        p_photo_blob        IN PU.PHOTO.image%TYPE DEFAULT NULL, -- Image BLOB (optional)
        -- If using path instead of BLOB:
        -- p_photo_path        IN VARCHAR2 DEFAULT NULL,

        -- Output Parameters (Optional)
        o_person_id         OUT ADM.PERSON.id%TYPE,
        o_user_id           OUT PU.PERSONUSER.id%TYPE
    );

END PU_USER_REGISTRATION_PKG;
/

-- =====================================================================
-- Package Body: PU_USER_REGISTRATION_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY PU.PU_USER_REGISTRATION_PKG AS

    -- Procedure to register a new user
    PROCEDURE register_user (
        p_institution_id    IN ADM.INSTITUTION.id%TYPE,
        p_email             IN PU.EMAIL.name%TYPE,
        p_first_name        IN ADM.PERSON.first_name%TYPE,
        p_second_name       IN ADM.PERSON.second_name%TYPE DEFAULT NULL,
        p_first_surname     IN ADM.PERSON.first_surname%TYPE,
        p_second_surname    IN ADM.PERSON.second_surname%TYPE DEFAULT NULL,
        p_id_number         IN ADM.PERSON.identification_number%TYPE,
        p_dob               IN ADM.PERSON.date_of_birth%TYPE,
        p_gender_id         IN ADM.PERSON.gender_id%TYPE,
        p_type_id_id        IN ADM.PERSON.type_identification_id%TYPE,
        p_username          IN PU.PERSONUSER.username%TYPE,
        p_hashed_password   IN PU.PERSONUSER.password%TYPE,
        p_phone_number      IN PU.PHONE.phone_number%TYPE,
        p_type_phone_id     IN PU.PHONE.type_phone_id%TYPE,
        p_photo_blob        IN PU.PHOTO.image%TYPE DEFAULT NULL,
        o_person_id         OUT ADM.PERSON.id%TYPE,
        o_user_id           OUT PU.PERSONUSER.id%TYPE
    ) AS
        v_email_domain   VARCHAR2(100);
        v_domain_count   NUMBER := 0;
        v_person_id      ADM.PERSON.id%TYPE;
        v_user_id        PU.PERSONUSER.id%TYPE;
        v_phone_id       PU.PHONE.id%TYPE;
        v_email_id       PU.EMAIL.id%TYPE;
        v_photo_id       PU.PHOTO.id%TYPE;
        e_invalid_domain EXCEPTION;
        PRAGMA EXCEPTION_INIT(e_invalid_domain, -20101); -- Define custom error number
        e_username_exists EXCEPTION;
        PRAGMA EXCEPTION_INIT(e_username_exists, -20102);
        e_email_exists EXCEPTION;
        PRAGMA EXCEPTION_INIT(e_email_exists, -20103);
        e_id_number_exists EXCEPTION;
        PRAGMA EXCEPTION_INIT(e_id_number_exists, -20104);

    BEGIN
        -- Step 0: Basic input validations (nullity, format if needed)
        IF p_institution_id IS NULL OR p_email IS NULL OR p_first_name IS NULL OR
             p_first_surname IS NULL OR p_id_number IS NULL OR p_dob IS NULL OR
             p_gender_id IS NULL OR p_type_id_id IS NULL OR p_username IS NULL OR
             p_hashed_password IS NULL OR p_phone_number IS NULL OR p_type_phone_id IS NULL
        THEN
             RAISE_APPLICATION_ERROR(-20100, 'Required data is missing for registration.');
        END IF;

        -- Step 1: Validate email domain
        -- Extract domain (part after '@')
        v_email_domain := SUBSTR(p_email, INSTR(p_email, '@') + 1);

        IF v_email_domain IS NULL THEN
                RAISE_APPLICATION_ERROR(-20105, 'Email format is invalid.');
        END IF;

        -- Verify if the extracted domain exists and is associated with the given institution
        BEGIN
            SELECT COUNT(*)
            INTO v_domain_count
            FROM ADM.DOMAIN d
            JOIN ADM.INSTITUTION_DOMAIN idom ON d.id = idom.domain_id
            WHERE LOWER(d.name) = LOWER(v_email_domain) -- Compare in lowercase just in case
                AND idom.institution_id = p_institution_id;
        EXCEPTION
                WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20106, 'Error validating email domain: ' || SQLERRM);
        END;

        -- If domain not found associated with the institution, throw error
        IF v_domain_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20101, 'Email domain (' || v_email_domain || ') is not valid for the selected institution.');
        END IF;

        -- Step 2: Verify Uniqueness (Username, Email, ID Number) before inserting
        -- (Better to check before to give clear messages than to wait for constraint errors)
        DECLARE
            v_check_count NUMBER;
        BEGIN
                -- Check Username
                SELECT COUNT(*) INTO v_check_count FROM PU.PERSONUSER WHERE username = p_username;
                IF v_check_count > 0 THEN
                        RAISE e_username_exists;
                END IF;

                -- Check Email
                SELECT COUNT(*) INTO v_check_count FROM PU.EMAIL WHERE name = p_email;
                IF v_check_count > 0 THEN
                        RAISE e_email_exists;
                END IF;

                -- Check ID Number (assuming it should be unique in ADM.PERSON)
                -- If it doesn't need to be unique, remove this validation.
                SELECT COUNT(*) INTO v_check_count FROM ADM.PERSON WHERE identification_number = p_id_number AND type_identification_id = p_type_id_id;
                IF v_check_count > 0 THEN
                     RAISE e_id_number_exists;
                END IF;
        END;

        -- Step 3: Insert into ADM.PERSON
        -- Assumes sequence/trigger for ID and audit
        INSERT INTO ADM.PERSON (
            first_name, second_name, first_surname, second_surname,
            identification_number, date_of_birth, gender_id, type_identification_id
        ) VALUES (
            p_first_name, p_second_name, p_first_surname, p_second_surname,
            p_id_number, p_dob, p_gender_id, p_type_id_id
        ) RETURNING id INTO v_person_id;

        -- Step 4: Insert into PU.PERSONUSER
        -- Assumes sequence/trigger for ID and audit
        INSERT INTO PU.PERSONUSER (
            username, password, person_id
        ) VALUES (
            p_username, p_hashed_password, v_person_id
        ) RETURNING id INTO v_user_id;

        -- Step 5: Insert into PU.PHONE
        -- Assumes sequence/trigger for ID and audit
        INSERT INTO PU.PHONE (
            phone_number, type_phone_id
        ) VALUES (
            p_phone_number, p_type_phone_id
        ) RETURNING id INTO v_phone_id;

        -- Step 6: Insert into relationship table PU.PHONE_PERSON
        -- Assumes trigger for audit
        INSERT INTO PU.PHONE_PERSON (person_id, phone_id)
        VALUES (v_person_id, v_phone_id);

        -- Step 7: Insert into PU.EMAIL
        -- Assumes sequence/trigger for ID and audit
        INSERT INTO PU.EMAIL (name, person_id)
        VALUES (p_email, v_person_id)
        RETURNING id INTO v_email_id;

        -- Step 8: Insert into PU.PHOTO (if a photo was provided)
        IF p_photo_blob IS NOT NULL THEN
            -- Assumes sequence/trigger for ID and audit
            INSERT INTO PU.PHOTO (image, person_id)
            VALUES (p_photo_blob, v_person_id)
            RETURNING id INTO v_photo_id;
            -- If using path:
            -- INSERT INTO PU.PHOTO (image_path, person_id) VALUES (p_photo_path, v_person_id) RETURNING id INTO v_photo_id;
        END IF;

        -- Step 9: Insert into relationship table PU.INSTITUTION_PERSON
        -- Assumes trigger for audit
        INSERT INTO PU.INSTITUTION_PERSON (institution_id, person_id)
        VALUES (p_institution_id, v_person_id);

        -- Step 10: Assign output IDs
        o_person_id := v_person_id;
        o_user_id   := v_user_id;

        -- Step 11: Confirm complete transaction
        COMMIT;

    EXCEPTION
        WHEN e_invalid_domain THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20101, 'Email domain is not valid for the selected institution.');
        WHEN e_username_exists THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20102, 'Username ''' || p_username || ''' already exists.');
        WHEN e_email_exists THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20103, 'Email ''' || p_email || ''' is already registered.');
        WHEN e_id_number_exists THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20104, 'ID number ''' || p_id_number || ''' is already registered.');
        WHEN DUP_VAL_ON_INDEX THEN
            -- Generic unique constraint error (could be username, email, id_number if we didn't validate them earlier, or something else)
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20110, 'Uniqueness error. Verify that the username, email or ID number do not already exist. Detail: ' || SQLERRM);
        WHEN OTHERS THEN
            -- Capture any other unexpected error
            ROLLBACK;
            -- Good practice to log detailed error in a log table if it exists
            -- Log_Error(SQLCODE, SQLERRM, 'PU_USER_REGISTRATION_PKG.register_user');
            RAISE; -- Re-raise the error
    END register_user;

END PU_USER_REGISTRATION_PKG;
/
