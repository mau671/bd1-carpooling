USE carpooling_pu;

DROP PROCEDURE IF EXISTS add_passenger_waypoint;
DROP PROCEDURE IF EXISTS update_passenger_waypoint;
DROP PROCEDURE IF EXISTS delete_passenger_waypoint;
DROP PROCEDURE IF EXISTS get_passenger_waypoint;

DELIMITER $$


CREATE PROCEDURE add_passenger_waypoint(
    IN p_passenger_id INT,
    IN p_waypoint_id INT
)
BEGIN
    DECLARE v_passenger_exists INT;
    DECLARE v_waypoint_exists INT;
    

    SELECT COUNT(*) INTO v_passenger_exists 
    FROM PASSENGER 
    WHERE person_id = p_passenger_id;
    

    SELECT COUNT(*) INTO v_waypoint_exists 
    FROM WAYPOINT 
    WHERE id = p_waypoint_id;
    
    IF v_passenger_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El pasajero no existe';
    ELSEIF v_waypoint_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El waypoint no existe';
    ELSE

        INSERT INTO PASSENGERXWAYPOINT (
            passenger_id, 
            waypoint_id,
            creator,
            creation_date
        ) VALUES (
            p_passenger_id, 
            p_waypoint_id,
            USER(),
            CURDATE()
        );
    END IF;
END $$


CREATE PROCEDURE update_passenger_waypoint(
    IN p_passenger_id INT,
    IN p_old_waypoint_id INT,
    IN p_new_waypoint_id INT
)
BEGIN
    DECLARE v_relation_exists INT;
    DECLARE v_new_waypoint_exists INT;
    
    SELECT COUNT(*) INTO v_relation_exists 
    FROM PASSENGERXWAYPOINT
    WHERE passenger_id = p_passenger_id AND waypoint_id = p_old_waypoint_id;
    
    SELECT COUNT(*) INTO v_new_waypoint_exists 
    FROM WAYPOINT 
    WHERE id = p_new_waypoint_id;
    
    IF v_relation_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La relación pasajero-waypoint original no existe';
    ELSEIF v_new_waypoint_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo waypoint no existe';
    ELSE

        DELETE FROM PASSENGERXWAYPOINT
        WHERE passenger_id = p_passenger_id AND waypoint_id = p_old_waypoint_id;
        
        INSERT INTO PASSENGERXWAYPOINT (
            passenger_id, 
            waypoint_id,
            creator,
            creation_date
        ) VALUES (
            p_passenger_id, 
            p_new_waypoint_id,
            USER(),
            CURDATE()
        );
    END IF;
END $$


CREATE PROCEDURE delete_passenger_waypoint(
    IN p_passenger_id INT,
    IN p_waypoint_id INT
)
BEGIN
    DECLARE v_relation_exists INT;
    
    SELECT COUNT(*) INTO v_relation_exists 
    FROM PASSENGERXWAYPOINT
    WHERE passenger_id = p_passenger_id AND waypoint_id = p_waypoint_id;
    
    IF v_relation_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La relación pasajero-waypoint no existe';
    ELSE

        DELETE FROM PASSENGERXWAYPOINT
        WHERE passenger_id = p_passenger_id AND waypoint_id = p_waypoint_id;
    END IF;
END $$


CREATE PROCEDURE get_passenger_waypoint(
    IN p_passenger_id INT
)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM PASSENGER WHERE person_id = p_passenger_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El pasajero no existe';
    ELSE

        SELECT 
            pw.passenger_id, 
            pw.waypoint_id,
            w.latitude, 
            w.longitude, 
            w.district_id,
            d.name AS district_name
        FROM PASSENGERXWAYPOINT pw
        JOIN WAYPOINT w ON w.id = pw.waypoint_id
        LEFT JOIN carpooling_adm.DISTRICT d ON w.district_id = d.id
        WHERE pw.passenger_id = p_passenger_id;
    END IF;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_pu.add_passenger_waypoint TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.update_passenger_waypoint TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_passenger_waypoint TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.get_passenger_waypoint TO 'pu_user'@'%';


GRANT SELECT, INSERT, DELETE ON carpooling_pu.PASSENGERXWAYPOINT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGER TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.DISTRICT TO 'pu_user'@'%';

FLUSH PRIVILEGES;