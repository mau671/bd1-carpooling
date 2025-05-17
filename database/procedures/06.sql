-- =====================================================================
-- Package: PU_TRIP_MGMT_PKG
-- Description: Contains procedures to manage the trips of the system
-- Author: Carmen Hidalgo Paz
-- Creation Date: 17/05/2025
-- =====================================================================
CREATE OR REPLACE PACKAGE PU.PU_TRIP_MGMT_PKG AS

    -- Create a trip
    PROCEDURE create_trip (p_vehicle_id IN PU.TRIP.vehicle_id%TYPE,
                            p_route_id   IN PU.TRIP.route_id%TYPE);
   
    -- Obtain the information of a trip
    FUNCTION get_trip_info (p_trip_id IN PU.TRIP.id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Update a trip
    PROCEDURE update_trip (p_trip_id              IN PU.TRIP.id%TYPE,
                           p_new_vehicle_id       IN PU.TRIP.vehicle_id%TYPE,
                           p_new_route_id         IN PU.TRIP.route_id%TYPE);
    
    -- Eliminate a trip
    PROCEDURE delete_trip(p_trip_id  IN PU.TRIP.id%TYPE);

END PU_TRIP_MGMT_PKG;
/

-- =====================================================================
-- Package Body: PU_TRIP_MGMT_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY PU.PU_TRIP_MGMT_PKG AS

    -- Procedure to add a trip
    PROCEDURE create_trip (p_vehicle_id IN PU.TRIP.vehicle_id%TYPE,
                            p_route_id   IN PU.TRIP.route_id%TYPE) AS
    BEGIN
        -- Insert into TRIP table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO PU.TRIP (vehicle_id, route_id)
                             VALUES (p_vehicle_id, p_route_id);

        -- Confirm
        COMMIT;

    END create_trip;
    
    -- Get trip info
    FUNCTION get_trip_info (p_trip_id IN PU.TRIP.id%TYPE)
                            RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, vehicle_id, route_id
            FROM PU.TRIP
            WHERE id = p_trip_id;
    
        RETURN v_cursor;
    END get_trip_info;
    
    -- Procedure to update a trip
    PROCEDURE update_trip (p_trip_id              IN PU.TRIP.id%TYPE,
                            p_new_vehicle_id       IN PU.TRIP.vehicle_id%TYPE,
                            p_new_route_id         IN PU.TRIP.route_id%TYPE) AS
    BEGIN
        UPDATE PU.TRIP
        SET vehicle_id       = p_new_vehicle_id,
            route_id         = p_new_route_id
        WHERE id = p_trip_id;
    
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20401, 'Trip not found.');
        END IF;
    
        COMMIT;
    END update_trip;
    
    -- Procedure to eliminate a trip
    PROCEDURE delete_trip(p_trip_id IN PU.TRIP.id%TYPE) AS
        BEGIN
            DELETE FROM PU.TRIP WHERE id = p_trip_id;
        
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20403, 'Trip with ID ' || p_trip_id || ' not found.');
            END IF;
        
            COMMIT;
        END delete_trip;

END PU_TRIP_MGMT_PKG;
/