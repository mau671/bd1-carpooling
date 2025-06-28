USE carpooling_pu;

DROP PROCEDURE IF EXISTS get_passenger_info;
DROP PROCEDURE IF EXISTS delete_passenger;

DELIMITER $$


CREATE PROCEDURE get_passenger_info(
    IN p_person_id INT
)
BEGIN
    SELECT 
        p.person_id, 
        per.first_name, 
        per.second_name, 
        per.first_surname,
        per.second_surname, 
        per.identification_number, 
        per.date_of_birth,
        per.creation_date,
        per.creator
    FROM PASSENGER p
    JOIN carpooling_adm.PERSON per ON per.id = p.person_id
    WHERE p.person_id = p_person_id;
END $$


CREATE PROCEDURE delete_passenger(
    IN p_person_id INT
)
BEGIN
    DECLARE trip_count INT;
    DECLARE waypoint_count INT;

    SELECT COUNT(*) INTO trip_count
    FROM PASSENGERXTRIP
    WHERE passenger_id = p_person_id;
    
    SELECT COUNT(*) INTO waypoint_count
    FROM PASSENGERXWAYPOINT
    WHERE passenger_id = p_person_id;
    
    IF trip_count > 0 OR waypoint_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete passenger: has associated trips or waypoints';
    ELSE
        DELETE FROM PASSENGER 
        WHERE person_id = p_person_id;
        
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Passenger not found';
        END IF;
    END IF;
END $$

DELIMITER ;

-- Permission

GRANT EXECUTE ON PROCEDURE carpooling_pu.get_passenger_info TO 'pu_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGER TO 'pu_user'@'%';
GRANT SELECT ON carpooling_adm.PERSON TO 'pu_user'@'%';

GRANT EXECUTE ON PROCEDURE carpooling_pu.delete_passenger TO 'adm_user'@'%';
GRANT DELETE ON carpooling_pu.PASSENGER TO 'adm_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXTRIP TO 'adm_user'@'%';
GRANT SELECT ON carpooling_pu.PASSENGERXWAYPOINT TO 'adm_user'@'%';

FLUSH PRIVILEGES;