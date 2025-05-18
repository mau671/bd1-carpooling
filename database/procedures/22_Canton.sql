-- ============================
-- CANTON PACKAGE
-- Description: Contains procedures to manage the cantons of the system
-- ============================
CREATE OR REPLACE PACKAGE ADM.ADM_CANTON_PKG AS
    
    -- Create a canton
    PROCEDURE create_canton(p_name IN ADM.CANTON.name%TYPE, p_province_id IN ADM.CANTON.province_id%TYPE);
    
    -- Obtain the information of cantons
    FUNCTION get_all_cantons RETURN SYS_REFCURSOR;
    
    -- Find canton based on province
    FUNCTION get_cantons_by_province(p_province_id IN ADM.CANTON.province_id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Change the name of a canton
    PROCEDURE update_canton_name(p_canton_id IN ADM.CANTON.id%TYPE, p_new_name IN ADM.CANTON.name%TYPE);
    
    -- Delete a canton
    PROCEDURE delete_canton(p_canton_id IN ADM.CANTON.id%TYPE);
    
END ADM_CANTON_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_CANTON_PKG AS
    PROCEDURE create_canton(p_name IN ADM.CANTON.name%TYPE, p_province_id IN ADM.CANTON.province_id%TYPE) IS
    BEGIN
        INSERT INTO ADM.CANTON (name, province_id) VALUES (p_name, p_province_id);
        COMMIT;
    END;

    FUNCTION get_all_cantons RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.CANTON;
        RETURN v_cursor;
    END;

    FUNCTION get_cantons_by_province(p_province_id IN ADM.CANTON.province_id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.CANTON WHERE province_id = p_province_id;
        RETURN v_cursor;
    END;

    PROCEDURE update_canton_name(p_canton_id IN ADM.CANTON.id%TYPE, p_new_name IN ADM.CANTON.name%TYPE) IS
    BEGIN
        UPDATE ADM.CANTON SET name = p_new_name WHERE id = p_canton_id;
        COMMIT;
    END;

    PROCEDURE delete_canton(p_canton_id IN ADM.CANTON.id%TYPE) IS
    BEGIN
        DELETE FROM ADM.CANTON WHERE id = p_canton_id;
        COMMIT;
    END;
END ADM_CANTON_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.CANTON TO PU;
GRANT SELECT ON ADM.CANTON_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_CANTON_PKG TO PU;