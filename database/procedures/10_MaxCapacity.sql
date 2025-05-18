-- ============================================================================
-- PACKAGE: ADM_MAXCAPACITY_PKG
-- Description: Manages operations related to the capacity of the vehicles in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_MAXCAPACITY_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    -- Get all vehicle capacities info
    FUNCTION get_all_max_capacity
    RETURN ref_cursor_type;

END ADM_MAXCAPACITY_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_MAXCAPACITY_PKG AS
    -- Get all vehicle capacities info
    FUNCTION get_all_max_capacity
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, capacity_number
            FROM ADM.MAXCAPACITY
            ORDER BY capacity_number;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_all_max_capacity;
    
END ADM_MAXCAPACITY_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.MAXCAPACITY TO PU;
GRANT SELECT ON ADM.MAXCAPACITY_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_MAXCAPACITY_PKG TO PU;