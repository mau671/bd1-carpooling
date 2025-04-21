-- ============================================
-- Crear las tablas
-- ============================================



-- ============================================
-- 1. Tabla GENDER (Maestra)
-- ============================================
CREATE TABLE PU.GENDER (
    id                NUMBER CONSTRAINT pk_GENDER PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 2. Tabla TYPE_IDENTIFICATION (Maestra)
-- ============================================
CREATE TABLE PU.TYPE_IDENTIFICATION (
    id                NUMBER CONSTRAINT pk_TYPE_IDENTIFICATION PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 3. Tabla TYPE_PHONE (Maestra)
-- ============================================
CREATE TABLE PU.TYPE_PHONE (
    id                NUMBER CONSTRAINT pk_TYPE_PHONE PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 4. Tabla PERSON (Maestra)
-- ============================================
CREATE TABLE PU.PERSON (
    id                       NUMBER CONSTRAINT pk_PERSON PRIMARY KEY
                                USING INDEX TABLESPACE PU_Index
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
        REFERENCES PU.GENDER(id),

    CONSTRAINT fk_PERSON_TYPE_IDENTIFICATION
        FOREIGN KEY (type_identification_id) 
        REFERENCES PU.TYPE_IDENTIFICATION(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 5. Tabla PHOTO (Dependiente de PERSON)
-- ============================================
CREATE TABLE PU.PHOTO (
    id                NUMBER CONSTRAINT pk_PHOTO PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
        FOREIGN KEY (person_id) REFERENCES PU.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 6. Tabla PHONE (Dependiente de PERSON y TYPE_PHONE)
-- ============================================
CREATE TABLE PU.PHONE (
    id                NUMBER CONSTRAINT pk_PHONE PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
        FOREIGN KEY (person_id) REFERENCES PU.PERSON(id),
    
    -- FK a TYPE_PHONE
    type_phone_id     NUMBER CONSTRAINT phone_type_phone_id_nn NOT NULL,
    CONSTRAINT fk_PHONE_TYPE_PHONE
        FOREIGN KEY (type_phone_id) REFERENCES PU.TYPE_PHONE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 7. Tabla PHONE_PERSON (Relación entre PERSON y PHONE)
-- ============================================
CREATE TABLE PU.PHONE_PERSON (
    person_id         NUMBER NOT NULL,
    phone_id          NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_PHONE_PERSON PRIMARY KEY (person_id, phone_id),
    
    CONSTRAINT fk_PHONE_PERSON_PERSON
       FOREIGN KEY (person_id) REFERENCES PU.PERSON(id),
    
    CONSTRAINT fk_PHONE_PERSON_PHONE
       FOREIGN KEY (phone_id)  REFERENCES PU.PHONE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 8. Tabla EMAIL (Dependiente de PERSON)
-- ============================================
CREATE TABLE PU.EMAIL (
    id                NUMBER CONSTRAINT pk_EMAIL PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
       FOREIGN KEY (person_id) REFERENCES PU.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 9. Tabla INSTITUTION (Maestra)
-- ============================================
CREATE TABLE PU.INSTITUTION (
    id                NUMBER CONSTRAINT pk_INSTITUTION PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 10. Tabla INSTITUTION_PERSON (Relación entre INSTITUTION y PERSON)
-- ============================================
CREATE TABLE PU.INSTITUTION_PERSON (
    institution_id    NUMBER NOT NULL,
    person_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_PERSON PRIMARY KEY (institution_id, person_id),
    
    CONSTRAINT fk_INSTITUTION_PER_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES PU.INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_PER_PER
       FOREIGN KEY (person_id) REFERENCES PU.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 11. Tabla DOMAIN (Maestra)
-- ============================================
CREATE TABLE PU.DOMAIN (
    id                NUMBER CONSTRAINT pk_DOMAIN PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 12. Tabla INSTITUTION_DOMAIN (Relación entre INSTITUTION y DOMAIN)
-- ============================================
CREATE TABLE PU.INSTITUTION_DOMAIN (
    institution_id    NUMBER NOT NULL,
    domain_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_DOMAIN PRIMARY KEY (institution_id, domain_id),
    
    CONSTRAINT fk_INSTITUTION_DOM_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES PU.INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_DOM_DOM
       FOREIGN KEY (domain_id) REFERENCES PU.DOMAIN(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 13. Tabla "USER" (cambiar ya que USER es palabra reservada)
-- ============================================
CREATE TABLE PU."USER" (
    id                NUMBER CONSTRAINT pk_USER PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
       FOREIGN KEY (person_id) REFERENCES PU.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 14. Tabla ADMIN (Hereda de PERSON mediante clave compartida)
-- ============================================
CREATE TABLE PU.ADMIN (
    person_id         NUMBER CONSTRAINT pk_ADMIN PRIMARY KEY,  -- shared primary key con PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ADMIN_PERSON
        FOREIGN KEY (person_id)
        REFERENCES PU.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 15. Tabla VEHICLE
-- ============================================
CREATE TABLE PU.VEHICLE (
    id                NUMBER CONSTRAINT pk_VEHICLE PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    plate             VARCHAR2(9) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 16. Tabla COUNTRY
-- ============================================
CREATE TABLE PU.COUNTRY (
    id                NUMBER CONSTRAINT pk_COUNTRY PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 17. Tabla PROVINCE
-- ============================================
CREATE TABLE PU.PROVINCE (
    id                NUMBER CONSTRAINT pk_PROVINCE PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
        REFERENCES PU.COUNTRY(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 18. Tabla CANTON
-- ============================================
CREATE TABLE PU.CANTON (
    id                NUMBER CONSTRAINT pk_CANTON PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
        REFERENCES PU.PROVINCE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 19. Tabla DISTRICT
-- ============================================
CREATE TABLE PU.DISTRICT (
    id                NUMBER CONSTRAINT pk_DISTRICT PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
        REFERENCES PU.CANTON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 20. Tabla STOP - Se cambió nombre a WAYPOINT porque STOP no se puede usar
-- ============================================
CREATE TABLE PU.WAYPOINT (
    id                NUMBER CONSTRAINT pk_WAYPOINT PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    district_id       NUMBER NOT NULL,
    latitude          NUMBER(9,6) NOT NULL,
    longitude         NUMBER(9,6) NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_WAYPOINT_DISTRICT
        FOREIGN KEY (district_id)
        REFERENCES PU.DISTRICT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 21. Tabla ROUTE
-- ============================================
CREATE TABLE PU.ROUTE (
    id                NUMBER CONSTRAINT pk_ROUTE PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    waypoint_id       NUMBER NOT NULL,
    start_time        TIMESTAMP NOT NULL,
    end_time          TIMESTAMP NOT NULL,
    programming_date  DATE NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ROUTE_WAYPOINT
        FOREIGN KEY (waypoint_id)
        REFERENCES PU.WAYPOINT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 22. Tabla TRIP (Hereda de VEHICLE y ROUTE mediante clave compartida)
-- ============================================
CREATE TABLE PU.TRIP (
    id                NUMBER CONSTRAINT pk_TRIP PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    vehicle_id        NUMBER NOT NULL,
    route_id          NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_TRIP_VEHICLE
        FOREIGN KEY (vehicle_id)
        REFERENCES PU.VEHICLE(id),
    CONSTRAINT fk_TRIP_ROUTE
        FOREIGN KEY (route_id)
        REFERENCES PU.ROUTE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 23. Tabla STATUS
-- ============================================
CREATE TABLE PU.STATUS (
    id                NUMBER CONSTRAINT pk_STATUS PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
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
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 24. Tabla STATUSXTRIP (Relación entre TRIP y STATUS)
-- ============================================
CREATE TABLE PU.STATUSXTRIP (
    trip_id           NUMBER NOT NULL,
    status_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_STATUSXTRIP PRIMARY KEY (trip_id, status_id),
    
    CONSTRAINT fk_STATUSXTRIP_TRIP
       FOREIGN KEY (trip_id) REFERENCES PU.TRIP(id),
    
    CONSTRAINT fk_STATUSXTRIP_STATUS
       FOREIGN KEY (status_id)  REFERENCES PU.STATUS(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 25. Tabla WAYPOINTXTRIP (Relación entre TRIP y WAYPOINT)
-- ============================================
CREATE TABLE PU.WAYPOINTXTRIP (
    trip_id           NUMBER NOT NULL,
    waypoint_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_WAYPOINTXTRIP PRIMARY KEY (trip_id, waypoint_id),
    
    CONSTRAINT fk_WAYPOINTXTRIP_TRIP
       FOREIGN KEY (trip_id) REFERENCES PU.TRIP(id),
    
    CONSTRAINT fk_WAYPOINTXTRIP_WAYPOINT
       FOREIGN KEY (waypoint_id)  REFERENCES PU.WAYPOINT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);
