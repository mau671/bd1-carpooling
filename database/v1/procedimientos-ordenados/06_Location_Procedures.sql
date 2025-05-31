-- =====================================================================
-- Procedures for Location Management (Country, Province, Canton, District)
-- =====================================================================
/*
 * This script creates the necessary procedures for managing location data
 * including countries, provinces, cantons and districts.
 * 
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 2. Country Procedures
-- ============================================

-- 2.1 Insert Country
CREATE OR REPLACE PROCEDURE ADM.INSERT_COUNTRY (
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO ADM.COUNTRY (
        name
    ) VALUES (
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error inserting country: ' || SQLERRM);
END INSERT_COUNTRY;
/

-- 2.2 Update Country
CREATE OR REPLACE PROCEDURE ADM.UPDATE_COUNTRY (
    p_id IN NUMBER,
    p_name IN VARCHAR2
) AS
BEGIN
    UPDATE ADM.COUNTRY
    SET name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Country not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Error updating country: ' || SQLERRM);
END UPDATE_COUNTRY;
/

-- 2.3 Delete Country
CREATE OR REPLACE PROCEDURE ADM.DELETE_COUNTRY (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if country has provinces
    SELECT COUNT(*) INTO v_count
    FROM ADM.PROVINCE
    WHERE country_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Cannot delete country with associated provinces');
    END IF;
    
    DELETE FROM ADM.COUNTRY
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Country not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20006, 'Error deleting country: ' || SQLERRM);
END DELETE_COUNTRY;
/

-- 2.4 Get Country
CREATE OR REPLACE PROCEDURE ADM.GET_COUNTRY (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.COUNTRY
        WHERE id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20007, 'Error getting country: ' || SQLERRM);
END GET_COUNTRY;
/

-- 2.5 List Countries
CREATE OR REPLACE PROCEDURE ADM.LIST_COUNTRIES (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.COUNTRY
        ORDER BY name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20008, 'Error listing countries: ' || SQLERRM);
END LIST_COUNTRIES;
/

-- 2.6 Get Country by Name
CREATE OR REPLACE PROCEDURE ADM.GET_COUNTRY_BY_NAME (
    p_name IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, creator, creation_date, modifier, modification_date
        FROM ADM.COUNTRY
        WHERE name = p_name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20039, 'Error getting country by name: ' || SQLERRM);
END GET_COUNTRY_BY_NAME;
/

-- ============================================
-- 3. Province Procedures
-- ============================================

-- 3.1 Insert Province
CREATE OR REPLACE PROCEDURE ADM.INSERT_PROVINCE (
    p_country_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    v_country_exists NUMBER;
BEGIN
    -- Validate country exists
    SELECT COUNT(*) INTO v_country_exists
    FROM ADM.COUNTRY
    WHERE id = p_country_id;
    
    IF v_country_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20009, 'Country not found with ID: ' || p_country_id);
    END IF;
    
    INSERT INTO ADM.PROVINCE (
        country_id,
        name
    ) VALUES (
        p_country_id,
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20010, 'Error inserting province: ' || SQLERRM);
END INSERT_PROVINCE;
/

-- 3.2 Update Province
CREATE OR REPLACE PROCEDURE ADM.UPDATE_PROVINCE (
    p_id IN NUMBER,
    p_country_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    v_country_exists NUMBER;
BEGIN
    -- Validate country exists
    SELECT COUNT(*) INTO v_country_exists
    FROM ADM.COUNTRY
    WHERE id = p_country_id;
    
    IF v_country_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Country not found with ID: ' || p_country_id);
    END IF;
    
    UPDATE ADM.PROVINCE
    SET country_id = p_country_id,
        name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'Province not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20013, 'Error updating province: ' || SQLERRM);
END UPDATE_PROVINCE;
/

-- 3.3 Delete Province
CREATE OR REPLACE PROCEDURE ADM.DELETE_PROVINCE (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if province has cantons
    SELECT COUNT(*) INTO v_count
    FROM ADM.CANTON
    WHERE province_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20014, 'Cannot delete province with associated cantons');
    END IF;
    
    DELETE FROM ADM.PROVINCE
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20015, 'Province not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20016, 'Error deleting province: ' || SQLERRM);
END DELETE_PROVINCE;
/

-- 3.4 Get Province
CREATE OR REPLACE PROCEDURE ADM.GET_PROVINCE (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT p.id, p.country_id, c.name as country_name, 
               p.name, p.creator, p.creation_date, 
               p.modifier, p.modification_date
        FROM ADM.PROVINCE p
        JOIN ADM.COUNTRY c ON p.country_id = c.id
        WHERE p.id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20017, 'Error getting province: ' || SQLERRM);
END GET_PROVINCE;
/

-- 3.5 List Provinces
CREATE OR REPLACE PROCEDURE ADM.LIST_PROVINCES (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT p.id, p.country_id, c.name as country_name, 
               p.name, p.creator, p.creation_date, 
               p.modifier, p.modification_date
        FROM ADM.PROVINCE p
        JOIN ADM.COUNTRY c ON p.country_id = c.id
        ORDER BY c.name, p.name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20018, 'Error listing provinces: ' || SQLERRM);
END LIST_PROVINCES;
/

-- 3.6 Get Province by Name
CREATE OR REPLACE PROCEDURE ADM.GET_PROVINCE_BY_NAME (
    p_name IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT p.id, p.country_id, c.name as country_name, 
               p.name, p.creator, p.creation_date, 
               p.modifier, p.modification_date
        FROM ADM.PROVINCE p
        JOIN ADM.COUNTRY c ON p.country_id = c.id
        WHERE p.name = p_name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20040, 'Error getting province by name: ' || SQLERRM);
END GET_PROVINCE_BY_NAME;
/

-- 3.7 List Provinces by Country
CREATE OR REPLACE PROCEDURE ADM.LIST_PROVINCES_BY_COUNTRY (
    p_country_name IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT p.id, p.country_id, c.name as country_name, 
               p.name, p.creator, p.creation_date, 
               p.modifier, p.modification_date
        FROM ADM.PROVINCE p
        JOIN ADM.COUNTRY c ON p.country_id = c.id
        WHERE c.name = p_country_name
        ORDER BY p.name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20041, 'Error listing provinces by country: ' || SQLERRM);
END LIST_PROVINCES_BY_COUNTRY;
/

-- ============================================
-- 4. Canton Procedures
-- ============================================

-- 4.1 Insert Canton
CREATE OR REPLACE PROCEDURE ADM.INSERT_CANTON (
    p_province_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    v_province_exists NUMBER;
BEGIN
    -- Validate province exists
    SELECT COUNT(*) INTO v_province_exists
    FROM ADM.PROVINCE
    WHERE id = p_province_id;
    
    IF v_province_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20019, 'Province not found with ID: ' || p_province_id);
    END IF;
    
    INSERT INTO ADM.CANTON (
        province_id,
        name
    ) VALUES (
        p_province_id,
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020, 'Error inserting canton: ' || SQLERRM);
END INSERT_CANTON;
/

-- 4.2 Update Canton
CREATE OR REPLACE PROCEDURE ADM.UPDATE_CANTON (
    p_id IN NUMBER,
    p_province_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    v_province_exists NUMBER;
BEGIN
    -- Validate province exists
    SELECT COUNT(*) INTO v_province_exists
    FROM ADM.PROVINCE
    WHERE id = p_province_id;
    
    IF v_province_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Province not found with ID: ' || p_province_id);
    END IF;
    
    UPDATE ADM.CANTON
    SET province_id = p_province_id,
        name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20022, 'Canton not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20023, 'Error updating canton: ' || SQLERRM);
END UPDATE_CANTON;
/

-- 4.3 Delete Canton
CREATE OR REPLACE PROCEDURE ADM.DELETE_CANTON (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if canton has districts
    SELECT COUNT(*) INTO v_count
    FROM ADM.DISTRICT
    WHERE canton_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20024, 'Cannot delete canton with associated districts');
    END IF;
    
    DELETE FROM ADM.CANTON
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20025, 'Canton not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20026, 'Error deleting canton: ' || SQLERRM);
END DELETE_CANTON;
/

-- 4.4 Get Canton
CREATE OR REPLACE PROCEDURE ADM.GET_CANTON (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT c.id, c.province_id, p.name as province_name,
               c.name, c.creator, c.creation_date,
               c.modifier, c.modification_date
        FROM ADM.CANTON c
        JOIN ADM.PROVINCE p ON c.province_id = p.id
        WHERE c.id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20027, 'Error getting canton: ' || SQLERRM);
END GET_CANTON;
/

-- 4.5 List Cantons
CREATE OR REPLACE PROCEDURE ADM.LIST_CANTONS (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT c.id, c.province_id, p.name as province_name,
               c.name, c.creator, c.creation_date,
               c.modifier, c.modification_date
        FROM ADM.CANTON c
        JOIN ADM.PROVINCE p ON c.province_id = p.id
        ORDER BY p.name, c.name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20028, 'Error listing cantons: ' || SQLERRM);
END LIST_CANTONS;
/

-- 4.6 Get Canton by Name
CREATE OR REPLACE PROCEDURE ADM.GET_CANTON_BY_NAME (
    p_name IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT c.id, c.province_id, p.name as province_name,
               c.name, c.creator, c.creation_date,
               c.modifier, c.modification_date
        FROM ADM.CANTON c
        JOIN ADM.PROVINCE p ON c.province_id = p.id
        WHERE c.name = p_name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20042, 'Error getting canton by name: ' || SQLERRM);
END GET_CANTON_BY_NAME;
/

-- 4.7 List Cantons by Province
CREATE OR REPLACE PROCEDURE ADM.LIST_CANTONS_BY_PROVINCE (
    p_province_name IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT c.id, c.province_id, p.name as province_name,
               c.name, c.creator, c.creation_date,
               c.modifier, c.modification_date
        FROM ADM.CANTON c
        JOIN ADM.PROVINCE p ON c.province_id = p.id
        WHERE p.name = p_province_name
        ORDER BY c.name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20043, 'Error listing cantons by province: ' || SQLERRM);
END LIST_CANTONS_BY_PROVINCE;
/

-- ============================================
-- 5. District Procedures
-- ============================================

-- 5.1 Insert District
CREATE OR REPLACE PROCEDURE ADM.INSERT_DISTRICT (
    p_canton_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    v_canton_exists NUMBER;
BEGIN
    -- Validate canton exists
    SELECT COUNT(*) INTO v_canton_exists
    FROM ADM.CANTON
    WHERE id = p_canton_id;
    
    IF v_canton_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20029, 'Canton not found with ID: ' || p_canton_id);
    END IF;
    
    INSERT INTO ADM.DISTRICT (
        canton_id,
        name
    ) VALUES (
        p_canton_id,
        p_name
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20030, 'Error inserting district: ' || SQLERRM);
END INSERT_DISTRICT;
/

-- 5.2 Update District
CREATE OR REPLACE PROCEDURE ADM.UPDATE_DISTRICT (
    p_id IN NUMBER,
    p_canton_id IN NUMBER,
    p_name IN VARCHAR2
) AS
    v_canton_exists NUMBER;
BEGIN
    -- Validate canton exists
    SELECT COUNT(*) INTO v_canton_exists
    FROM ADM.CANTON
    WHERE id = p_canton_id;
    
    IF v_canton_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20031, 'Canton not found with ID: ' || p_canton_id);
    END IF;
    
    UPDATE ADM.DISTRICT
    SET canton_id = p_canton_id,
        name = p_name
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20032, 'District not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20033, 'Error updating district: ' || SQLERRM);
END UPDATE_DISTRICT;
/

-- 5.3 Delete District
CREATE OR REPLACE PROCEDURE ADM.DELETE_DISTRICT (
    p_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if district is used in waypoints
    SELECT COUNT(*) INTO v_count
    FROM PU.WAYPOINT
    WHERE district_id = p_id;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20034, 'Cannot delete district that is used in waypoints');
    END IF;
    
    DELETE FROM ADM.DISTRICT
    WHERE id = p_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20035, 'District not found with ID: ' || p_id);
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20036, 'Error deleting district: ' || SQLERRM);
END DELETE_DISTRICT;
/

-- 5.4 Get District
CREATE OR REPLACE PROCEDURE ADM.GET_DISTRICT (
    p_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT d.id, d.canton_id, c.name as canton_name,
               d.name, d.creator, d.creation_date,
               d.modifier, d.modification_date
        FROM ADM.DISTRICT d
        JOIN ADM.CANTON c ON d.canton_id = c.id
        WHERE d.id = p_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20037, 'Error getting district: ' || SQLERRM);
END GET_DISTRICT;
/

-- 5.5 List Districts
CREATE OR REPLACE PROCEDURE ADM.LIST_DISTRICTS (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT d.id, d.canton_id, c.name as canton_name,
               d.name, d.creator, d.creation_date,
               d.modifier, d.modification_date
        FROM ADM.DISTRICT d
        JOIN ADM.CANTON c ON d.canton_id = c.id
        ORDER BY c.name, d.name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20038, 'Error listing districts: ' || SQLERRM);
END LIST_DISTRICTS;
/

-- ============================================
-- 6. Grants for Location Procedures
-- ============================================
GRANT EXECUTE ON ADM.INSERT_COUNTRY TO PU;
GRANT EXECUTE ON ADM.UPDATE_COUNTRY TO PU;
GRANT EXECUTE ON ADM.DELETE_COUNTRY TO PU;
GRANT EXECUTE ON ADM.GET_COUNTRY TO PU;
GRANT EXECUTE ON ADM.LIST_COUNTRIES TO PU;

GRANT EXECUTE ON ADM.INSERT_PROVINCE TO PU;
GRANT EXECUTE ON ADM.UPDATE_PROVINCE TO PU;
GRANT EXECUTE ON ADM.DELETE_PROVINCE TO PU;
GRANT EXECUTE ON ADM.GET_PROVINCE TO PU;
GRANT EXECUTE ON ADM.LIST_PROVINCES TO PU;

GRANT EXECUTE ON ADM.INSERT_CANTON TO PU;
GRANT EXECUTE ON ADM.UPDATE_CANTON TO PU;
GRANT EXECUTE ON ADM.DELETE_CANTON TO PU;
GRANT EXECUTE ON ADM.GET_CANTON TO PU;
GRANT EXECUTE ON ADM.LIST_CANTONS TO PU;

GRANT EXECUTE ON ADM.INSERT_DISTRICT TO PU;
GRANT EXECUTE ON ADM.UPDATE_DISTRICT TO PU;
GRANT EXECUTE ON ADM.DELETE_DISTRICT TO PU;
GRANT EXECUTE ON ADM.GET_DISTRICT TO PU;
GRANT EXECUTE ON ADM.LIST_DISTRICTS TO PU;

-- Grants for new procedures
GRANT EXECUTE ON ADM.GET_COUNTRY_BY_NAME TO PU;
GRANT EXECUTE ON ADM.GET_PROVINCE_BY_NAME TO PU;
GRANT EXECUTE ON ADM.LIST_PROVINCES_BY_COUNTRY TO PU;
GRANT EXECUTE ON ADM.GET_CANTON_BY_NAME TO PU;
GRANT EXECUTE ON ADM.LIST_CANTONS_BY_PROVINCE TO PU; 