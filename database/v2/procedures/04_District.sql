USE carpooling_adm;

-- Eliminar procedimientos existentes
DROP PROCEDURE IF EXISTS create_district;
DROP PROCEDURE IF EXISTS get_all_districts;
DROP PROCEDURE IF EXISTS get_districts_by_canton;
DROP PROCEDURE IF EXISTS update_district_name;
DROP PROCEDURE IF EXISTS delete_district;
DROP PROCEDURE IF EXISTS get_district;

DELIMITER $$

-- ========================================
-- PROCEDURE: create_district (ORIGINAL - mantenido)
-- Purpose: Insert a new district
-- ========================================
CREATE PROCEDURE create_district(
    IN p_name VARCHAR(50),
    IN p_canton_id INT
)
BEGIN
    DECLARE v_canton_exists INT;
    DECLARE v_district_exists INT;

    SELECT COUNT(*) INTO v_canton_exists 
    FROM CANTON 
    WHERE id = p_canton_id;

    SELECT COUNT(*) INTO v_district_exists 
    FROM DISTRICT 
    WHERE name = p_name AND canton_id = p_canton_id;
    
    IF v_canton_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cantón no existe';
    ELSEIF v_district_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El distrito ya existe para este cantón';
    ELSE
        INSERT INTO DISTRICT (
            canton_id,
            name,
            creator,
            creation_date
        ) VALUES (
            p_canton_id,
            p_name,
            USER(),
            CURDATE()
        );
    END IF;
END $$


-- ========================================
-- PROCEDURE: get_all_districts (ORIGINAL - mantenido)
-- Purpose: Get all districts
-- ========================================
CREATE PROCEDURE get_all_districts()
BEGIN
    SELECT 
        d.id,
        d.name,
        d.canton_id,
        c.name AS canton_name,
        c.province_id,
        p.name AS province_name,
        p.country_id,
        co.name AS country_name,
        d.creator,
        d.creation_date,
        d.modifier,
        d.modification_date
    FROM DISTRICT d
    JOIN CANTON c ON d.canton_id = c.id
    JOIN PROVINCE p ON c.province_id = p.id
    JOIN COUNTRY co ON p.country_id = co.id
    ORDER BY co.name, p.name, c.name, d.name;
END $$

-- ========================================
-- PROCEDURE: get_district (MIGRADO)
-- Purpose: Get a specific district by ID
-- ========================================
CREATE PROCEDURE get_district(
    IN p_id INT
)
BEGIN
    SELECT 
        d.id, 
        d.canton_id, 
        c.name AS canton_name,
        d.name, 
        d.creator, 
        d.creation_date,
        d.modifier, 
        d.modification_date
    FROM DISTRICT d
    JOIN CANTON c ON d.canton_id = c.id
    WHERE d.id = p_id;
END $$


CREATE PROCEDURE get_districts_by_canton(
    IN p_canton_id INT
)
BEGIN
    DECLARE v_canton_exists INT;
    
    SELECT COUNT(*) INTO v_canton_exists 
    FROM CANTON 
    WHERE id = p_canton_id;
    
    IF v_canton_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cantón no existe';
    ELSE
        SELECT 
            d.id,
            d.name,
            d.creator,
            d.creation_date,
            d.modifier,
            d.modification_date
        FROM DISTRICT d
        WHERE d.canton_id = p_canton_id
        ORDER BY d.name;
    END IF;
END $$


CREATE PROCEDURE update_district_name(
    IN p_district_id INT,
    IN p_new_name VARCHAR(50)
)
BEGIN
    DECLARE v_district_exists INT;
    DECLARE v_name_exists INT;

    SELECT COUNT(*) INTO v_district_exists 
    FROM DISTRICT 
    WHERE id = p_district_id;

    SELECT COUNT(*) INTO v_name_exists 
    FROM DISTRICT d1
    JOIN DISTRICT d2 ON d1.canton_id = d2.canton_id
    WHERE d2.id = p_district_id AND d1.name = p_new_name AND d1.id != p_district_id;
    
    IF v_district_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El distrito no existe';
    ELSEIF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo nombre ya está en uso por otro distrito del mismo cantón';
    ELSE
        UPDATE DISTRICT 
        SET 
            name = p_new_name,
            modifier = USER(),
            modification_date = CURDATE()
        WHERE id = p_district_id;
    END IF;
END $$


CREATE PROCEDURE delete_district(
    IN p_district_id INT)
BEGIN
    DECLARE v_district_exists INT;
    DECLARE v_has_waypoints INT;

    SELECT COUNT(*) INTO v_district_exists 
    FROM DISTRICT 
    WHERE id = p_district_id;

    SELECT COUNT(*) INTO v_has_waypoints 
    FROM carpooling_pu.WAYPOINT 
    WHERE district_id = p_district_id;
    
    IF v_district_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El distrito no existe';
    ELSEIF v_has_waypoints > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el distrito porque tiene waypoints asociados';
    ELSE
        DELETE FROM DISTRICT 
        WHERE id = p_district_id;
    END IF;
END $$

DELIMITER ;

-- Otorgar permisos

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_district TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_districts TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_district TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_districts_by_canton TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_district_name TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_district TO 'pu_user'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_adm.DISTRICT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CANTON TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PROVINCE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.COUNTRY TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.WAYPOINT TO 'pu_user'@'%';

FLUSH PRIVILEGES;