USE carpooling_pu;

DROP PROCEDURE IF EXISTS get_driver_info;
DROP PROCEDURE IF EXISTS delete_driver;

DELIMITER $$


CREATE PROCEDURE get_driver_info(
    IN p_person_id INT
)
BEGIN
    SELECT 
        d.person_id, 
        p.first_name, 
        p.second_name, 
        p.first_surname,
        p.second_surname, 
        p.identification_number, 
        p.date_of_birth,
        p.creation_date,
        p.creator
    FROM DRIVER d
    JOIN carpooling_adm.PERSON p ON p.id = d.person_id
    WHERE d.person_id = p_person_id;
END $$


CREATE PROCEDURE delete_driver(
    IN p_person_id INT
)
BEGIN
    DECLARE rows_affected INT;

    DELETE FROM DRIVERXVEHICLE WHERE driver_id = p_person_id;
    
    DELETE FROM DRIVER WHERE person_id = p_person_id;
    
    SET rows_affected = ROW_COUNT();
    
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Driver not found';
    END IF;
END $$

DELIMITER ;

-- Permisos

GRANT EXECUTE ON PROCEDURE carpooling_pu.get_driver_info TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVER TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_driver TO 'adm_user'@'%';
GRANT DELETE ON carpooling_pu.DRIVER TO 'adm_user'@'%';
GRANT DELETE ON carpooling_pu.DRIVERXVEHICLE TO 'adm_user'@'%';

GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';

FLUSH PRIVILEGES;