USE carpooling_pu;

DROP PROCEDURE IF EXISTS create_waypoint_with_district;
DROP PROCEDURE IF EXISTS create_waypoint_with_coords;
DROP PROCEDURE IF EXISTS get_waypoint_info;
DROP PROCEDURE IF EXISTS update_waypoint_district;
DROP PROCEDURE IF EXISTS delete_waypoint;

DELIMITER $$

CREATE PROCEDURE create_waypoint_with_district (
    IN p_route_id INT,
    IN p_district_id INT
)
BEGIN
    INSERT INTO WAYPOINT (route_id, district_id)
    VALUES (p_route_id, p_district_id);
END $$

CREATE PROCEDURE create_waypoint_with_coords (
    IN p_route_id INT,
    IN p_latitude DECIMAL(10,8),
    IN p_longitude DECIMAL(11,8)
)
BEGIN
    INSERT INTO WAYPOINT (route_id, latitude, longitude)
    VALUES (p_route_id, p_latitude, p_longitude);
END $$

CREATE PROCEDURE get_waypoint_info (
    IN p_waypoint_id INT
)
BEGIN
    SELECT id, district_id, latitude, longitude,
           creator, creation_date, modifier, modification_date
    FROM WAYPOINT
    WHERE id = p_waypoint_id;
END $$

CREATE PROCEDURE update_waypoint_district (
    IN p_waypoint_id INT,
    IN p_new_district INT
)
BEGIN
    DECLARE rows_affected INT;

    UPDATE WAYPOINT
    SET district_id = p_new_district
    WHERE id = p_waypoint_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Waypoint not found.';
    END IF;
END $$

CREATE PROCEDURE delete_waypoint (
    IN p_waypoint_id INT
)
BEGIN
    DECLARE rows_affected INT;

    DELETE FROM WAYPOINT WHERE id = p_waypoint_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Waypoint with ID ', p_waypoint_id, ' not found.');
    END IF;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_pu.create_waypoint_with_district TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.DISTRICT TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.create_waypoint_with_coords TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.get_waypoint_info TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.update_waypoint_district TO 'pu_user'@'%';
GRANT UPDATE ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.DISTRICT TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_waypoint TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';


GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';

FLUSH PRIVILEGES;