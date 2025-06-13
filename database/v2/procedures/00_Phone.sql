USE carpooling_pu;

DELIMITER $$

CREATE PROCEDURE INSERT_PHONE_SIMPLE(
    IN p_phone_number VARCHAR(20),
    IN p_type_phone_id INT
)
BEGIN
    INSERT INTO carpooling_adm.PHONE (
        phone_number,
        type_phone_id,
        creation_date,
        modification_date
    ) VALUES (
        p_phone_number,
        p_type_phone_id,
        CURRENT_DATE(),
        CURRENT_DATE()
    );
END $$

CREATE PROCEDURE DELETE_PHONE_BY_TYPE_AND_NUMBER(
    IN p_phone_number VARCHAR(20),
    IN p_type_phone_id INT
)
BEGIN
    DELETE FROM carpooling_adm.PHONE 
    WHERE phone_number = p_phone_number 
    AND type_phone_id = p_type_phone_id;
END $$

DELIMITER ;