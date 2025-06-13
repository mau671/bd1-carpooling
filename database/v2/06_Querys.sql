-- =====================================================================
-- carpooling_adm General Query Procedures (MySQL 8.0+)
-- Migración de consultas generales desde Oracle a MySQL
-- Autor: Mauricio González Prendas
-- Fecha: 20 mayo 2025
-- =====================================================================

USE carpooling_adm;

-- Eliminar procedimientos existentes si los hubiera
DROP PROCEDURE IF EXISTS get_top_drivers;
DROP PROCEDURE IF EXISTS get_top_waypoints;
DROP PROCEDURE IF EXISTS get_top_active_users;
DROP PROCEDURE IF EXISTS get_complete_trips;
DROP PROCEDURE IF EXISTS get_average_driver_revenue;
DROP PROCEDURE IF EXISTS get_new_users_last_3_months;

DELIMITER $$
-- ============================================
-- 1. Top Drivers by Service Count
-- ============================================
CREATE PROCEDURE get_top_drivers (IN p_limit INT)
BEGIN
    SELECT 
        CONCAT(per.first_name,' ', per.first_surname)  AS driver_name,
        COUNT(DISTINCT t.id)                          AS service_count
    FROM carpooling_pu.DRIVER d
    JOIN carpooling_adm.PERSON per          ON d.person_id = per.id
    JOIN carpooling_pu.DRIVERXVEHICLE dv    ON d.person_id = dv.driver_id
    JOIN carpooling_pu.VEHICLE v            ON dv.vehicle_id = v.id
    JOIN carpooling_pu.TRIP t               ON v.id = t.vehicle_id
    GROUP BY driver_name
    ORDER BY service_count DESC
    LIMIT p_limit;
END $$

-- ============================================
-- 2. Top Most Concurrent Waypoints (by passenger count) in a date range
-- ============================================
CREATE PROCEDURE get_top_waypoints (
    IN p_start_date DATE,
    IN p_end_date   DATE,
    IN p_limit      INT
)
BEGIN
    SELECT 
        dist.name                                                      AS district_name,
        COUNT(DISTINCT pxt.passenger_id)                               AS passenger_count
    FROM carpooling_pu.WAYPOINT w
    JOIN carpooling_adm.DISTRICT dist          ON w.district_id = dist.id
    JOIN carpooling_pu.PASSENGERXWAYPOINT pwx  ON w.id = pwx.waypoint_id
    JOIN carpooling_pu.PASSENGERXTRIP pxt      ON pwx.passenger_id = pxt.passenger_id
    JOIN carpooling_pu.TRIP t                  ON pxt.trip_id = t.id
    WHERE DATE(t.creation_date) BETWEEN p_start_date AND p_end_date
    GROUP BY district_name
    ORDER BY passenger_count DESC
    LIMIT p_limit;
END $$

-- ============================================
-- 3. Top Most Active Users (passengers) by trip count
-- ============================================
CREATE PROCEDURE get_top_active_users (IN p_limit INT)
BEGIN
    SELECT 
        CONCAT(per.first_name,' ', per.first_surname) AS user_name,
        COUNT(DISTINCT pxt.trip_id)                  AS trip_count
    FROM carpooling_adm.PERSON per
    JOIN carpooling_pu.PASSENGER pass    ON per.id = pass.person_id
    JOIN carpooling_pu.PASSENGERXTRIP pxt ON pass.person_id = pxt.passenger_id
    GROUP BY user_name
    ORDER BY trip_count DESC
    LIMIT p_limit;
END $$

