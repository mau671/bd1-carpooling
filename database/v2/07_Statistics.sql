-- =====================================================================
-- carpooling_adm Statistics Procedures (MySQL 8.0+)
-- Migración de ADM_STATISTICS_PKG desde Oracle a MySQL
-- Autor: Mauricio González Prendas
-- Fecha: 20 mayo 2025
-- =====================================================================

USE carpooling_adm;

-- Eliminar versiones previas
DROP PROCEDURE IF EXISTS get_drivers_by_gender;
DROP PROCEDURE IF EXISTS get_passengers_by_gender;
DROP PROCEDURE IF EXISTS get_users_by_age_range;
DROP PROCEDURE IF EXISTS get_total_trips_per_month;

DELIMITER $$
-- =========================================
-- 1. Drivers by Gender (for institution & date range)
-- =========================================
CREATE PROCEDURE get_drivers_by_gender (
    IN p_institution_id INT,
    IN p_start_date DATE,
    IN p_end_date   DATE
)
BEGIN
    DECLARE v_start DATE;
    DECLARE v_end   DATE;
    SET v_start = COALESCE(p_start_date, DATE(CONCAT(YEAR(CURRENT_DATE),'-01-01')));
    SET v_end   = COALESCE(p_end_date, CURRENT_DATE);

    SELECT 
        g.name                                   AS gender_name,
        COUNT(DISTINCT d.person_id)              AS total_drivers,
        ROUND(COUNT(DISTINCT d.person_id) * 100 / 
              (SELECT COUNT(DISTINCT d2.person_id)
               FROM carpooling_pu.DRIVER d2
               JOIN carpooling_pu.INSTITUTION_PERSON ip2 ON d2.person_id = ip2.person_id
               WHERE ip2.institution_id = p_institution_id
                 AND d2.creation_date BETWEEN v_start AND v_end), 2) AS percentage
    FROM carpooling_pu.DRIVER d
    JOIN carpooling_adm.PERSON p      ON d.person_id = p.id
    JOIN carpooling_adm.GENDER g      ON p.gender_id = g.id
    JOIN carpooling_pu.INSTITUTION_PERSON ip ON p.id = ip.person_id
    WHERE ip.institution_id = p_institution_id
      AND d.creation_date BETWEEN v_start AND v_end
    GROUP BY g.name, g.id
    ORDER BY g.id;
END $$

-- =========================================
-- 2. Passengers by Gender (for institution & date range)
-- =========================================
CREATE PROCEDURE get_passengers_by_gender (
    IN p_institution_id INT,
    IN p_start_date DATE,
    IN p_end_date   DATE
)
BEGIN
    DECLARE v_start DATE;
    DECLARE v_end   DATE;
    SET v_start = COALESCE(p_start_date, DATE(CONCAT(YEAR(CURRENT_DATE),'-01-01')));
    SET v_end   = COALESCE(p_end_date, CURRENT_DATE);

    SELECT 
        g.name                                        AS gender_name,
        COUNT(DISTINCT pass.person_id)                AS total_passengers,
        ROUND(COUNT(DISTINCT pass.person_id) * 100 / 
              (SELECT COUNT(DISTINCT p2.person_id)
               FROM carpooling_pu.PASSENGER p2
               JOIN carpooling_pu.INSTITUTION_PERSON ip2 ON p2.person_id = ip2.person_id
               WHERE ip2.institution_id = p_institution_id
                 AND p2.creation_date BETWEEN v_start AND v_end), 2) AS percentage
    FROM carpooling_pu.PASSENGER pass
    JOIN carpooling_adm.PERSON pers   ON pass.person_id = pers.id
    JOIN carpooling_adm.GENDER g      ON pers.gender_id = g.id
    JOIN carpooling_pu.INSTITUTION_PERSON ip ON pers.id = ip.person_id
    WHERE ip.institution_id = p_institution_id
      AND pass.creation_date BETWEEN v_start AND v_end
    GROUP BY g.name, g.id
    ORDER BY g.id;
END $$

-- =========================================
-- 3. Users by Age Range (optional gender filter)
-- =========================================
CREATE PROCEDURE get_users_by_age_range (
    IN p_gender_id INT
)
BEGIN
    WITH age_ranges AS (
        SELECT 
            p.id,
            p.gender_id,
            g.name                         AS gender_name,
            CASE 
                WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) <= 18 THEN '0-18'
                WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) <= 30 THEN '19-30'
                WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) <= 45 THEN '31-45'
                WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) <= 60 THEN '46-60'
                WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) <= 75 THEN '61-75'
                ELSE '75+'
            END AS age_range
        FROM carpooling_adm.PERSON p
        JOIN carpooling_adm.GENDER g ON p.gender_id = g.id
        WHERE p_gender_id IS NULL OR p.gender_id = p_gender_id
    )
    SELECT 
        gender_name,
        age_range,
        COUNT(*)                                           AS total_users,
        ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (PARTITION BY gender_name), 2) AS percentage
    FROM age_ranges
    GROUP BY gender_name, age_range
    ORDER BY gender_name,
             FIELD(age_range,'0-18','19-30','31-45','46-60','61-75','75+');
END $$

-- =========================================
-- 4. Total Trips per Month (extra statistic)
-- =========================================
DELIMITER $$
CREATE PROCEDURE get_total_trips_per_month ()
BEGIN
    SELECT DATE_FORMAT(t.creation_date,'%Y-%m') AS month,
           COUNT(*)                             AS total_trips
    FROM carpooling_pu.TRIP t
    GROUP BY month
    ORDER BY month;
END $$
DELIMITER ;

DELIMITER ;

-- =====================================================================
-- 4. EXTRA STATISTIC (Subject to professor approval)
-- =====================================================================
-- Ejemplo de estadística adicional (comentado hasta aprobación):
-- DROP PROCEDURE IF EXISTS get_total_trips_per_month;
-- DELIMITER $$
-- CREATE PROCEDURE get_total_trips_per_month ()
-- BEGIN
--     SELECT DATE_FORMAT(t.creation_date,'%Y-%m') AS month,
--            COUNT(*)                             AS total_trips
--     FROM carpooling_pu.TRIP t
--     GROUP BY month
--     ORDER BY month;
-- END $$
-- DELIMITER ; 