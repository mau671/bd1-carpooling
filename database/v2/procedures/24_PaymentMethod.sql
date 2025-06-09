USE carpooling_adm;

DROP PROCEDURE IF EXISTS get_all_payment_methods;

DELIMITER $$


CREATE PROCEDURE get_all_payment_methods()
BEGIN
    SELECT 
        id,
        name,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM PAYMENTMETHOD
    ORDER BY name;
END $$

DELIMITER ;

-- Privilegios

GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_payment_methods TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PAYMENTMETHOD TO 'pu_user'@'%';

FLUSH PRIVILEGES;