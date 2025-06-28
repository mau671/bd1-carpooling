USE carpooling_adm;

-- Eliminar procedimientos existentes
DROP PROCEDURE IF EXISTS get_all_payment_methods;
DROP PROCEDURE IF EXISTS create_payment_method;
DROP PROCEDURE IF EXISTS get_payment_method_by_id;
DROP PROCEDURE IF EXISTS update_payment_method_name;
DROP PROCEDURE IF EXISTS delete_payment_method;

DELIMITER $$

-- ========================================
-- PROCEDURE: get_all_payment_methods (ORIGINAL)
-- Purpose: Get all payment methods
-- ========================================
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

-- ========================================
-- PROCEDURE: create_payment_method
-- Purpose: Insert a new payment method
-- ========================================
CREATE PROCEDURE create_payment_method(
    IN p_name VARCHAR(50),
    OUT o_method_id INT
)
BEGIN
    DECLARE v_method_exists INT;
    
    -- Check if payment method already exists
    SELECT COUNT(*) INTO v_method_exists 
    FROM PAYMENTMETHOD 
    WHERE name = TRIM(p_name);
    
    IF v_method_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Payment method already exists';
    ELSE
        INSERT INTO PAYMENTMETHOD (name)
        VALUES (TRIM(p_name));
        
        SET o_method_id = LAST_INSERT_ID();
    END IF;
END $$

-- ========================================
-- PROCEDURE: get_payment_method_by_id
-- Purpose: Get a specific payment method by ID
-- ========================================
CREATE PROCEDURE get_payment_method_by_id(
    IN p_id INT
)
BEGIN
    SELECT 
        id, 
        name, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM PAYMENTMETHOD
    WHERE id = p_id;
END $$

-- ========================================
-- PROCEDURE: update_payment_method_name
-- Purpose: Update payment method name
-- ========================================
CREATE PROCEDURE update_payment_method_name(
    IN p_id INT,
    IN p_name VARCHAR(50)
)
BEGIN
    DECLARE v_method_exists INT;
    DECLARE v_name_exists INT;
    DECLARE rows_affected INT;
    
    -- Check if payment method exists
    SELECT COUNT(*) INTO v_method_exists 
    FROM PAYMENTMETHOD 
    WHERE id = p_id;
    
    -- Check if new name already exists
    SELECT COUNT(*) INTO v_name_exists 
    FROM PAYMENTMETHOD 
    WHERE name = TRIM(p_name) AND id != p_id;
    
    IF v_method_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Payment method not found';
    ELSEIF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Payment method name already exists';
    ELSE
        UPDATE PAYMENTMETHOD
        SET name = TRIM(p_name)
        WHERE id = p_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Payment method not found';
        END IF;
    END IF;
END $$

-- ========================================
-- PROCEDURE: delete_payment_method
-- Purpose: Delete a payment method
-- ========================================
CREATE PROCEDURE delete_payment_method(
    IN p_id INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE rows_affected INT;
    
    -- Check if payment method is used in payments
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.PASSENGERXTRIPXPAYMENT
    WHERE payment_method_id = p_id;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete payment method that is used in payments';
    ELSE
        DELETE FROM PAYMENTMETHOD
        WHERE id = p_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Payment method not found';
        END IF;
    END IF;
END $$

DELIMITER ;

-- ========================================
-- GRANTS
-- ========================================
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_payment_methods TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_payment_method_by_id TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_payment_method TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_payment_method_by_id TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_payment_method_name TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_payment_method TO 'adm_user'@'%';

GRANT SELECT ON carpooling_adm.PAYMENTMETHOD TO 'pu_user'@'%';

-- Permisos de acceso para validaciones cruzadas
GRANT SELECT ON carpooling_pu.PASSENGERXTRIPXPAYMENT TO 'adm_user'@'%';

FLUSH PRIVILEGES;