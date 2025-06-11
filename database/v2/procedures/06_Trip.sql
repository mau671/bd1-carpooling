USE carpooling_pu;


DROP PROCEDURE IF EXISTS create_trip;
DROP PROCEDURE IF EXISTS get_trip_info;
DROP PROCEDURE IF EXISTS get_trips_by_driver;
DROP PROCEDURE IF EXISTS update_trip;
DROP PROCEDURE IF EXISTS delete_trip;

DELIMITER $$


CREATE PROCEDURE create_trip(
    IN p_vehicle_id INT,
    IN p_route_id INT,
    IN p_price DECIMAL(10,2),
    IN p_currency_id INT,
    OUT o_trip_id INT
)
BEGIN
    INSERT INTO TRIP (
        vehicle_id, route_id, price_per_passenger, id_currency
    ) VALUES (
        p_vehicle_id, p_route_id, p_price, p_currency_id
    );
    
    SET o_trip_id = LAST_INSERT_ID();
END $$


CREATE PROCEDURE get_trip_info(
    IN p_trip_id INT
)
BEGIN
    SELECT 
        id, vehicle_id, route_id, price_per_passenger, id_currency,
        creator, creation_date, modifier, modification_date
    FROM TRIP
    WHERE id = p_trip_id;
END $$


CREATE PROCEDURE get_trips_by_driver(
    IN p_driver_id INT
)
BEGIN
    SELECT
        T.id AS trip_id,
        R.programming_date AS trip_date,
        D1.name AS start_point,
        D2.name AS destination_point,
        VEH.plate,
        S.name AS status,
        T.price_per_passenger,
        C.name AS currency
    FROM TRIP T
    JOIN ROUTE R ON T.route_id = R.id
    JOIN VEHICLEXROUTE VR ON VR.route_id = R.id
    JOIN VEHICLE VEH ON VEH.id = VR.vehicle_id
    JOIN DRIVERXVEHICLE VD ON VD.vehicle_id = VEH.id
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
    WHERE VD.driver_id = p_driver_id;

END $$

CREATE PROCEDURE update_trip(
    IN p_trip_id INT,
    IN p_new_vehicle_id INT,
    IN p_new_route_id INT,
    IN p_new_price DECIMAL(10,2),
    IN p_new_currency_id INT
)
BEGIN
    DECLARE rows_affected INT;

    UPDATE TRIP
    SET 
        vehicle_id = p_new_vehicle_id,
        route_id = p_new_route_id,
        price_per_passenger = p_new_price,
        id_currency = p_new_currency_id
    WHERE id = p_trip_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trip not found.';
    END IF;
END $$

-- Procedimiento para eliminar un viaje
CREATE PROCEDURE delete_trip(
    IN p_trip_id INT
)
BEGIN
    DECLARE rows_affected INT;

    -- Primero eliminamos las relaciones con status
    DELETE FROM STATUSXTRIP WHERE trip_id = p_trip_id;
    
    -- Luego eliminamos el viaje
    DELETE FROM TRIP WHERE id = p_trip_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Trip with ID ', p_trip_id, ' not found.');
    END IF;
END $$

DELIMITER ;

--  Grants

GRANT EXECUTE ON PROCEDURE carpooling_pu.assign_initial_status TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.cancel_trip TO 'pu_user'@'%';
GRANT UPDATE ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.auto_update_status TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';
GRANT SELECT, UPDATE ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.update_all_trip_statuses TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.get_trip_status TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';


GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLEXROUTE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CURRENCY TO 'pu_user'@'%';

FLUSH PRIVILEGES;