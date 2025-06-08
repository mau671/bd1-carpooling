USE carpooling_pu;

DROP PROCEDURE IF EXISTS assign_vehicle_to_route;
DROP PROCEDURE IF EXISTS get_routes_by_vehicle;
DROP PROCEDURE IF EXISTS get_vehicles_by_route;
DROP PROCEDURE IF EXISTS update_vehicle_for_route;
DROP PROCEDURE IF EXISTS remove_vehicle_route_link;

DELIMITER $$


CREATE PROCEDURE assign_vehicle_to_route(
    IN p_vehicle_id INT,
    IN p_route_id INT
)
BEGIN
    DECLARE v_vehicle_exists INT;
    DECLARE v_route_exists INT;
    DECLARE v_link_exists INT;
    SELECT COUNT(*) INTO v_vehicle_exists FROM VEHICLE WHERE id = p_vehicle_id;
    SELECT COUNT(*) INTO v_route_exists FROM ROUTE WHERE id = p_route_id;
    SELECT COUNT(*) INTO v_link_exists 
    FROM VEHICLEXROUTE 
    WHERE vehicle_id = p_vehicle_id AND route_id = p_route_id;
    
    IF v_vehicle_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El vehículo no existe';
    ELSEIF v_route_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La ruta no existe';
    ELSEIF v_link_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El vehículo ya está asignado a esta ruta';
    ELSE
        INSERT INTO VEHICLEXROUTE (
            vehicle_id, 
            route_id,
            creator,
            creation_date
        ) VALUES (
            p_vehicle_id, 
            p_route_id,
            USER(),
            CURDATE()
        );
    END IF;
END $$


CREATE PROCEDURE get_routes_by_vehicle(
    IN p_vehicle_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM VEHICLE WHERE id = p_vehicle_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El vehículo no existe';
    ELSE
        SELECT 
            r.id,
            r.start_time,
            r.end_time,
            r.programming_date,
            r.creator,
            r.creation_date,
            r.modifier,
            r.modification_date
        FROM VEHICLEXROUTE vr
        JOIN ROUTE r ON r.id = vr.route_id
        WHERE vr.vehicle_id = p_vehicle_id
        ORDER BY r.programming_date, r.start_time;
    END IF;
END $$


CREATE PROCEDURE get_vehicles_by_route(
    IN p_route_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ROUTE WHERE id = p_route_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La ruta no existe';
    ELSE
        SELECT 
            v.id,
            v.plate,
            v.creator,
            v.creation_date,
            v.modifier,
            v.modification_date
        FROM VEHICLEXROUTE vr
        JOIN VEHICLE v ON v.id = vr.vehicle_id
        WHERE vr.route_id = p_route_id
        ORDER BY v.plate;
    END IF;
END $$


CREATE PROCEDURE update_vehicle_for_route(
    IN p_route_id INT,
    IN p_new_vehicle_id INT
)
BEGIN
    DECLARE v_vehicle_exists INT;
    DECLARE v_route_exists INT;
    DECLARE v_link_exists INT;
    SELECT COUNT(*) INTO v_vehicle_exists FROM VEHICLE WHERE id = p_new_vehicle_id;
    SELECT COUNT(*) INTO v_route_exists FROM ROUTE WHERE id = p_route_id;
    SELECT COUNT(*) INTO v_link_exists 
    FROM VEHICLEXROUTE 
    WHERE route_id = p_route_id;
    
    IF v_vehicle_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo vehículo no existe';
    ELSEIF v_route_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La ruta no existe';
    ELSEIF v_link_exists = 0 THEN
        INSERT INTO VEHICLEXROUTE (
            vehicle_id, 
            route_id,
            creator,
            creation_date
        ) VALUES (
            p_new_vehicle_id, 
            p_route_id,
            USER(),
            CURDATE()
        );
    ELSE
        UPDATE VEHICLEXROUTE
        SET 
            vehicle_id = p_new_vehicle_id,
            modifier = USER(),
            modification_date = CURDATE()
        WHERE route_id = p_route_id;
    END IF;
END $$


CREATE PROCEDURE remove_vehicle_route_link(
    IN p_vehicle_id INT,
    IN p_route_id INT
)
BEGIN
    DECLARE v_link_exists INT;
    
    SELECT COUNT(*) INTO v_link_exists 
    FROM VEHICLEXROUTE 
    WHERE vehicle_id = p_vehicle_id AND route_id = p_route_id;
    
    IF v_link_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se encontró la relación vehículo-ruta';
    ELSE
        DELETE FROM VEHICLEXROUTE
        WHERE vehicle_id = p_vehicle_id AND route_id = p_route_id;
    END IF;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_pu.assign_vehicle_to_route TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.get_routes_by_vehicle TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.get_vehicles_by_route TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.update_vehicle_for_route TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.remove_vehicle_route_link TO 'pu_user'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_pu.VEHICLEXROUTE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';

FLUSH PRIVILEGES;