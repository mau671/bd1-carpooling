-- ============================================================================
-- Job on the table STATUS_TRIP
-- Purpose: Updates statuses of trips from scheduled to ongoing to completed
-- ============================================================================
BEGIN
  DBMS_SCHEDULER.create_job (
    job_name        => 'TRIP_STATUS_UPDATE_JOB',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN PU.PU_TRIP_STATUS_PKG.update_all_trip_statuses; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=MINUTELY; INTERVAL=1',
    end_date        => TO_TIMESTAMP('2025-05-21 13:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    enabled         => TRUE,
    comments        => 'Automatically updates trip statuses every minute until May 21st'
  );
END;
/