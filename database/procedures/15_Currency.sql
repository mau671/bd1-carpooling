-- =====================================================================
-- Package: ADM_CURRENCY_MGMT_PKG
-- Description: Manages CURRENCY operations
-- =====================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_CURRENCY_PKG AS

    -- Create a currency
    PROCEDURE create_currency(
        p_name IN ADM.CURRENCY.name%TYPE
    );

    -- Get all currencies
    FUNCTION get_all_currencies RETURN SYS_REFCURSOR;

    -- Update a currency name
    PROCEDURE update_currency_name(
        p_currency_id IN ADM.CURRENCY.id%TYPE,
        p_new_name    IN ADM.CURRENCY.name%TYPE
    );

    -- Delete a currency
    PROCEDURE delete_currency(
        p_currency_id IN ADM.CURRENCY.id%TYPE
    );

END ADM_CURRENCY_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_CURRENCY_PKG AS
    
    -- Create a currency
    PROCEDURE create_currency(
        p_name IN ADM.CURRENCY.name%TYPE
    ) IS
    BEGIN
        INSERT INTO ADM.CURRENCY (id, name)
        VALUES (ADM.CURRENCY_SEQ.NEXTVAL, p_name);
        COMMIT;
    END;
    
    -- Get all currencies
    FUNCTION get_all_currencies RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name FROM ADM.CURRENCY;
        RETURN v_cursor;
    END;
    
    -- Update a currency name
    PROCEDURE update_currency_name(
        p_currency_id IN ADM.CURRENCY.id%TYPE,
        p_new_name    IN ADM.CURRENCY.name%TYPE
    ) IS
    BEGIN
        UPDATE ADM.CURRENCY
        SET name = p_new_name
        WHERE id = p_currency_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20405, 'Currency not found.');
        END IF;
        COMMIT;
    END;
    
    -- Delete a currency
    PROCEDURE delete_currency(
        p_currency_id IN ADM.CURRENCY.id%TYPE
    ) IS
    BEGIN
        DELETE FROM ADM.CURRENCY
        WHERE id = p_currency_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20406, 'Currency not found.');
        END IF;
        COMMIT;
    END;

END ADM_CURRENCY_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.CURRENCY TO PU;
GRANT SELECT ON ADM.CURRENCY_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_CURRENCY_PKG TO PU;