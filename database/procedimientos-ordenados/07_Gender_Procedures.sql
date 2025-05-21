-- =====================================================================
-- Procedures for Gender Management
-- =====================================================================
/*
 * This script creates the necessary procedures for managing gender data.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Insert Gender
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.INSERT_GENDER (
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.GENDER (
        name
    ) VALUES (
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20039, 'Error inserting gender: ' || SQLERRM);
END INSERT_GENDER;
/

-- ============================================
-- 2. Update Gender
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.UPDATE_GENDER (
    p_id IN NUMBER,
    p_name IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.GENDER
    SET name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20040, 'Gender not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20041, 'Error updating gender: ' || SQLERRM);
END UPDATE_GENDER;
/

-- ============================================
-- 3. Delete Gender
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.DELETE_GENDER (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if gender is used in persons
    SELECT COUNT(*) INTO v_count
    FROM ADM.PERSON
    WHERE gender_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20042, 'Cannot delete gender that is used in persons');
    END IF;
    
    DELETE FROM ADM.GENDER
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20043, 'Gender not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20044, 'Error deleting gender: ' || SQLERRM);
END DELETE_GENDER;
/

-- ============================================
-- 4. Get Gender
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_GENDER (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.GENDER
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20045, 'Error getting gender: ' || SQLERRM);
END GET_GENDER;
/

-- ============================================
-- 5. List Genders
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.LIST_GENDERS (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.GENDER
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20046, 'Error listing genders: ' || SQLERRM);
END LIST_GENDERS;
/

-- ============================================
-- 6. Grants for Gender Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_GENDER TO PU;
GRANT EXECUTE ON ADM.UPDATE_GENDER TO PU;
GRANT EXECUTE ON ADM.DELETE_GENDER TO PU;
GRANT EXECUTE ON ADM.GET_GENDER TO PU;
GRANT EXECUTE ON ADM.LIST_GENDERS TO PU; 