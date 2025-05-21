-- =====================================================================
-- Procedures for Status Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing status data.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Status Procedures
-- ============================================

-- 1.1 Insert Status
CREATE OR REPLACE PROCEDURE ADM.INSERT_STATUS (
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.STATUS (
        name
    ) VALUES (
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20063, 'Error inserting status: ' || SQLERRM);
END INSERT_STATUS;
/

-- 1.2 Update Status
CREATE OR REPLACE PROCEDURE ADM.UPDATE_STATUS (
    p_id IN NUMBER,
    p_name IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.STATUS
    SET name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20064, 'Status not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20065, 'Error updating status: ' || SQLERRM);
END UPDATE_STATUS;
/

-- 1.3 Delete Status
CREATE OR REPLACE PROCEDURE ADM.DELETE_STATUS (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if status is used in trips
    SELECT COUNT(*) INTO v_count
    FROM PU.TRIP
    WHERE status_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20066, 'Cannot delete status that is used in trips');
    END IF;
    
    DELETE FROM ADM.STATUS
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20067, 'Status not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20068, 'Error deleting status: ' || SQLERRM);
END DELETE_STATUS;
/

-- 1.4 Get Status
CREATE OR REPLACE PROCEDURE ADM.GET_STATUS (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.STATUS
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20069, 'Error getting status: ' || SQLERRM);
END GET_STATUS;
/

-- 1.5 List Statuses
CREATE OR REPLACE PROCEDURE ADM.LIST_STATUSES (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.STATUS
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20070, 'Error listing statuses: ' || SQLERRM);
END LIST_STATUSES;
/

-- ============================================
-- 2. Grants for Status Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_STATUS TO PU;
GRANT EXECUTE ON ADM.UPDATE_STATUS TO PU;
GRANT EXECUTE ON ADM.DELETE_STATUS TO PU;
GRANT EXECUTE ON ADM.GET_STATUS TO PU;
GRANT EXECUTE ON ADM.LIST_STATUSES TO PU; 