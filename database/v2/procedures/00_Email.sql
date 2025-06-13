USE carpooling_pu;

DELIMITER $$

DROP PROCEDURE IF EXISTS delete_email_by_address$$

CREATE PROCEDURE DELETE_EMAIL_BY_ADDRESS(
    IN p_email_address VARCHAR(100)
)
BEGIN
    DELETE FROM carpooling_adm.EMAIL 
    WHERE name = p_email_address;
    
    -- Opcional: Retornar el número de filas afectadas
    SELECT ROW_COUNT() AS rows_affected;
END $$

DELIMITER ;