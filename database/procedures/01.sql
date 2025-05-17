-- =====================================================================
-- Package: ADM_INSTITUTION_MGMT_PKG
-- Description: Contains procedures for managing institutions 
--              and their associated domains in the ADM schema.
-- Author: Mauricio González
-- Creation Date: 04/05/2025
-- =====================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_INSTITUTION_MGMT_PKG AS

    -- Definition of a collection type to pass multiple domain names
    TYPE type_varchar2_tab IS TABLE OF VARCHAR2(100);

    -- Procedure to register a new institution and its initial domains
    -- Note: Assumes that sequences for ADM.INSTITUTION.id and ADM.DOMAIN.id exist
    --       and that audit triggers are active.
    PROCEDURE register_institution (
        p_institution_name IN ADM.INSTITUTION.name%TYPE,
        p_domain_names     IN type_varchar2_tab,
        o_institution_id   OUT ADM.INSTITUTION.id%TYPE -- Optional: Returns the ID of the created institution
    );

    -- Procedure to add a domain to an existing institution
    -- Note: Assumes that sequences for ADM.DOMAIN.id exist and triggers are active.
    PROCEDURE add_domain_to_institution (
        p_institution_id IN ADM.INSTITUTION.id%TYPE,
        p_domain_name    IN ADM.DOMAIN.name%TYPE
    );

END ADM_INSTITUTION_MGMT_PKG;
/

-- =====================================================================
-- Package Body: ADM_INSTITUTION_MGMT_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY ADM.ADM_INSTITUTION_MGMT_PKG AS

    -- Procedure to register a new institution and its initial domains
    PROCEDURE register_institution (
        p_institution_name IN ADM.INSTITUTION.name%TYPE,
        p_domain_names     IN type_varchar2_tab,
        o_institution_id   OUT ADM.INSTITUTION.id%TYPE
    ) AS
        v_institution_id ADM.INSTITUTION.id%TYPE;
        v_domain_id      ADM.DOMAIN.id%TYPE;
        v_current_domain ADM.DOMAIN.name%TYPE;
    BEGIN
        -- Step 1: Validate that the institution name is not null or empty
        IF p_institution_name IS NULL OR TRIM(p_institution_name) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Institution name cannot be empty.');
        END IF;

        -- Step 2: Insert the new institution
        -- Assumes that a sequence (e.g., ADM.INSTITUTION_SEQ) and/or trigger
        -- is responsible for automatically generating the ID.
        -- We use RETURNING to get the generated ID.
        INSERT INTO ADM.INSTITUTION (name)
        VALUES (p_institution_name)
        RETURNING id INTO v_institution_id;

        -- Assign the generated ID to the output parameter
        o_institution_id := v_institution_id;

        -- Step 3: Process and associate domains
        IF p_domain_names IS NOT NULL AND p_domain_names.COUNT > 0 THEN
            -- Iterate over the provided collection of domain names
            FOR i IN 1..p_domain_names.COUNT LOOP
                v_current_domain := TRIM(LOWER(p_domain_names(i))); -- Normalize: remove spaces and convert to lowercase

                -- Validate that the domain name is not empty
                IF v_current_domain IS NULL THEN
                    -- We could decide to skip this domain or throw an error
                    -- For now, we skip it and continue with the next one
                    CONTINUE; -- Skip to the next iteration of the loop
                END IF;

                -- Step 3a: Check if the domain already exists in the ADM.DOMAIN table
                BEGIN
                    SELECT id
                    INTO v_domain_id
                    FROM ADM.DOMAIN
                    WHERE name = v_current_domain;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        -- The domain doesn't exist, so we insert it
                        -- Assumes that a sequence (e.g., ADM.DOMAIN_SEQ) and/or trigger
                        -- is responsible for automatically generating the ID.
                        INSERT INTO ADM.DOMAIN (name)
                        VALUES (v_current_domain)
                        RETURNING id INTO v_domain_id;

                    WHEN OTHERS THEN
                        -- Capture any other unexpected error during the search
                        RAISE_APPLICATION_ERROR(-20002, 'Error when searching/inserting domain: ' || v_current_domain || ' - ' || SQLERRM);
                END;

                -- Step 3b: Associate the domain (existing or newly created) with the institution
                -- in the ADM.INSTITUTION_DOMAIN relationship table.
                -- The audit trigger will handle the creator/creation_date fields.
                BEGIN
                    INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id)
                    VALUES (v_institution_id, v_domain_id);
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                        -- The relationship already exists, which is acceptable if the domain already existed
                        -- and was previously associated (although it shouldn't happen in a new record).
                        -- We simply continue. We could add a log if necessary.
                        NULL; -- Ignore the duplicate relationship error
                    WHEN OTHERS THEN
                        -- Capture any other unexpected error during the association
                        RAISE_APPLICATION_ERROR(-20003, 'Error associating domain ' || v_current_domain || ' with institution ID ' || v_institution_id || ' - ' || SQLERRM);
                END;

            END LOOP; -- End of domain loop
        END IF; -- End of p_domain_names validation

        -- Step 4: Commit the transaction
        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            -- In case of any unhandled error, roll back the transaction
            ROLLBACK;
            -- Re-raise the error so the calling application knows about it
            RAISE;
    END register_institution;


    -- Procedure to add a domain to an existing institution
    PROCEDURE add_domain_to_institution (
        p_institution_id IN ADM.INSTITUTION.id%TYPE,
        p_domain_name    IN ADM.DOMAIN.name%TYPE
    ) AS
        v_domain_id      ADM.DOMAIN.id%TYPE;
        v_inst_exists    NUMBER;
        v_current_domain ADM.DOMAIN.name%TYPE;
    BEGIN
        -- Step 1: Validate inputs
        IF p_institution_id IS NULL THEN
            RAISE_APPLICATION_ERROR(-20011, 'Institution ID is required.');
        END IF;

        v_current_domain := TRIM(LOWER(p_domain_name));
        IF v_current_domain IS NULL THEN
            RAISE_APPLICATION_ERROR(-20012, 'Domain name cannot be empty.');
        END IF;

        -- Step 2: Verify that the institution exists
        SELECT COUNT(*)
        INTO v_inst_exists
        FROM ADM.INSTITUTION
        WHERE id = p_institution_id;

        IF v_inst_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20013, 'Institution with ID ' || p_institution_id || ' does not exist.');
        END IF;

        -- Step 3: Find or insert the domain
        BEGIN
            SELECT id
            INTO v_domain_id
            FROM ADM.DOMAIN
            WHERE name = v_current_domain;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- The domain doesn't exist, we insert it
                INSERT INTO ADM.DOMAIN (name)
                VALUES (v_current_domain)
                RETURNING id INTO v_domain_id;
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20014, 'Error when searching/inserting domain: ' || v_current_domain || ' - ' || SQLERRM);
        END;

        -- Step 4: Associate the domain with the institution
        BEGIN
            INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id)
            VALUES (p_institution_id, v_domain_id);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                -- The domain is already associated with this institution. Not a fatal error.
                -- We could issue a warning or simply ignore it.
                RAISE_APPLICATION_ERROR(-20015, 'Domain ' || v_current_domain || ' is already associated with institution ID ' || p_institution_id || '.');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20016, 'Error associating domain ' || v_current_domain || ' with institution ID ' || p_institution_id || ' - ' || SQLERRM);
        END;

        -- Step 5: Commit the transaction
        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END add_domain_to_institution;

END ADM_INSTITUTION_MGMT_PKG;
/