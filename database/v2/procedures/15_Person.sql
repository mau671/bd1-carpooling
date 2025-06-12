USE carpooling_adm;

DROP PROCEDURE IF EXISTS get_person_profile;

DELIMITER $$


CREATE PROCEDURE get_person_profile(
    IN p_person_id INT
)
BEGIN
    DECLARE v_person_exists INT DEFAULT 0;

    SELECT COUNT(*) INTO v_person_exists 
    FROM PERSON 
    WHERE id = p_person_id;
    
    IF v_person_exists = 0 THEN
        SELECT 
            NULL AS first_name,
            NULL AS second_name,
            NULL AS first_surname,
            NULL AS second_surname,
            NULL AS identification_number,
            NULL AS date_of_birth,
            NULL AS gender_id,
            NULL AS type_identification_id,
            'Person not found' AS message;
    ELSE
        SELECT 
            first_name,
            second_name,
            first_surname,
            second_surname,
            identification_number,
            date_of_birth,
            gender_id,
            type_identification_id,
            'Success' AS message
        FROM
            PERSON
        WHERE
            id = p_person_id;
    END IF;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_adm.get_person_profile TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON TO 'pu_user'@'%';

FLUSH PRIVILEGES;