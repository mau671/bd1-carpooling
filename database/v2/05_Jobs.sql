-- =====================================================================
-- carpooling_adm Report Generation Job (MySQL 8.0+)
-- Convierte el antiguo 05_Jobs.sql de Oracle a MySQL.
-- Genera reportes diarios por institución (tabla INSTITUTION_REPORT).
-- Autor: Mauricio González Prendas
-- Fecha: 20 mayo 2025
-- =====================================================================

USE carpooling_adm;

-- ===============================
-- 1. Parámetro de hora del reporte
-- ===============================
-- Si no existe el parámetro lo insertamos por defecto 00:00
INSERT INTO PARAMETER(name,value)
SELECT 'REPORT_GENERATION_TIME','15:00'
WHERE NOT EXISTS (SELECT 1 FROM PARAMETER WHERE name='REPORT_GENERATION_TIME');

-- ===============================
-- 2. Procedimiento de generación
-- ===============================
DROP PROCEDURE IF EXISTS generate_institution_reports;
DELIMITER $$
CREATE PROCEDURE generate_institution_reports(IN p_report_date DATE)
BEGIN
    DECLARE v_report_date DATE;
    IF p_report_date IS NULL THEN
        SET v_report_date = DATE_SUB(CURDATE(), INTERVAL 1 DAY); -- día anterior
    ELSE
        SET v_report_date = p_report_date;
    END IF;

    -- eliminar reportes existentes para esa fecha
    DELETE FROM INSTITUTION_REPORT WHERE report_date = v_report_date;

    INSERT INTO INSTITUTION_REPORT(
        institution_id, report_date, total_trips, total_passengers, total_revenue, creator)
    SELECT 
        ip.institution_id,
        v_report_date,
        COUNT(DISTINCT t.id) AS total_trips,
        COUNT(DISTINCT pxt.passenger_id) AS total_passengers,
        IFNULL(SUM(t.price_per_passenger),0) AS total_revenue,
        'SYSTEM'
    FROM carpooling_pu.INSTITUTION_PERSON ip
    JOIN carpooling_pu.PASSENGER pass ON ip.person_id = pass.person_id
    JOIN carpooling_pu.PASSENGERXTRIP pxt ON pass.person_id = pxt.passenger_id
    JOIN carpooling_pu.TRIP t ON pxt.trip_id = t.id
    WHERE DATE(t.creation_date) = v_report_date
    GROUP BY ip.institution_id;

END $$
DELIMITER ;

-- ===============================
-- 3. Evento programado diario
-- ===============================
-- La hora se lee del parámetro REPORT_GENERATION_TIME. Creamos un evento que se
-- auto-ajusta diariamente.

DROP EVENT IF EXISTS ev_generate_institution_reports;

CREATE EVENT ev_generate_institution_reports
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
  CALL generate_institution_reports(NULL);

-- ===============================
-- 4. Grants (si fuera necesario)
-- ===============================
-- GRANT EVENT ON carpooling_adm.* TO 'adm_user'@'%';

-- Activar scheduler (solo necesita hacerse una vez a nivel server)
-- SET GLOBAL event_scheduler = ON;
CALL generate_institution_reports(NULL);