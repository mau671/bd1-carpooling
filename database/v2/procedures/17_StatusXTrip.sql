USE carpooling_pu;


DROP PROCEDURE IF EXISTS assign_initial_status;
DROP PROCEDURE IF EXISTS cancel_trip;
DROP PROCEDURE IF EXISTS auto_update_status;
DROP PROCEDURE IF EXISTS update_all_trip_statuses;
DROP PROCEDURE IF EXISTS get_trip_status;

DELIMITER $$


CREATE PROCEDURE assign_initial_status(IN p_trip_id INT)
BEGIN
    DECLARE v_status_id INT;
    

    SELECT id INTO v_status_id FROM carpooling_adm.STATUS WHERE UPPER(name) = 'PENDING';
    

    INSERT INTO STATUSXTRIP (trip_id, status_id)
    VALUES (p_trip_id, v_status_id);
END $$


CREATE PROCEDURE cancel_trip(IN p_trip_id INT)
BEGIN
    DECLARE v_pending_id INT;
    DECLARE v_cancelled_id INT;
    DECLARE v_current_id INT;
    DECLARE rows_affected INT;
    

    SELECT id INTO v_pending_id FROM carpooling_adm.STATUS WHERE UPPER(name) = 'PENDING';
    SELECT id INTO v_cancelled_id FROM carpooling_adm.STATUS WHERE UPPER(name) = 'CANCELLED';
    

    SELECT status_id INTO v_current_id
    FROM STATUSXTRIP
    WHERE trip_id = p_trip_id;
    

    IF v_current_id = v_pending_id THEN
        UPDATE STATUSXTRIP
        SET status_id = v_cancelled_id
        WHERE trip_id = p_trip_id;
        
        SET rows_affected = ROW_COUNT();
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Trip cannot be cancelled. Not in PENDING state.';
    END IF;
END $$


CREATE PROCEDURE auto_update_status(IN p_trip_id INT)
BEGIN
  DECLARE v_pending    INT;
  DECLARE v_in_prog    INT;
  DECLARE v_completed  INT;
  DECLARE v_now        DATETIME;
  DECLARE v_start      DATETIME;
  DECLARE v_end        DATETIME;
  DECLARE v_curr_status INT;

  -- 1) Load the three status IDs once
  SELECT id INTO v_pending
    FROM carpooling_adm.STATUS
   WHERE UPPER(name) = 'PENDING'
   LIMIT 1;
  
  SELECT id INTO v_in_prog
    FROM carpooling_adm.STATUS
   WHERE UPPER(name) = 'IN PROGRESS'
   LIMIT 1;
  
  SELECT id INTO v_completed
    FROM carpooling_adm.STATUS
   WHERE UPPER(name) = 'COMPLETED'
   LIMIT 1;

  -- 2) Grab the current timestamp
  SET v_now = NOW();

  -- 3) Pull in the trip's exact start/end DATETIMEs
  SELECT R.start_time, R.end_time
    INTO v_start, v_end
    FROM carpooling_pu.TRIP T
    JOIN carpooling_pu.ROUTE R ON T.route_id = R.id
   WHERE T.id = p_trip_id;

  -- 4) What status is it *right now*?
  SELECT status_id INTO v_curr_status
    FROM carpooling_pu.STATUSXTRIP
   WHERE trip_id = p_trip_id;

  -- 5) Only two cases to move forward:
  IF v_curr_status = v_pending
     AND v_now BETWEEN v_start AND v_end
  THEN
    UPDATE carpooling_pu.STATUSXTRIP
       SET status_id = v_in_prog
     WHERE trip_id = p_trip_id;

  ELSEIF v_curr_status IN (v_pending, v_in_prog)
     AND v_now >= v_end
  THEN
    UPDATE carpooling_pu.STATUSXTRIP
       SET status_id = v_completed
     WHERE trip_id = p_trip_id;
  END IF;
END$$


CREATE PROCEDURE update_all_trip_statuses()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_trip_id INT;
    DECLARE cur CURSOR FOR
        SELECT trip_id
        FROM STATUSXTRIP SX
        WHERE SX.status_id IN (
            SELECT id FROM carpooling_adm.STATUS WHERE UPPER(name) IN ('PENDING', 'IN PROGRESS')
        );
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_trip_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        CALL auto_update_status(v_trip_id);
    END LOOP;
    
    CLOSE cur;
END $$


CREATE PROCEDURE get_trip_status(IN p_trip_id INT)
BEGIN
    SELECT S.id, S.name
    FROM STATUSXTRIP SX
    JOIN carpooling_adm.STATUS S ON S.id = SX.status_id
    WHERE SX.trip_id = p_trip_id;
END $$

DELIMITER ; 

-- Privileges

GRANT EXECUTE ON PROCEDURE carpooling_pu.assign_initial_status TO 'pu_user'@'%';
GRANT INSERT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.cancel_trip TO 'pu_user'@'%';
GRANT UPDATE ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.auto_update_status TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.TRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.ROUTE TO 'pu_user'@'%';
GRANT SELECT, UPDATE ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.update_all_trip_statuses TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';


GRANT EXECUTE ON PROCEDURE carpooling_pu.get_trip_status TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.STATUSXTRIP TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';


GRANT SELECT ON carpooling_pu.VEHICLE TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.VEHICLEXROUTE TO 'pu_user'@'%';

FLUSH PRIVILEGES;