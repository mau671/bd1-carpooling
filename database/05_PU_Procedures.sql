-- Ejecutar como usuario PU o con privilegios apropiados
---------------------------------------------------------------------------
-- Package Specification: USER_AUTH_PKG
-- Purpose: Manages user authentication and role assignments
-- Author: System Administrator
-- Created: [Date]
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PU.USER_AUTH_PKG AS
    -- Constants for status codes
    STATUS_SUCCESS CONSTANT NUMBER := 1;
    STATUS_FAILURE CONSTANT NUMBER := 0;
    
    -- Procedure to register a new user
    PROCEDURE REGISTER_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_person_id IN NUMBER,
        p_user_id OUT NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to validate user credentials
    PROCEDURE VALIDATE_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_user_id OUT NUMBER,
        p_person_id OUT NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to check if a person is a driver
    PROCEDURE CHECK_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_is_driver OUT NUMBER
    );
    
    -- Procedure to check if a person is a passenger
    PROCEDURE CHECK_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_is_passenger OUT NUMBER
    );
    
    -- Procedure to add driver role to a person
    PROCEDURE ADD_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to add passenger role to a person
    PROCEDURE ADD_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to remove driver role from a person
    PROCEDURE REMOVE_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to remove passenger role from a person
    PROCEDURE REMOVE_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    );
END USER_AUTH_PKG;
/

---------------------------------------------------------------------------
-- Package Body: USER_AUTH_PKG
-- Implementation of user authentication functionality
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PU.USER_AUTH_PKG AS
    PROCEDURE REGISTER_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_person_id IN NUMBER,
        p_user_id OUT NUMBER,
        p_success OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        -- Check if username already exists
        SELECT COUNT(*) INTO v_count
        FROM PU.PERSONUSER
        WHERE USERNAME = p_username;
        
        IF v_count > 0 THEN
            p_success := STATUS_FAILURE; -- Username already exists
            RETURN;
        END IF;
        
        -- Insert new user
        INSERT INTO PU.PERSONUSER (USERNAME, PASSWORD, PERSON_ID)
        VALUES (p_username, p_password, p_person_id)
        RETURNING ID INTO p_user_id;
        
        p_success := STATUS_SUCCESS; -- Registration successful
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := STATUS_FAILURE;
            ROLLBACK;
            RAISE;
    END REGISTER_USER;
    
    PROCEDURE VALIDATE_USER(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_user_id OUT NUMBER,
        p_person_id OUT NUMBER,
        p_success OUT NUMBER
    ) IS
    BEGIN
        SELECT ID, PERSON_ID INTO p_user_id, p_person_id
        FROM PU.PERSONUSER
        WHERE USERNAME = p_username
        AND PASSWORD = p_password;
        
        p_success := STATUS_SUCCESS; -- Authentication successful
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_success := STATUS_FAILURE; -- Invalid credentials
            p_user_id := NULL;
            p_person_id := NULL;
        WHEN OTHERS THEN
            p_success := STATUS_FAILURE;
            RAISE;
    END VALIDATE_USER;
    
    PROCEDURE CHECK_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_is_driver OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM PU.DRIVER
        WHERE person_id = p_person_id;
        
        p_is_driver := CASE WHEN v_count > 0 THEN STATUS_SUCCESS ELSE STATUS_FAILURE END;
    EXCEPTION
        WHEN OTHERS THEN
            p_is_driver := STATUS_FAILURE;
            RAISE;
    END CHECK_DRIVER_ROLE;
    
    PROCEDURE CHECK_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_is_passenger OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM PU.PASSENGER
        WHERE person_id = p_person_id;
        
        p_is_passenger := CASE WHEN v_count > 0 THEN STATUS_SUCCESS ELSE STATUS_FAILURE END;
    EXCEPTION
        WHEN OTHERS THEN
            p_is_passenger := STATUS_FAILURE;
            RAISE;
    END CHECK_PASSENGER_ROLE;
    
    PROCEDURE ADD_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        -- Check if person exists
        SELECT COUNT(*) INTO v_count
        FROM ADM.PERSON
        WHERE id = p_person_id;
        
        IF v_count = 0 THEN
            p_success := STATUS_FAILURE;
            RETURN;
        END IF;
        
        -- Check if already has driver role
        SELECT COUNT(*) INTO v_count
        FROM PU.DRIVER
        WHERE person_id = p_person_id;
        
        IF v_count > 0 THEN
            p_success := STATUS_FAILURE;
            RETURN;
        END IF;
        
        -- Add driver role
        INSERT INTO PU.DRIVER (person_id)
        VALUES (p_person_id);
        
        p_success := STATUS_SUCCESS;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := STATUS_FAILURE;
            ROLLBACK;
    END ADD_DRIVER_ROLE;
    
    PROCEDURE ADD_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    ) IS
        v_count NUMBER;
    BEGIN
        -- Check if person exists
        SELECT COUNT(*) INTO v_count
        FROM ADM.PERSON
        WHERE id = p_person_id;
        
        IF v_count = 0 THEN
            p_success := STATUS_FAILURE;
            RETURN;
        END IF;
        
        -- Check if already has passenger role
        SELECT COUNT(*) INTO v_count
        FROM PU.PASSENGER
        WHERE person_id = p_person_id;
        
        IF v_count > 0 THEN
            p_success := STATUS_FAILURE;
            RETURN;
        END IF;
        
        -- Add passenger role
        INSERT INTO PU.PASSENGER (person_id)
        VALUES (p_person_id);
        
        p_success := STATUS_SUCCESS;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := STATUS_FAILURE;
            ROLLBACK;
    END ADD_PASSENGER_ROLE;
    
    PROCEDURE REMOVE_DRIVER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    ) IS
    BEGIN
        DELETE FROM PU.DRIVER
        WHERE person_id = p_person_id;
        
        p_success := STATUS_SUCCESS;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := STATUS_FAILURE;
            ROLLBACK;
    END REMOVE_DRIVER_ROLE;
    
    PROCEDURE REMOVE_PASSENGER_ROLE(
        p_person_id IN NUMBER,
        p_success OUT NUMBER
    ) IS
    BEGIN
        DELETE FROM PU.PASSENGER
        WHERE person_id = p_person_id;
        
        p_success := STATUS_SUCCESS;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := STATUS_FAILURE;
            ROLLBACK;
    END REMOVE_PASSENGER_ROLE;
