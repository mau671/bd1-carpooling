--==============================================
-- Creacion de sequencias para las tablas de PU
--==============================================

-- ============================================
-- 1. SEQUENCA PARA PHOTO
-- ============================================
CREATE SEQUENCE PHOTO_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 2. SEQUENCA PARA PHONE
-- ============================================
CREATE SEQUENCE PHONE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 3. SEQUENCA PARA EMAIL
-- ============================================
CREATE SEQUENCE EMAIL_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 4. SEQUENCA PARA INSTITUTION
-- ============================================
CREATE SEQUENCE INSTITUTION_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 5. SEQUENCA PARA DOMAIN 
-- ============================================
CREATE SEQUENCE DOMAIN_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 6. SEQUENCA PARA PERSONUSER (cambio de nombre de USER)
-- ============================================
CREATE SEQUENCE PERSONUSER_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 7. SEQUENCA PARA VEHICLE
-- ============================================
CREATE SEQUENCE VEHICLE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 8. SEQUENCA PARA STOP - Se cambió nombre a WAYPOINT porque STOP no se puede usar
-- ============================================
CREATE SEQUENCE WAYPOINT_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 9. SEQUENCA PARA ROUTE
-- ============================================
CREATE SEQUENCE ROUTE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 10. SEQUENCA PARA TRIP
-- ============================================
CREATE SEQUENCE TRIP_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 11. SEQUENCA PARA VEHICLEXROUTE
-- ============================================
CREATE SEQUENCE VEHICLEXROUTE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 12. SEQUENCA PARA DRIVERXVEHICLE
-- ============================================
CREATE SEQUENCE DRIVERXVEHICLE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 13. SEQUENCA PARA MAXCAPACITYXVEHICLE
-- ============================================
CREATE SEQUENCE MAXCAPACITYXVEHICLE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 14. SEQUENCA PARA PASSENGERXTRIP
-- ============================================
CREATE SEQUENCE PASSENGERXTRIP_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 15. SEQUENCA PARA PASSENGERXTRIPXPAYMENT
-- ============================================
CREATE SEQUENCE PASSENGERXTRIPXPAYMENT_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


