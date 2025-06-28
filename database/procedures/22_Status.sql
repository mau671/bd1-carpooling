USE carpooling_adm;

-- Eliminar procedimientos existentes
DROP PROCEDURE IF EXISTS get_all_status;
DROP PROCEDURE IF EXISTS create_status;
DROP PROCEDURE IF EXISTS get_status_by_id;
DROP PROCEDURE IF EXISTS update_status_name;
DROP PROCEDURE IF EXISTS delete_status;

DELIMITER $$

-- ========================================
-- PROCEDURE: get_all_status (ORIGINAL)
-- Purpose: Get all statuses
-- ========================================
CREATE PROCEDURE get_all_status()
BEGIN
    SELECT 
        id, 
        name,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM STATUS
    ORDER BY name;
END $$

-- ========================================
-- PROCEDURE: create_status
-- Purpose: Insert a new status
-- ========================================
CREATE PROCEDURE create_status(
    IN p_name VARCHAR(50),
    OUT o_status_id INT
)
BEGIN
    DECLARE v_status_exists INT;
    
    -- Check if status already exists
    SELECT COUNT(*) INTO v_status_exists 
    FROM STATUS 
    WHERE name = TRIM(p_name);
    
    IF v_status_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El status ya existe';
    ELSE
        INSERT INTO STATUS (name)
        VALUES (TRIM(p_name));
        
        SET o_status_id = LAST_INSERT_ID();
    END IF;
END $$

-- ========================================
-- PROCEDURE: get_status_by_id
-- Purpose: Get a specific status by ID
-- ========================================
CREATE PROCEDURE get_status_by_id(
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
    FROM STATUS
    WHERE id = p_id;
END $$

-- ========================================
-- PROCEDURE: update_status_name
-- Purpose: Update status name
-- ========================================
CREATE PROCEDURE update_status_name(
    IN p_id INT,
    IN p_name VARCHAR(50)
)
BEGIN
    DECLARE v_status_exists INT;
    DECLARE v_name_exists INT;
    DECLARE rows_affected INT;
    
    -- Check if status exists
    SELECT COUNT(*) INTO v_status_exists 
    FROM STATUS 
    WHERE id = p_id;
    
    -- Check if new name already exists
    SELECT COUNT(*) INTO v_name_exists 
    FROM STATUS 
    WHERE name = TRIM(p_name) AND id != p_id;
    
    IF v_status_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Status not found';
    ELSEIF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Status name already exists';
    ELSE
        UPDATE STATUS
        SET name = TRIM(p_name)
        WHERE id = p_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Status not found';
        END IF;
    END IF;
END $$

-- ========================================
-- PROCEDURE: delete_status
-- Purpose: Delete a status
-- ========================================
CREATE PROCEDURE delete_status(
    IN p_id INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE rows_affected INT;
    
    -- Check if status is used in trips
    SELECT COUNT(*) INTO v_count
    FROM carpooling_pu.STATUSXTRIP
    WHERE status_id = p_id;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete status that is used in trips';
    ELSE
        DELETE FROM STATUS
        WHERE id = p_id;
        
        SET rows_affected = ROW_COUNT();
        
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Status not found';
        END IF;
    END IF;
END $$

DELIMITER ;

-- ========================================
-- GRANTS
-- ========================================
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_status TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_status_by_id TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_adm.create_status TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_status_by_id TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.update_status_name TO 'adm_user'@'%';
GRANT EXECUTE ON PROCEDURE carpooling_adm.delete_status TO 'adm_user'@'%';

GRANT SELECT ON carpooling_adm.STATUS TO 'adm_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';

GRANT INSERT, UPDATE ON carpooling_adm.STATUS TO 'adm_user'@'%'; 
GRANT DELETE ON carpooling_adm.STATUS TO 'adm_user'@'%' WITH GRANT OPTION; 

-- Permisos de acceso para validaciones cruzadas
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'adm_user'@'%';

FLUSH PRIVILEGES;