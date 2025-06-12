USE carpooling_adm;


DROP PROCEDURE IF EXISTS create_country;
DROP PROCEDURE IF EXISTS get_all_countries;
DROP PROCEDURE IF EXISTS update_country_name;
DROP PROCEDURE IF EXISTS delete_country;

DELIMITER $$


CREATE PROCEDURE create_country(
    IN p_name VARCHAR(50)
)
BEGIN
    DECLARE v_country_exists INT;
    
    SELECT COUNT(*) INTO v_country_exists 
    FROM COUNTRY 
    WHERE name = p_name;
    
    IF v_country_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El país ya existe';
    ELSE
        INSERT INTO COUNTRY (
            name,
            creator,
            creation_date
        ) VALUES (
            p_name,
            USER(),
            CURDATE()
        );
    END IF;
END $$

CREATE PROCEDURE get_all_countries()
BEGIN
    SELECT 
        id,
        name,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM COUNTRY
    ORDER BY name;
END $$


CREATE PROCEDURE update_country_name(
    IN p_country_id INT,
    IN p_new_name VARCHAR(50))
BEGIN
    DECLARE v_country_exists INT;
    DECLARE v_name_exists INT;

    SELECT COUNT(*) INTO v_country_exists 
    FROM COUNTRY 
    WHERE id = p_country_id;

    SELECT COUNT(*) INTO v_name_exists 
    FROM COUNTRY 
    WHERE name = p_new_name AND id != p_country_id;
    
    IF v_country_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El país no existe';
    ELSEIF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo nombre ya está en uso por otro país';
    ELSE

        UPDATE COUNTRY 
        SET 
            name = p_new_name,
            modifier = USER(),
            modification_date = CURDATE()
        WHERE id = p_country_id;
    END IF;
END $$


CREATE PROCEDURE delete_country(
    IN p_country_id INT)
BEGIN
    DECLARE v_country_exists INT;
    DECLARE v_has_provinces INT;

    SELECT COUNT(*) INTO v_country_exists 
    FROM COUNTRY 
    WHERE id = p_country_id;

    SELECT COUNT(*) INTO v_has_provinces 
    FROM PROVINCE 
    WHERE country_id = p_country_id;
    
    IF v_country_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El país no existe';
    ELSEIF v_has_provinces > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el país porque tiene provincias asociadas';
    ELSE

        DELETE FROM COUNTRY 
        WHERE id = p_country_id;
    END IF;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_country TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_countries TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_country_name TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_country TO 'pu_user'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_adm.COUNTRY TO 'pu_user'@'%';

FLUSH PRIVILEGES;