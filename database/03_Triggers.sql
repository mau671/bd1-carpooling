-- ============================================
-- Creation of ADM triggers
-- ============================================

-- Note: It is assumed that the sequences (ADM.GENDER_SEQ, ADM.LOGS_SEQ, etc.) exist.
--       These triggers assign IDs (if null) and manage auditing/logs.

-- ============================================
-- 1. Trigger for table ADM.GENDER
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_gender_audit
BEFORE INSERT OR UPDATE ON ADM.GENDER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Assign ID if not provided
        IF :NEW.id IS NULL THEN
            SELECT ADM.GENDER_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        -- Audit
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        -- Log
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.GENDER (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        -- Audit
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        -- Log
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.GENDER (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 2. Trigger for table ADM.TYPE_IDENTIFICATION
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_type_identification_audit
BEFORE INSERT OR UPDATE ON ADM.TYPE_IDENTIFICATION
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.TYPE_IDENTIFICATION_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.TYPE_IDENTIFICATION (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.TYPE_IDENTIFICATION (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 3. Trigger for table ADM.TYPE_PHONE
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_type_phone_audit
BEFORE INSERT OR UPDATE ON ADM.TYPE_PHONE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.TYPE_PHONE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.TYPE_PHONE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.TYPE_PHONE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 4. Trigger for table ADM.COUNTRY
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_country_audit
BEFORE INSERT OR UPDATE ON ADM.COUNTRY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.COUNTRY_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.COUNTRY (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.COUNTRY (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 5. Trigger for table ADM.PROVINCE
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_province_audit
BEFORE INSERT OR UPDATE ON ADM.PROVINCE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.PROVINCE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.PROVINCE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.PROVINCE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/


-- ============================================
-- 6. Trigger for table ADM.CANTON
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_canton_audit
BEFORE INSERT OR UPDATE ON ADM.CANTON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.CANTON_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.CANTON (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.CANTON (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 7. Trigger for table ADM.DISTRICT
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_district_audit
BEFORE INSERT OR UPDATE ON ADM.DISTRICT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.DISTRICT_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.DISTRICT (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.DISTRICT (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 8. Trigger for table ADM.STATUS
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_status_audit
BEFORE INSERT OR UPDATE ON ADM.STATUS
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.STATUS_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.STATUS (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.STATUS (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 9. Trigger for table ADM.MAXCAPACITY
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_maxcapacity_audit
BEFORE INSERT OR UPDATE ON ADM.MAXCAPACITY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.MAXCAPACITY_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.MAXCAPACITY (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.MAXCAPACITY (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 10. Trigger for table ADM.CHOSENCAPACITY
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_chosencapacity_audit
BEFORE INSERT OR UPDATE ON ADM.CHOSENCAPACITY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.CHOSENCAPACITY_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.CHOSENCAPACITY (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.CHOSENCAPACITY (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 11. Trigger for table ADM.PERSON
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_person_audit
BEFORE INSERT OR UPDATE ON ADM.PERSON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.PERSON_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.PERSON (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.PERSON (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 12. Trigger for table ADM.ADMIN
-- (No own ID with sequence, inherits person_id)
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_admin_audit
BEFORE INSERT OR UPDATE ON ADM.ADMIN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.ADMIN (Person_ID: ' || :NEW.person_id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.ADMIN (Person_ID: ' || :NEW.person_id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 13. Trigger for table ADM.PAYMENTMETHOD
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_paymentmethod_audit
BEFORE INSERT OR UPDATE ON ADM.PAYMENTMETHOD
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.PAYMENTMETHOD_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.PAYMENTMETHOD (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.PAYMENTMETHOD (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 14. Trigger for table ADM.INSTITUTION (Moved to ADM)
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_institution_audit
BEFORE INSERT OR UPDATE ON ADM.INSTITUTION
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.INSTITUTION_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.INSTITUTION (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.INSTITUTION (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 15. Trigger for table ADM.DOMAIN (Moved to ADM)
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_domain_audit
BEFORE INSERT OR UPDATE ON ADM.DOMAIN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT ADM.DOMAIN_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.DOMAIN (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.DOMAIN (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 16. Trigger for table ADM.INSTITUTION_DOMAIN (Moved to ADM)
-- (No own ID with sequence)
-- ============================================
CREATE OR REPLACE TRIGGER ADM.trg_institution_domain_audit
BEFORE INSERT OR UPDATE ON ADM.INSTITUTION_DOMAIN
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in ADM.INSTITUTION_DOMAIN (InstID:' || :NEW.institution_id ||', DomID:'||:NEW.domain_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in ADM.INSTITUTION_DOMAIN (InstID:' || :NEW.institution_id ||', DomID:'||:NEW.domain_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/


-- ============================================
-- Creation of PU triggers
-- ============================================

-- Note: It is assumed that the sequences (PU.PHOTO_SEQ, etc.) and ADM.LOGS_SEQ exist.
--       These triggers assign IDs (if null) and manage auditing/logs.

-- ============================================
-- 1. Trigger for table PU.PHOTO
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_photo_audit
BEFORE INSERT OR UPDATE ON PU.PHOTO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.PHOTO_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PHOTO (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PHOTO (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 2. Trigger for table PU.PHONE
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_phone_audit
BEFORE INSERT OR UPDATE ON PU.PHONE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.PHONE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PHONE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PHONE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 3. Trigger for table PU.PHONE_PERSON
-- (No own ID with sequence)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_phone_person_audit
BEFORE INSERT OR UPDATE ON PU.PHONE_PERSON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PHONE_PERSON (PersonID:'||:NEW.person_id||', PhoneID:'||:NEW.phone_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PHONE_PERSON (PersonID:'||:NEW.person_id||', PhoneID:'||:NEW.phone_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 4. Trigger for table PU.EMAIL
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_email_audit
BEFORE INSERT OR UPDATE ON PU.EMAIL
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.EMAIL_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.EMAIL (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.EMAIL (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/


-- ============================================
-- 5. Trigger for table PU.INSTITUTION_PERSON
-- (No own ID with sequence)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_institution_person_audit
BEFORE INSERT OR UPDATE ON PU.INSTITUTION_PERSON
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.INSTITUTION_PERSON (InstID:'||:NEW.institution_id||', PersonID:'||:NEW.person_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.INSTITUTION_PERSON (InstID:'||:NEW.institution_id||', PersonID:'||:NEW.person_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 6. Trigger for table PU.PERSONUSER
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_personuser_audit
BEFORE INSERT OR UPDATE ON PU.PERSONUSER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.PERSONUSER_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PERSONUSER (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PERSONUSER (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 7. Trigger for table PU.VEHICLE
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_vehicle_audit
BEFORE INSERT OR UPDATE ON PU.VEHICLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.VEHICLE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.VEHICLE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.VEHICLE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 8. Trigger for table PU.WAYPOINT
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_waypoint_audit
BEFORE INSERT OR UPDATE ON PU.WAYPOINT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.WAYPOINT_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.WAYPOINT (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.WAYPOINT (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 9. Trigger for table PU.ROUTE
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_route_audit
BEFORE INSERT OR UPDATE ON PU.ROUTE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.ROUTE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.ROUTE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.ROUTE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 10. Trigger for table PU.TRIP
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_trip_audit
BEFORE INSERT OR UPDATE ON PU.TRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
            SELECT PU.TRIP_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.TRIP (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.TRIP (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 11. Trigger for table PU.STATUSXTRIP
-- (No own ID with sequence)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_statusxtrip_audit
BEFORE INSERT OR UPDATE ON PU.STATUSXTRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.STATUSXTRIP (TripID:'||:NEW.trip_id||', StatusID:'||:NEW.status_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.STATUSXTRIP (TripID:'||:NEW.trip_id||', StatusID:'||:NEW.status_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 12. Trigger for table PU.WAYPOINTXTRIP
-- (No own ID with sequence)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_waypointxtrip_audit
BEFORE INSERT OR UPDATE ON PU.WAYPOINTXTRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.WAYPOINTXTRIP (TripID:'||:NEW.trip_id||', WaypointID:'||:NEW.waypoint_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.WAYPOINTXTRIP (TripID:'||:NEW.trip_id||', WaypointID:'||:NEW.waypoint_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 13. Trigger for table PU.PASSENGER
-- (No own ID with sequence, inherits person_id)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_passenger_audit
BEFORE INSERT OR UPDATE ON PU.PASSENGER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PASSENGER (Person_ID: ' || :NEW.person_id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PASSENGER (Person_ID: ' || :NEW.person_id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 14. Trigger for table PU.DRIVER
-- (No own ID with sequence, inherits person_id)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_driver_audit
BEFORE INSERT OR UPDATE ON PU.DRIVER
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.DRIVER (Person_ID: ' || :NEW.person_id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.DRIVER (Person_ID: ' || :NEW.person_id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 15. Trigger for table PU.PASSENGERXWAYPOINT
-- (No own ID with sequence)
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_passengerxwaypoint_audit
BEFORE INSERT OR UPDATE ON PU.PASSENGERXWAYPOINT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PASSENGERXWAYPOINT (PassID:'||:NEW.passenger_id||', WayID:'||:NEW.waypoint_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PASSENGERXWAYPOINT (PassID:'||:NEW.passenger_id||', WayID:'||:NEW.waypoint_id||')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 16. Trigger for table PU.VEHICLEXROUTE
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_vehiclexroute_audit
BEFORE INSERT OR UPDATE ON PU.VEHICLEXROUTE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
             SELECT PU.VEHICLEXROUTE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.VEHICLEXROUTE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.VEHICLEXROUTE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 17. Trigger for table PU.DRIVERXVEHICLE
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_driverxvehicle_audit
BEFORE INSERT OR UPDATE ON PU.DRIVERXVEHICLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
             SELECT PU.DRIVERXVEHICLE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.DRIVERXVEHICLE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.DRIVERXVEHICLE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 18. Trigger for table PU.MAXCAPACITYXVEHICLE
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_maxcapacityxvehicle_audit
BEFORE INSERT OR UPDATE ON PU.MAXCAPACITYXVEHICLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
             SELECT PU.MAXCAPACITYXVEHICLE_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.MAXCAPACITYXVEHICLE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.MAXCAPACITYXVEHICLE (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 19. Trigger for table PU.PASSENGERXTRIP
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_passengerxtrip_audit
BEFORE INSERT OR UPDATE ON PU.PASSENGERXTRIP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
             SELECT PU.PASSENGERXTRIP_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PASSENGERXTRIP (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PASSENGERXTRIP (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/

-- ============================================
-- 20. Trigger for table PU.PASSENGERXTRIPXPAYMENT
-- ============================================
CREATE OR REPLACE TRIGGER PU.trg_passxtripxpaY_audit
BEFORE INSERT OR UPDATE ON PU.PASSENGERXTRIPXPAYMENT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.id IS NULL THEN
             SELECT PU.PASSENGERXTRIPXPAYMENT_SEQ.NEXTVAL INTO :NEW.id FROM DUAL;
        END IF;
        :NEW.creator := USER;
        :NEW.creation_date := SYSDATE;
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'INSERT in PU.PASSENGERXTRIPXPAYMENT (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    ELSIF UPDATING THEN
        :NEW.modifier := USER;
        :NEW.modification_date := SYSDATE;
        INSERT INTO ADM.LOGS (id, description, creator, creation_date, modifier, modification_date, log_date)
        VALUES (ADM.LOGS_SEQ.NEXTVAL, 'UPDATE in PU.PASSENGERXTRIPXPAYMENT (ID: ' || :NEW.id || ')', USER, SYSDATE, USER, SYSDATE, SYSDATE);
    END IF;
END;
/


-- ============================================
-- Required permissions for triggers to work
-- ============================================

-- PU user needs INSERT and SELECT permissions on ADM.LOGS and ADM.LOGS_SEQ
GRANT INSERT ON ADM.LOGS TO PU;
-- GRANT SELECT ON ADM.LOGS_SEQ TO PU; -- (This is already in the sequences script)

-- ADM and PU users need to be able to use sequences in their own schemas
-- (This is normally implicit if they own the sequence)

-- If a different user creates the triggers (e.g., SYSTEM), that user will need:
-- ALTER ANY TRIGGER (or CREATE TRIGGER and permissions on tables/sequences)
-- SELECT on sequences (ADM.GENDER_SEQ, PU.PHOTO_SEQ, etc.)
-- INSERT on ADM.LOGS
-- SELECT on ADM.LOGS_SEQ