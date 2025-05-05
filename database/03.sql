-- =====================================================================
-- Package: ADM_CATALOG_MGMT_PKG
-- Description: Contains procedures to manage the general catalogs
--              of the system
-- Author: Mauricio González
-- Creation Date: 04/05/2025
-- =====================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_CATALOG_MGMT_PKG AS

    -- Procedure to register a new Gender
    PROCEDURE register_gender (p_name IN ADM.GENDER.name%TYPE);

    -- Procedure to register a new Phone Type
    PROCEDURE register_type_phone (p_name IN ADM.TYPE_PHONE.name%TYPE);

    -- Procedure to register a new Identification Type
    PROCEDURE register_type_identification (p_name IN ADM.TYPE_IDENTIFICATION.name%TYPE);

END ADM_CATALOG_MGMT_PKG;
/

-- =====================================================================
-- Package Body: ADM_CATALOG_MGMT_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY ADM.ADM_CATALOG_MGMT_PKG AS

    -- Procedure to register a new Gender
    PROCEDURE register_gender (p_name IN ADM.GENDER.name%TYPE) AS
    BEGIN
        -- Validate input
        IF p_name IS NULL OR TRIM(p_name) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20201, 'Gender name cannot be empty.');
        END IF;

        -- Insert into GENDER table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO ADM.GENDER (name) VALUES (p_name);

        -- Confirm
        COMMIT;

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20202, 'Gender ''' || p_name || ''' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END register_gender;

    -- Procedure to register a new Phone Type
    PROCEDURE register_type_phone (p_name IN ADM.TYPE_PHONE.name%TYPE) AS
    BEGIN
        -- Validate input
        IF p_name IS NULL OR TRIM(p_name) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20211, 'Phone type name cannot be empty.');
        END IF;

        -- Insert into TYPE_PHONE table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO ADM.TYPE_PHONE (name) VALUES (p_name);

        -- Confirm
        COMMIT;

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20212, 'Phone type ''' || p_name || ''' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END register_type_phone;

    -- Procedure to register a new Identification Type
    PROCEDURE register_type_identification (p_name IN ADM.TYPE_IDENTIFICATION.name%TYPE) AS
    BEGIN
        -- Validate input
        IF p_name IS NULL OR TRIM(p_name) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20221, 'Identification type name cannot be empty.');
        END IF;

        -- Insert into TYPE_IDENTIFICATION table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO ADM.TYPE_IDENTIFICATION (name) VALUES (p_name);

        -- Confirm
        COMMIT;

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20222, 'Identification type ''' || p_name || ''' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END register_type_identification;

END ADM_CATALOG_MGMT_PKG;
/