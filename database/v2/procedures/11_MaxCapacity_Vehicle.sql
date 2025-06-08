USE carpooling_pu;

DROP PROCEDURE IF EXISTS assign_capacity_to_vehicle;
DROP PROCEDURE IF EXISTS get_capacity_by_vehicle;
DROP PROCEDURE IF EXISTS update_vehicle_capacity;
DROP PROCEDURE IF EXISTS remove_vehicle_capacity;


DELIMITER $$


CREATE PROCEDURE assign_capacity_to_vehicle(
    IN p_vehicle_id INT,
    IN p_max_capacity_id INT
)
BEGIN
    INSERT INTO MAXCAPACITYXVEHICLE (vehicle_id, max_capacity_id)
    VALUES (p_vehicle_id, p_max_capacity_id);
END $$


CREATE PROCEDURE get_capacity_by_vehicle(
    IN p_vehicle_id INT
)
BEGIN
    SELECT 
        mcv.id, 
        mc.capacity_number,
        mc.creator,
        mc.creation_date
    FROM MAXCAPACITYXVEHICLE mcv
    JOIN carpooling_adm.MAXCAPACITY mc ON mc.id = mcv.max_capacity_id
    WHERE mcv.vehicle_id = p_vehicle_id;
END $$


CREATE PROCEDURE update_vehicle_capacity(
    IN p_vehicle_id INT,
    IN p_new_capacity_id INT
)
BEGIN
    DECLARE rows_affected INT;
    
    UPDATE MAXCAPACITYXVEHICLE
    SET max_capacity_id = p_new_capacity_id
    WHERE vehicle_id = p_vehicle_id;
    
    SET rows_affected = ROW_COUNT();
    
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No capacity assigned to this vehicle';
    END IF;
END $$


CREATE PROCEDURE remove_vehicle_capacity(
    IN p_vehicle_id INT
)
BEGIN
    DELETE FROM MAXCAPACITYXVEHICLE
    WHERE vehicle_id = p_vehicle_id;
END $$

DELIMITER ;

-- Grant Permissions

GRANT EXECUTE ON PROCEDURE carpooling_pu.assign_capacity_to_vehicle TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.MAXCAPACITY TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.get_capacity_by_vehicle TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.update_vehicle_capacity TO 'pu_user'@'%';
GRANT UPDATE ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.remove_vehicle_capacity TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'pu_user'@'%';

GRANT ALL ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'adm_user'@'%';

FLUSH PRIVILEGES;