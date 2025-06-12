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

-- Grant Privileges

GRANT EXECUTE ON PROCEDURE carpooling_adm.get_all_status TO 'adm_user'@'%';
GRANT SELECT ON carpooling_adm.STATUS TO 'adm_user'@'%';


GRANT SELECT ON carpooling_adm.STATUS TO 'pu_user'@'%';


GRANT INSERT, UPDATE ON carpooling_adm.STATUS TO 'adm_user'@'%'; 
GRANT DELETE ON carpooling_adm.STATUS TO 'adm_user'@'%' WITH GRANT OPTION; 

FLUSH PRIVILEGES;