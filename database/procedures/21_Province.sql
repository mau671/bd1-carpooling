-- ============================
-- PROVINCE PACKAGE
-- Description: Contains procedures to manage the provinces of the system
-- ============================
CREATE OR REPLACE PACKAGE ADM.ADM_PROVINCE_PKG AS
    
    -- Create a province
    PROCEDURE create_province(p_name IN ADM.PROVINCE.name%TYPE, p_country_id IN ADM.PROVINCE.country_id%TYPE);
    
    -- Obtain the information of provinces
    FUNCTION get_all_provinces RETURN SYS_REFCURSOR;
    
    -- Find province based on country
    FUNCTION get_provinces_by_country(p_country_id IN ADM.PROVINCE.country_id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Change the name of a province
    PROCEDURE update_province_name(p_province_id IN ADM.PROVINCE.id%TYPE, p_new_name IN ADM.PROVINCE.name%TYPE);
    
    -- Delete a province
    PROCEDURE delete_province(p_province_id IN ADM.PROVINCE.id%TYPE);
    
END ADM_PROVINCE_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_PROVINCE_PKG AS
    PROCEDURE create_province(p_name IN ADM.PROVINCE.name%TYPE, p_country_id IN ADM.PROVINCE.country_id%TYPE) IS
    BEGIN
        INSERT INTO ADM.PROVINCE (name, country_id) VALUES (p_name, p_country_id);
        COMMIT;
    END;

    FUNCTION get_all_provinces RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.PROVINCE;
        RETURN v_cursor;
    END;

    FUNCTION get_provinces_by_country(p_country_id IN ADM.PROVINCE.country_id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.PROVINCE WHERE country_id = p_country_id;
        RETURN v_cursor;
    END;

    PROCEDURE update_province_name(p_province_id IN ADM.PROVINCE.id%TYPE, p_new_name IN ADM.PROVINCE.name%TYPE) IS
    BEGIN
        UPDATE ADM.PROVINCE SET name = p_new_name WHERE id = p_province_id;
        COMMIT;
    END;

    PROCEDURE delete_province(p_province_id IN ADM.PROVINCE.id%TYPE) IS
    BEGIN
        DELETE FROM ADM.PROVINCE WHERE id = p_province_id;
        COMMIT;
    END;
END ADM_PROVINCE_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.PROVINCE TO PU;
GRANT SELECT ON ADM.PROVINCE_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_PROVINCE_PKG TO PU;