-- ============================================
-- 4. Complete Trip Information (driver, passenger, route)
-- ============================================
CREATE PROCEDURE get_complete_trips (IN p_limit INT)
BEGIN
    SELECT 
        t.id                                   AS trip_id,
        CONCAT(dp.first_name,' ',dp.first_surname)  AS driver_name,
        v.plate                                AS vehicle_plate,
        CONCAT(pp.first_name,' ',pp.first_surname)  AS passenger_name,
        r.start_time,
        r.end_time,
        t.price_per_passenger,
        cur.name                               AS currency
    FROM carpooling_pu.TRIP t
    JOIN carpooling_pu.VEHICLE v            ON t.vehicle_id = v.id
    JOIN carpooling_pu.DRIVERXVEHICLE dv    ON v.id = dv.vehicle_id
    JOIN carpooling_adm.PERSON dp           ON dv.driver_id = dp.id
    JOIN carpooling_pu.PASSENGERXTRIP pxt   ON t.id = pxt.trip_id
    JOIN carpooling_pu.PASSENGER pass       ON pxt.passenger_id = pass.person_id
    JOIN carpooling_adm.PERSON pp           ON pass.person_id = pp.id
    JOIN carpooling_pu.ROUTE r              ON t.route_id = r.id
    LEFT JOIN carpooling_adm.CURRENCY cur   ON t.id_currency = cur.id
    ORDER BY t.id DESC
    LIMIT p_limit;
END $$

-- ============================================
-- 5. Average Driver Revenue (price_per_passenger)
-- ============================================
CREATE PROCEDURE get_average_driver_revenue (IN p_limit INT)
BEGIN
    SELECT 
        CONCAT(per.first_name,' ', per.first_surname) AS driver_name,
        ROUND(AVG(t.price_per_passenger),2)          AS avg_revenue,
        cur.name                                     AS currency
    FROM carpooling_pu.DRIVER d
    JOIN carpooling_adm.PERSON per          ON d.person_id = per.id
    JOIN carpooling_pu.DRIVERXVEHICLE dv    ON d.person_id = dv.driver_id
    JOIN carpooling_pu.VEHICLE v            ON dv.vehicle_id = v.id
    JOIN carpooling_pu.TRIP t               ON v.id = t.vehicle_id
    LEFT JOIN carpooling_adm.CURRENCY cur   ON t.id_currency = cur.id
    GROUP BY driver_name, currency
    ORDER BY avg_revenue DESC
    LIMIT p_limit;
END $$

-- ============================================
-- 6. New Users Last 3 Months (count per month)
-- ============================================
CREATE PROCEDURE get_new_users_last_3_months ()
BEGIN
    SELECT DATE_FORMAT(p.creation_date, '%b-%Y') AS month_year,
           COUNT(*)                              AS new_users
    FROM carpooling_adm.PERSON p
    WHERE p.creation_date >= DATE_SUB(DATE_FORMAT(CURRENT_DATE, '%Y-%m-01'), INTERVAL 2 MONTH)
      AND p.creation_date <  DATE_ADD(DATE_FORMAT(CURRENT_DATE, '%Y-%m-01'), INTERVAL 1 MONTH)
    GROUP BY DATE_FORMAT(p.creation_date, '%b-%Y')
    ORDER BY MIN(p.creation_date);
END $$

DELIMITER ;

-- 1) get_top_drivers
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_top_drivers TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVER         TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVERXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP           TO 'pu_user'@'%';

-- 2) get_top_waypoints
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_top_waypoints TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.WAYPOINT           TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.DISTRICT         TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXWAYPOINT TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXTRIP    TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP              TO 'pu_user'@'%';

-- 3) get_top_active_users
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_top_active_users TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGER      TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXTRIP TO 'pu_user'@'%';

-- 4) get_complete_trips
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_complete_trips TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP           TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVERXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGER      TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE          TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CURRENCY      TO 'pu_user'@'%';

-- 5) get_average_driver_revenue
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_average_driver_revenue TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVER         TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.DRIVERXVEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLE        TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP           TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.CURRENCY      TO 'pu_user'@'%';

-- 6) get_new_users_last_3_months
GRANT EXECUTE ON PROCEDURE carpooling_adm.get_new_users_last_3_months TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON        TO 'pu_user'@'%';

FLUSH PRIVILEGES;