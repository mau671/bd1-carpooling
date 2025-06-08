USE carpooling_pu;

DROP PROCEDURE IF EXISTS create_vehicle;
DROP PROCEDURE IF EXISTS get_vehicle_info;
DROP PROCEDURE IF EXISTS update_vehicle;
DROP PROCEDURE IF EXISTS delete_vehicle;

DELIMITER $$


CREATE PROCEDURE create_vehicle(
    IN p_plate VARCHAR(9),
    OUT o_vehicle_id INT
)
BEGIN
    INSERT INTO VEHICLE (plate)
    VALUES (p_plate);
    
    SET o_vehicle_id = LAST_INSERT_ID();
END $$


CREATE PROCEDURE get_vehicle_info(
    IN p_vehicle_id INT
)
BEGIN
    SELECT 
        id, 
        plate,
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM VEHICLE
    WHERE id = p_vehicle_id;
END $$


CREATE PROCEDURE update_vehicle(
    IN p_vehicle_id INT,
    IN p_new_plate VARCHAR(9)
)
BEGIN
    DECLARE rows_affected INT;
    
    UPDATE VEHICLE
    SET plate = p_new_plate
    WHERE id = p_vehicle_id;
    
    SET rows_affected = ROW_COUNT();
    
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle not found.';
    END IF;
END $$


CREATE PROCEDURE delete_vehicle(
    IN p_vehicle_id INT
)
BEGIN
    DECLARE rows_affected INT;
    

    DELETE FROM DRIVERXVEHICLE WHERE vehicle_id = p_vehicle_id;
    DELETE FROM VEHICLEXROUTE WHERE vehicle_id = p_vehicle_id;
    DELETE FROM MAXCAPACITYXVEHICLE WHERE vehicle_id = p_vehicle_id;
    

    DELETE FROM VEHICLE WHERE id = p_vehicle_id;
    
    SET rows_affected = ROW_COUNT();
    
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Vehicle with ID ', p_vehicle_id, ' not found.');
    END IF;
END $$

DELIMITER ;

-- Permisos de ejecucion

GRANT EXECUTE ON PROCEDURE carpooling_pu.create_vehicle TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.get_vehicle_info TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.update_vehicle TO 'pu_user'@'%';
GRANT UPDATE ON carpooling_pu.VEHICLE TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_vehicle TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.DRIVERXVEHICLE TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.VEHICLEXROUTE TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';


GRANT SELECT ON carpooling_pu.DRIVER TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.MAXCAPACITY TO 'pu_user'@'%';

FLUSH PRIVILEGES;
