-- =====================================================================
-- Package: PU_ROUTE_MGMT_PKG
-- Description: Contains procedures to manage the routes of the system
-- =====================================================================
CREATE OR REPLACE PACKAGE PU.PU_ROUTE_MGMT_PKG AS

    -- Create a route
    PROCEDURE create_route (p_start_time       IN TIMESTAMP,
                            p_end_time         IN TIMESTAMP,
                            p_programming_date IN DATE,
                            o_route_id         OUT PU.ROUTE.id%TYPE);
   
    -- Obtain the information of a route
    FUNCTION get_route_info (p_route_id IN PU.ROUTE.id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Update a route
    PROCEDURE update_route (p_route_id         IN PU.ROUTE.id%TYPE,
                            p_start_time       IN TIMESTAMP,
                            p_end_time         IN TIMESTAMP,
                            p_programming_date IN DATE);
    
    -- Eliminate a route
    PROCEDURE delete_route(p_route_id IN PU.ROUTE.id%TYPE);

END PU_ROUTE_MGMT_PKG;
/

-- =====================================================================
-- Package Body: PU_ROUTE_MGMT_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY PU.PU_ROUTE_MGMT_PKG AS

    -- Procedure to add a route
    PROCEDURE create_route (p_start_time       IN PU.ROUTE.start_time%TYPE,
                            p_end_time         IN PU.ROUTE.end_time%TYPE,
                            p_programming_date IN PU.ROUTE.programming_date%TYPE) AS
    BEGIN
        -- Insert into ROUTE table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO PU.ROUTE (start_time, end_time, programming_date)
                              VALUES (p_start_time, p_end_time, p_programming_date)
                              RETURNING id INTO o_route_id;

        -- Confirm
        COMMIT;

    END create_route;
    
    -- Get route info
    FUNCTION get_route_info (p_route_id IN PU.ROUTE.id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, start_time, end_time, programming_date,
                   creator, creation_date, modifier, modification_date
            FROM PU.ROUTE
            WHERE id = p_route_id;
    
        RETURN v_cursor;
    END get_route_info;
    
    -- Procedure to update a route
    PROCEDURE update_route (p_route_id             IN PU.ROUTE.id%TYPE,
                            p_new_start_time       IN PU.ROUTE.start_time%TYPE,
                            p_new_end_time         IN PU.ROUTE.end_time%TYPE,
                            p_new_programming_date IN PU.ROUTE.programming_date%TYPE) AS
    BEGIN
        UPDATE PU.ROUTE
        SET start_time       = p_new_start_time,
            end_time         = p_new_end_time,
            programming_date = p_new_programming_date
        WHERE id = p_route_id;
    
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20401, 'Route not found.');
        END IF;
    
        COMMIT;
    END update_route;
    
    -- Procedure to eliminate a route
    PROCEDURE delete_route(p_route_id IN PU.ROUTE.id%TYPE) AS
        BEGIN
            DELETE FROM PU.WAYPOINT WHERE route_id = p_route_id;
            DELETE FROM PU.ROUTE WHERE id = p_route_id;
        
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20403, 'Route with ID ' || p_route_id || ' not found.');
            END IF;
        
            COMMIT;
        END delete_route;

END PU_ROUTE_MGMT_PKG;
/