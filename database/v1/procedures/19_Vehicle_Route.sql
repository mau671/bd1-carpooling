-- =====================================================================
-- Package: ADM_VEHICLE_ROUTE_PKG
-- Description: Manages routes made by vehicles
-- =====================================================================

CREATE OR REPLACE PACKAGE PU.PU_VEHICLE_ROUTE_PKG AS

    -- Link a vehicle with a route
    PROCEDURE assign_vehicle_to_route(
        p_vehicle_id IN PU.VEHICLEXROUTE.vehicle_id%TYPE,
        p_route_id   IN PU.VEHICLEXROUTE.route_id%TYPE
    );

    -- Get all routes assigned to a vehicle
    FUNCTION get_routes_by_vehicle(
        p_vehicle_id IN PU.VEHICLEXROUTE.vehicle_id%TYPE
    ) RETURN SYS_REFCURSOR;

    -- Optional: Get all vehicles assigned to a route
    FUNCTION get_vehicles_by_route(
        p_route_id IN PU.VEHICLEXROUTE.route_id%TYPE
    ) RETURN SYS_REFCURSOR;
    
    -- Update the vehicle assigned to a route
    PROCEDURE update_vehicle_for_route(p_route_id        IN PU.VEHICLEXROUTE.route_id%TYPE,
                                       p_new_vehicle_id  IN PU.VEHICLEXROUTE.vehicle_id%TYPE);
                                       
    -- Remove a link between a vehicle and a route
    PROCEDURE remove_vehicle_route_link(
        p_vehicle_id IN PU.VEHICLEXROUTE.vehicle_id%TYPE,
        p_route_id   IN PU.VEHICLEXROUTE.route_id%TYPE
    );

END PU_VEHICLE_ROUTE_PKG;
/


CREATE OR REPLACE PACKAGE BODY PU.PU_VEHICLE_ROUTE_PKG AS

    -- Assign a vehicle to a route
    PROCEDURE assign_vehicle_to_route(
        p_vehicle_id IN PU.VEHICLEXROUTE.vehicle_id%TYPE,
        p_route_id   IN PU.VEHICLEXROUTE.route_id%TYPE
    ) IS
    BEGIN
        INSERT INTO PU.VEHICLEXROUTE (id, vehicle_id, route_id)
        VALUES (PU.VEHICLEXROUTE_SEQ.NEXTVAL, p_vehicle_id, p_route_id);
        COMMIT;
    END;

    -- Get all routes assigned to a vehicle
    FUNCTION get_routes_by_vehicle(
        p_vehicle_id IN PU.VEHICLEXROUTE.vehicle_id%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT r.*
            FROM PU.VEHICLEXROUTE vr
            JOIN PU.ROUTE r ON r.id = vr.route_id
            WHERE vr.vehicle_id = p_vehicle_id;
        RETURN v_cursor;
    END;

    -- Optional: Get all vehicles assigned to a route
    FUNCTION get_vehicles_by_route(
        p_route_id IN PU.VEHICLEXROUTE.route_id%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT v.*
            FROM PU.VEHICLEXROUTE vr
            JOIN PU.VEHICLE v ON v.id = vr.vehicle_id
            WHERE vr.route_id = p_route_id;
        RETURN v_cursor;
    END;
    
    PROCEDURE update_vehicle_for_route(
        p_route_id        IN PU.VEHICLEXROUTE.route_id%TYPE,
        p_new_vehicle_id  IN PU.VEHICLEXROUTE.vehicle_id%TYPE
    ) IS
    BEGIN
        UPDATE PU.VEHICLEXROUTE
        SET vehicle_id = p_new_vehicle_id
        WHERE route_id = p_route_id;
    
        IF SQL%ROWCOUNT = 0 THEN
            -- If no record exists yet, insert instead
            INSERT INTO PU.VEHICLEXROUTE (id, vehicle_id, route_id)
            VALUES (PU.VEHICLEXROUTE_SEQ.NEXTVAL, p_new_vehicle_id, p_route_id);
        END IF;
    
        COMMIT;
    END;
    
    -- Remove the link between a vehicle and a route
    PROCEDURE remove_vehicle_route_link(
        p_vehicle_id IN PU.VEHICLEXROUTE.vehicle_id%TYPE,
        p_route_id   IN PU.VEHICLEXROUTE.route_id%TYPE
    ) IS
    BEGIN
        DELETE FROM PU.VEHICLEXROUTE
        WHERE vehicle_id = p_vehicle_id AND route_id = p_route_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20404, 'Vehicle-Route link not found.');
        END IF;

        COMMIT;
    END;

END PU_VEHICLE_ROUTE_PKG;
/