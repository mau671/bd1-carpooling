-- ============================================================================
-- PACKAGE: ADM_STATUSXTRIP_PKG
-- Description: Manages operations related to trip statuses in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_TRIP_STATUS_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;

    -- Assign initial status (Pending)
    PROCEDURE assign_initial_status(p_trip_id IN NUMBER);

    -- Manually cancel a trip (only if Pending)
    PROCEDURE cancel_trip(p_trip_id IN NUMBER);

    -- Update status based on current date/time
    PROCEDURE auto_update_status(p_trip_id IN NUMBER);

    -- Update all trips' statuses
    PROCEDURE update_all_trip_statuses;

    -- Get current status of a trip
    FUNCTION get_trip_status(p_trip_id IN NUMBER) RETURN SYS_REFCURSOR;

END PU_TRIP_STATUS_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_TRIP_STATUS_PKG AS

    -- Assigns 'Pending' status to a trip
    PROCEDURE assign_initial_status(p_trip_id IN NUMBER) AS
        v_status_id NUMBER;
    BEGIN
        SELECT id INTO v_status_id FROM ADM.STATUS WHERE UPPER(name) = 'PENDING';

        INSERT INTO PU.STATUSXTRIP (trip_id, status_id)
        VALUES (p_trip_id, v_status_id);
    END assign_initial_status;

    -- Manually cancels a trip (only if it's still 'Pending')
    PROCEDURE cancel_trip(p_trip_id IN NUMBER) AS
        v_pending_id   NUMBER;
        v_cancelled_id NUMBER;
        v_current_id   NUMBER;
    BEGIN
        SELECT id INTO v_pending_id FROM ADM.STATUS WHERE UPPER(name) = 'PENDING';
        SELECT id INTO v_cancelled_id FROM ADM.STATUS WHERE UPPER(name) = 'CANCELLED';

        SELECT status_id INTO v_current_id
        FROM PU.STATUSXTRIP
        WHERE trip_id = p_trip_id;

        IF v_current_id = v_pending_id THEN
            UPDATE PU.STATUSXTRIP
            SET status_id = v_cancelled_id
            WHERE trip_id = p_trip_id;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Trip cannot be cancelled. Not in PENDING state.');
        END IF;
    END cancel_trip;

    -- Automatically updates status based on current time
    PROCEDURE auto_update_status(p_trip_id IN NUMBER) AS
            v_in_progress_id   NUMBER;
            v_completed_id     NUMBER;
            v_pending_id       NUMBER;
            v_trip_start       TIMESTAMP;
            v_trip_end         TIMESTAMP;
            v_programming_date DATE;
            v_current_status   NUMBER;
        BEGIN
            -- Get status IDs
            SELECT id INTO v_pending_id FROM ADM.STATUS WHERE UPPER(name) = 'PENDING';
            SELECT id INTO v_in_progress_id FROM ADM.STATUS WHERE UPPER(name) = 'IN PROGRESS';
            SELECT id INTO v_completed_id FROM ADM.STATUS WHERE UPPER(name) = 'COMPLETED';
        
            -- Get trip data
            SELECT R.start_time, R.end_time, R.programming_date
            INTO v_trip_start, v_trip_end, v_programming_date
            FROM PU.TRIP T
            JOIN PU.ROUTE R ON T.route_id = R.id
            WHERE T.id = p_trip_id;
        
            -- Get current trip status
            SELECT status_id INTO v_current_status
            FROM PU.STATUSXTRIP
            WHERE trip_id = p_trip_id;
        
            -- Switch from Pending → In Progress
            IF v_current_status = v_pending_id
               AND TRUNC(SYSDATE) = v_programming_date
               AND SYSDATE >= v_trip_start AND SYSDATE < v_trip_end THEN
        
                UPDATE PU.STATUSXTRIP
                SET status_id = v_in_progress_id
                WHERE trip_id = p_trip_id;
        
            -- Switch from In Progress → Completed (same day and after end)
            ELSIF v_current_status = v_in_progress_id
               AND TRUNC(SYSDATE) = v_programming_date
               AND SYSDATE >= v_trip_end THEN
        
                UPDATE PU.STATUSXTRIP
                SET status_id = v_completed_id
                WHERE trip_id = p_trip_id;
        
            -- Force Completed if trip date already passed and still in progress
            ELSIF v_current_status = v_in_progress_id
               AND TRUNC(SYSDATE) > v_programming_date THEN
        
                UPDATE PU.STATUSXTRIP
                SET status_id = v_completed_id
                WHERE trip_id = p_trip_id;
        
            -- ✅ NEW: Force Completed if trip date already passed and still pending
            ELSIF v_current_status = v_pending_id
               AND TRUNC(SYSDATE) > v_programming_date THEN
        
                UPDATE PU.STATUSXTRIP
                SET status_id = v_completed_id
                WHERE trip_id = p_trip_id;
        
            END IF;
        
            COMMIT;
        END auto_update_status;

    -- Updates all active trips (pending or in progress)
    PROCEDURE update_all_trip_statuses IS
        CURSOR c_trips IS
            SELECT trip_id
            FROM PU.STATUSXTRIP SX
            WHERE SX.status_id IN (
                SELECT id FROM ADM.STATUS WHERE UPPER(name) IN ('PENDING', 'IN PROGRESS')
            );
    BEGIN
        FOR trip_rec IN c_trips LOOP
            PU.PU_TRIP_STATUS_PKG.auto_update_status(trip_rec.trip_id);
        END LOOP;
        COMMIT;
    END update_all_trip_statuses;

    -- Returns the current status of a trip
    FUNCTION get_trip_status(p_trip_id IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT S.id, S.name
            FROM PU.STATUSXTRIP SX
            JOIN ADM.STATUS S ON S.id = SX.status_id
            WHERE SX.trip_id = p_trip_id;

        RETURN v_cursor;
    END get_trip_status;

END PU_TRIP_STATUS_PKG;
/

GRANT SELECT, INSERT, UPDATE ON PU.TRIP TO ADM;
GRANT SELECT, INSERT, UPDATE ON PU.ROUTE TO ADM;
GRANT SELECT, INSERT, UPDATE ON PU.STATUSXTRIP TO ADM;

SELECT id, name FROM ADM.STATUS;

SELECT SX.trip_id, SX.status_id, S.name
FROM PU.STATUSXTRIP SX
JOIN ADM.STATUS S ON S.id = SX.status_id;

SELECT R.start_time, R.end_time, R.programming_date
FROM PU.TRIP T
JOIN PU.ROUTE R ON T.route_id = R.id
WHERE T.id = 22;