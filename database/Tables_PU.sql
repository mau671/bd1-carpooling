-- ============================================
-- Creacion de tablas PU 
-- ============================================

-- ============================================
-- 1. Tabla PHOTO (Dependiente de PERSON)
-- ============================================
CREATE TABLE PHOTO (
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
        FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 2. Tabla PHONE (Dependiente de PERSON y TYPE_PHONE)
-- ============================================
CREATE TABLE PHONE (
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
        FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id),
    
    -- FK a TYPE_PHONE
    type_phone_id     NUMBER CONSTRAINT phone_type_phone_id_nn NOT NULL,
    CONSTRAINT fk_PHONE_TYPE_PHONE
        FOREIGN KEY (type_phone_id) REFERENCES ADM.TYPE_PHONE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 3. Tabla PHONE_PERSON (Relación entre PERSON y PHONE)
-- ============================================
CREATE TABLE PHONE_PERSON (
    person_id         NUMBER NOT NULL,
    phone_id          NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_PHONE_PERSON PRIMARY KEY (person_id, phone_id),
    
    CONSTRAINT fk_PHONE_PERSON_PERSON
       FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id),
    
    CONSTRAINT fk_PHONE_PERSON_PHONE
       FOREIGN KEY (phone_id)  REFERENCES PHONE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 4. Tabla EMAIL (Dependiente de PERSON)
-- ============================================
CREATE TABLE EMAIL (
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
       FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 5. Tabla INSTITUTION (Maestra)
-- ============================================
CREATE TABLE INSTITUTION (
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
-- 6. Tabla INSTITUTION_PERSON (Relación entre INSTITUTION y PERSON)
-- ============================================
CREATE TABLE INSTITUTION_PERSON (
    institution_id    NUMBER NOT NULL,
    person_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_PERSON PRIMARY KEY (institution_id, person_id),
    
    CONSTRAINT fk_INSTITUTION_PER_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_PER_PER
       FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 7. Tabla DOMAIN (Maestra)
-- ============================================
CREATE TABLE DOMAIN (
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
-- 8. Tabla INSTITUTION_DOMAIN (Relación entre INSTITUTION y DOMAIN)
-- ============================================
CREATE TABLE INSTITUTION_DOMAIN (
    institution_id    NUMBER NOT NULL,
    domain_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_DOMAIN PRIMARY KEY (institution_id, domain_id),
    
    CONSTRAINT fk_INSTITUTION_DOM_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_DOM_DOM
       FOREIGN KEY (domain_id) REFERENCES DOMAIN(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 9. Tabla PERSONUSER (cambio de nombre de USER)
-- ============================================
CREATE TABLE PERSONUSER (
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
       FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 10. Tabla VEHICLE
-- ============================================
CREATE TABLE VEHICLE (
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
-- 11. Tabla STOP - Se cambió nombre a WAYPOINT porque STOP no se puede usar
-- ============================================
CREATE TABLE WAYPOINT (
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
        REFERENCES ADM.DISTRICT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 12. Tabla ROUTE
-- ============================================
CREATE TABLE ROUTE (
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
        REFERENCES WAYPOINT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 13. Tabla TRIP (Hereda de VEHICLE y ROUTE mediante clave compartida)
-- ============================================
CREATE TABLE TRIP (
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
        REFERENCES VEHICLE(id),
    CONSTRAINT fk_TRIP_ROUTE
        FOREIGN KEY (route_id)
        REFERENCES ROUTE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 14. Tabla STATUSXTRIP (Relación entre TRIP y STATUS)
-- ============================================
CREATE TABLE STATUSXTRIP (
    trip_id           NUMBER NOT NULL,
    status_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_STATUSXTRIP PRIMARY KEY (trip_id, status_id),
    
    CONSTRAINT fk_STATUSXTRIP_TRIP
       FOREIGN KEY (trip_id) REFERENCES TRIP(id),
    
    CONSTRAINT fk_STATUSXTRIP_STATUS
       FOREIGN KEY (status_id)  REFERENCES ADM.STATUS(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 15. Tabla WAYPOINTXTRIP (Relación entre TRIP y WAYPOINT)
-- ============================================
CREATE TABLE WAYPOINTXTRIP (
    trip_id           NUMBER NOT NULL,
    waypoint_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,

    CONSTRAINT pk_WAYPOINTXTRIP PRIMARY KEY (trip_id, waypoint_id),
    
    CONSTRAINT fk_WAYPOINTXTRIP_TRIP
       FOREIGN KEY (trip_id) REFERENCES TRIP(id),
    
    CONSTRAINT fk_WAYPOINTXTRIP_WAYPOINT
       FOREIGN KEY (waypoint_id)  REFERENCES WAYPOINT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 16. Tabla PASSENGER
-- ============================================
CREATE TABLE PASSENGER (
    person_id         NUMBER CONSTRAINT pk_PASSENGER PRIMARY KEY,  -- shared primary key con PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ADMIN_PERSON
        FOREIGN KEY (person_id)
        REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 17. Tabla DRIVER
-- ============================================
CREATE TABLE DRIVER (
    person_id         NUMBER CONSTRAINT pk_DRIVER PRIMARY KEY,  -- shared primary key con PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ADM_PERSON
        FOREIGN KEY (person_id)
        REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 18. Tabla PASSENGERXWAYPOINT (relacion entre passenger y waypoint)
-- ============================================
CREATE TABLE PASSENGERXWAYPOINT (
    passenger_id      NUMBER NOT NULL,
    waypoint_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT pk_passenger_x_waypoint PRIMARY KEY (passenger_id, waypoint_id),
    CONSTRAINT fk_WAYPXPASSENGER_PASSENGER
        FOREIGN KEY (passenger_id) REFERENCES PASSENGER(person_id),
    CONSTRAINT fk_WAYPXPASSENGER_WAYP
       FOREIGN KEY (waypoint_id)  REFERENCES WAYPOINT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 19. Tabla VEHICLEXROUTE (relacion entre passenger y waypoint)
-- ============================================
CREATE TABLE VEHICLEXROUTE (
    id                NUMBER CONSTRAINT pk_VEHICLEXROUTE PRIMARY KEY,
    vehicle_id      NUMBER NOT NULL,
    route_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_VEHICLEXROUTE_VEHICLE
        FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_VEHICLEXROUTE_ROUTE
       FOREIGN KEY (route_id)  REFERENCES ROUTE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 20. Tabla DRIVERXVEHICLE (relacion entre passenger y waypoint)
-- ============================================
CREATE TABLE DRIVERXVEHICLE (
    id                NUMBER CONSTRAINT pk_DRIVERXVEHICLE PRIMARY KEY,
    vehicle_id      NUMBER NOT NULL,
    driver_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_DRIVERXVEHICLE_VEHICLE
        FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_DRIVERXVEHICLE_DRIVER
       FOREIGN KEY (driver_id)  REFERENCES DRIVER(person_id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 21. Tabla MAXCAPACITYXVEHICLE (relacion entre passenger y waypoint)
-- ============================================
CREATE TABLE MAXCAPACITYXVEHICLE (
    id                NUMBER CONSTRAINT pk_MAXCAPACITYXVEHICLE PRIMARY KEY,
    max_capacity_id      NUMBER NOT NULL,
    vehicle_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_MAXCAPACITYXVEHICLE_VEHICLE
        FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_MAXCAPACITYXVEHICLE_DRIVER
       FOREIGN KEY (max_capacity_id)  REFERENCES ADM.MAXCAPACITY(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 22. Tabla PASSENGERXTRIP (relacion entre passenger y waypoint)
-- ============================================
CREATE TABLE PASSENGERXTRIP (
    id                NUMBER CONSTRAINT pk_PASSENGERXTRIP PRIMARY KEY,
    passenger_id      NUMBER NOT NULL,
    trip_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    amount NUMBER NOT NULL,
    CONSTRAINT fk_PASSENGERXTRIP_PASSENGER
        FOREIGN KEY (passenger_id) REFERENCES PASSENGER(person_id),
    CONSTRAINT fk_PASSENGERXTRIP_TRIP
       FOREIGN KEY (trip_id)  REFERENCES TRIP(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- 23. Tabla PASSENGERXTRIPXPAYMENT (relacion entre passenger y waypoint)
-- ============================================
CREATE TABLE PASSENGERXTRIPXPAYMENT (
    id                NUMBER CONSTRAINT pk_PASSENGERXTRIPXPAYMENT PRIMARY KEY,
    passenger_x_trip_id      NUMBER NOT NULL,
    payment_method_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_PASSXTRIPXPAY_PASSXTRIP
        FOREIGN KEY (passenger_x_trip_id) REFERENCES PASSENGERXTRIP(id),
    CONSTRAINT fk_PASSXTRIPXPAY_PAY
       FOREIGN KEY (payment_method_id)  REFERENCES ADM.PAYMENTMETHOD(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

-- ============================================
-- GRANTS para las tablas del esquema ADM
-- ============================================
GRANT ALL PRIVILEGES ON VEHICLEXROUTE TO ADM;
