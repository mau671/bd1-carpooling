-- ============================================================================
-- PACKAGE: ADM_CHOSENCAPACITY_PKG
-- Description: Manages operations related to chosen capacities per vehicle-route
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_CHOSENCAPACITY_PKG AS

    -- Insert a new chosen capacity record for a vehicle-route
    PROCEDURE create_chosen_capacity(
        p_vehicle_route_id IN CHOSENCAPACITY.vehicle_x_route_id%TYPE,
        p_chosen_number    IN CHOSENCAPACITY.chosen_number%TYPE
    );

END ADM_CHOSENCAPACITY_PKG;
/

-- ============================================================================
-- PACKAGE BODY: ADM_CHOSENCAPACITY_PKG
-- ============================================================================
CREATE OR REPLACE PACKAGE BODY ADM.ADM_CHOSENCAPACITY_PKG AS

    -- Insert a new chosen capacity record for a vehicle-route
    PROCEDURE create_chosen_capacity(
        p_vehicle_route_id IN CHOSENCAPACITY.vehicle_x_route_id%TYPE,
        p_chosen_number    IN CHOSENCAPACITY.chosen_number%TYPE
    ) IS
    BEGIN
        INSERT INTO ADM.CHOSENCAPACITY (
            id,
            vehicle_x_route_id,
            chosen_number
        ) VALUES (
            ADM.CHOSENCAPACITY_SEQ.NEXTVAL,
            p_vehicle_route_id,
            p_chosen_number
        );
    END create_chosen_capacity;

END ADM_CHOSENCAPACITY_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.CHOSENCAPACITY TO PU;
GRANT SELECT ON ADM.CHOSENCAPACITY_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_CHOSENCAPACITY_PKG TO PU;