END USER_AUTH_PKG;
/

---------------------------------------------------------------------------
-- Package Specification: TRIP_MANAGEMENT_PKG
-- Purpose: Manages trip-related operations
-- Author: System Administrator
-- Created: [Date]
---------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PU.TRIP_MANAGEMENT_PKG AS
    -- Function to create a new trip
    PROCEDURE CREATE_TRIP(
        p_vehicle_id IN NUMBER,
        p_route_id IN NUMBER,
        p_trip_id OUT NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to add passenger to trip
    PROCEDURE ADD_PASSENGER_TO_TRIP(
        p_passenger_id IN NUMBER,
        p_trip_id IN NUMBER,
        p_amount IN NUMBER,
        p_success OUT NUMBER
    );
    
    -- Procedure to update trip status
    PROCEDURE UPDATE_TRIP_STATUS(
        p_trip_id IN NUMBER,
        p_status_id IN NUMBER,
        p_success OUT NUMBER
    );
    
    -- Function to get trips by driver
    FUNCTION GET_TRIPS_BY_DRIVER(
        p_driver_id IN NUMBER
    ) RETURN SYS_REFCURSOR;
    
    -- Function to get trips by passenger
    FUNCTION GET_TRIPS_BY_PASSENGER(
        p_passenger_id IN NUMBER
    ) RETURN SYS_REFCURSOR;
END TRIP_MANAGEMENT_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.TRIP_MANAGEMENT_PKG AS
    PROCEDURE CREATE_TRIP(
        p_vehicle_id IN NUMBER,
        p_route_id IN NUMBER,
        p_trip_id OUT NUMBER,
        p_success OUT NUMBER
    ) IS
    BEGIN
        INSERT INTO PU.TRIP (vehicle_id, route_id)
        VALUES (p_vehicle_id, p_route_id)
        RETURNING id INTO p_trip_id;
        
        p_success := 1; -- Success
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := 0; -- Failure
            ROLLBACK;
    END CREATE_TRIP;
    
    PROCEDURE ADD_PASSENGER_TO_TRIP(
        p_passenger_id IN NUMBER,
        p_trip_id IN NUMBER,
        p_amount IN NUMBER,
        p_success OUT NUMBER
    ) IS
        v_id NUMBER;
    BEGIN
        -- Insert passenger trip record
        INSERT INTO PU.PASSENGERXTRIP (passenger_id, trip_id, amount)
        VALUES (p_passenger_id, p_trip_id, p_amount)
        RETURNING id INTO v_id;
        
        p_success := 1; -- Success
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := 0; -- Failure
            ROLLBACK;
    END ADD_PASSENGER_TO_TRIP;
    
    PROCEDURE UPDATE_TRIP_STATUS(
        p_trip_id IN NUMBER,
        p_status_id IN NUMBER,
        p_success OUT NUMBER
    ) IS
    BEGIN
        -- First, delete any existing status for this trip
        DELETE FROM PU.STATUSXTRIP
        WHERE trip_id = p_trip_id;
        
        -- Insert new status
        INSERT INTO PU.STATUSXTRIP (trip_id, status_id)
        VALUES (p_trip_id, p_status_id);
        
        p_success := 1; -- Success
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_success := 0; -- Failure
            ROLLBACK;
    END UPDATE_TRIP_STATUS;
    
    FUNCTION GET_TRIPS_BY_DRIVER(
        p_driver_id IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT t.id, t.route_id, r.start_time, r.end_time, r.programming_date
            FROM PU.TRIP t
            JOIN PU.ROUTE r ON t.route_id = r.id
            JOIN PU.VEHICLE v ON t.vehicle_id = v.id
            JOIN PU.DRIVERXVEHICLE dv ON v.id = dv.vehicle_id
            WHERE dv.driver_id = p_driver_id
            ORDER BY r.programming_date DESC, r.start_time;
        
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END GET_TRIPS_BY_DRIVER;
    
    FUNCTION GET_TRIPS_BY_PASSENGER(
        p_passenger_id IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT t.id, t.route_id, r.start_time, r.end_time, pt.amount
            FROM PU.TRIP t
            JOIN PU.ROUTE r ON t.route_id = r.id
            JOIN PU.PASSENGERXTRIP pt ON t.id = pt.trip_id
            WHERE pt.passenger_id = p_passenger_id
            ORDER BY r.programming_date DESC, r.start_time;
        
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END GET_TRIPS_BY_PASSENGER;
END TRIP_MANAGEMENT_PKG;
/

-- Permisos adicionales para las tablas del esquema PU
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PERSONUSER TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.DRIVER TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PASSENGER TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.VEHICLE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.DRIVERXVEHICLE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.ROUTE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.WAYPOINT TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.TRIP TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PASSENGERXTRIP TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.STATUSXTRIP TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PASSENGERXWAYPOINT TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.WAYPOINTXTRIP TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.MAXCAPACITYXVEHICLE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.VEHICLEXROUTE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PASSENGERXTRIPXPAYMENT TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.INSTITUTION_PERSON TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PHONE TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PHONE_PERSON TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.EMAIL TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON PU.PHOTO TO PU;

-- Permisos para que PU pueda ejecutar sus propios paquetes
GRANT EXECUTE ON PU.USER_AUTH_PKG TO PU;
GRANT EXECUTE ON PU.TRIP_MANAGEMENT_PKG TO PU;