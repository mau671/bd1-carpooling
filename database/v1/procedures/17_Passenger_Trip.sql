-- ============================================================================
-- PACKAGE: PU_PASSENGERXTRIP_PKG
-- Description: Manages the relationship between passengers and their booked trips
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_PASSENGERXTRIP_PKG AS

    -- Book a trip for a passenger (only if status is 'Pending')
    PROCEDURE book_trip(
        p_passenger_id IN NUMBER,
        p_trip_id      IN NUMBER
    );

    -- Cancel a trip booking
    PROCEDURE cancel_trip_booking(
        p_passenger_id IN NUMBER,
        p_trip_id      IN NUMBER
    );

    -- Get all trips booked by a passenger
    FUNCTION get_booked_trips(
        p_passenger_id IN NUMBER
    ) RETURN SYS_REFCURSOR;

END PU_PASSENGERXTRIP_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_PASSENGERXTRIP_PKG AS

    PROCEDURE book_trip(
        p_passenger_id IN NUMBER,
        p_trip_id      IN NUMBER
    ) IS
        v_status_name ADM.STATUS.name%TYPE;
        v_new_id PU.PASSENGERXTRIP.id%TYPE;
    BEGIN
        -- Check that the trip status is 'Pending'
        SELECT S.name
        INTO v_status_name
        FROM PU.STATUSXTRIP SX
        JOIN ADM.STATUS S ON S.id = SX.status_id
        WHERE SX.trip_id = p_trip_id;

        IF UPPER(v_status_name) != 'PENDING' THEN
            RAISE_APPLICATION_ERROR(-20405, 'Trip cannot be booked. Status is not PENDING.');
        END IF;

        -- Generate new ID
        SELECT PU.PASSENGERXTRIP_SEQ.NEXTVAL INTO v_new_id FROM DUAL;

        INSERT INTO PU.PASSENGERXTRIP (
            id, passenger_id, trip_id
        ) VALUES (
            v_new_id, p_passenger_id, p_trip_id
        );

        COMMIT;
    END;

    -- Cancel a trip booking
    PROCEDURE cancel_trip_booking(
        p_passenger_id IN NUMBER,
        p_trip_id      IN NUMBER
    ) IS
    BEGIN
        DELETE FROM PU.PASSENGERXTRIP
        WHERE passenger_id = p_passenger_id AND trip_id = p_trip_id;

        COMMIT;
    END;

    -- Get all trips booked by a passenger
    FUNCTION get_booked_trips(
        p_passenger_id IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT T.id AS trip_id,
                   R.programming_date,
                   D1.name AS start_point,
                   D2.name AS destination_point,
                   V.plate,
                   S.name AS status
            FROM PU.PASSENGERXTRIP PX
            JOIN PU.TRIP T ON T.id = PX.trip_id
            JOIN PU.ROUTE R ON T.route_id = R.id
            JOIN PU.VEHICLE V ON V.id = T.vehicle_id
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
            WHERE PX.passenger_id = p_passenger_id;

        RETURN v_cursor;
    END;

END PU_PASSENGERXTRIP_PKG;
/