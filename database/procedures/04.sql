-- =====================================================================
-- Package: PU_WAYPOINT_MGMT_PKG
-- Description: Contains procedures to manage the stop points
--              of the system
-- Author: Carmen Hidalgo Paz
-- Creation Date: 17/05/2025
-- =====================================================================
CREATE OR REPLACE PACKAGE PU.PU_WAYPOINT_MGMT_PKG AS

    -- Create a stop point with a district (start and end points)
    PROCEDURE create_waypoint_with_district (p_route_id   IN PU.WAYPOINT.route_id%TYPE,
                                             p_district_id IN PU.WAYPOINT.district_id%TYPE);
    
    -- Create a stop point with coordinates
    PROCEDURE create_waypoint_with_coords (p_route_id   IN PU.WAYPOINT.route_id%TYPE,
                                           p_latitude  IN PU.WAYPOINT.latitude%TYPE,
                                           p_longitude IN PU.WAYPOINT.longitude%TYPE
                                           );
    
    -- Obtain the information of stops
    FUNCTION get_waypoint_info (p_waypoint_id IN PU.WAYPOINT.id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Update a stop point with a district
    PROCEDURE update_waypoint_district (p_waypoint_id  IN PU.WAYPOINT.id%TYPE,
                                        p_new_district IN PU.WAYPOINT.district_id%TYPE
                                        );
    
    -- Eliminate a stop point
    PROCEDURE delete_waypoint(p_waypoint_id IN PU.WAYPOINT.id%TYPE);

END PU_WAYPOINT_MGMT_PKG;
/

-- =====================================================================
-- Package Body: PU_WAYPOINT_MGMT_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY PU.PU_WAYPOINT_MGMT_PKG AS

    -- Procedure to add a stop point with a district
    PROCEDURE create_waypoint_with_district (p_route_id    IN PU.WAYPOINT.route_id%TYPE,
                                             p_district_id IN PU.WAYPOINT.district_id%TYPE) AS
    BEGIN
        -- Insert into WAPOINT table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO PU.WAYPOINT (route_id, district_id) VALUES (p_route_id, p_district_id);

        -- Confirm
        COMMIT;

    END create_waypoint_with_district;

     -- Procedure to add a stop point with coordinates
    PROCEDURE create_waypoint_with_coords (p_route_id    IN PU.WAYPOINT.route_id%TYPE,
                                           p_latitude  IN PU.WAYPOINT.latitude%TYPE,
                                           p_longitude IN PU.WAYPOINT.longitude%TYPE) AS
    BEGIN
        -- Insert into WAPOINT table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO PU.WAYPOINT (route_id, latitude, longitude) VALUES (p_route_id, p_latitude, p_longitude);

        -- Confirm
        COMMIT;

    END create_waypoint_with_coords;
    
    -- Get stop point info
    FUNCTION get_waypoint_info ( p_waypoint_id IN PU.WAYPOINT.id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, district_id, latitude, longitude,
                   creator, creation_date, modifier, modification_date
            FROM PU.WAYPOINT
            WHERE id = p_waypoint_id;
    
        RETURN v_cursor;
    END get_waypoint_info;
    
    -- Procedure to update start or stop points
    PROCEDURE update_waypoint_district (p_waypoint_id  IN PU.WAYPOINT.id%TYPE,
                                        p_new_district IN PU.WAYPOINT.district_id%TYPE) AS
    BEGIN
        UPDATE PU.WAYPOINT
        SET district_id = p_new_district
        WHERE id = p_waypoint_id;
    
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20401, 'Waypoint not found.');
        END IF;
    
        COMMIT;
    END update_waypoint_district;
    
    -- Procedure to eliminate a stop point
    PROCEDURE delete_waypoint(p_waypoint_id IN PU.WAYPOINT.id%TYPE) AS
        BEGIN
            DELETE FROM PU.WAYPOINT WHERE id = p_waypoint_id;
        
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20403, 'Waypoint with ID ' || p_waypoint_id || ' not found.');
            END IF;
        
            COMMIT;
        END delete_waypoint;

END PU_WAYPOINT_MGMT_PKG;
/