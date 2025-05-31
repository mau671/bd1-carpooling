-- =====================================================================
-- Procedures for Payment Method Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing payment methods.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 0. Grants necesarios antes de crear los procedimientos
-- ============================================

-- Grants para que PU pueda acceder a las tablas de ADM
GRANT SELECT, REFERENCES ON ADM.PAYMENTMETHOD TO PU;

-- Grants para que ADM pueda acceder a las tablas de PU
GRANT SELECT ON PU.PASSENGERXTRIPXPAYMENT TO ADM;

-- ============================================
-- 1. Payment Method Procedures
-- ============================================

-- 1.1 Insert Payment Method
CREATE OR REPLACE PROCEDURE ADM.INSERT_PAYMENT_METHOD (
    p_name IN VARCHAR2,
    p_creator IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    INSERT INTO ADM.PAYMENTMETHOD (
        name,
        creator,
        creation_date
    ) VALUES (
        p_name,
        p_creator,
        SYSDATE
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20079, 'Error inserting payment method: ' || SQLERRM);
END INSERT_PAYMENT_METHOD;
/

-- 1.2 Update Payment Method
CREATE OR REPLACE PROCEDURE ADM.UPDATE_PAYMENT_METHOD (
    p_id IN NUMBER,
    p_name IN VARCHAR2,
    p_modifier IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    UPDATE ADM.PAYMENTMETHOD
    SET name = p_name,
        modifier = p_modifier,
        modification_date = SYSDATE
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20080, 'Payment method not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20081, 'Error updating payment method: ' || SQLERRM);
END UPDATE_PAYMENT_METHOD;
/

-- 1.3 Delete Payment Method
CREATE OR REPLACE PROCEDURE ADM.DELETE_PAYMENT_METHOD (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if payment method is used in payments
    SELECT COUNT(*) INTO v_count
    FROM PU.PASSENGERXTRIPXPAYMENT
    WHERE payment_method_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20082, 'Cannot delete payment method that is used in payments');
    END IF;
    
    DELETE FROM ADM.PAYMENTMETHOD
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20083, 'Payment method not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20084, 'Error deleting payment method: ' || SQLERRM);
END DELETE_PAYMENT_METHOD;
/

-- 1.4 Get Payment Method
CREATE OR REPLACE PROCEDURE ADM.GET_PAYMENT_METHOD (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.PAYMENTMETHOD
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20085, 'Error getting payment method: ' || SQLERRM);
END GET_PAYMENT_METHOD;
/

-- 1.5 List Payment Methods
CREATE OR REPLACE PROCEDURE ADM.LIST_PAYMENT_METHODS (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.PAYMENTMETHOD
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20086, 'Error listing payment methods: ' || SQLERRM);
END LIST_PAYMENT_METHODS;
/

-- ============================================
-- 2. Grants for Payment Method Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_PAYMENT_METHOD TO PU;
GRANT EXECUTE ON ADM.UPDATE_PAYMENT_METHOD TO PU;
GRANT EXECUTE ON ADM.DELETE_PAYMENT_METHOD TO PU;
GRANT EXECUTE ON ADM.GET_PAYMENT_METHOD TO PU;
GRANT EXECUTE ON ADM.LIST_PAYMENT_METHODS TO PU; 