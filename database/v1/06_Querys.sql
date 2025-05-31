-- Grants para las tablas de ADM que necesita PU
GRANT SELECT ON ADM.PERSON TO PU;
GRANT SELECT ON ADM.DISTRICT TO PU;
GRANT SELECT ON ADM.CURRENCY TO PU;
GRANT SELECT ON ADM.LOGS TO PU;
GRANT SELECT ON ADM.STATUS TO PU;

-- Grants para las tablas de PU que necesita PU
GRANT SELECT ON PU.DRIVER TO PU;
GRANT SELECT ON PU.DRIVERXVEHICLE TO PU;
GRANT SELECT ON PU.VEHICLE TO PU;
GRANT SELECT ON PU.TRIP TO PU;
GRANT SELECT ON PU.WAYPOINT TO PU;
GRANT SELECT ON PU.PASSENGERXWAYPOINT TO PU;
GRANT SELECT ON PU.PASSENGERXTRIP TO PU;
GRANT SELECT ON PU.PASSENGER TO PU;
GRANT SELECT ON PU.ROUTE TO PU;

-- Grants para las tablas de PU que necesita ADM
GRANT SELECT ON PU.DRIVER TO ADM;
GRANT SELECT ON PU.DRIVERXVEHICLE TO ADM;
GRANT SELECT ON PU.VEHICLE TO ADM;
GRANT SELECT ON PU.TRIP TO ADM;
GRANT SELECT ON PU.WAYPOINT TO ADM;
GRANT SELECT ON PU.PASSENGERXWAYPOINT TO ADM;
GRANT SELECT ON PU.PASSENGERXTRIP TO ADM;
GRANT SELECT ON PU.PASSENGER TO ADM;
GRANT SELECT ON PU.ROUTE TO ADM;

-- Grant para la secuencia de logs
GRANT SELECT ON ADM.LOGS_SEQ TO PU;

-- =====================================================================
-- General Queries Procedures
-- =====================================================================
/*
 * This script contains stored procedures for general system queries.
 * Each procedure includes error handling and logging.
 *
 * Author: Mauricio González Prendas
 * Version: 1.0
 */

