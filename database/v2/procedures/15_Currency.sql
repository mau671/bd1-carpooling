USE carpooling_adm;

DROP PROCEDURE IF EXISTS create_currency;
DROP PROCEDURE IF EXISTS get_all_currencies;
DROP PROCEDURE IF EXISTS update_currency_name;
DROP PROCEDURE IF EXISTS delete_currency;

DELIMITER $$


CREATE PROCEDURE create_currency(
    IN p_name VARCHAR(50),
    OUT o_currency_id INT
)
BEGIN
    INSERT INTO CURRENCY (name)
    VALUES (p_name);
    
    SET o_currency_id = LAST_INSERT_ID();
END $$


CREATE PROCEDURE get_all_currencies()
BEGIN
    SELECT 
        id, 
        name,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM CURRENCY
    ORDER BY name;
END $$


CREATE PROCEDURE update_currency_name(
    IN p_currency_id INT,
    IN p_new_name VARCHAR(50)
BEGIN
    DECLARE rows_affected INT;
    
    UPDATE CURRENCY
    SET name = p_new_name
    WHERE id = p_currency_id;
    
    SET rows_affected = ROW_COUNT();
    
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Currency not found';
    END IF;
END $$


CREATE PROCEDURE delete_currency(
    IN p_currency_id INT)
BEGIN
    DECLARE rows_affected INT;
    DECLARE is_used INT;
    

    SELECT COUNT(*) INTO is_used 
    FROM carpooling_pu.TRIP 
    WHERE id_currency = p_currency_id;
    
    IF is_used > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete currency: it is being used in trips';
    ELSE
        DELETE FROM CURRENCY
        WHERE id = p_currency_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Currency not found';
        END IF;
    END IF;
END $$

DELIMITER ;

-- Permisos necesarios

GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_currencies TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CURRENCY TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_currency TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_currency_name TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_currency TO 'adm_user'@'%';
GRANT INSERT, UPDATE, DELETE ON carpooling_adm.CURRENCY TO 'adm_user'@'%';

GRANT SELECT ON carpooling_pu.TRIP TO 'adm_user'@'%';

FLUSH PRIVILEGES;