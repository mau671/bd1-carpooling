-- ============================================
-- 1. Tabla GENDER (Maestra)
-- ============================================
CREATE TABLE GE.GENDER (
    id                NUMBER CONSTRAINT pk_GENDER PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(50) CONSTRAINT gender_name_nn NOT NULL,
    creation_user     VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 2. Tabla TYPE_IDENTIFICATION (Maestra)
-- ============================================
CREATE TABLE GE.TYPE_IDENTIFICATION (
    id                NUMBER CONSTRAINT pk_TYPE_IDENTIFICATION PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 3. Tabla TYPE_PHONE (Maestra)
-- ============================================
CREATE TABLE GE.TYPE_PHONE (
    id                NUMBER CONSTRAINT pk_TYPE_PHONE PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 4. Tabla PERSON (Maestra)
-- ============================================
CREATE TABLE GE.PERSON (
    id                       NUMBER CONSTRAINT pk_PERSON PRIMARY KEY
                                USING INDEX TABLESPACE GE_Index
                                STORAGE (
                                    INITIAL 10K NEXT 10K MINEXTENTS 1 
                                    MAXEXTENTS UNLIMITED PCTINCREASE 0
                                ),
    fis_name                 VARCHAR2(50) CONSTRAINT person_fis_name_nn NOT NULL,
    second_name              VARCHAR2(50),
    first_surname            VARCHAR2(50) CONSTRAINT person_first_surname_nn NOT NULL,
    second_surname           VARCHAR2(50),
    identification_number    VARCHAR2(50) CONSTRAINT person_identification_number_nn NOT NULL,
    date_of_birth            DATE         CONSTRAINT person_date_of_birth_nn NOT NULL,
    creation_date            DATE,
    creation_user            VARCHAR2(50),
    modification_date        DATE,
    modification_user        VARCHAR2(50),
    gender_id                NUMBER CONSTRAINT person_gender_id_nn NOT NULL,
    type_identification_id   NUMBER CONSTRAINT person_type_identification_id_nn NOT NULL,

    CONSTRAINT fk_PERSON_GENDER
        FOREIGN KEY (gender_id) 
        REFERENCES GE.GENDER(id),

    CONSTRAINT fk_PERSON_TYPE_IDENTIFICATION
        FOREIGN KEY (type_identification_id) 
        REFERENCES GE.TYPE_IDENTIFICATION(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 5. Tabla PHOTO (Dependiente de PERSON)
-- ============================================
CREATE TABLE GE.PHOTO (
    id                NUMBER CONSTRAINT pk_PHOTO PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    image             BLOB,  -- Usar BLOB para almacenar la imagen binaria; si se requiere solo la ruta, se puede usar VARCHAR2
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    person_id         NUMBER CONSTRAINT photo_person_id_nn NOT NULL,

    CONSTRAINT fk_PHOTO_PERSON
        FOREIGN KEY (person_id) REFERENCES GE.PERSON(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 6. Tabla PHONE (Dependiente de PERSON y TYPE_PHONE)
-- ============================================
CREATE TABLE GE.PHONE (
    id                NUMBER CONSTRAINT pk_PHONE PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    phone_number      VARCHAR2(20) CONSTRAINT phone_number_nn NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    -- FK a PERSON
    person_id         NUMBER CONSTRAINT phone_person_id_nn NOT NULL,
    CONSTRAINT fk_PHONE_PERSON
        FOREIGN KEY (person_id) REFERENCES GE.PERSON(id),
    
    -- FK a TYPE_PHONE
    type_phone_id     NUMBER CONSTRAINT phone_type_phone_id_nn NOT NULL,
    CONSTRAINT fk_PHONE_TYPE_PHONE
        FOREIGN KEY (type_phone_id) REFERENCES GE.TYPE_PHONE(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 7. Tabla PHONE_PERSON (Relación entre PERSON y PHONE)
-- ============================================
CREATE TABLE GE.PHONE_PERSON (
    person_id         NUMBER NOT NULL,
    phone_id          NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_PHONE_PERSON PRIMARY KEY (person_id, phone_id),
    
    CONSTRAINT fk_PHONE_PERSON_PERSON
       FOREIGN KEY (person_id) REFERENCES GE.PERSON(id),
    
    CONSTRAINT fk_PHONE_PERSON_PHONE
       FOREIGN KEY (phone_id)  REFERENCES GE.PHONE(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 8. Tabla EMAIL (Dependiente de PERSON)
-- ============================================
CREATE TABLE GE.EMAIL (
    id                NUMBER CONSTRAINT pk_EMAIL PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(100) NOT NULL,  -- Dirección de email
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    person_id         NUMBER NOT NULL,
    CONSTRAINT fk_EMAIL_PERSON
       FOREIGN KEY (person_id) REFERENCES GE.PERSON(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 9. Tabla INSTITUTION (Maestra)
-- ============================================
CREATE TABLE GE.INSTITUTION (
    id                NUMBER CONSTRAINT pk_INSTITUTION PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(100) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 10. Tabla INSTITUTION_PERSON (Relación entre INSTITUTION y PERSON)
-- ============================================
CREATE TABLE GE.INSTITUTION_PERSON (
    institution_id    NUMBER NOT NULL,
    person_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_PERSON PRIMARY KEY (institution_id, person_id),
    
    CONSTRAINT fk_INSTITUTION_PERSON_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES GE.INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_PERSON_PERSON
       FOREIGN KEY (person_id) REFERENCES GE.PERSON(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 11. Tabla DOMAIN (Maestra)
-- ============================================
CREATE TABLE GE.DOMAIN (
    id                NUMBER CONSTRAINT pk_DOMAIN PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(100) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 12. Tabla INSTITUTION_DOMAIN (Relación entre INSTITUTION y DOMAIN)
-- ============================================
CREATE TABLE GE.INSTITUTION_DOMAIN (
    institution_id    NUMBER NOT NULL,
    domain_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_DOMAIN PRIMARY KEY (institution_id, domain_id),
    
    CONSTRAINT fk_INSTITUTION_DOMAIN_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES GE.INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_DOMAIN_DOMAIN
       FOREIGN KEY (domain_id) REFERENCES GE.DOMAIN(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 13. Tabla "USER" (cambiar ya que USER es palabra reservada)
-- ============================================
CREATE TABLE GE."USER" (
    id                NUMBER CONSTRAINT pk_USER PRIMARY KEY
                         USING INDEX TABLESPACE GE_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    username          VARCHAR2(50) NOT NULL,
    password          VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    person_id         NUMBER NOT NULL,
    CONSTRAINT fk_USER_PERSON
       FOREIGN KEY (person_id) REFERENCES GE.PERSON(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 14. Tabla ADMIN (Hereda de PERSON mediante clave compartida)
-- ============================================
CREATE TABLE GE.ADMIN (
    person_id         NUMBER CONSTRAINT pk_ADMIN PRIMARY KEY,  -- shared primary key con PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ADMIN_PERSON
        FOREIGN KEY (person_id)
        REFERENCES GE.PERSON(id)
)
TABLESPACE GE_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);
