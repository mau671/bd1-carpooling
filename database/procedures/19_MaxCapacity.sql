
USE carpooling_adm;

-- Eliminar procedimientos existentes
DROP PROCEDURE IF EXISTS get_all_max_capacity;
DROP PROCEDURE IF EXISTS create_max_capacity;
DROP PROCEDURE IF EXISTS get_max_capacity_by_id;
DROP PROCEDURE IF EXISTS update_max_capacity;
DROP PROCEDURE IF EXISTS delete_max_capacity;

DELIMITER $$

-- ========================================
-- PROCEDURE: get_all_max_capacity (ORIGINAL)
-- Purpose: Get all max capacities
-- ========================================
CREATE PROCEDURE get_all_max_capacity()
BEGIN
    SELECT 
        id, 
        capacity_number,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM MAXCAPACITY
    ORDER BY capacity_number;
END $$

-- ========================================
-- PROCEDURE: create_max_capacity
-- Purpose: Insert a new max capacity
-- ========================================
CREATE PROCEDURE create_max_capacity(
    IN p_capacity INT,
    OUT o_capacity_id INT
)
BEGIN
    DECLARE v_capacity_exists INT;
    
    -- Check if capacity number already exists
    SELECT COUNT(*) INTO v_capacity_exists 
    FROM MAXCAPACITY 
    WHERE capacity_number = p_capacity;
    
    IF v_capacity_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Max capacity number already exists';
    ELSEIF p_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Capacity must be greater than 0';
    ELSE
        INSERT INTO MAXCAPACITY (capacity_number)
        VALUES (p_capacity);
        
        SET o_capacity_id = LAST_INSERT_ID();
    END IF;
END $$

-- ========================================
-- PROCEDURE: get_max_capacity_by_id
-- Purpose: Get a specific max capacity by ID
-- ========================================
CREATE PROCEDURE get_max_capacity_by_id(
    IN p_id INT
)
BEGIN
    SELECT 
        id, 
        capacity_number, 
        creator, 
        creation_date, 
        modifier, 
        modification_date
    FROM MAXCAPACITY
    WHERE id = p_id;
END $$

-- ========================================
-- PROCEDURE: update_max_capacity
-- Purpose: Update max capacity number
-- ========================================
CREATE PROCEDURE update_max_capacity(
    IN p_id INT,
    IN p_capacity INT
)
BEGIN
    DECLARE v_capacity_exists INT;
    DECLARE v_number_exists INT;
    DECLARE rows_affected INT;
    
    -- Check if capacity exists
    SELECT COUNT(*) INTO v_capacity_exists 
    FROM MAXCAPACITY 
    WHERE id = p_id;
    
    -- Check if new capacity number already exists
    SELECT COUNT(*) INTO v_number_exists 
    FROM MAXCAPACITY 
    WHERE capacity_number = p_capacity AND id != p_id;
    
    IF v_capacity_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Max capacity not found';
    ELSEIF p_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Capacity must be greater than 0';
    ELSEIF v_number_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Capacity number already exists';
    ELSE
        UPDATE MAXCAPACITY
        SET capacity_number = p_capacity
        WHERE id = p_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Max capacity not found';
        END IF;
    END IF;
END $$

-- ========================================
-- PROCEDURE: delete_max_capacity
-- Purpose: Delete a max capacity
-- ========================================
CREATE PROCEDURE delete_max_capacity(
    IN p_id INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE rows_affected INT;
    
    -- Check if max capacity is used in vehicle-capacity relationships
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.MAXCAPACITYXVEHICLE
    WHERE max_capacity_id = p_id;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete max capacity that is used in vehicle-capacity relationships';
    ELSE
        DELETE FROM MAXCAPACITY
        WHERE id = p_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Max capacity not found';
        END IF;
    END IF;
END $$

DELIMITER ;

-- ========================================
-- GRANTS
-- ========================================
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_max_capacity TO 'pu_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_max_capacity_by_id TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_max_capacity TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_max_capacity_by_id TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_max_capacity TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_max_capacity TO 'adm_user'@'%';

GRANT SELECT ON carpooling_adm.MAXCAPACITY TO 'pu_user'@'%';
GRANT INSERT, UPDATE, DELETE ON carpooling_adm.MAXCAPACITY TO 'adm_user'@'%';

-- Permisos de acceso para validaciones cruzadas
GRANT SELECT ON carpooling_pu.MAXCAPACITYXVEHICLE TO 'adm_user'@'%';

FLUSH PRIVILEGES;