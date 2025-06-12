-- =====================================================================
-- carpooling_adm.parameter Procedures (MySQL 8.0+)
-- Migración de 14_Parameter_Procedures.sql (Oracle) a MySQL
-- Autor: Mauricio González Prendas
-- Fecha: 20 mayo 2025
-- =====================================================================

USE carpooling_adm;

-- =========================================
-- Tabla de parámetros (si no existe)
-- =========================================
-- CREATE TABLE IF NOT EXISTS parameter (
--     id BIGINT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(100) NOT NULL UNIQUE,
--     value VARCHAR(255) NOT NULL,
--     creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
--     modification_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- ) ENGINE = InnoDB;

-- Eliminar procedimientos existentes para evitar errores de duplicado
DROP PROCEDURE IF EXISTS validate_parameter_exists;
DROP PROCEDURE IF EXISTS create_parameter;
DROP PROCEDURE IF EXISTS update_parameter;
DROP PROCEDURE IF EXISTS delete_parameter;
DROP PROCEDURE IF EXISTS get_parameter;
DROP PROCEDURE IF EXISTS get_all_parameters;
DROP PROCEDURE IF EXISTS get_parameter_by_name;

-- Helper: validar existencia
DELIMITER $$
CREATE PROCEDURE validate_parameter_exists(IN p_id BIGINT)
BEGIN
    DECLARE v_msg VARCHAR(255);
    IF NOT EXISTS (SELECT 1 FROM PARAMETER WHERE id = p_id) THEN
        SET v_msg = CONCAT('No se encontró parámetro con ID: ', p_id);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
    END IF;
END $$
DELIMITER ;

-- =========================================
-- 1. CRUD Procedures
-- =========================================
DELIMITER $$

-- 1.1 Crear parámetro
CREATE PROCEDURE create_parameter (
    IN p_name VARCHAR(100),
    IN p_value VARCHAR(255),
    OUT p_new_id BIGINT
)
BEGIN
    DECLARE duplicate_key CONDITION FOR SQLSTATE '23000';
    DECLARE EXIT HANDLER FOR duplicate_key
    BEGIN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe un parámetro con ese nombre.';
    END;

    START TRANSACTION;
    INSERT INTO PARAMETER(name, value) VALUES (p_name, p_value);
    SET p_new_id = LAST_INSERT_ID();
    COMMIT;
END $$

-- 1.2 Actualizar parámetro
CREATE PROCEDURE update_parameter (
    IN p_id BIGINT,
    IN p_name VARCHAR(100),
    IN p_value VARCHAR(255)
)
BEGIN
    CALL validate_parameter_exists(p_id);

    UPDATE PARAMETER
    SET name  = p_name,
        value = p_value
    WHERE id = p_id;
END $$

-- 1.3 Eliminar parámetro
CREATE PROCEDURE delete_parameter (
    IN p_id BIGINT
)
BEGIN
    CALL validate_parameter_exists(p_id);
    DELETE FROM PARAMETER WHERE id = p_id;
END $$

-- 1.4 Obtener parámetro por ID
CREATE PROCEDURE get_parameter (
    IN p_id BIGINT
)
BEGIN
    CALL validate_parameter_exists(p_id);
    SELECT id, name, value FROM PARAMETER WHERE id = p_id;
END $$

-- 1.5 Listar parámetros
CREATE PROCEDURE get_all_parameters ()
BEGIN
    SELECT id, name, value FROM PARAMETER ORDER BY name;
END $$

-- 1.6 Obtener parámetro por nombre
CREATE PROCEDURE get_parameter_by_name (
    IN p_name VARCHAR(100)
)
BEGIN
    SELECT id, name, value FROM PARAMETER WHERE name = p_name;
END $$

DELIMITER ; 