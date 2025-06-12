USE carpooling_pu;

DROP PROCEDURE IF EXISTS book_trip;
DROP PROCEDURE IF EXISTS cancel_trip_booking;
DROP PROCEDURE IF EXISTS get_booked_trips;

DELIMITER $$

CREATE PROCEDURE book_trip(
    IN p_passenger_id INT,
    IN p_trip_id INT,
    OUT o_booking_id INT
)
BEGIN
    DECLARE v_status_name VARCHAR(50);
    DECLARE v_available_seats INT;

    SELECT S.name INTO v_status_name
    FROM STATUSXTRIP SX
    JOIN carpooling_adm.STATUS S ON S.id = SX.status_id
    WHERE SX.trip_id = p_trip_id;
    
    IF UPPER(v_status_name) != 'PENDING' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trip cannot be booked. Status is not PENDING.';
    END IF;

    SELECT (mc.capacity_number - COUNT(px.id)) INTO v_available_seats
    FROM TRIP t
    JOIN MAXCAPACITYXVEHICLE mcv ON mcv.vehicle_id = t.vehicle_id
    JOIN carpooling_adm.MAXCAPACITY mc ON mc.id = mcv.max_capacity_id
    LEFT JOIN PASSENGERXTRIP px ON px.trip_id = t.id
    WHERE t.id = p_trip_id
    GROUP BY mc.capacity_number;
    
    IF v_available_seats <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No available seats for this trip';
    END IF;

    INSERT INTO PASSENGERXTRIP (passenger_id, trip_id)
    VALUES (p_passenger_id, p_trip_id);
    
    SET o_booking_id = LAST_INSERT_ID();
END $$


CREATE PROCEDURE cancel_trip_booking(
    IN p_passenger_id INT,
    IN p_trip_id INT
)
BEGIN
    DECLARE rows_affected INT;
    
    DELETE FROM PASSENGERXTRIP
    WHERE passenger_id = p_passenger_id AND trip_id = p_trip_id;
    
    SET rows_affected = ROW_COUNT();
    
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Booking not found';
    END IF;
END $$


CREATE PROCEDURE get_booked_trips(
    IN p_passenger_id INT
)
BEGIN
    SELECT 
        T.id AS trip_id,
        R.programming_date,
        D1.name AS start_point,
        D2.name AS destination_point,
        V.plate,
        S.name AS status,
        T.price_per_passenger,
        C.name AS currency
    FROM PASSENGERXTRIP PX
    JOIN TRIP T ON T.id = PX.trip_id
    JOIN ROUTE R ON T.route_id = R.id
    JOIN VEHICLE V ON V.id = T.vehicle_id
    JOIN STATUSXTRIP SX ON SX.trip_id = T.id
    JOIN carpooling_adm.STATUS S ON S.id = SX.status_id
    JOIN carpooling_adm.CURRENCY C ON C.id = T.id_currency
    JOIN (
        SELECT route_id, district_id
        FROM (
            SELECT route_id, district_id,
                   ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) rn
            FROM WAYPOINT
            WHERE district_id IS NOT NULL
        ) t WHERE rn = 1
    ) WP1 ON WP1.route_id = R.id
    JOIN carpooling_adm.DISTRICT D1 ON D1.id = WP1.district_id
    JOIN (
        SELECT route_id, district_id
        FROM (
            SELECT route_id, district_id,
                   ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id DESC) rn
            FROM WAYPOINT
            WHERE district_id IS NOT NULL
        ) t WHERE rn = 1
    ) WP2 ON WP2.route_id = R.id
    JOIN carpooling_adm.DISTRICT D2 ON D2.id = WP2.district_id
    WHERE PX.passenger_id = p_passenger_id;
END $$

DELIMITER ;

-- Permisos

GRANT EXECUTE ON PROCEDURE carpooling_pu.book_trip TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.PASSENGERXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.MAXCAPACITY TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.cancel_trip_booking TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.PASSENGERXTRIP TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.get_booked_trips TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.DISTRICT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CURRENCY TO 'pu_user'@'%';

FLUSH PRIVILEGES;