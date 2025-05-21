-- ============================================================================
-- PACKAGE: ADM_STATISTICS_PKG
-- Purpose: Gestiona las estadísticas del sistema para administradores
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_STATISTICS_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    /**
     * Obtiene la cantidad total de conductores por género para una institución
     * en un rango de fechas específico
     * 
     * @param p_institution_id ID de la institución
     * @param p_start_date Fecha inicial del rango
     * @param p_end_date Fecha final del rango
     * @return Cursor con la cantidad de conductores por género
     */
    FUNCTION get_drivers_by_gender(
        p_institution_id IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN ref_cursor_type;
    
    /**
     * Obtiene la cantidad total de pasajeros por género para una institución
     * en un rango de fechas específico
     * 
     * @param p_institution_id ID de la institución
     * @param p_start_date Fecha inicial del rango
     * @param p_end_date Fecha final del rango
     * @return Cursor con la cantidad de pasajeros por género
     */
    FUNCTION get_passengers_by_gender(
        p_institution_id IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN ref_cursor_type;
    
    /**
     * Obtiene el total de usuarios por rango de edad y género
     * 
     * @param p_gender_id ID del género (opcional, NULL para todos)
     * @return Cursor con la cantidad de usuarios por rango de edad
     */
    FUNCTION get_users_by_age_range(
        p_gender_id IN NUMBER DEFAULT NULL
    ) RETURN ref_cursor_type;
END ADM_STATISTICS_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_STATISTICS_PKG AS
    FUNCTION get_drivers_by_gender(
        p_institution_id IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN ref_cursor_type
    IS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT 
                g.name as gender_name,
                COUNT(DISTINCT d.person_id) as total_drivers,
                ROUND(COUNT(DISTINCT d.person_id) * 100.0 / 
                    SUM(COUNT(DISTINCT d.person_id)) OVER (), 2) as percentage
            FROM PU.DRIVER d
            JOIN ADM.PERSON p ON d.person_id = p.id
            JOIN ADM.GENDER g ON p.gender_id = g.id
            JOIN PU.INSTITUTION_PERSON ip ON p.id = ip.person_id
            WHERE ip.institution_id = p_institution_id
            AND d.creation_date BETWEEN p_start_date AND p_end_date
            GROUP BY g.name, g.id
            ORDER BY g.id;
            
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_drivers_by_gender;
    
    FUNCTION get_passengers_by_gender(
        p_institution_id IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN ref_cursor_type
    IS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT 
                g.name as gender_name,
                COUNT(DISTINCT p.person_id) as total_passengers,
                ROUND(COUNT(DISTINCT p.person_id) * 100.0 / 
                    SUM(COUNT(DISTINCT p.person_id)) OVER (), 2) as percentage
            FROM PU.PASSENGER p
            JOIN ADM.PERSON per ON p.person_id = per.id
            JOIN ADM.GENDER g ON per.gender_id = g.id
            JOIN PU.INSTITUTION_PERSON ip ON per.id = ip.person_id
            WHERE ip.institution_id = p_institution_id
            AND p.creation_date BETWEEN p_start_date AND p_end_date
            GROUP BY g.name, g.id
            ORDER BY g.id;
            
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_passengers_by_gender;
    
    FUNCTION get_users_by_age_range(
        p_gender_id IN NUMBER DEFAULT NULL
    ) RETURN ref_cursor_type
    IS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            WITH age_ranges AS (
                SELECT 
                    p.id,
                    p.gender_id,
                    g.name as gender_name,
                    CASE 
                        WHEN MONTHS_BETWEEN(SYSDATE, p.date_of_birth)/12 <= 18 THEN '0-18'
                        WHEN MONTHS_BETWEEN(SYSDATE, p.date_of_birth)/12 <= 30 THEN '19-30'
                        WHEN MONTHS_BETWEEN(SYSDATE, p.date_of_birth)/12 <= 45 THEN '31-45'
                        WHEN MONTHS_BETWEEN(SYSDATE, p.date_of_birth)/12 <= 60 THEN '46-60'
                        WHEN MONTHS_BETWEEN(SYSDATE, p.date_of_birth)/12 <= 75 THEN '61-75'
                        ELSE '75+'
                    END as age_range
                FROM ADM.PERSON p
                JOIN ADM.GENDER g ON p.gender_id = g.id
                WHERE p_gender_id IS NULL OR p.gender_id = p_gender_id
            )
            SELECT 
                gender_name,
                age_range,
                COUNT(*) as total_users,
                ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY gender_name), 2) as percentage
            FROM age_ranges
            GROUP BY gender_name, age_range
            ORDER BY gender_name, 
                CASE age_range
                    WHEN '0-18' THEN 1
                    WHEN '19-30' THEN 2
                    WHEN '31-45' THEN 3
                    WHEN '46-60' THEN 4
                    WHEN '61-75' THEN 5
                    ELSE 6
                END;
                
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_users_by_age_range;
END ADM_STATISTICS_PKG;
/

-- Grants necesarios
GRANT EXECUTE ON ADM.ADM_STATISTICS_PKG TO PU;
