USE carpooling_pu;

DROP PROCEDURE IF EXISTS assign_payment_method;
DROP PROCEDURE IF EXISTS update_payment_method;
DROP PROCEDURE IF EXISTS delete_payment_method;
DROP PROCEDURE IF EXISTS get_payment_method;

DELIMITER $$


CREATE PROCEDURE assign_payment_method(
    IN p_passenger_x_trip_id INT,
    IN p_payment_method_id INT
)
BEGIN
    DECLARE v_passenger_trip_exists INT;
    DECLARE v_payment_method_exists INT;
    DECLARE v_relation_exists INT;

    SELECT COUNT(*) INTO v_passenger_trip_exists 
    FROM PASSENGERXTRIP 
    WHERE id = p_passenger_x_trip_id;

    SELECT COUNT(*) INTO v_payment_method_exists 
    FROM carpooling_adm.PAYMENTMETHOD 
    WHERE id = p_payment_method_id;
    
    SELECT COUNT(*) INTO v_relation_exists 
    FROM PASSENGERXTRIPXPAYMENT 
    WHERE passenger_x_trip_id = p_passenger_x_trip_id;
    
    IF v_passenger_trip_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La relación pasajero-viaje no existe';
    ELSEIF v_payment_method_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El método de pago no existe';
    ELSEIF v_relation_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ya existe un método de pago asignado a este viaje de pasajero';
    ELSE
        INSERT INTO PASSENGERXTRIPXPAYMENT (
            passenger_x_trip_id,
            payment_method_id,
            creator,
            creation_date
        ) VALUES (
            p_passenger_x_trip_id,
            p_payment_method_id,
            USER(),
            CURDATE()
        );
    END IF;
END $$


CREATE PROCEDURE update_payment_method(
    IN p_passenger_x_trip_id INT,
    IN p_new_payment_method_id INT
)
BEGIN
    DECLARE v_passenger_trip_exists INT;
    DECLARE v_payment_method_exists INT;
    DECLARE v_relation_exists INT;
    
    SELECT COUNT(*) INTO v_passenger_trip_exists 
    FROM PASSENGERXTRIP 
    WHERE id = p_passenger_x_trip_id;
    
    SELECT COUNT(*) INTO v_payment_method_exists 
    FROM carpooling_adm.PAYMENTMETHOD 
    WHERE id = p_new_payment_method_id;
    
    SELECT COUNT(*) INTO v_relation_exists 
    FROM PASSENGERXTRIPXPAYMENT 
    WHERE passenger_x_trip_id = p_passenger_x_trip_id;
    
    IF v_passenger_trip_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La relación pasajero-viaje no existe';
    ELSEIF v_payment_method_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nuevo método de pago no existe';
    ELSEIF v_relation_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No existe un método de pago asignado a este viaje de pasajero';
    ELSE
        UPDATE PASSENGERXTRIPXPAYMENT
        SET 
            payment_method_id = p_new_payment_method_id,
            modifier = USER(),
            modification_date = CURDATE()
        WHERE passenger_x_trip_id = p_passenger_x_trip_id;
    END IF;
END $$


CREATE PROCEDURE delete_payment_method(
    IN p_passenger_x_trip_id INT
)
BEGIN
    DECLARE v_relation_exists INT;
    SELECT COUNT(*) INTO v_relation_exists 
    FROM PASSENGERXTRIPXPAYMENT 
    WHERE passenger_x_trip_id = p_passenger_x_trip_id;
    
    IF v_relation_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No existe un método de pago asignado a este viaje de pasajero';
    ELSE
        DELETE FROM PASSENGERXTRIPXPAYMENT
        WHERE passenger_x_trip_id = p_passenger_x_trip_id;
    END IF;
END $$


CREATE PROCEDURE get_payment_method(
    IN p_passenger_x_trip_id INT
)
BEGIN
    DECLARE v_passenger_trip_exists INT;
    SELECT COUNT(*) INTO v_passenger_trip_exists 
    FROM PASSENGERXTRIP 
    WHERE id = p_passenger_x_trip_id;
    
    IF v_passenger_trip_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La relación pasajero-viaje no existe';
    ELSE
        SELECT 
            PX.id,
            PX.passenger_x_trip_id,
            PX.payment_method_id,
            PM.name AS payment_method_name,
            PX.creator,
            PX.creation_date,
            PX.modifier,
            PX.modification_date
        FROM PASSENGERXTRIPXPAYMENT PX
        JOIN carpooling_adm.PAYMENTMETHOD PM ON PM.id = PX.payment_method_id
        WHERE PX.passenger_x_trip_id = p_passenger_x_trip_id;
    END IF;
END $$

DELIMITER ;

-- Grants

GRANT EXECUTE ON PROCEDURE carpooling_pu.assign_payment_method TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.update_payment_method TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_payment_method TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_pu.get_payment_method TO 'pu_user'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_pu.PASSENGERXTRIPXPAYMENT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PAYMENTMETHOD TO 'pu_user'@'%';

FLUSH PRIVILEGES;