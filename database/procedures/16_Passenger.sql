-- ============================================================================
-- PACKAGE: PU_PASSENGER_PKG
-- Description: Manages operations related to the passengers in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_PASSENGER_PKG AS

    -- Obtain the info of the passenger
    FUNCTION get_passenger_info(p_person_id IN NUMBER) RETURN SYS_REFCURSOR;

    -- Delete a passenger
    PROCEDURE delete_passenger(p_person_id IN NUMBER);

END PU_PASSENGER_PKG;
/


CREATE OR REPLACE PACKAGE BODY PU.PU_PASSENGER_PKG AS

    -- Obtain a passenger's info
    FUNCTION get_passenger_info(p_person_id IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT p.person_id, u.first_name, u.second_name, u.first_surname,
                   u.second_surname, u.identification_number, u.date_of_birth
            FROM PU.PASSENGER p
            JOIN ADM.PERSON u ON u.id = p.person_id
            WHERE p.person_id = p_person_id;
        RETURN v_cursor;
    END;

    -- Delete a passenger
    PROCEDURE delete_passenger(p_person_id IN NUMBER) IS
    BEGIN
        DELETE FROM PU.PASSENGER WHERE person_id = p_person_id;
        COMMIT;
    END;

END PU_PASSENGER_PKG;
/