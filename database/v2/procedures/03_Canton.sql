USE carpooling_adm;

DROP PROCEDURE IF EXISTS create_canton;
DROP PROCEDURE IF EXISTS get_all_cantons;
DROP PROCEDURE IF EXISTS get_cantons_by_province;
DROP PROCEDURE IF EXISTS update_canton_name;
DROP PROCEDURE IF EXISTS delete_canton;

DELIMITER $$


CREATE PROCEDURE create_canton(
    IN p_name VARCHAR(50),
    IN p_province_id INT
)
BEGIN
    DECLARE v_province_exists INT;
    DECLARE v_canton_exists INT;

    SELECT COUNT(*) INTO v_province_exists 
    FROM PROVINCE 
    WHERE id = p_province_id;
    
    SELECT COUNT(*) INTO v_canton_exists 
    FROM CANTON 
    WHERE name = p_name AND province_id = p_province_id;
    
    IF v_province_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La provincia no existe';
    ELSEIF v_canton_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cantón ya existe para esta provincia';
    ELSE
        INSERT INTO CANTON (
            province_id,
            name,
            creator,
            creation_date
        ) VALUES (
            p_province_id,
            p_name,
            USER(),
            CURDATE()
        );
    END IF;
END $$


CREATE PROCEDURE get_all_cantons()
BEGIN
    SELECT 
        c.id,
        c.name,
        c.province_id,
        p.name AS province_name,
        p.country_id,
        co.name AS country_name,
        c.creator,
        c.creation_date,
        c.modifier,
        c.modification_date
    FROM CANTON c
    JOIN PROVINCE p ON c.province_id = p.id
    JOIN COUNTRY co ON p.country_id = co.id
    ORDER BY co.name, p.name, c.name;
END $$


CREATE PROCEDURE get_cantons_by_province(
    IN p_province_id INT
)
BEGIN
    DECLARE v_province_exists INT;
    
    SELECT COUNT(*) INTO v_province_exists 
    FROM PROVINCE 
    WHERE id = p_province_id;
    
    IF v_province_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La provincia no existe';
    ELSE
        SELECT 
            c.id,
            c.name,
            c.creator,
            c.creation_date,
            c.modifier,
            c.modification_date
        FROM CANTON c
        WHERE c.province_id = p_province_id
        ORDER BY c.name;
    END IF;
END $$


CREATE PROCEDURE update_canton_name(
    IN p_canton_id INT,
    IN p_new_name VARCHAR(50)
)
BEGIN
    DECLARE v_canton_exists INT;
    DECLARE v_name_exists INT;

    SELECT COUNT(*) INTO v_canton_exists 
    FROM CANTON 
    WHERE id = p_canton_id;

    SELECT COUNT(*) INTO v_name_exists 
    FROM CANTON c1
    JOIN CANTON c2 ON c1.province_id = c2.province_id
    WHERE c2.id = p_canton_id AND c1.name = p_new_name AND c1.id != p_canton_id;
    
    IF v_canton_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cantón no existe';
    ELSEIF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo nombre ya está en uso por otro cantón de la misma provincia';
    ELSE
        UPDATE CANTON 
        SET 
            name = p_new_name,
            modifier = USER(),
            modification_date = CURDATE()
        WHERE id = p_canton_id;
    END IF;
END $$


CREATE PROCEDURE delete_canton(
    IN p_canton_id INT)
BEGIN
    DECLARE v_canton_exists INT;
    DECLARE v_has_districts INT;

    SELECT COUNT(*) INTO v_canton_exists 
    FROM CANTON 
    WHERE id = p_canton_id;

    SELECT COUNT(*) INTO v_has_districts 
    FROM DISTRICT 
    WHERE canton_id = p_canton_id;
    
    IF v_canton_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cantón no existe';
    ELSEIF v_has_districts > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el cantón porque tiene distritos asociados';
    ELSE
        DELETE FROM CANTON 
        WHERE id = p_canton_id;
    END IF;
END $$

DELIMITER ;

-- Grant

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_canton TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_cantons TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_cantons_by_province TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_canton_name TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_canton TO 'pu_user'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_adm.CANTON TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PROVINCE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.COUNTRY TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.DISTRICT TO 'pu_user'@'%';

FLUSH PRIVILEGES;