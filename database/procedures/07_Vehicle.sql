-- =====================================================================
-- Package: PU_VEHICLE_MGMT_PKG
-- Description: Contains procedures to manage the vehicles of the system
-- =====================================================================
CREATE OR REPLACE PACKAGE PU.PU_VEHICLE_MGMT_PKG AS

    -- Create a vehicle
    PROCEDURE create_vehicle (p_plate       IN PU.VEHICLE.plate%TYPE,
                              o_vehicle_id  OUT PU.VEHICLE.id%TYPE);
   
    -- Obtain the information of a vehicle
    FUNCTION get_vehicle_info (p_vehicle_id IN PU.VEHICLE.id%TYPE) RETURN SYS_REFCURSOR;
    
    -- Update a vehicle
    PROCEDURE update_vehicle (p_vehicle_id  IN PU.VEHICLE.id%TYPE,
                             p_new_plate    IN PU.VEHICLE.plate%TYPE);
    
    -- Eliminate a vehicle
    PROCEDURE delete_vehicle(p_vehicle_id  IN PU.VEHICLE.id%TYPE);

END PU_VEHICLE_MGMT_PKG;
/

-- =====================================================================
-- Package Body: PU_VEHICLE_MGMT_PKG
-- =====================================================================
CREATE OR REPLACE PACKAGE BODY PU.PU_VEHICLE_MGMT_PKG AS

    -- Procedure to add a vehicle
    PROCEDURE create_vehicle (p_plate IN PU.VEHICLE.plate%TYPE) AS
    BEGIN
        -- Insert into VEHICLE table
        -- Assuming sequence/trigger for ID and auditing
        INSERT INTO PU.VEHICLE (plate) VALUES (p_plate) RETURNING id INTO o_vehicle_id;

        -- Confirm
        COMMIT;

    END create_vehicle;
    
    -- Get vehicle info
    FUNCTION get_vehicle_info (p_vehicle_id IN PU.VEHICLE.id%TYPE)
                               RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, plate
            FROM PU.VEHICLE
            WHERE id = p_vehicle_id;
    
        RETURN v_cursor;
    END get_vehicle_info;
    
    -- Procedure to update a vehicle
    PROCEDURE update_vehicle (p_vehicle_id IN PU.VEHICLE.id%TYPE,
                              p_new_plate  IN PU.VEHICLE.plate%TYPE) AS
    BEGIN
        UPDATE PU.VEHICLE
        SET plate = p_new_plate
        WHERE id = p_vehicle_id;
    
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20401, 'Vehicle not found.');
        END IF;
    
        COMMIT;
    END update_vehicle;
    
    -- Procedure to eliminate a vehicle
    PROCEDURE delete_vehicle(p_vehicle_id IN PU.VEHICLE.id%TYPE) AS
        BEGIN
            DELETE FROM PU.VEHICLE WHERE id = p_vehicle_id;
        
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20403, 'Vehicle with ID ' || p_vehicle_id || ' not found.');
            END IF;
        
            COMMIT;
        END delete_vehicle;

END PU_VEHICLE_MGMT_PKG;
/