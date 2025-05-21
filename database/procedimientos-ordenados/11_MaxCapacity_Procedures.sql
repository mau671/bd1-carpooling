-- =====================================================================
-- Procedures for Max Capacity Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing max capacity data.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Max Capacity Procedures
-- ============================================

-- 1.1 Insert Max Capacity
CREATE OR REPLACE PROCEDURE ADM.INSERT_MAX_CAPACITY (
    p_capacity IN NUMBER
) AS
BEGIN
    INSERT INTO ADM.MAXCAPACITY (
        capacity
    ) VALUES (
        p_capacity
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20071, 'Error inserting max capacity: ' || SQLERRM);
END INSERT_MAX_CAPACITY;
/

-- 1.2 Update Max Capacity
CREATE OR REPLACE PROCEDURE ADM.UPDATE_MAX_CAPACITY (
    p_id IN NUMBER,
    p_capacity IN NUMBER
) AS
BEGIN
    UPDATE ADM.MAXCAPACITY
    SET capacity = p_capacity
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20072, 'Max capacity not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20073, 'Error updating max capacity: ' || SQLERRM);
END UPDATE_MAX_CAPACITY;
/

-- 1.3 Delete Max Capacity
CREATE OR REPLACE PROCEDURE ADM.DELETE_MAX_CAPACITY (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if max capacity is used in trips
    SELECT COUNT(*) INTO v_count
    FROM PU.TRIP
    WHERE max_capacity_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20074, 'Cannot delete max capacity that is used in trips');
    END IF;
    
    DELETE FROM ADM.MAXCAPACITY
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20075, 'Max capacity not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20076, 'Error deleting max capacity: ' || SQLERRM);
END DELETE_MAX_CAPACITY;
/

-- 1.4 Get Max Capacity
CREATE OR REPLACE PROCEDURE ADM.GET_MAX_CAPACITY (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, capacity, creator, creation_date, modifier, modification_date
        FROM ADM.MAXCAPACITY
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20077, 'Error getting max capacity: ' || SQLERRM);
END GET_MAX_CAPACITY;
/

-- 1.5 List Max Capacities
CREATE OR REPLACE PROCEDURE ADM.LIST_MAX_CAPACITIES (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, capacity, creator, creation_date, modifier, modification_date
        FROM ADM.MAXCAPACITY
        ORDER BY capacity;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20078, 'Error listing max capacities: ' || SQLERRM);
END LIST_MAX_CAPACITIES;
/

-- ============================================
-- 2. Grants for Max Capacity Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_MAX_CAPACITY TO PU;
GRANT EXECUTE ON ADM.UPDATE_MAX_CAPACITY TO PU;
GRANT EXECUTE ON ADM.DELETE_MAX_CAPACITY TO PU;
GRANT EXECUTE ON ADM.GET_MAX_CAPACITY TO PU;
GRANT EXECUTE ON ADM.LIST_MAX_CAPACITIES TO PU; 