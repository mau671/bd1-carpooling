-- ============================================================================
-- PACKAGE: ADM_VEHICLE_DRIVER_PKG
-- Description: Manages operations related to the vehicles of a driver in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_VEHICLE_DRIVER_PKG AS

    -- Link a vehicle to a driver
    PROCEDURE assign_vehicle_to_driver (p_driver_id   IN PU.DRIVER.person_id%TYPE,
                                        p_vehicle_id  IN PU.VEHICLE.id%TYPE);

    -- Get all vehicle info for one driver
    FUNCTION get_vehicles_by_driver (p_driver_id IN PU.DRIVER.person_id%TYPE)
                                     RETURN SYS_REFCURSOR;

END PU_VEHICLE_DRIVER_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_VEHICLE_DRIVER_PKG AS
    
    -- Link a vehicle to a driver
    PROCEDURE assign_vehicle_to_driver (p_driver_id   IN PU.DRIVER.person_id%TYPE,
                                        p_vehicle_id  IN PU.VEHICLE.id%TYPE) IS
    BEGIN
        INSERT INTO PU.DRIVERXVEHICLE (id, vehicle_id, driver_id) 
        VALUES (PU.DRIVERXVEHICLE_SEQ.NEXTVAL, p_vehicle_id, p_driver_id);
        COMMIT;
    END;
    
    -- Get all vehicle info for one driver
    FUNCTION get_vehicles_by_driver (
        p_driver_id IN PU.DRIVER.person_id%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT
                v.plate AS plate_number,
                mc.capacity_number AS max_capacity,
                0 AS trip_count -- placeholder
            FROM PU.DRIVERXVEHICLE dv
            JOIN PU.VEHICLE v ON v.id = dv.vehicle_id
            LEFT JOIN PU.MAXCAPACITYXVEHICLE mcv ON mcv.vehicle_id = v.id
            LEFT JOIN ADM.MAXCAPACITY mc ON mc.id = mcv.max_capacity_id
            WHERE dv.driver_id = p_driver_id;
        RETURN v_cursor;
    END;

END PU_VEHICLE_DRIVER_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON PU.DRIVERXVEHICLE TO ADM;
GRANT EXECUTE ON PU.PU_VEHICLE_DRIVER_PKG TO ADM;