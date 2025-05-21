-- ============================================================================
-- PACKAGE: ADM_PAYMENTMETHOD_PKG
-- Description: Manages operations related to payment methods in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_PAYMENTMETHOD_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    -- Get all payment method info
    FUNCTION get_all_payment_methods
    RETURN ref_cursor_type;

END ADM_PAYMENTMETHOD_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_PAYMENTMETHOD_PKG AS

    -- Get all payment method info
    FUNCTION get_all_payment_methods
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.PAYMENTMETHOD
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_all_payment_methods;

END ADM_PAYMENTMETHOD_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.PAYMENTMETHOD TO PU;
GRANT SELECT ON ADM.PAYMENTMETHOD_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_PAYMENTMETHOD_PKG TO PU;