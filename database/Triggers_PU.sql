-- ============================================
-- Creacion de triggers PU 
-- ============================================

-- ============================================
-- 1. Trigger para la tabla PHOTO
-- ============================================
CREATE OR REPLACE TRIGGER trg_photo_audit
BEFORE INSERT OR UPDATE ON PHOTO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PHOTO por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PHOTO por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 2. Trigger para la tabla PHONE
-- ============================================
CREATE OR REPLACE TRIGGER trg_phone_audit
BEFORE INSERT OR UPDATE ON PHONE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PHONE por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PHONE por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 3. Trigger para la tabla PHONE_PERSON
-- ============================================
CREATE OR REPLACE TRIGGER trg_phone_person_audit
BEFORE INSERT OR UPDATE ON PHONE_PERSON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PHONE_PERSON por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PHONE_PERSON por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 4. Trigger para la tabla EMAIL
-- ============================================
CREATE OR REPLACE TRIGGER trg_email_audit
BEFORE INSERT OR UPDATE ON EMAIL
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en EMAIL por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó EMAIL por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 5. Trigger para la tabla INSTITUTION
-- ============================================
CREATE OR REPLACE TRIGGER trg_institution_audit
BEFORE INSERT OR UPDATE ON INSTITUTION
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en INSTITUTION por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó INSTITUTION por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 6. Trigger para la tabla INSTITUTION_PERSON
-- ============================================
CREATE OR REPLACE TRIGGER trg_institution_person_audit
BEFORE INSERT OR UPDATE ON INSTITUTION_PERSON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en INSTITUTION_PERSON por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó INSTITUTION_PERSON por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 7. Trigger para la DOMAIN
-- ============================================
CREATE OR REPLACE TRIGGER trg_domain_audit
BEFORE INSERT OR UPDATE ON DOMAIN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en INSTITUTION_DOMAIN por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó INSTITUTION_DOMAIN por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 8. Trigger para la tabla INSTITUTION_DOMAIN
-- ============================================
CREATE OR REPLACE TRIGGER trg_institution_domain_audit
BEFORE INSERT OR UPDATE ON INSTITUTION_DOMAIN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en INSTITUTION_DOMAIN por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó INSTITUTION_DOMAIN por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 9. Trigger para la tabla PERSONUSER
-- ============================================
CREATE OR REPLACE TRIGGER trg_personuser_audit
BEFORE INSERT OR UPDATE ON PERSONUSER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PERSONUSER por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PERSONUSER por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 10. Trigger para la tabla VEHICLE
-- ============================================
CREATE OR REPLACE TRIGGER trg_vehicle_audit
BEFORE INSERT OR UPDATE ON VEHICLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en VEHICLE por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó VEHICLE por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 11. Trigger para la tabla WAYPOINT
-- ============================================
CREATE OR REPLACE TRIGGER trg_waypoint_audit
BEFORE INSERT OR UPDATE ON WAYPOINT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en WAYPOINT por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó WAYPOINT por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 12. Trigger para la tabla ROUTE
-- ============================================
CREATE OR REPLACE TRIGGER trg_route_audit
BEFORE INSERT OR UPDATE ON ROUTE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en ROUTE por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó ROUTE por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 13. Trigger para la tabla TRIP
-- ============================================
CREATE OR REPLACE TRIGGER trg_trip_audit
BEFORE INSERT OR UPDATE ON TRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en TRIP por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó TRIP por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 14. Trigger para la tabla STATUSXTRIP
-- ============================================
CREATE OR REPLACE TRIGGER trg_statusxtrip_audit
BEFORE INSERT OR UPDATE ON STATUSXTRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en STATUSXTRIP por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó STATUSXTRIP por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 15. Trigger para la tabla WAYPOINTXTRIP
-- ============================================
CREATE OR REPLACE TRIGGER trg_waypointxtrip_audit
BEFORE INSERT OR UPDATE ON WAYPOINTXTRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en WAYPOINTXTRIP por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó WAYPOINTXTRIP por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 16. Trigger para la tabla PASSENGER
-- ============================================
CREATE OR REPLACE TRIGGER trg_passenger_audit
BEFORE INSERT OR UPDATE ON PASSENGER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PASSENGER por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PASSENGER por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 17. Trigger para la tabla DRIVER
-- ============================================
CREATE OR REPLACE TRIGGER trg_driver_audit
BEFORE INSERT OR UPDATE ON DRIVER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en DRIVER por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó DRIVER por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 18. Trigger para la tabla PASSENGERXWAYPOINT
-- ============================================
CREATE OR REPLACE TRIGGER trg_passengerxwaypoint_audit
BEFORE INSERT OR UPDATE ON PASSENGERXWAYPOINT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PASSENGERXWAYPOINT por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PASSENGERXWAYPOINT por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 19. Trigger para la tabla VEHICLEXROUTE
-- ============================================
CREATE OR REPLACE TRIGGER trg_vehiclexroute_audit
BEFORE INSERT OR UPDATE ON VEHICLEXROUTE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en VEHICLEXROUTE por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó VEHICLEXROUTE por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 20. Trigger para la tabla DRIVERXVEHICLE
-- ============================================
CREATE OR REPLACE TRIGGER trg_driverxvehicle_audit
BEFORE INSERT OR UPDATE ON DRIVERXVEHICLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en DRIVERXVEHICLE por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó DRIVERXVEHICLE por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 21. Trigger para la tabla MAXCAPACITYXVEHICLE
-- ============================================
CREATE OR REPLACE TRIGGER trg_maxcapacityxvehicle_audit
BEFORE INSERT OR UPDATE ON MAXCAPACITYXVEHICLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en MAXCAPACITYXVEHICLE por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó MAXCAPACITYXVEHICLE por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 22. Trigger para la tabla PASSENGERXTRIP
-- ============================================
CREATE OR REPLACE TRIGGER trg_passengerxtrip_audit
BEFORE INSERT OR UPDATE ON PASSENGERXTRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PASSENGERXTRIP por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PASSENGERXTRIP por ' || USER, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 23. Trigger para la tabla PASSENGERXTRIPXPAYMENT
-- ============================================
CREATE OR REPLACE TRIGGER trg_passxtripxpaY_audit
BEFORE INSERT OR UPDATE ON PASSENGERXTRIPXPAYMENT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se insertó en PASSENGERXTRIPXPAYMENT por ' || USER, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'Se modificó PASSENGERXTRIPXPAYMENT por ' || USER, SYSDATE);
    END IF;
END;
/
