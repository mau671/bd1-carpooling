USE carpooling_pu;

-- Eliminar procedimientos existentes si ya están definidos
DROP PROCEDURE IF EXISTS create_route;
DROP PROCEDURE IF EXISTS get_route_info;
DROP PROCEDURE IF EXISTS update_route;
DROP PROCEDURE IF EXISTS delete_route;

DELIMITER $$

CREATE PROCEDURE create_route (
    IN p_start_time TIMESTAMP,
    IN p_end_time TIMESTAMP,
    IN p_programming_date DATE,
    OUT o_route_id INT
)
BEGIN
    INSERT INTO ROUTE (start_time, end_time, programming_date)
    VALUES (p_start_time, p_end_time, p_programming_date);

    SET o_route_id = LAST_INSERT_ID();
END $$

CREATE PROCEDURE get_route_info (
    IN p_route_id INT
)
BEGIN
    SELECT id, start_time, end_time, programming_date,
           creator, creation_date, modifier, modification_date
    FROM ROUTE
    WHERE id = p_route_id;
END $$

CREATE PROCEDURE update_route (
    IN p_route_id INT,
    IN p_start_time TIMESTAMP,
    IN p_end_time TIMESTAMP,
    IN p_programming_date DATE
)
BEGIN
    DECLARE rows_affected INT;

    UPDATE ROUTE
    SET start_time = p_start_time,
        end_time = p_end_time,
        programming_date = p_programming_date
    WHERE id = p_route_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Route not found.';
    END IF;
END $$

CREATE PROCEDURE delete_route (
    IN p_route_id INT
)
BEGIN
    DECLARE rows_affected INT;

    DELETE FROM WAYPOINT WHERE route_id = p_route_id;
    DELETE FROM ROUTE WHERE id = p_route_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Route with ID ', p_route_id, ' not found.');
    END IF;
END $$

DELIMITER ;

-- Permisos necesarios

GRANT EXECUTE ON PROCEDURE carpooling_pu.create_route TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.ROUTE TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.get_route_info TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.update_route TO 'pu_user'@'%';
GRANT UPDATE ON carpooling_pu.ROUTE TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_route TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.ROUTE TO 'pu_user'@'%';
GRANT DELETE ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';


GRANT SELECT ON carpooling_adm.DISTRICT TO 'pu_user'@'%';

FLUSH PRIVILEGES;