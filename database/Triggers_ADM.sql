-- ============================================
-- Creacion de triggers ADM
-- ============================================

-- ============================================
-- 1. Trigger para la tabla GENDER
-- ============================================
CREATE OR REPLACE TRIGGER trg_gender_audit 
BEFORE INSERT OR UPDATE ON GENDER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creation_user := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en GENDER por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó GENDER por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 2. Trigger para la tabla TYPE_IDENTIFICATION
-- ============================================
CREATE OR REPLACE TRIGGER trg_type_identification_audit 
BEFORE INSERT OR UPDATE ON TYPE_IDENTIFICATION
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en TYPE_IDENTIFICATION por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó TYPE_IDENTIFICATION por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 3. Trigger para la tabla TYPE_PHONE
-- ============================================
CREATE OR REPLACE TRIGGER trg_type_phone_audit 
BEFORE INSERT OR UPDATE ON TYPE_PHONE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en TYPE_PHONE por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó TYPE_PHONE por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 4. Trigger para la tabla COUNTRY
-- ============================================
CREATE OR REPLACE TRIGGER trg_country_audit 
BEFORE INSERT OR UPDATE ON COUNTRY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en COUNTRY por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó COUNTRY por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 5. Trigger para la tabla PROVINCE
-- ============================================
CREATE OR REPLACE TRIGGER trg_province_audit 
BEFORE INSERT OR UPDATE ON PROVINCE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en PROVINCE por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó PROVINCE por ' || USER, SYSDATE); 
    END IF;
END;
/


-- ============================================
-- 6. Trigger para la tabla CANTON
-- ============================================
CREATE OR REPLACE TRIGGER trg_canton_audit 
BEFORE INSERT OR UPDATE ON CANTON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en CANTON por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó CANTON por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 7. Trigger para la tabla DISTRICT
-- ============================================
CREATE OR REPLACE TRIGGER trg_district_audit 
BEFORE INSERT OR UPDATE ON DISTRICT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en DISTRICT por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó DISTRICT por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 8. Trigger para la tabla STATUS
-- ============================================
CREATE OR REPLACE TRIGGER trg_status_audit 
BEFORE INSERT OR UPDATE ON STATUS
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en STATUS por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó STATUS por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 9. Trigger para la tabla MAXCAPACITY
-- ============================================
CREATE OR REPLACE TRIGGER trg_maxcapacity_audit 
BEFORE INSERT OR UPDATE ON MAXCAPACITY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en MAXCAPACITY por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó MAXCAPACITY por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 10. Trigger para la tabla CHOSENCAPACITY
-- ============================================
CREATE OR REPLACE TRIGGER trg_chosencapacity_audit 
BEFORE INSERT OR UPDATE ON CHOSENCAPACITY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en CHOSENCAPACITY por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó CHOSENCAPACITY por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 11. Trigger para la tabla PERSON
-- ============================================
CREATE OR REPLACE TRIGGER trg_person_audit 
BEFORE INSERT OR UPDATE ON PERSON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creation_user := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modification_user := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en PERSON por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modification_user := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó PERSON por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 12. Trigger para la tabla ADMIN
-- ============================================
CREATE OR REPLACE TRIGGER trg_admin_audit 
BEFORE INSERT OR UPDATE ON ADMIN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en ADMIN por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó ADMIN por ' || USER, SYSDATE); 
    END IF;
END;
/

-- ============================================
-- 13. Trigger para la tabla PAYMENTMETHOD
-- ============================================
CREATE OR REPLACE TRIGGER trg_paymentmethod_audit 
BEFORE INSERT OR UPDATE ON PAYMENTMETHOD
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se insertó en PAYMENTMETHOD por ' || USER, SYSDATE); 
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO LOGS (id, description, log_date)
        VALUES (LOGS_SEQ.NEXTVAL, 'Se modificó PAYMENTMETHOD por ' || USER, SYSDATE); 
    END IF;
END;
/
