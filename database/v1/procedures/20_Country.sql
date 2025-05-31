-- ============================
-- COUNTRY PACKAGE
-- Description: Contains procedures to manage the countries of the system
-- ============================
CREATE OR REPLACE PACKAGE ADM.ADM_COUNTRY_PKG AS
    
    -- Create a country
    PROCEDURE create_country(p_name IN ADM.COUNTRY.name%TYPE);
    
    -- Obtain the information of countries
    FUNCTION get_all_countries RETURN SYS_REFCURSOR;
    
    -- Change the name of a country
    PROCEDURE update_country_name(p_country_id IN ADM.COUNTRY.id%TYPE, p_new_name IN ADM.COUNTRY.name%TYPE);
    
    -- Delete a country
    PROCEDURE delete_country(p_country_id IN ADM.COUNTRY.id%TYPE);
    
END ADM_COUNTRY_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_COUNTRY_PKG AS
    PROCEDURE create_country(p_name IN ADM.COUNTRY.name%TYPE) IS
    BEGIN
        INSERT INTO ADM.COUNTRY (name) VALUES (p_name);
        COMMIT;
    END;

    FUNCTION get_all_countries RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM ADM.COUNTRY;
        RETURN v_cursor;
    END;

    PROCEDURE update_country_name(p_country_id IN ADM.COUNTRY.id%TYPE, p_new_name IN ADM.COUNTRY.name%TYPE) IS
    BEGIN
        UPDATE ADM.COUNTRY SET name = p_new_name WHERE id = p_country_id;
        COMMIT;
    END;

    PROCEDURE delete_country(p_country_id IN ADM.COUNTRY.id%TYPE) IS
    BEGIN
        DELETE FROM ADM.COUNTRY WHERE id = p_country_id;
        COMMIT;
    END;
END ADM_COUNTRY_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.COUNTRY TO PU;
GRANT SELECT ON ADM.COUNTRY_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_COUNTRY_PKG TO PU;