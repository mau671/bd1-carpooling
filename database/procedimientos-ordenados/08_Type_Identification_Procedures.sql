-- =====================================================================
-- Procedures for Type Identification Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing type identification data.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Insert Type Identification
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.INSERT_TYPE_IDENTIFICATION (
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.TYPE_IDENTIFICATION (
        name
    ) VALUES (
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20047, 'Error inserting type identification: ' || SQLERRM);
END INSERT_TYPE_IDENTIFICATION;
/

-- ============================================
-- 2. Update Type Identification
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.UPDATE_TYPE_IDENTIFICATION (
    p_id IN NUMBER,
    p_name IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.TYPE_IDENTIFICATION
    SET name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20048, 'Type identification not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20049, 'Error updating type identification: ' || SQLERRM);
END UPDATE_TYPE_IDENTIFICATION;
/

-- ============================================
-- 3. Delete Type Identification
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.DELETE_TYPE_IDENTIFICATION (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if type identification is used in persons
    SELECT COUNT(*) INTO v_count
    FROM ADM.PERSON
    WHERE type_identification_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20050, 'Cannot delete type identification that is used in persons');
    END IF;
    
    DELETE FROM ADM.TYPE_IDENTIFICATION
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20051, 'Type identification not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20052, 'Error deleting type identification: ' || SQLERRM);
END DELETE_TYPE_IDENTIFICATION;
/

-- ============================================
-- 4. Get Type Identification
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_TYPE_IDENTIFICATION (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.TYPE_IDENTIFICATION
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20053, 'Error getting type identification: ' || SQLERRM);
END GET_TYPE_IDENTIFICATION;
/

-- ============================================
-- 5. List Type Identifications
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.LIST_TYPE_IDENTIFICATIONS (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.TYPE_IDENTIFICATION
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20054, 'Error listing type identifications: ' || SQLERRM);
END LIST_TYPE_IDENTIFICATIONS;
/

-- ============================================
-- 6. Grants for Type Identification Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_TYPE_IDENTIFICATION TO PU;
GRANT EXECUTE ON ADM.UPDATE_TYPE_IDENTIFICATION TO PU;
GRANT EXECUTE ON ADM.DELETE_TYPE_IDENTIFICATION TO PU;
GRANT EXECUTE ON ADM.GET_TYPE_IDENTIFICATION TO PU;
GRANT EXECUTE ON ADM.LIST_TYPE_IDENTIFICATIONS TO PU; 