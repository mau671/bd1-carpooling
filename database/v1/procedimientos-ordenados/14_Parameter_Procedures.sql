-- =====================================================================
-- Procedures for System Parameter Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing system parameters.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Parameter Procedures
-- ============================================

-- 1.1 Insert Parameter
CREATE OR REPLACE PROCEDURE ADM.INSERT_PARAMETER (
    p_name IN VARCHAR2,
    p_value IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.PARAMETER (
        name,
        value
    ) VALUES (
        p_name,
        p_value
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20095, 'Error inserting parameter: ' || SQLERRM);
END INSERT_PARAMETER;
/

-- 1.2 Update Parameter
CREATE OR REPLACE PROCEDURE ADM.UPDATE_PARAMETER (
    p_id IN NUMBER,
    p_name IN VARCHAR2,
    p_value IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.PARAMETER
    SET name = p_name,
        value = p_value
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20096, 'Parameter not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20097, 'Error updating parameter: ' || SQLERRM);
END UPDATE_PARAMETER;
/

-- 1.3 Delete Parameter
CREATE OR REPLACE PROCEDURE ADM.DELETE_PARAMETER (
    p_id IN NUMBER
) AS
BEGIN
    DELETE FROM ADM.PARAMETER
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20098, 'Parameter not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20099, 'Error deleting parameter: ' || SQLERRM);
END DELETE_PARAMETER;
/

-- 1.4 Get Parameter
CREATE OR REPLACE PROCEDURE ADM.GET_PARAMETER (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, value
        FROM ADM.PARAMETER
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20100, 'Error getting parameter: ' || SQLERRM);
END GET_PARAMETER;
/

-- 1.5 List Parameters
CREATE OR REPLACE PROCEDURE ADM.LIST_PARAMETERS (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, value
        FROM ADM.PARAMETER
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, 'Error listing parameters: ' || SQLERRM);
END LIST_PARAMETERS;
/

-- 1.6 Get Parameter by Name
CREATE OR REPLACE PROCEDURE ADM.GET_PARAMETER_BY_NAME (
    p_name IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, value
        FROM ADM.PARAMETER
        WHERE name = p_name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20102, 'Error getting parameter by name: ' || SQLERRM);
END GET_PARAMETER_BY_NAME;
/

-- ============================================
-- 2. Grants for Parameter Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_PARAMETER TO PU;
GRANT EXECUTE ON ADM.UPDATE_PARAMETER TO PU;
GRANT EXECUTE ON ADM.DELETE_PARAMETER TO PU;
GRANT EXECUTE ON ADM.GET_PARAMETER TO PU;
GRANT EXECUTE ON ADM.LIST_PARAMETERS TO PU;
GRANT EXECUTE ON ADM.GET_PARAMETER_BY_NAME TO PU; 