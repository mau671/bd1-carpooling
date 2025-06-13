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

DELIMITER ;