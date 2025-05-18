-- ============================================================================
-- PACKAGE: ADM_STATUSXTRIP_PKG
-- Description: Manages operations related to trip statuses in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_TRIP_STATUS_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    -- Assign initial status (Pending)
    PROCEDURE assign_initial_status(p_trip_id IN PU.TRIP.id%TYPE);
    
    -- Manually cancel a trip (only if Pending)
    PROCEDURE cancel_trip(p_trip_id IN PU.TRIP.id%TYPE);
    
    -- Update status based on current date/time
    PROCEDURE auto_update_status(p_trip_id IN PU.TRIP.id%TYPE);
    
    -- Update all trips' statuses
    PROCEDURE update_all_trip_statuses;
    
    -- Get current status of a trip
    FUNCTION get_trip_status(p_trip_id IN PU.TRIP.id%TYPE) RETURN SYS_REFCURSOR;

END ADM_TRIP_STATUS_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_TRIP_STATUS_PKG AS
    -- When a trip is created, say that its pending
    PROCEDURE assign_initial_status(p_trip_id IN PU.TRIP.id%TYPE) AS
                                    v_status_id ADM.STATUS.id%TYPE;
      BEGIN
        SELECT id INTO v_status_id FROM ADM.STATUS WHERE UPPER(name) = 'PENDING';
    
        INSERT INTO PU.STATUSXTRIP (trip_id, status_id)
        VALUES (p_trip_id, v_status_id);
        COMMIT;
      END assign_initial_status;
    
    -- Update status to in progress and completed of a trip 
    PROCEDURE auto_update_status(p_trip_id IN PU.TRIP.id%TYPE) AS
        v_in_progress_id ADM.STATUS.id%TYPE;
        v_completed_id ADM.STATUS.id%TYPE;
        v_pending_id ADM.STATUS.id%TYPE;
        v_trip_start TIMESTAMP;
        v_trip_end TIMESTAMP;
        v_current_status PU.STATUSXTRIP.status_id%TYPE;
      BEGIN
        -- Get status IDs
        SELECT id INTO v_pending_id FROM ADM.STATUS WHERE UPPER(name) = 'PENDING';
        SELECT id INTO v_in_progress_id FROM ADM.STATUS WHERE UPPER(name) = 'IN PROGRESS';
        SELECT id INTO v_completed_id FROM ADM.STATUS WHERE UPPER(name) = 'COMPLETED';
    
        -- Get trip times
        SELECT R.start_time, R.end_time
        INTO v_trip_start, v_trip_end
        FROM PU.TRIP T
        JOIN PU.ROUTE R ON T.route_id = R.id
        WHERE T.id = p_trip_id;
    
        -- Get current status
        SELECT status_id INTO v_current_status
        FROM PU.STATUSXTRIP
        WHERE trip_id = p_trip_id;
    
        -- Compare times
        IF v_current_status = v_pending_id AND SYSDATE >= v_trip_start AND SYSDATE < v_trip_end THEN
          -- Set to In Progress
          UPDATE PU.STATUSXTRIP
          SET status_id = v_in_progress_id
          WHERE trip_id = p_trip_id;
    
        ELSIF v_current_status = v_in_progress_id AND SYSDATE >= v_trip_end THEN
          -- Set to Completed
          UPDATE PU.STATUSXTRIP
          SET status_id = v_completed_id
          WHERE trip_id = p_trip_id;
        END IF;
    
        COMMIT;
    END auto_update_status;
    
    -- Updates statuses of all trips
    PROCEDURE update_all_trip_statuses IS
      CURSOR c_trips IS
        SELECT trip_id
        FROM PU.STATUSXTRIP SX
        WHERE SX.status_id IN (
          SELECT id FROM ADM.STATUS WHERE UPPER(name) IN ('PENDING', 'IN PROGRESS')
        );
    
    BEGIN
      FOR trip_rec IN c_trips LOOP
        PU.STATUSXTRIP_MGMT_PKG.auto_update_status(trip_rec.trip_id);
      END LOOP;
    END update_all_trip_statuses;
    
    -- Get status of a trip
    FUNCTION get_trip_status(p_trip_id IN PU.TRIP.id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
      BEGIN
        OPEN v_cursor FOR
          SELECT S.id, S.name
          FROM PU.STATUSXTRIP SX
          JOIN ADM.STATUS S ON S.id = SX.status_id
          WHERE SX.trip_id = p_trip_id;
        RETURN v_cursor;
      END get_trip_status;
    
END ADM_TRIP_STATUS_PKG;
/