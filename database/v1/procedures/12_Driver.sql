-- ============================================================================
-- PACKAGE: ADM_DRIVER_PKG
-- Description: Manages operations related to the drivers in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_DRIVER_PKG AS
    
    -- Obtain the info of the driver
    FUNCTION get_driver_info(p_person_id IN NUMBER) RETURN SYS_REFCURSOR;
    
    -- Delete a driver
    PROCEDURE delete_driver(p_person_id IN NUMBER);
    
END PU_DRIVER_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_DRIVER_PKG AS
    
    -- Obtain a driver's info
    FUNCTION get_driver_info(p_person_id IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT d.person_id, u.first_name, u.second_name, u.first_surname,
                   u.second_surname, u.identification_number, u.date_of_birth
            FROM PU.DRIVER d
            JOIN ADM.PERSON u ON u.id = d.person_id
            WHERE d.person_id = p_person_id;
        RETURN v_cursor;
    END;

    -- Delete a driver
    PROCEDURE delete_driver(p_person_id IN NUMBER) IS
    BEGIN
        DELETE FROM PU.DRIVER WHERE person_id = p_person_id;
        COMMIT;
    END;

END PU_DRIVER_PKG;
/