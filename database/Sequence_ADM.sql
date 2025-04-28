--==============================================
-- Creacion de sequencias para las tablas de PU
--==============================================

-- ============================================
-- 1. SEQUENCA PARA GENDER
-- ============================================
CREATE SEQUENCE GENDER_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 2. SEQUENCA PARA TYPE_IDENTIFICATION
-- ============================================
CREATE SEQUENCE TYPE_IDENTIFICATION_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 3. SEQUENCA PARA TYPE_PHONE
-- ============================================
CREATE SEQUENCE TYPE_PHONE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 4. SEQUENCA PARA COUNTRY
-- ============================================
CREATE SEQUENCE COUNTRY_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 5. SEQUENCA PARA PROVINCE
-- ============================================
CREATE SEQUENCE PROVINCE_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 6. SEQUENCA PARA CANTON
-- ============================================
CREATE SEQUENCE CANTON_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 7. SEQUENCA PARA DISTRICT
-- ============================================
CREATE SEQUENCE DISTRICT_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 8. SEQUENCA PARA STATUS
-- ============================================
CREATE SEQUENCE STATUS_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 9. SEQUENCA PARA MAXCAPACITY
-- ============================================
CREATE SEQUENCE MAXCAPACITY_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 10. SEQUENCA PARA CHOSENCAPACITY
-- ============================================
CREATE SEQUENCE CHOSENCAPACITY_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 11. SEQUENCA PARA LOGS
-- ============================================
CREATE SEQUENCE LOGS_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

GRANT SELECT ON LOGS_SEQ TO PU;

-- ============================================
-- 12. SEQUENCA PARA PARAMETER
-- ============================================
CREATE SEQUENCE PARAMETER_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 13. SEQUENCA PARA PERSON
-- ============================================
CREATE SEQUENCE PERSON_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- ============================================
-- 14. SEQUENCA PARA PAYMENTMETHOD
-- ============================================
CREATE SEQUENCE PAYMENTMETHOD_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
