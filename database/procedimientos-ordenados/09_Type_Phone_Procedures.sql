-- =====================================================================
-- Procedures for Type Phone Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing type phone data.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Insert Type Phone
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.INSERT_TYPE_PHONE (
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.TYPE_PHONE (
        name
    ) VALUES (
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20055, 'Error inserting type phone: ' || SQLERRM);
END INSERT_TYPE_PHONE;
/

-- ============================================
-- 2. Update Type Phone
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.UPDATE_TYPE_PHONE (
    p_id IN NUMBER,
    p_name IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.TYPE_PHONE
    SET name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20056, 'Type phone not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20057, 'Error updating type phone: ' || SQLERRM);
END UPDATE_TYPE_PHONE;
/

-- ============================================
-- 3. Delete Type Phone
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.DELETE_TYPE_PHONE (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if type phone is used in phones
    SELECT COUNT(*) INTO v_count
    FROM PU.PHONE
    WHERE type_phone_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20058, 'Cannot delete type phone that is used in phones');
    END IF;
    
    DELETE FROM ADM.TYPE_PHONE
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20059, 'Type phone not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20060, 'Error deleting type phone: ' || SQLERRM);
END DELETE_TYPE_PHONE;
/

-- ============================================
-- 4. Get Type Phone
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_TYPE_PHONE (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.TYPE_PHONE
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20061, 'Error getting type phone: ' || SQLERRM);
END GET_TYPE_PHONE;
/

-- ============================================
-- 5. List Type Phones
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.LIST_TYPE_PHONES (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.TYPE_PHONE
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20062, 'Error listing type phones: ' || SQLERRM);
END LIST_TYPE_PHONES;
/

-- ============================================
-- 6. Grants for Type Phone Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_TYPE_PHONE TO PU;
GRANT EXECUTE ON ADM.UPDATE_TYPE_PHONE TO PU;
GRANT EXECUTE ON ADM.DELETE_TYPE_PHONE TO PU;
GRANT EXECUTE ON ADM.GET_TYPE_PHONE TO PU;
GRANT EXECUTE ON ADM.LIST_TYPE_PHONES TO PU; 