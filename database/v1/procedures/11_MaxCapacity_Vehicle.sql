-- ============================================================================
-- PACKAGE: ADM_VEHICLECAPACITY_PKG
-- Description: Manages operations related to the capacity of a vehicle in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_VEHICLECAPACITY_PKG AS

    -- Procedure to link a vehicle with a capacity
    PROCEDURE assign_capacity_to_vehicle (p_vehicle_id         IN PU.VEHICLE.id%TYPE,
                                          p_max_capacity_id    IN ADM.MAXCAPACITY.id%TYPE);

    -- Get capacity assigned to a vehicle
    FUNCTION get_capacity_by_vehicle (p_vehicle_id IN PU.VEHICLE.id%TYPE)RETURN SYS_REFCURSOR;

    -- Update capacity for a vehicle
    PROCEDURE update_vehicle_capacity (p_vehicle_id     IN PU.VEHICLE.id%TYPE,
                                       p_new_capacity_id IN ADM.MAXCAPACITY.id%TYPE);

    -- Remove capacity association
    PROCEDURE remove_vehicle_capacity (p_vehicle_id IN PU.VEHICLE.id%TYPE);

END PU_VEHICLECAPACITY_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_VEHICLECAPACITY_PKG AS
    
    -- Procedure to link a vehicle with a capacity
    PROCEDURE assign_capacity_to_vehicle (p_vehicle_id      IN PU.VEHICLE.id%TYPE,
                                          p_max_capacity_id IN ADM.MAXCAPACITY.id%TYPE) IS
    BEGIN
        INSERT INTO PU.MAXCAPACITYXVEHICLE (vehicle_id, max_capacity_id)
        VALUES (p_vehicle_id, p_max_capacity_id);
        COMMIT;
    END;
    
    -- Get capacity assigned to a vehicle
    FUNCTION get_capacity_by_vehicle (p_vehicle_id IN PU.VEHICLE.id%TYPE)
                                      RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT mcv.id, mc.capacity_number
            FROM PU.MAXCAPACITYXVEHICLE mcv
            JOIN ADM.MAXCAPACITY mc ON mc.id = mcv.max_capacity_id
            WHERE mcv.vehicle_id = p_vehicle_id;
        RETURN v_cursor;
    END;
    
    -- Update capacity for a vehicle
    PROCEDURE update_vehicle_capacity (p_vehicle_id      IN PU.VEHICLE.id%TYPE,
                                       p_new_capacity_id IN ADM.MAXCAPACITY.id%TYPE) IS
    BEGIN
        UPDATE PU.MAXCAPACITYXVEHICLE
        SET max_capacity_id = p_new_capacity_id
        WHERE vehicle_id = p_vehicle_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20410, 'No capacity assigned to this vehicle.');
        END IF;

        COMMIT;
    END;
    
    -- Remove capacity association
    PROCEDURE remove_vehicle_capacity (p_vehicle_id IN PU.VEHICLE.id%TYPE) IS
    BEGIN
        DELETE FROM PU.MAXCAPACITYXVEHICLE
        WHERE vehicle_id = p_vehicle_id;
        COMMIT;
    END;

END PU_VEHICLECAPACITY_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON PU.MAXCAPACITYXVEHICLE TO ADM;
GRANT EXECUTE ON PU.PU_VEHICLECAPACITY_PKG TO ADM;