-- ============================================
-- 1. Top Drivers by Service Count
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_TOP_DRIVERS (
    p_limit IN NUMBER DEFAULT 5,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
        SELECT driver_name, service_count
        FROM (
            SELECT driver_name, service_count, rnk
            FROM (
                SELECT 
                    p.first_name || ' ' || p.first_surname as driver_name,
                    COUNT(DISTINCT t.id) as service_count,
                    RANK() OVER (ORDER BY COUNT(DISTINCT t.id) DESC) as rnk
                FROM 
                    ADM.PERSON p
                    JOIN PU.DRIVER d ON p.id = d.person_id
                    JOIN PU.DRIVERXVEHICLE dv ON d.person_id = dv.driver_id
                    JOIN PU.VEHICLE v ON dv.vehicle_id = v.id
                    JOIN PU.TRIP t ON v.id = t.vehicle_id
                GROUP BY 
                    p.first_name, p.first_surname
            )
            WHERE rnk <= p_limit
        );
END GET_TOP_DRIVERS;
/

-- ============================================
-- 2. Top Most Concurrent Waypoints
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_TOP_WAYPOINTS (
    p_start_date IN DATE,
    p_end_date IN DATE,
    p_limit IN NUMBER DEFAULT 5,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
        SELECT district_name, passenger_count
        FROM (
            SELECT district_name, passenger_count, rnk
            FROM (
                SELECT 
                    d.name as district_name,
                    COUNT(DISTINCT pxt.passenger_id) as passenger_count,
                    RANK() OVER (ORDER BY COUNT(DISTINCT pxt.passenger_id) DESC) as rnk
                FROM 
                    PU.WAYPOINT w
                    JOIN ADM.DISTRICT d ON w.district_id = d.id
                    JOIN PU.PASSENGERXWAYPOINT pwx ON w.id = pwx.waypoint_id
                    JOIN PU.PASSENGERXTRIP pxt ON pwx.passenger_id = pxt.passenger_id
                    JOIN PU.TRIP t ON pxt.trip_id = t.id
                WHERE 
                    TRUNC(t.creation_date) BETWEEN p_start_date AND p_end_date
                GROUP BY 
                    d.name
            )
            WHERE rnk <= p_limit
        );
END GET_TOP_WAYPOINTS;
/

-- ============================================
-- 3. Top Most Active Users
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_TOP_ACTIVE_USERS (
    p_limit IN NUMBER DEFAULT 5,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
        SELECT user_name, trip_count
        FROM (
            SELECT user_name, trip_count, rnk
            FROM (
                SELECT 
                    p.first_name || ' ' || p.first_surname as user_name,
                    COUNT(DISTINCT pxt.trip_id) as trip_count,
                    RANK() OVER (ORDER BY COUNT(DISTINCT pxt.trip_id) DESC) as rnk
                FROM 
                    ADM.PERSON p
                    JOIN PU.PASSENGER pass ON p.id = pass.person_id
                    JOIN PU.PASSENGERXTRIP pxt ON pass.person_id = pxt.passenger_id
                GROUP BY 
                    p.first_name, p.first_surname
            )
            WHERE rnk <= p_limit
        );
END GET_TOP_ACTIVE_USERS;
/

-- ============================================
-- 4. Complete Trip Information
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_COMPLETE_TRIPS (
    p_limit IN NUMBER DEFAULT 5,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
        SELECT trip_id, driver_name, vehicle_plate, passenger_name, start_time, end_time, price_per_passenger, currency
        FROM (
            SELECT trip_id, driver_name, vehicle_plate, passenger_name, start_time, end_time, price_per_passenger, currency, rn
            FROM (
                SELECT 
                    t.id as trip_id,
                    dp.first_name || ' ' || dp.first_surname as driver_name,
                    v.plate as vehicle_plate,
                    pp.first_name || ' ' || pp.first_surname as passenger_name,
                    r.start_time,
                    r.end_time,
                    t.price_per_passenger,
                    cur.name as currency,
                    ROW_NUMBER() OVER (ORDER BY t.id ASC) as rn
                FROM 
                    PU.TRIP t
                    JOIN PU.VEHICLE v ON t.vehicle_id = v.id
                    JOIN PU.DRIVERXVEHICLE dv ON v.id = dv.vehicle_id
                    JOIN ADM.PERSON dp ON dv.driver_id = dp.id
                    JOIN PU.PASSENGERXTRIP pxt ON t.id = pxt.trip_id
                    JOIN PU.PASSENGER pass ON pxt.passenger_id = pass.person_id
                    JOIN ADM.PERSON pp ON pass.person_id = pp.id
                    JOIN PU.ROUTE r ON t.route_id = r.id
                    LEFT JOIN ADM.CURRENCY cur ON t.ID_CURRENCY = cur.id
            )
            WHERE rn <= p_limit
        );
END GET_COMPLETE_TRIPS;
/

-- ============================================
-- 5. Average Driver Revenue
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_AVERAGE_DRIVER_REVENUE (
    p_limit IN NUMBER DEFAULT 5,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
        SELECT driver_name, avg_revenue, currency
        FROM (
            SELECT driver_name, avg_revenue, currency, rnk
            FROM (
                SELECT 
                    p.first_name || ' ' || p.first_surname as driver_name,
                    ROUND(AVG(t.price_per_passenger), 2) as avg_revenue,
                    cur.name as currency,
                    RANK() OVER (ORDER BY ROUND(AVG(t.price_per_passenger), 2) DESC NULLS LAST, p.first_name ASC, p.first_surname ASC) as rnk
                FROM 
                    ADM.PERSON p
                    JOIN PU.DRIVER d ON p.id = d.person_id
                    JOIN PU.DRIVERXVEHICLE dv ON d.person_id = dv.driver_id
                    JOIN PU.VEHICLE v ON dv.vehicle_id = v.id
                    JOIN PU.TRIP t ON v.id = t.vehicle_id
                    LEFT JOIN ADM.CURRENCY cur ON t.ID_CURRENCY = cur.id
                GROUP BY 
                    p.first_name, p.first_surname, cur.name
            )
            WHERE rnk <= p_limit
        );
END GET_AVERAGE_DRIVER_REVENUE;
/

-- ============================================
-- 6. New Users Last 3 Months
-- ============================================
CREATE OR REPLACE PROCEDURE ADM.GET_NEW_USERS_LAST_3_MONTHS (
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
        SELECT month_year, new_users
        FROM (
            SELECT month_year, new_users, rn
            FROM (
                SELECT 
                    TO_CHAR(TRUNC(p.creation_date, 'MM'), 'MON-YYYY') as month_year,
                    COUNT(*) as new_users,
                    ROW_NUMBER() OVER (ORDER BY TRUNC(p.creation_date, 'MM') ASC) as rn
                FROM 
                    ADM.PERSON p
                WHERE 
                    p.creation_date >= ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -2) 
                    AND p.creation_date < TRUNC(SYSDATE, 'MM') + INTERVAL '1' MONTH
                GROUP BY 
                    TRUNC(p.creation_date, 'MM')
            )
        );
END GET_NEW_USERS_LAST_3_MONTHS;
/

-- Grants para ejecutar los procedimientos almacenados
GRANT EXECUTE ON ADM.GET_TOP_DRIVERS TO PU;
GRANT EXECUTE ON ADM.GET_TOP_WAYPOINTS TO PU;
GRANT EXECUTE ON ADM.GET_TOP_ACTIVE_USERS TO PU;
GRANT EXECUTE ON ADM.GET_COMPLETE_TRIPS TO PU;
GRANT EXECUTE ON ADM.GET_AVERAGE_DRIVER_REVENUE TO PU;
GRANT EXECUTE ON ADM.GET_NEW_USERS_LAST_3_MONTHS TO PU;

