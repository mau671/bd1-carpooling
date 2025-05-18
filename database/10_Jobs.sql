-- ============================================================================
-- Job on the table STATUS_TRIP
-- Purpose: Updates statuses of trips from scheduled to ongoing to completed
-- ============================================================================
BEGIN
  DBMS_SCHEDULER.create_job (
    job_name        => 'TRIP_STATUS_UPDATE_JOB',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN PU.STATUSXTRIP_MGMT_PKG.update_all_trip_statuses; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=MINUTELY; INTERVAL=30',
    end_date        => TO_TIMESTAMP('2025-05-21 13:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    enabled         => TRUE,
    comments        => 'Automatically updates trip statuses until May 21st, 2025 at 1:30 PM'
  );
END;
/