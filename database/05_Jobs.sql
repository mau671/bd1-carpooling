-- =====================================================================
-- Procedures and Jobs for Report Generation
-- =====================================================================
/*
 * This script creates the necessary objects for automatic generation
 * of daily institution reports. It includes:
 * - Configuration parameter for generation time
 * - Procedure for report generation
 * - Scheduled job for automatic execution
 * - Necessary grants for PU user
 *
 * Author: Mauricio González Prendas
 * Date: 20 de mayo de 2025
 * Version: 1.0
 */

-- ============================================
-- 1. Grants for necessary objects
-- ============================================
/*
 * These grants allow the PU user to execute the report generation procedure
 * from a Java application and to access all the necessary objects.
 */

-- 1.1 Grant select privileges on tables used in the procedure
GRANT SELECT ON ADM.PARAMETER TO PU;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.INSTITUTION_REPORT TO PU;
GRANT SELECT ON PU.INSTITUTION_PERSON TO ADM;
-- 1.2 Grant privileges on sequences used in the procedure
GRANT SELECT ON ADM.INSTITUTION_REPORT_SEQ TO PU;

-- ============================================
-- 2. Initial Parameters for Report Generation
-- ============================================
/*
 * Inserts the initial parameter to configure the report generation time.
 * Default is set to 00:00 (midnight).
 * This parameter can be modified later as needed.
 */
INSERT INTO ADM.PARAMETER (
    id,
    name,
    value
)
VALUES (
    ADM.PARAMETER_SEQ.NEXTVAL,
    'REPORT_GENERATION_TIME',
    '00:00'
);

COMMIT;

-- ============================================
-- 3. Procedure to Generate Institution Reports
-- ============================================
/*
 * Procedure that generates daily reports per institution.
 * 
 * Functionality:
 * - Gets generation time from parameters
 * - Generates reports for the previous day
 * - Calculates totals for trips, passengers and revenue
 * - Logs the operation
 * 
 * Parameters:
 *   p_report_date: Date for which to generate reports (default: SYSDATE)
 * 
 * Exceptions:
 * - Handles errors and logs them
 * - Performs rollback in case of error
 * 
 * Dependencies:
 * - ADM.PARAMETER: For getting generation time
 * - ADM.INSTITUTION_REPORT: For storing reports
 * - ADM.LOGS: For operation logging
 * - ADM.INSTITUTION_REPORT_SEQ: For ID generation
 */
CREATE OR REPLACE PROCEDURE ADM.GENERATE_INSTITUTION_REPORTS (
    p_report_date IN DATE DEFAULT TRUNC(SYSDATE)
) AS
    v_report_time VARCHAR2(8);    -- Report generation time
    v_job_name VARCHAR2(30);      -- Scheduled job name
    v_report_date DATE;           -- Report date to generate
    
    -- Variables para almacenar datos de cada institución
    v_institution_id NUMBER;
    v_total_trips NUMBER;
    v_total_passengers NUMBER;
    v_total_revenue NUMBER(10,2);
    
    -- Cursor para manejar los reportes por institución (con campos explícitamente nombrados)
    CURSOR c_institution_reports IS
        SELECT 
            i.id,
            COUNT(DISTINCT t.id) trips,
            COUNT(DISTINCT pxt.passenger_id) passengers,
            SUM(t.price_per_passenger) revenue
        FROM 
            ADM.INSTITUTION i,
            PU.INSTITUTION_PERSON ip,
            PU.PASSENGER p,
            PU.PASSENGERXTRIP pxt,
            PU.TRIP t
        WHERE 
            i.id = ip.institution_id AND
            ip.person_id = p.person_id AND
            p.person_id = pxt.passenger_id AND
            pxt.trip_id = t.id AND
            TRUNC(t.creation_date) = v_report_date
        GROUP BY 
            i.id;
BEGIN
    -- Get report generation time from parameters
    SELECT value INTO v_report_time
    FROM ADM.PARAMETER
    WHERE name = 'REPORT_GENERATION_TIME';
    
    -- Set report date to previous day
    v_report_date := p_report_date - 1;
    
    -- Delete any existing reports for the date
    DELETE FROM ADM.INSTITUTION_REPORT
    WHERE report_date = v_report_date;
    
    -- Generate new reports for each institution using a cursor
    OPEN c_institution_reports;
    LOOP
        -- Fetch next record
        FETCH c_institution_reports INTO 
            v_institution_id, 
            v_total_trips, 
            v_total_passengers, 
            v_total_revenue;
            
        -- Exit when no more records
        EXIT WHEN c_institution_reports%NOTFOUND;
        
        -- Insert individual report (sequence and logs handled by trigger)
        INSERT INTO ADM.INSTITUTION_REPORT (
            institution_id,
            report_date,
            total_trips,
            total_passengers,
            total_revenue,
            creator
        ) VALUES (
            v_institution_id,
            v_report_date,
            v_total_trips,
            v_total_passengers,
            v_total_revenue,
            'SYSTEM'
        );
    END LOOP;
    CLOSE c_institution_reports;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        -- Este error será capturado por el trigger trg_gen_reports_error
        RAISE_APPLICATION_ERROR(-20000, 'Error generating institution reports: ' || SQLERRM);
END GENERATE_INSTITUTION_REPORTS;
/

-- ============================================
-- 4. Job to Schedule Report Generation
-- ============================================
/*
 * Creates a scheduled job to execute report generation
 * automatically each day at the time specified in the
 * REPORT_GENERATION_TIME parameter.
 * 
 * Configuration:
 * - Frequency: Daily
 * - Time: Configurable via parameter
 * - Status: Enabled by default
 */
-- Concede permiso de ejecución al usuario PU
GRANT EXECUTE ON ADM.GENERATE_INSTITUTION_REPORTS TO PU;

-- ============================================
-- 4. Job to Schedule Report Generation
-- ============================================
/*
 * Creates a scheduled job to execute report generation
 * automatically each day at the time specified in the
 * REPORT_GENERATION_TIME parameter.
 * 
 * Configuration:
 * - Frequency: Daily
 * - Time: Configurable via parameter
 * - Status: Enabled by default
 */

-- First, grant necessary privileges for job scheduling
GRANT CREATE JOB TO PU;
GRANT MANAGE SCHEDULER TO PU;
GRANT EXECUTE ON SYS.DBMS_SCHEDULER TO PU;

-- Then create the job
BEGIN
    -- Create the scheduled job
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'ADM.GEN_INST_REPORTS_JOB',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'ADM.GENERATE_INSTITUTION_REPORTS',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0',
        enabled         => TRUE,
        comments        => 'Job to generate daily institution reports'
    );
END;
/

COMMIT;