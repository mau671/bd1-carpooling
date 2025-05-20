-- ============================================================================
-- PACKAGE: ADM_STATUS_PKG
-- Description: Manages operations related to statuses in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_STATUS_PKG AS
    TYPE ref_cursor_type IS REF CURSOR;
    
    -- Get all status info
    FUNCTION get_all_status
    RETURN ref_cursor_type;

END ADM_STATUS_PKG;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_STATUS_PKG AS
    -- Get all status info
    FUNCTION get_all_status
    RETURN ref_cursor_type
    AS
        v_cursor ref_cursor_type;
    BEGIN
        OPEN v_cursor FOR
            SELECT id, name
            FROM ADM.STATUS
            ORDER BY name;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
            RAISE;
    END get_all_status;
    
END ADM_STATUS_PKG;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.STATUS TO PU;
GRANT SELECT ON ADM.STATUS_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_STATUS_PKG TO PU;