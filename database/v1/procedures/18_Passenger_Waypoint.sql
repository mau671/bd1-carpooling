-- ============================================================================
-- PACKAGE: PU_PASSENGERXWAYPOINT_PKG
-- Description: Manages passenger associations to specific stop points (waypoints)
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_PASSENGERXWAYPOINT_PKG AS

    -- Passenger selects a stop (waypoint)
    PROCEDURE add_passenger_waypoint(p_passenger_id IN NUMBER, p_waypoint_id IN NUMBER);

    -- Passenger updates their chosen stop
    PROCEDURE update_passenger_waypoint(p_passenger_id IN NUMBER, p_old_waypoint_id IN NUMBER, p_new_waypoint_id IN NUMBER);

    -- Passenger cancels their stop
    PROCEDURE delete_passenger_waypoint(p_passenger_id IN NUMBER, p_waypoint_id IN NUMBER);

    -- Get passenger's chosen waypoint
    FUNCTION get_passenger_waypoint(p_passenger_id IN NUMBER) RETURN SYS_REFCURSOR;

END PU_PASSENGERXWAYPOINT_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_PASSENGERXWAYPOINT_PKG AS

    -- Add a new stop point selection for a passenger
    PROCEDURE add_passenger_waypoint(p_passenger_id IN NUMBER, p_waypoint_id IN NUMBER) IS
    BEGIN
        INSERT INTO PU.PASSENGERXWAYPOINT (
            passenger_id, waypoint_id
        ) VALUES (
            p_passenger_id, p_waypoint_id
        );

        COMMIT;
    END;

    -- Update the waypoint selection for a passenger
    PROCEDURE update_passenger_waypoint(
        p_passenger_id IN NUMBER,
        p_old_waypoint_id IN NUMBER,
        p_new_waypoint_id IN NUMBER
    ) IS
    BEGIN
        -- First, delete the old link
        DELETE FROM PU.PASSENGERXWAYPOINT
        WHERE passenger_id = p_passenger_id AND waypoint_id = p_old_waypoint_id;

        -- Then insert the new one
        INSERT INTO PU.PASSENGERXWAYPOINT (
            passenger_id, waypoint_id
        ) VALUES (
            p_passenger_id, p_new_waypoint_id
        );

        COMMIT;
    END;

    -- Delete a stop point selection for a passenger
    PROCEDURE delete_passenger_waypoint(p_passenger_id IN NUMBER, p_waypoint_id IN NUMBER) IS
    BEGIN
        DELETE FROM PU.PASSENGERXWAYPOINT
        WHERE passenger_id = p_passenger_id AND waypoint_id = p_waypoint_id;

        COMMIT;
    END;

    -- Return the stop point(s) chosen by a passenger
    FUNCTION get_passenger_waypoint(p_passenger_id IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT pw.passenger_id, pw.waypoint_id,
                   w.latitude, w.longitude, w.district_id
            FROM PU.PASSENGERXWAYPOINT pw
            JOIN PU.WAYPOINT w ON w.id = pw.waypoint_id
            WHERE pw.passenger_id = p_passenger_id;

        RETURN v_cursor;
    END;

END PU_PASSENGERXWAYPOINT_PKG;
/