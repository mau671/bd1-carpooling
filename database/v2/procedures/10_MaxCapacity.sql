
USE carpooling_adm;


DROP PROCEDURE IF EXISTS get_all_max_capacity;


DELIMITER $$

CREATE PROCEDURE get_all_max_capacity()
BEGIN
    SELECT 
        id, 
        capacity_number,
        creator,
        creation_date,
        modifier,
        modification_date
    FROM MAXCAPACITY
    ORDER BY capacity_number;
END $$

DELIMITER ;

-- Privileges

GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_max_capacity TO 'pu_user'@'%';

GRANT SELECT ON carpooling_adm.MAXCAPACITY TO 'pu_user'@'%';
GRANT INSERT, UPDATE, DELETE ON carpooling_adm.MAXCAPACITY TO 'adm_user'@'%';

GRANT SELECT ON carpooling_adm.MAXCAPAC