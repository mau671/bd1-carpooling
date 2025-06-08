USE carpooling_adm;

DROP PROCEDURE IF EXISTS get_all_status;

DELIMITER $$

CREATE PROCEDURE get_all_status()
BEGIN
    SELECT 
        id, 
        name,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM STATUS
    ORDER BY name;
END $$

DELIMITER ;