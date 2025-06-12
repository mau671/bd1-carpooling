-- =====================================================================
-- carpooling_adm.LOGS Procedures (MySQL 8.0+)
-- Autor: Mauricio González Prendas
-- Fecha: 20 mayo 2025
-- =====================================================================

USE carpooling_adm;

-- Eliminar procedimiento existente
DROP PROCEDURE IF EXISTS get_all_logs;

DELIMITER $$
-- ========================================
-- PROCEDURE: get_all_logs
-- Purpose : Obtener todos los registros de la tabla LOGS
-- ========================================
CREATE PROCEDURE get_all_logs()
BEGIN
    SELECT 
        id,
        schema_name,
        table_name,
        field_name,
        previous_value,
        current_value,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM LOGS
    ORDER BY creation_date DESC, id DESC;
END $$
DELIMITER ; 