-- ============================================
-- Creacion de las tablas de ADM
-- ============================================

-- ============================================
-- 1. Tabla GENDER (Maestra)
-- ============================================
CREATE TABLE GENDER (
    id                NUMBER CONSTRAINT pk_GENDER PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 2. Tabla TYPE_IDENTIFICATION (Maestra)
-- ============================================
CREATE TABLE TYPE_IDENTIFICATION (
    id                NUMBER CONSTRAINT pk_TYPE_IDENTIFICATION PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 3. Tabla TYPE_PHONE (Maestra)
-- ============================================
CREATE TABLE TYPE_PHONE (
    id                NUMBER CONSTRAINT pk_TYPE_PHONE PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 4. Tabla COUNTRY
-- ============================================
CREATE TABLE COUNTRY (
    id                NUMBER CONSTRAINT pk_COUNTRY PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 5. Tabla PROVINCE
-- ============================================
CREATE TABLE PROVINCE (
    id                NUMBER CONSTRAINT pk_PROVINCE PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    country_id        NUMBER NOT NULL,
    name              VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_PROVINCE_COUNTRY
        FOREIGN KEY (country_id)
        REFERENCES COUNTRY(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 6. Tabla CANTON
-- ============================================
CREATE TABLE CANTON (
    id                NUMBER CONSTRAINT pk_CANTON PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    province_id       NUMBER NOT NULL,
    name              VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_CANTON_PROVINCE
        FOREIGN KEY (province_id)
        REFERENCES PROVINCE(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 7. Tabla DISTRICT
-- ============================================
CREATE TABLE DISTRICT (
    id                NUMBER CONSTRAINT pk_DISTRICT PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    canton_id         NUMBER NOT NULL,
    name              VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_DISTRICT_CANTON
        FOREIGN KEY (canton_id)
        REFERENCES CANTON(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 8. Tabla STATUS
-- ============================================
CREATE TABLE STATUS (
    id                NUMBER CONSTRAINT pk_STATUS PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 9. Tabla MAXCAPACITY
-- ============================================
CREATE TABLE MAXCAPACITY (
    id                NUMBER CONSTRAINT pk_MAXCAPACITY PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    capacity_number   NUMBER,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 10. Tabla CHOSENCAPACITY
-- ============================================
CREATE TABLE CHOSENCAPACITY (
       id                NUMBER CONSTRAINT pk_CHOSENCAPACITY PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    vehicle_x_route_id         NUMBER NOT NULL,
    chosen_number              NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
  
    CONSTRAINT fk_vehicle_x_route
      FOREIGN KEY (vehicle_x_route_id)
      REFERENCES PU.VEHICLEXROUTE(id)
)
TABLESPACE ADM_Data
STORAGE (
  INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 11. Tabla LOGS
-- ============================================
CREATE TABLE LOGS (
    id                NUMBER CONSTRAINT pk_LOGS PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    description       VARCHAR2(100),
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    log_date DATE
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 12. Tabla PARAMETER
-- ============================================
CREATE TABLE PARAMETER (
    id                NUMBER CONSTRAINT pk_PARAMETER PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(50) NOT NULL,
    value             NUMBER
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 13. Tabla PERSON (Maestra)
-- ============================================
CREATE TABLE PERSON (
    id                       NUMBER CONSTRAINT pk_PERSON PRIMARY KEY
                                USING INDEX TABLESPACE ADM_Index
                                STORAGE (
                                    INITIAL 10K NEXT 10K MINEXTENTS 1 
                                    MAXEXTENTS UNLIMITED PCTINCREASE 0
                                ),
    first_name               VARCHAR2(50) CONSTRAINT person_f_name_nn NOT NULL,
    second_name              VARCHAR2(50),
    first_surname            VARCHAR2(50) CONSTRAINT person_f_surname_nn NOT NULL,
    second_surname           VARCHAR2(50),
    identification_number    VARCHAR2(50) CONSTRAINT person_id_num_nn NOT NULL,
    date_of_birth            DATE         CONSTRAINT person_date_birth_nn NOT NULL,
    creation_date            DATE,
    creation_user            VARCHAR2(50),
    modification_date        DATE,
    modification_user        VARCHAR2(50),
    gender_id                NUMBER CONSTRAINT person_gender_id_nn NOT NULL,
    type_identification_id   NUMBER CONSTRAINT person_type_id_nn NOT NULL,

    CONSTRAINT fk_PERSON_GENDER
        FOREIGN KEY (gender_id) 
        REFERENCES GENDER(id),

    CONSTRAINT fk_PERSON_TYPE_IDENTIFICATION
        FOREIGN KEY (type_identification_id) 
        REFERENCES TYPE_IDENTIFICATION(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 14. Tabla ADMIN (Hereda de PERSON mediante clave compartida)
-- ============================================
CREATE TABLE ADMIN (
    person_id         NUMBER CONSTRAINT pk_ADMIN PRIMARY KEY,  -- shared primary key con PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ADMIN_PERSON
        FOREIGN KEY (person_id)
        REFERENCES PERSON(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 15. Tabla PAYMENTMETHOD
-- ============================================
CREATE TABLE PAYMENTMETHOD (
    id         NUMBER CONSTRAINT pk_PAYMENTMETHOD PRIMARY KEY,
    name       VARCHAR2(50) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- GRANTS para las tablas del esquema ADM
-- ============================================

GRANT SELECT, INSERT ON GENDER TO PU;
GRANT SELECT, INSERT ON TYPE_IDENTIFICATION TO PU;
GRANT SELECT, INSERT ON TYPE_PHONE TO PU;
GRANT SELECT, INSERT ON COUNTRY TO PU;
GRANT SELECT, INSERT ON PROVINCE TO PU;
GRANT SELECT, INSERT ON CANTON TO PU;
GRANT SELECT, INSERT ON DISTRICT TO PU;
GRANT SELECT, INSERT ON STATUS TO PU;
GRANT SELECT, INSERT ON MAXCAPACITY TO PU;
GRANT SELECT, INSERT ON CHOSENCAPACITY TO PU;
GRANT SELECT, INSERT ON LOGS TO PU;
GRANT SELECT, INSERT ON PARAMETER TO PU;
GRANT SELECT, INSERT ON PERSON TO PU;

GRANT REFERENCES ON PERSON TO PU;
GRANT REFERENCES ON GENDER TO PU;
GRANT REFERENCES ON TYPE_IDENTIFICATION TO PU;
GRANT REFERENCES ON TYPE_PHONE TO PU;
GRANT REFERENCES ON COUNTRY TO PU;
GRANT REFERENCES ON PROVINCE TO PU;
GRANT REFERENCES ON CANTON TO PU;
GRANT REFERENCES ON DISTRICT TO PU;
GRANT REFERENCES ON STATUS TO PU;
GRANT REFERENCES ON MAXCAPACITY TO PU;
GRANT REFERENCES ON LOGS TO PU;
GRANT REFERENCES ON PARAMETER TO PU;
GRANT REFERENCES ON ADMIN TO PU;
GRANT REFERENCES ON PAYMENTMETHOD TO PU;
