USE carpooling_adm;

DROP PROCEDURE IF EXISTS create_province;
DROP PROCEDURE IF EXISTS get_all_provinces;
DROP PROCEDURE IF EXISTS get_provinces_by_country;
DROP PROCEDURE IF EXISTS update_province_name;
DROP PROCEDURE IF EXISTS delete_province;

DELIMITER $$


CREATE PROCEDURE create_province(
    IN p_name VARCHAR(50),
    IN p_country_id INT
)
BEGIN
    DECLARE v_country_exists INT;
    DECLARE v_province_exists INT;
    
    SELECT COUNT(*) INTO v_country_exists 
    FROM COUNTRY 
    WHERE id = p_country_id;
    
    SELECT COUNT(*) INTO v_province_exists 
    FROM PROVINCE 
    WHERE name = p_name AND country_id = p_country_id;
    
    IF v_country_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El país no existe';
    ELSEIF v_province_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La provincia ya existe para este país';
    ELSE
        INSERT INTO PROVINCE (
            country_id,
            name,
            creator,
            creation_date
        ) VALUES (
            p_country_id,
            p_name,
            USER(),
            CURDATE()
        );
    END IF;
END $$


CREATE PROCEDURE get_all_provinces()
BEGIN
    SELECT 
        p.id,
        p.name,
        p.country_id,
        c.name AS country_name,
        p.creator,
        p.creation_date,
        p.modifier,
        p.modification_date
    FROM PROVINCE p
    JOIN COUNTRY c ON p.country_id = c.id
    ORDER BY c.name, p.name;
END $$


CREATE PROCEDURE get_provinces_by_country(
    IN p_country_id INT
)
BEGIN
    DECLARE v_country_exists INT;

    SELECT COUNT(*) INTO v_country_exists 
    FROM COUNTRY 
    WHERE id = p_country_id;
    
    IF v_country_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El país no existe';
    ELSE
        SELECT 
            p.id,
            p.name,
            p.creator,
            p.creation_date,
            p.modifier,
            p.modification_date
        FROM PROVINCE p
        WHERE p.country_id = p_country_id
        ORDER BY p.name;
    END IF;
END $$


CREATE PROCEDURE update_province_name(
    IN p_province_id INT,
    IN p_new_name VARCHAR(50)
)
BEGIN
    DECLARE v_province_exists INT;
    DECLARE v_name_exists INT;

    SELECT COUNT(*) INTO v_province_exists 
    FROM PROVINCE 
    WHERE id = p_province_id;

    SELECT COUNT(*) INTO v_name_exists 
    FROM PROVINCE p1
    JOIN PROVINCE p2 ON p1.country_id = p2.country_id
    WHERE p2.id = p_province_id AND p1.name = p_new_name AND p1.id != p_province_id;
    
    IF v_province_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La provincia no existe';
    ELSEIF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo nombre ya está en uso por otra provincia del mismo país';
    ELSE
        UPDATE PROVINCE 
        SET 
            name = p_new_name,
            modifier = USER(),
            modification_date = CURDATE()
        WHERE id = p_province_id;
    END IF;
END $$


CREATE PROCEDURE delete_province(
    IN p_province_id INT)
BEGIN
    DECLARE v_province_exists INT;
    DECLARE v_has_cantons INT;
    SELECT COUNT(*) INTO v_province_exists 
    FROM PROVINCE 
    WHERE id = p_province_id;
    SELECT COUNT(*) INTO v_has_cantons 
    FROM CANTON 
    WHERE province_id = p_province_id;
    
    IF v_province_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La provincia no existe';
    ELSEIF v_has_cantons > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar la provincia porque tiene cantones asociados';
    ELSE
        DELETE FROM PROVINCE 
        WHERE id = p_province_id;
    END IF;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_province TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_provinces TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_provinces_by_country TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_province_name TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_province TO 'pu_user'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_adm.PROVINCE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.COUNTRY TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CANTON TO 'pu_user'@'%';

FLUSH PRIVILEGES;