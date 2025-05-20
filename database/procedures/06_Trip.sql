-- =====================================================================
-- Package: PU_TRIP_MGMT_PKG
-- Description: Contains procedures to manage the trips of the system
-- =====================================================================
CREATE OR REPLACE PACKAGE PU.PU_TRIP_MGMT_PKG AS

    -- Create a trip
    PROCEDURE create_trip (p_vehicle_id   IN PU.TRIP.vehicle_id%TYPE,
                           p_route_id     IN PU.TRIP.route_id%TYPE,
                           p_price        IN PU.TRIP.price_per_passenger%TYPE,
                           p_currency_id  IN PU.TRIP.id_currency%TYPE,
                           p_trip_id      OUT PU.TRIP.id%TYPE);
   
    -- Obtain the information of a trip
    FUNCTION get_trip_info (p_trip_id IN PU.TRIP.id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Get all trip info for a driver with route and status for display
    FUNCTION get_trips_by_driver(p_user_id IN NUMBER) RETURN SYS_REFCURSOR;
    
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
   PROCEDURE create_trip (p_vehicle_id   IN PU.TRIP.vehicle_id%TYPE,
                          p_route_id     IN PU.TRIP.route_id%TYPE,
                          p_price        IN PU.TRIP.price_per_passenger%TYPE,
                          p_currency_id  IN PU.TRIP.id_currency%TYPE,
                          p_trip_id      OUT PU.TRIP.id%TYPE) AS
    BEGIN
        SELECT PU.TRIP_SEQ.NEXTVAL INTO p_trip_id FROM DUAL;
    
        INSERT INTO PU.TRIP (
            id, vehicle_id, route_id, price_per_passenger, id_currency
        ) VALUES (
            p_trip_id, p_vehicle_id, p_route_id, p_price, p_currency_id
        );
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
    
     -- Get all trip info with route and status for display
    FUNCTION get_trips_by_driver(p_user_id IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
                SELECT
                    R.programming_date AS trip_date,
                    D1.name AS start_point,
                    D2.name AS destination_point,
                    VEH.plate_number,
                    S.name AS status
                FROM PU.TRIP T
                JOIN PU.ROUTE R ON T.route_id = R.id
                JOIN PU.VEHICLEXROUTE VR ON VR.route_id = R.id
                JOIN PU.VEHICLE VEH ON VEH.id = VR.vehicle_id
                JOIN PU.DRIVERXVEHICLE VD ON VD.vehicle_id = VEH.id
                JOIN PU.STATUSXTRIP SX ON SX.trip_id = T.id
                JOIN ADM.STATUS S ON S.id = SX.status_id
                -- Start point
                JOIN (
                    SELECT route_id, district_id
                    FROM (
                        SELECT route_id, district_id,
                               ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) rn
                        FROM PU.WAYPOINT
                        WHERE district_id IS NOT NULL
                    ) WHERE rn = 1
                ) WP1 ON WP1.route_id = R.id
                JOIN ADM.DISTRICT D1 ON D1.id = WP1.district_id
                -- End point
                JOIN (
                    SELECT route_id, district_id
                    FROM (
                        SELECT route_id, district_id,
                               ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id DESC) rn
                        FROM PU.WAYPOINT
                        WHERE district_id IS NOT NULL
                    ) WHERE rn = 1
                ) WP2 ON WP2.route_id = R.id
                JOIN ADM.DISTRICT D2 ON D2.id = WP2.district_id
                -- Filter by driver
                WHERE VD.driver_id = p_user_id;
        
            RETURN v_cursor;
        END get_trips_by_driver;
    
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