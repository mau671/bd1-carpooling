-- =====================================================================
-- Procedures for Currency Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing currencies.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Currency Procedures
-- ============================================

-- 1.1 Insert Currency
CREATE OR REPLACE PROCEDURE ADM.INSERT_CURRENCY (
    p_name IN VARCHAR2,
    p_symbol IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.CURRENCY (
        name,
        symbol
    ) VALUES (
        p_name,
        p_symbol
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20087, 'Error inserting currency: ' || SQLERRM);
END INSERT_CURRENCY;
/

-- 1.2 Update Currency
CREATE OR REPLACE PROCEDURE ADM.UPDATE_CURRENCY (
    p_id IN NUMBER,
    p_name IN VARCHAR2,
    p_symbol IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.CURRENCY
    SET name = p_name,
        symbol = p_symbol
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20088, 'Currency not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20089, 'Error updating currency: ' || SQLERRM);
END UPDATE_CURRENCY;
/

-- 1.3 Delete Currency
CREATE OR REPLACE PROCEDURE ADM.DELETE_CURRENCY (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if currency is used in payments
    SELECT COUNT(*) INTO v_count
    FROM PU.PAYMENT
    WHERE currency_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20090, 'Cannot delete currency that is used in payments');
    END IF;
    
    DELETE FROM ADM.CURRENCY
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20091, 'Currency not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20092, 'Error deleting currency: ' || SQLERRM);
END DELETE_CURRENCY;
/

-- 1.4 Get Currency
CREATE OR REPLACE PROCEDURE ADM.GET_CURRENCY (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, symbol, creator, creation_date, modifier, modification_date
        FROM ADM.CURRENCY
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20093, 'Error getting currency: ' || SQLERRM);
END GET_CURRENCY;
/

-- 1.5 List Currencies
CREATE OR REPLACE PROCEDURE ADM.LIST_CURRENCIES (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, symbol, creator, creation_date, modifier, modification_date
        FROM ADM.CURRENCY
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20094, 'Error listing currencies: ' || SQLERRM);
END LIST_CURRENCIES;
/

-- ============================================
-- 2. Grants for Currency Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_CURRENCY TO PU;
GRANT EXECUTE ON ADM.UPDATE_CURRENCY TO PU;
GRANT EXECUTE ON ADM.DELETE_CURRENCY TO PU;
GRANT EXECUTE ON ADM.GET_CURRENCY TO PU;
GRANT EXECUTE ON ADM.LIST_CURRENCIES TO PU; 