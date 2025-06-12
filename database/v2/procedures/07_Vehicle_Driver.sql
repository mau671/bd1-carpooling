USE carpooling_pu;

DROP PROCEDURE IF EXISTS assign_vehicle_to_driver;
DROP PROCEDURE IF EXISTS get_vehicles_by_driver;

DELIMITER $$

CREATE PROCEDURE assign_vehicle_to_driver(
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    OUT o_assignment_id INT
)
BEGIN
    INSERT INTO DRIVERXVEHICLE (vehicle_id, driver_id)
    VALUES (p_vehicle_id, p_driver_id);
    
    SET o_assignment_id = LAST_INSERT_ID();
END $$


CREATE PROCEDURE get_vehicles_by_driver(
    IN p_driver_id INT
)
BEGIN
    SELECT
        v.id AS vehicle_id,
        v.plate AS plate_number,
        IFNULL(mc.capacity_number, 0) AS max_capacity,
        (SELECT COUNT(*) FROM TRIP t WHERE t.vehicle_id = v.id) AS trip_count
    FROM DRIVERXVEHICLE dv
    JOIN VEHICLE v ON v.id = dv.vehicle_id
    LEFT JOIN MAXCAPACITYXVEHICLE mcv ON mcv.vehicle_id = v.id
    LEFT JOIN carpooling_adm.MAXCAPACITY mc ON mc.id = mcv.max_capacity_id
    WHERE dv.driver_id = p_driver_id
    ORDER BY v.plate;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_pu.assign_vehicle_to_driver TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.DRIVERXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVER TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.get_vehicles_by_driver TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVERXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.MAXCAPACITY TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP TO 'pu_user'@'%';


GRANT DELETE ON carpooling_pu.DRIVERXVEHICLE TO 'adm_user'@'%';
GRANT UPDATE ON carpooling_pu.DRIVERXVEHICLE TO 'adm_user'@'%';

FLUSH PRIVILEGES;