USE carpooling_adm;

DROP PROCEDURE IF EXISTS create_chosen_capacity;

DELIMITER $$

CREATE PROCEDURE create_chosen_capacity(
    IN p_vehicle_route_id INT,
    IN p_chosen_number INT,
    OUT o_capacity_id INT
)
BEGIN

    DECLARE vehicle_route_exists INT;
    
    SELECT COUNT(*) INTO vehicle_route_exists 
    FROM carpooling_pu.VEHICLEXROUTE 
    WHERE id = p_vehicle_route_id;
    
    IF vehicle_route_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Vehicle-Route combination does not exist';
    END IF;


    INSERT INTO CHOSENCAPACITY (
        vehicle_x_route_id,
        chosen_number
    ) VALUES (
        p_vehicle_route_id,
        p_chosen_number
    );
    
    SET o_capacity_id = LAST_INSERT_ID();
END $$

DELIMITER ;

-- Grant

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_chosen_capacity TO 'pu_user'@'%';

GRANT SELECT, INSERT ON carpooling_adm.CHOSENCAPACITY TO 'pu_user'@'%';
GRANT UPDATE, DELETE ON carpooling_adm.CHOSENCAPACITY TO 'adm_user'@'%';

GRANT SELECT ON carpooling_pu.VEHICLEXROUTE TO 'pu_user'@'%';

FLUSH PRIVILEGES;