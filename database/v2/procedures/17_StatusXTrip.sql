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
    DECLARE v_in_progress_id INT;
    DECLARE v_completed_id INT;
    DECLARE v_pending_id INT;
    DECLARE v_trip_start TIMESTAMP;
    DECLARE v_trip_end TIMESTAMP;
    DECLARE v_programming_date DATE;
    DECLARE v_current_status INT;
    DECLARE v_current_date DATE;
    DECLARE v_current_datetime DATETIME;
    

    SELECT id INTO v_pending_id FROM carpooling_adm.STATUS WHERE UPPER(name) = 'PENDING';
    SELECT id INTO v_in_progress_id FROM carpooling_adm.STATUS WHERE UPPER(name) = 'IN PROGRESS';
    SELECT id INTO v_completed_id FROM carpooling_adm.STATUS WHERE UPPER(name) = 'COMPLETED';
    

    SET v_current_date = CURDATE();
    SET v_current_datetime = NOW();
    

    SELECT R.start_time, R.end_time, R.programming_date
    INTO v_trip_start, v_trip_end, v_programming_date
    FROM TRIP T
    JOIN ROUTE R ON T.route_id = R.id
    WHERE T.id = p_trip_id;


    SELECT status_id INTO v_current_status
    FROM STATUSXTRIP
    WHERE trip_id = p_trip_id;
    

    IF v_current_status = v_pending_id
       AND v_current_date = v_programming_date
       AND v_current_datetime >= v_trip_start 
       AND v_current_datetime < v_trip_end THEN
        
        UPDATE STATUSXTRIP
        SET status_id = v_in_progress_id
        WHERE trip_id = p_trip_id;
        
    ELSEIF v_current_status = v_in_progress_id
       AND v_current_date = v_programming_date
       AND v_current_datetime >= v_trip_end THEN
        
        UPDATE STATUSXTRIP
        SET status_id = v_completed_id
        WHERE trip_id = p_trip_id;
        
    ELSEIF v_current_status = v_in_progress_id
       AND v_current_date > v_programming_date THEN
        
        UPDATE STATUSXTRIP
        SET status_id = v_completed_id
        WHERE trip_id = p_trip_id;
        
    ELSEIF v_current_status = v_pending_id
       AND v_current_date > v_programming_date THEN
        
        UPDATE STATUSXTRIP
        SET status_id = v_completed_id
        WHERE trip_id = p_trip_id;
    END IF;
END $$


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