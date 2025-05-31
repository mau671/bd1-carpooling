-- ============================
-- DISTRICT PACKAGE
-- Description: Contains procedures to manage the districts of the system
-- ============================
CREATE OR REPLACE PACKAGE ADM.ADM_DISTRICT_PKG AS
    
    -- Create a district
    PROCEDURE create_district(p_name IN ADM.DISTRICT.name%TYPE, p_canton_id IN ADM.DISTRICT.canton_id%TYPE);
    
    -- Obtain the information of districts
    FUNCTION get_all_districts RETURN SYS_REFCURSOR;
    
    -- Find district based on canton
    FUNCTION get_districts_by_canton(p_canton_id IN ADM.DISTRICT.canton_id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Change the name of a district
    PROCEDURE update_district_name(p_district_id IN ADM.DISTRICT.id%TYPE, p_new_name IN ADM.DISTRICT.name%TYPE);
    
    -- Delete a district
    PROCEDURE delete_district(p_district_id IN ADM.DISTRICT.id%TYPE);
    
END ADM_DISTRICT_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_DISTRICT_PKG AS
    PROCEDURE create_district(p_name IN ADM.DISTRICT.name%TYPE, p_canton_id IN ADM.DISTRICT.canton_id%TYPE) IS
    BEGIN
        INSERT INTO ADM.DISTRICT (name, canton_id) VALUES (p_name, p_canton_id);
        COMMIT;
    END;

    FUNCTION get_all_districts RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.DISTRICT;
        RETURN v_cursor;
    END;

    FUNCTION get_districts_by_canton(p_canton_id IN ADM.DISTRICT.canton_id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.DISTRICT WHERE canton_id = p_canton_id;
        RETURN v_cursor;
    END;

    PROCEDURE update_district_name(p_district_id IN ADM.DISTRICT.id%TYPE, p_new_name IN ADM.DISTRICT.name%TYPE) IS
    BEGIN
        UPDATE ADM.DISTRICT SET name = p_new_name WHERE id = p_district_id;
        COMMIT;
    END;

    PROCEDURE delete_district(p_district_id IN ADM.DISTRICT.id%TYPE) IS
    BEGIN
        DELETE FROM ADM.DISTRICT WHERE id = p_district_id;
        COMMIT;
    END;
END ADM_DISTRICT_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.DISTRICT TO PU;
GRANT SELECT ON ADM.DISTRICT_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_DISTRICT_PKG TO PU;