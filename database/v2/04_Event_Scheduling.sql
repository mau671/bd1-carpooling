USE carpooling_pu;
-- Make sure the event scheduler is enabled
SET GLOBAL event_scheduler = ON;

-- Drop existing event if it exists
DROP EVENT IF EXISTS trip_status_update_event;

-- Create the scheduled event
CREATE EVENT trip_status_update_event
ON SCHEDULE 
    EVERY 1 MINUTE
    STARTS CURRENT_TIMESTAMP
    ENDS TIMESTAMP '2025-06-13 18:00:00'
DO
    CALL update_all_trip_statuses();

SHOW EVENTS FROM carpooling_pu;