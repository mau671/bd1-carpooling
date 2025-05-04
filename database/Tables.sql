-- =====================================================================
-- ADM and PU Schema Tables Creation Script
-- This script creates all necessary tables for the transportation system
-- with appropriate documentation and schema prefixes for clarity
-- =====================================================================

-- ============================================
-- 1. GENDER Table (Master)
-- ============================================
CREATE TABLE ADM.GENDER (
    id                NUMBER CONSTRAINT pk_GENDER PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(50) CONSTRAINT gender_name_nn NOT NULL,
    creator     VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.GENDER IS 'Master table that stores different genders';
COMMENT ON COLUMN ADM.GENDER.id IS 'Unique identifier for gender';
COMMENT ON COLUMN ADM.GENDER.name IS 'Gender name';
COMMENT ON COLUMN ADM.GENDER.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.GENDER.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.GENDER.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.GENDER.modification_date IS 'Record modification date';

-- ============================================
-- 2. TYPE_IDENTIFICATION Table (Master)
-- ============================================
CREATE TABLE ADM.TYPE_IDENTIFICATION (
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

COMMENT ON TABLE ADM.TYPE_IDENTIFICATION IS 'Master table that stores identification types';
COMMENT ON COLUMN ADM.TYPE_IDENTIFICATION.id IS 'Unique identifier for identification type';
COMMENT ON COLUMN ADM.TYPE_IDENTIFICATION.name IS 'Identification type name';
COMMENT ON COLUMN ADM.TYPE_IDENTIFICATION.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.TYPE_IDENTIFICATION.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.TYPE_IDENTIFICATION.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.TYPE_IDENTIFICATION.modification_date IS 'Record modification date';

-- ============================================
-- 3. TYPE_PHONE Table (Master)
-- ============================================
CREATE TABLE ADM.TYPE_PHONE (
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

COMMENT ON TABLE ADM.TYPE_PHONE IS 'Master table that stores phone types';
COMMENT ON COLUMN ADM.TYPE_PHONE.id IS 'Unique identifier for phone type';
COMMENT ON COLUMN ADM.TYPE_PHONE.name IS 'Phone type name';
COMMENT ON COLUMN ADM.TYPE_PHONE.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.TYPE_PHONE.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.TYPE_PHONE.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.TYPE_PHONE.modification_date IS 'Record modification date';

-- ============================================
-- 4. COUNTRY Table
-- ============================================
CREATE TABLE ADM.COUNTRY (
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

COMMENT ON TABLE ADM.COUNTRY IS 'Table that stores countries';
COMMENT ON COLUMN ADM.COUNTRY.id IS 'Unique identifier for country';
COMMENT ON COLUMN ADM.COUNTRY.name IS 'Country name';
COMMENT ON COLUMN ADM.COUNTRY.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.COUNTRY.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.COUNTRY.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.COUNTRY.modification_date IS 'Record modification date';

-- ============================================
-- 5. PROVINCE Table
-- ============================================
CREATE TABLE ADM.PROVINCE (
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
        REFERENCES ADM.COUNTRY(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.PROVINCE IS 'Table that stores provinces';
COMMENT ON COLUMN ADM.PROVINCE.id IS 'Unique identifier for province';
COMMENT ON COLUMN ADM.PROVINCE.country_id IS 'Identifier of the country to which the province belongs';
COMMENT ON COLUMN ADM.PROVINCE.name IS 'Province name';
COMMENT ON COLUMN ADM.PROVINCE.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.PROVINCE.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.PROVINCE.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.PROVINCE.modification_date IS 'Record modification date';

-- ============================================
-- 6. CANTON Table
-- ============================================
CREATE TABLE ADM.CANTON (
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
        REFERENCES ADM.PROVINCE(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.CANTON IS 'Table that stores cantons';
COMMENT ON COLUMN ADM.CANTON.id IS 'Unique identifier for canton';
COMMENT ON COLUMN ADM.CANTON.province_id IS 'Identifier of the province to which the canton belongs';
COMMENT ON COLUMN ADM.CANTON.name IS 'Canton name';
COMMENT ON COLUMN ADM.CANTON.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.CANTON.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.CANTON.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.CANTON.modification_date IS 'Record modification date';

-- ============================================
-- 7. DISTRICT Table
-- ============================================
CREATE TABLE ADM.DISTRICT (
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
        REFERENCES ADM.CANTON(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.DISTRICT IS 'Table that stores districts';
COMMENT ON COLUMN ADM.DISTRICT.id IS 'Unique identifier for district';
COMMENT ON COLUMN ADM.DISTRICT.canton_id IS 'Identifier of the canton to which the district belongs';
COMMENT ON COLUMN ADM.DISTRICT.name IS 'District name';
COMMENT ON COLUMN ADM.DISTRICT.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.DISTRICT.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.DISTRICT.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.DISTRICT.modification_date IS 'Record modification date';

-- ============================================
-- 8. STATUS Table
-- ============================================
CREATE TABLE ADM.STATUS (
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

COMMENT ON TABLE ADM.STATUS IS 'Table that stores different statuses';
COMMENT ON COLUMN ADM.STATUS.id IS 'Unique identifier for status';
COMMENT ON COLUMN ADM.STATUS.name IS 'Status name';
COMMENT ON COLUMN ADM.STATUS.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.STATUS.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.STATUS.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.STATUS.modification_date IS 'Record modification date';

-- ============================================
-- 9. MAXCAPACITY Table
-- ============================================
CREATE TABLE ADM.MAXCAPACITY (
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

COMMENT ON TABLE ADM.MAXCAPACITY IS 'Table that stores maximum capacities';
COMMENT ON COLUMN ADM.MAXCAPACITY.id IS 'Unique identifier for maximum capacity';
COMMENT ON COLUMN ADM.MAXCAPACITY.capacity_number IS 'Maximum capacity number';
COMMENT ON COLUMN ADM.MAXCAPACITY.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.MAXCAPACITY.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.MAXCAPACITY.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.MAXCAPACITY.modification_date IS 'Record modification date';

-- ============================================
-- 10. LOGS Table
-- ============================================
CREATE TABLE ADM.LOGS (
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
    log_date          DATE
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.LOGS IS 'Table that stores system event logs';
COMMENT ON COLUMN ADM.LOGS.id IS 'Unique identifier for log';
COMMENT ON COLUMN ADM.LOGS.description IS 'Description of the recorded event';
COMMENT ON COLUMN ADM.LOGS.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.LOGS.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.LOGS.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.LOGS.modification_date IS 'Record modification date';
COMMENT ON COLUMN ADM.LOGS.log_date IS 'Date when the recorded event occurred';

-- ============================================
-- 11. PARAMETER Table
-- ============================================
CREATE TABLE ADM.PARAMETER (
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

COMMENT ON TABLE ADM.PARAMETER IS 'Table that stores system configuration parameters';
COMMENT ON COLUMN ADM.PARAMETER.id IS 'Unique identifier for parameter';
COMMENT ON COLUMN ADM.PARAMETER.name IS 'Parameter name';
COMMENT ON COLUMN ADM.PARAMETER.value IS 'Numeric value of the parameter';

-- ============================================
-- 12. PERSON Table (Master)
-- ============================================
CREATE TABLE ADM.PERSON (
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
    creator            VARCHAR2(50),
    modification_date        DATE,
    modifier        VARCHAR2(50),
    gender_id                NUMBER CONSTRAINT person_gender_id_nn NOT NULL,
    type_identification_id   NUMBER CONSTRAINT person_type_id_nn NOT NULL,

    CONSTRAINT fk_PERSON_GENDER
        FOREIGN KEY (gender_id) 
        REFERENCES ADM.GENDER(id),

    CONSTRAINT fk_PERSON_TYPE_IDENTIFICATION
        FOREIGN KEY (type_identification_id) 
        REFERENCES ADM.TYPE_IDENTIFICATION(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.PERSON IS 'Master table that stores all person information';
COMMENT ON COLUMN ADM.PERSON.id IS 'Unique identifier for person';
COMMENT ON COLUMN ADM.PERSON.first_name IS 'Person first name';
COMMENT ON COLUMN ADM.PERSON.second_name IS 'Person second name';
COMMENT ON COLUMN ADM.PERSON.first_surname IS 'Person first surname';
COMMENT ON COLUMN ADM.PERSON.second_surname IS 'Person second surname';
COMMENT ON COLUMN ADM.PERSON.identification_number IS 'Person identification number';
COMMENT ON COLUMN ADM.PERSON.date_of_birth IS 'Person date of birth';
COMMENT ON COLUMN ADM.PERSON.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.PERSON.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.PERSON.modification_date IS 'Record modification date';
COMMENT ON COLUMN ADM.PERSON.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.PERSON.gender_id IS 'Foreign key to GENDER table';
COMMENT ON COLUMN ADM.PERSON.type_identification_id IS 'Foreign key to TYPE_IDENTIFICATION table';

-- ============================================
-- 13. ADMIN Table (Inherits from PERSON via shared key)
-- ============================================
CREATE TABLE ADM.ADMIN (
    person_id         NUMBER CONSTRAINT pk_ADMIN PRIMARY KEY,  -- shared primary key with PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_ADMIN_PERSON
        FOREIGN KEY (person_id)
        REFERENCES ADM.PERSON(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.ADMIN IS 'Table that stores system administrators';
COMMENT ON COLUMN ADM.ADMIN.person_id IS 'Primary key and foreign key to PERSON table';
COMMENT ON COLUMN ADM.ADMIN.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.ADMIN.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.ADMIN.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.ADMIN.modification_date IS 'Record modification date';

-- ============================================
-- 14. PAYMENTMETHOD Table
-- ============================================
CREATE TABLE ADM.PAYMENTMETHOD (
    id                NUMBER CONSTRAINT pk_PAYMENTMETHOD PRIMARY KEY
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

COMMENT ON TABLE ADM.PAYMENTMETHOD IS 'Table that stores payment methods';
COMMENT ON COLUMN ADM.PAYMENTMETHOD.id IS 'Unique identifier for payment method';
COMMENT ON COLUMN ADM.PAYMENTMETHOD.name IS 'Payment method name';
COMMENT ON COLUMN ADM.PAYMENTMETHOD.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.PAYMENTMETHOD.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.PAYMENTMETHOD.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.PAYMENTMETHOD.modification_date IS 'Record modification date';

GRANT SELECT, REFERENCES ON ADM.GENDER              TO PU;
GRANT SELECT, REFERENCES ON ADM.TYPE_IDENTIFICATION TO PU;
GRANT SELECT, REFERENCES ON ADM.TYPE_PHONE          TO PU;
GRANT SELECT, REFERENCES ON ADM.COUNTRY             TO PU;
GRANT SELECT, REFERENCES ON ADM.PROVINCE            TO PU;
GRANT SELECT, REFERENCES ON ADM.CANTON              TO PU;
GRANT SELECT, REFERENCES ON ADM.DISTRICT            TO PU;
GRANT SELECT, REFERENCES ON ADM.STATUS              TO PU;
GRANT SELECT, REFERENCES ON ADM.MAXCAPACITY         TO PU;
GRANT SELECT, REFERENCES ON ADM.PERSON              TO PU;
GRANT SELECT, REFERENCES ON ADM.PAYMENTMETHOD       TO PU;


-- ============================================
-- PU Tables Creation
-- ============================================

-- ============================================
-- 15. PHOTO Table (Dependent on PERSON)
-- ============================================
CREATE TABLE PU.PHOTO (
    id                NUMBER CONSTRAINT pk_PHOTO PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    image             BLOB,  -- BLOB to store binary image data; use VARCHAR2 if only storing path
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

COMMENT ON TABLE PU.PHOTO IS 'Table that stores person photos';
COMMENT ON COLUMN PU.PHOTO.id IS 'Unique identifier for photo';
COMMENT ON COLUMN PU.PHOTO.image IS 'Binary image data';
COMMENT ON COLUMN PU.PHOTO.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PHOTO.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PHOTO.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PHOTO.modification_date IS 'Record modification date';
COMMENT ON COLUMN PU.PHOTO.person_id IS 'Foreign key to PERSON table';

-- ============================================
-- 16. PHONE Table (Dependent on PERSON and TYPE_PHONE)
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
    
    -- FK to TYPE_PHONE
    type_phone_id     NUMBER CONSTRAINT phone_type_phone_id_nn NOT NULL,
    CONSTRAINT fk_PHONE_TYPE_PHONE
        FOREIGN KEY (type_phone_id) REFERENCES ADM.TYPE_PHONE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.PHONE IS 'Table that stores person phone numbers';
COMMENT ON COLUMN PU.PHONE.id IS 'Unique identifier for phone';
COMMENT ON COLUMN PU.PHONE.phone_number IS 'Phone number';
COMMENT ON COLUMN PU.PHONE.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PHONE.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PHONE.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PHONE.modification_date IS 'Record modification date';
COMMENT ON COLUMN PU.PHONE.type_phone_id IS 'Foreign key to TYPE_PHONE table';

-- ============================================
-- 17. EMAIL Table (Dependent on PERSON)
-- ============================================
CREATE TABLE PU.EMAIL (
    id                NUMBER CONSTRAINT pk_EMAIL PRIMARY KEY
                         USING INDEX TABLESPACE PU_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    name              VARCHAR2(100) NOT NULL,  -- Email address
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

COMMENT ON TABLE PU.EMAIL IS 'Table that stores person email addresses';
COMMENT ON COLUMN PU.EMAIL.id IS 'Unique identifier for email';
COMMENT ON COLUMN PU.EMAIL.name IS 'Email address';
COMMENT ON COLUMN PU.EMAIL.creator IS 'User who created the record';
COMMENT ON COLUMN PU.EMAIL.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.EMAIL.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.EMAIL.modification_date IS 'Record modification date';
COMMENT ON COLUMN PU.EMAIL.person_id IS 'Foreign key to PERSON table';

-- ============================================
-- 18. INSTITUTION Table (Master)
-- ============================================
CREATE TABLE ADM.INSTITUTION (
    id                NUMBER CONSTRAINT pk_INSTITUTION PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.INSTITUTION IS 'Master table that stores institutions';
COMMENT ON COLUMN ADM.INSTITUTION.id IS 'Unique identifier for institution';
COMMENT ON COLUMN ADM.INSTITUTION.name IS 'Institution name';
COMMENT ON COLUMN ADM.INSTITUTION.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.INSTITUTION.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.INSTITUTION.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.INSTITUTION.modification_date IS 'Record modification date';

-- ============================================
-- 19. DOMAIN Table (Master)
-- ============================================
CREATE TABLE ADM.DOMAIN (
    id                NUMBER CONSTRAINT pk_DOMAIN PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
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
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.DOMAIN IS 'Master table that stores domains';
COMMENT ON COLUMN ADM.DOMAIN.id IS 'Unique identifier for domain';
COMMENT ON COLUMN ADM.DOMAIN.name IS 'Domain name';
COMMENT ON COLUMN ADM.DOMAIN.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.DOMAIN.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.DOMAIN.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.DOMAIN.modification_date IS 'Record modification date';

GRANT SELECT, REFERENCES ON ADM.INSTITUTION         TO PU;
GRANT SELECT, REFERENCES ON ADM.DOMAIN              TO PU;

-- ============================================
-- 20. VEHICLE Table
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

COMMENT ON TABLE PU.VEHICLE IS 'Table that stores vehicles';
COMMENT ON COLUMN PU.VEHICLE.id IS 'Unique identifier for vehicle';
COMMENT ON COLUMN PU.VEHICLE.plate IS 'Vehicle license plate';
COMMENT ON COLUMN PU.VEHICLE.creator IS 'User who created the record';
COMMENT ON COLUMN PU.VEHICLE.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.VEHICLE.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.VEHICLE.modification_date IS 'Record modification date';

-- ============================================
-- 21. WAYPOINT Table (renamed from STOP)
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
        REFERENCES ADM.DISTRICT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.WAYPOINT IS 'Table that stores waypoints/stops';
COMMENT ON COLUMN PU.WAYPOINT.id IS 'Unique identifier for waypoint';
COMMENT ON COLUMN PU.WAYPOINT.district_id IS 'Foreign key to DISTRICT table';
COMMENT ON COLUMN PU.WAYPOINT.latitude IS 'Waypoint latitude coordinate';
COMMENT ON COLUMN PU.WAYPOINT.longitude IS 'Waypoint longitude coordinate';
COMMENT ON COLUMN PU.WAYPOINT.creator IS 'User who created the record';
COMMENT ON COLUMN PU.WAYPOINT.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.WAYPOINT.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.WAYPOINT.modification_date IS 'Record modification date';

-- ============================================
-- 22. PHONE_PERSON Table (Relationship between PERSON and PHONE)
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
       FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id),
    
    CONSTRAINT fk_PHONE_PERSON_PHONE
       FOREIGN KEY (phone_id)  REFERENCES PU.PHONE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.PHONE_PERSON IS 'Relationship table between PERSON and PHONE';
COMMENT ON COLUMN PU.PHONE_PERSON.person_id IS 'Foreign key to PERSON table';
COMMENT ON COLUMN PU.PHONE_PERSON.phone_id IS 'Foreign key to PHONE table';
COMMENT ON COLUMN PU.PHONE_PERSON.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PHONE_PERSON.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PHONE_PERSON.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PHONE_PERSON.modification_date IS 'Record modification date';

-- ============================================
-- 23. INSTITUTION_PERSON Table (Relationship between INSTITUTION and PERSON)
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
       FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.INSTITUTION_PERSON IS 'Relationship table between INSTITUTION and PERSON';
COMMENT ON COLUMN PU.INSTITUTION_PERSON.institution_id IS 'Foreign key to INSTITUTION table';
COMMENT ON COLUMN PU.INSTITUTION_PERSON.person_id IS 'Foreign key to PERSON table';
COMMENT ON COLUMN PU.INSTITUTION_PERSON.creator IS 'User who created the record';
COMMENT ON COLUMN PU.INSTITUTION_PERSON.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.INSTITUTION_PERSON.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.INSTITUTION_PERSON.modification_date IS 'Record modification date';

-- ============================================
-- 24. INSTITUTION_DOMAIN Table (Relationship between INSTITUTION and DOMAIN)
-- ============================================
CREATE TABLE ADM.INSTITUTION_DOMAIN (
    institution_id    NUMBER NOT NULL,
    domain_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT pk_INSTITUTION_DOMAIN PRIMARY KEY (institution_id, domain_id),
    
    CONSTRAINT fk_INSTITUTION_DOM_INSTITUTION
       FOREIGN KEY (institution_id) REFERENCES ADM.INSTITUTION(id),
    
    CONSTRAINT fk_INSTITUTION_DOM_DOM
       FOREIGN KEY (domain_id) REFERENCES ADM.DOMAIN(id)
)
TABLESPACE ADM_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.INSTITUTION_DOMAIN IS 'Relationship table between INSTITUTION and DOMAIN';
COMMENT ON COLUMN ADM.INSTITUTION_DOMAIN.institution_id IS 'Foreign key to INSTITUTION table';
COMMENT ON COLUMN ADM.INSTITUTION_DOMAIN.domain_id IS 'Foreign key to DOMAIN table';
COMMENT ON COLUMN ADM.INSTITUTION_DOMAIN.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.INSTITUTION_DOMAIN.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.INSTITUTION_DOMAIN.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.INSTITUTION_DOMAIN.modification_date IS 'Record modification date';

GRANT SELECT             ON ADM.INSTITUTION_DOMAIN  TO PU;

-- ============================================
-- 25. PERSONUSER Table (renamed from USER)
-- ============================================
CREATE TABLE PU.PERSONUSER (
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

COMMENT ON TABLE PU.PERSONUSER IS 'Table that stores system users';
COMMENT ON COLUMN PU.PERSONUSER.id IS 'Unique identifier for user';
COMMENT ON COLUMN PU.PERSONUSER.username IS 'User username';
COMMENT ON COLUMN PU.PERSONUSER.password IS 'User password';
COMMENT ON COLUMN PU.PERSONUSER.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PERSONUSER.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PERSONUSER.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PERSONUSER.modification_date IS 'Record modification date';
COMMENT ON COLUMN PU.PERSONUSER.person_id IS 'Foreign key to PERSON table';

--------------------------------------------------------------------------------
--  E)  Routes and vehicle-route association
--------------------------------------------------------------------------------

-- ============================================
-- 26. ROUTE Table
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

COMMENT ON TABLE PU.ROUTE IS 'Table that stores routes';
COMMENT ON COLUMN PU.ROUTE.id IS 'Unique identifier for route';
COMMENT ON COLUMN PU.ROUTE.waypoint_id IS 'Foreign key to WAYPOINT table';
COMMENT ON COLUMN PU.ROUTE.start_time IS 'Route start time';
COMMENT ON COLUMN PU.ROUTE.end_time IS 'Route end time';
COMMENT ON COLUMN PU.ROUTE.programming_date IS 'Date when the route was programmed';
COMMENT ON COLUMN PU.ROUTE.creator IS 'User who created the record';
COMMENT ON COLUMN PU.ROUTE.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.ROUTE.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.ROUTE.modification_date IS 'Record modification date';

-- ============================================
-- 27. VEHICLEXROUTE Table (Relationship between VEHICLE and ROUTE)
-- ============================================
CREATE TABLE PU.VEHICLEXROUTE (
    id                NUMBER CONSTRAINT pk_VEHICLEXROUTE PRIMARY KEY,
    vehicle_id        NUMBER NOT NULL,
    route_id          NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_VEHICLEXROUTE_VEHICLE
        FOREIGN KEY (vehicle_id) REFERENCES PU.VEHICLE(id),
    CONSTRAINT fk_VEHICLEXROUTE_ROUTE
       FOREIGN KEY (route_id)  REFERENCES PU.ROUTE(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.VEHICLEXROUTE IS 'Relationship table between VEHICLE and ROUTE';
COMMENT ON COLUMN PU.VEHICLEXROUTE.id IS 'Unique identifier for vehicle-route relationship';
COMMENT ON COLUMN PU.VEHICLEXROUTE.vehicle_id IS 'Foreign key to VEHICLE table';
COMMENT ON COLUMN PU.VEHICLEXROUTE.route_id IS 'Foreign key to ROUTE table';
COMMENT ON COLUMN PU.VEHICLEXROUTE.creator IS 'User who created the record';
COMMENT ON COLUMN PU.VEHICLEXROUTE.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.VEHICLEXROUTE.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.VEHICLEXROUTE.modification_date IS 'Record modification date';

GRANT REFERENCES ON PU.VEHICLEXROUTE TO ADM;

--------------------------------------------------------------------------------
--  F)  Trips and statuses
--------------------------------------------------------------------------------

-- ============================================
-- 28. TRIP Table (Related to VEHICLE and ROUTE)
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

COMMENT ON TABLE PU.TRIP IS 'Table that stores trips';
COMMENT ON COLUMN PU.TRIP.id IS 'Unique identifier for trip';
COMMENT ON COLUMN PU.TRIP.vehicle_id IS 'Foreign key to VEHICLE table';
COMMENT ON COLUMN PU.TRIP.route_id IS 'Foreign key to ROUTE table';
COMMENT ON COLUMN PU.TRIP.creator IS 'User who created the record';
COMMENT ON COLUMN PU.TRIP.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.TRIP.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.TRIP.modification_date IS 'Record modification date';

-- ============================================
-- 29. STATUSXTRIP Table (Relationship between TRIP and STATUS)
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
       FOREIGN KEY (status_id)  REFERENCES ADM.STATUS(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.STATUSXTRIP IS 'Relationship table between TRIP and STATUS';
COMMENT ON COLUMN PU.STATUSXTRIP.trip_id IS 'Foreign key to TRIP table';
COMMENT ON COLUMN PU.STATUSXTRIP.status_id IS 'Foreign key to STATUS table';
COMMENT ON COLUMN PU.STATUSXTRIP.creator IS 'User who created the record';
COMMENT ON COLUMN PU.STATUSXTRIP.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.STATUSXTRIP.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.STATUSXTRIP.modification_date IS 'Record modification date';

-- ============================================
-- 30. WAYPOINTXTRIP Table (Relationship between TRIP and WAYPOINT)
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

COMMENT ON TABLE PU.WAYPOINTXTRIP IS 'Relationship table between TRIP and WAYPOINT';
COMMENT ON COLUMN PU.WAYPOINTXTRIP.trip_id IS 'Foreign key to TRIP table';
COMMENT ON COLUMN PU.WAYPOINTXTRIP.waypoint_id IS 'Foreign key to WAYPOINT table';
COMMENT ON COLUMN PU.WAYPOINTXTRIP.creator IS 'User who created the record';
COMMENT ON COLUMN PU.WAYPOINTXTRIP.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.WAYPOINTXTRIP.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.WAYPOINTXTRIP.modification_date IS 'Record modification date';

--------------------------------------------------------------------------------
--  G)  Passengers and drivers
--------------------------------------------------------------------------------

-- ============================================
-- 31. PASSENGER Table (Inherits from PERSON)
-- ============================================
CREATE TABLE PU.PASSENGER (
    person_id         NUMBER CONSTRAINT pk_PASSENGER PRIMARY KEY,  -- shared primary key with PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_PASSENGER_PERSON
        FOREIGN KEY (person_id)
        REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.PASSENGER IS 'Table that stores passenger information';
COMMENT ON COLUMN PU.PASSENGER.person_id IS 'Primary key and foreign key to PERSON table';
COMMENT ON COLUMN PU.PASSENGER.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PASSENGER.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PASSENGER.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PASSENGER.modification_date IS 'Record modification date';

-- ============================================
-- 32. DRIVER Table (Inherits from PERSON)
-- ============================================
CREATE TABLE PU.DRIVER (
    person_id         NUMBER CONSTRAINT pk_DRIVER PRIMARY KEY,  -- shared primary key with PERSON
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    
    CONSTRAINT fk_DRIVER_PERSON
        FOREIGN KEY (person_id)
        REFERENCES ADM.PERSON(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.DRIVER IS 'Table that stores driver information';
COMMENT ON COLUMN PU.DRIVER.person_id IS 'Primary key and foreign key to PERSON table';
COMMENT ON COLUMN PU.DRIVER.creator IS 'User who created the record';
COMMENT ON COLUMN PU.DRIVER.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.DRIVER.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.DRIVER.modification_date IS 'Record modification date';

--------------------------------------------------------------------------------
--  H)  Final PU associations
--------------------------------------------------------------------------------

-- ============================================
-- 33. PASSENGERXWAYPOINT Table (Relationship between PASSENGER and WAYPOINT)
-- ============================================
CREATE TABLE PU.PASSENGERXWAYPOINT (
    passenger_id      NUMBER NOT NULL,
    waypoint_id       NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT pk_passenger_x_waypoint PRIMARY KEY (passenger_id, waypoint_id),
    CONSTRAINT fk_WAYPXPASSENGER_PASSENGER
        FOREIGN KEY (passenger_id) REFERENCES PU.PASSENGER(person_id),
    CONSTRAINT fk_WAYPXPASSENGER_WAYP
       FOREIGN KEY (waypoint_id)  REFERENCES PU.WAYPOINT(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.PASSENGERXWAYPOINT IS 'Relationship table between PASSENGER and WAYPOINT';
COMMENT ON COLUMN PU.PASSENGERXWAYPOINT.passenger_id IS 'Foreign key to PASSENGER table';
COMMENT ON COLUMN PU.PASSENGERXWAYPOINT.waypoint_id IS 'Foreign key to WAYPOINT table';
COMMENT ON COLUMN PU.PASSENGERXWAYPOINT.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PASSENGERXWAYPOINT.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PASSENGERXWAYPOINT.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PASSENGERXWAYPOINT.modification_date IS 'Record modification date';

-- ============================================
-- 34. DRIVERXVEHICLE Table (Relationship between DRIVER and VEHICLE)
-- ============================================
CREATE TABLE PU.DRIVERXVEHICLE (
    id                NUMBER CONSTRAINT pk_DRIVERXVEHICLE PRIMARY KEY,
    vehicle_id        NUMBER NOT NULL,
    driver_id         NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_DRIVERXVEHICLE_VEHICLE
        FOREIGN KEY (vehicle_id) REFERENCES PU.VEHICLE(id),
    CONSTRAINT fk_DRIVERXVEHICLE_DRIVER
       FOREIGN KEY (driver_id)  REFERENCES PU.DRIVER(person_id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.DRIVERXVEHICLE IS 'Relationship table between DRIVER and VEHICLE';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.id IS 'Unique identifier for driver-vehicle relationship';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.vehicle_id IS 'Foreign key to VEHICLE table';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.driver_id IS 'Foreign key to DRIVER table';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.creator IS 'User who created the record';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.DRIVERXVEHICLE.modification_date IS 'Record modification date';

-- ============================================
-- 35. MAXCAPACITYXVEHICLE Table (Relationship between MAXCAPACITY and VEHICLE)
-- ============================================
CREATE TABLE PU.MAXCAPACITYXVEHICLE (
    id                NUMBER CONSTRAINT pk_MAXCAPACITYXVEHICLE PRIMARY KEY,
    max_capacity_id   NUMBER NOT NULL,
    vehicle_id        NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    CONSTRAINT fk_MAXCAPACITYXVEHICLE_VEHICLE
        FOREIGN KEY (vehicle_id) REFERENCES PU.VEHICLE(id),
    CONSTRAINT fk_MAXCAPACITYXVEHICLE_MAXCAP
       FOREIGN KEY (max_capacity_id)  REFERENCES ADM.MAXCAPACITY(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.MAXCAPACITYXVEHICLE IS 'Relationship table between MAXCAPACITY and VEHICLE';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.id IS 'Unique identifier for max capacity-vehicle relationship';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.max_capacity_id IS 'Foreign key to MAXCAPACITY table';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.vehicle_id IS 'Foreign key to VEHICLE table';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.creator IS 'User who created the record';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.MAXCAPACITYXVEHICLE.modification_date IS 'Record modification date';

-- ============================================
-- 36. PASSENGERXTRIP Table (Relationship between PASSENGER and TRIP)
-- ============================================
CREATE TABLE PU.PASSENGERXTRIP (
    id                NUMBER CONSTRAINT pk_PASSENGERXTRIP PRIMARY KEY,
    passenger_id      NUMBER NOT NULL,
    trip_id           NUMBER NOT NULL,
    creator           VARCHAR2(50),
    creation_date     DATE,
    modifier          VARCHAR2(50),
    modification_date DATE,
    amount            NUMBER NOT NULL,
    CONSTRAINT fk_PASSENGERXTRIP_PASSENGER
        FOREIGN KEY (passenger_id) REFERENCES PU.PASSENGER(person_id),
    CONSTRAINT fk_PASSENGERXTRIP_TRIP
       FOREIGN KEY (trip_id)  REFERENCES PU.TRIP(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.PASSENGERXTRIP IS 'Relationship table between PASSENGER and TRIP';
COMMENT ON COLUMN PU.PASSENGERXTRIP.id IS 'Unique identifier for passenger-trip relationship';
COMMENT ON COLUMN PU.PASSENGERXTRIP.passenger_id IS 'Foreign key to PASSENGER table';
COMMENT ON COLUMN PU.PASSENGERXTRIP.trip_id IS 'Foreign key to TRIP table';
COMMENT ON COLUMN PU.PASSENGERXTRIP.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PASSENGERXTRIP.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PASSENGERXTRIP.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PASSENGERXTRIP.modification_date IS 'Record modification date';
COMMENT ON COLUMN PU.PASSENGERXTRIP.amount IS 'Amount paid for the trip';

--------------------------------------------------------------------------------
--  I)  Payments
--------------------------------------------------------------------------------
-- ============================================
-- 37. PASSENGERXTRIPXPAYMENT Table (Relationship between PASSENGERXTRIP and PAYMENTMETHOD)
-- ============================================
CREATE TABLE PU.PASSENGERXTRIPXPAYMENT (
    id                    NUMBER CONSTRAINT pk_PASSENGERXTRIPXPAYMENT PRIMARY KEY,
    passenger_x_trip_id   NUMBER NOT NULL,
    payment_method_id     NUMBER NOT NULL,
    creator               VARCHAR2(50),
    creation_date         DATE,
    modifier              VARCHAR2(50),
    modification_date     DATE,
    CONSTRAINT fk_PASSXTRIPXPAY_PASSXTRIP
        FOREIGN KEY (passenger_x_trip_id) REFERENCES PU.PASSENGERXTRIP(id),
    CONSTRAINT fk_PASSXTRIPXPAY_PAY
       FOREIGN KEY (payment_method_id)  REFERENCES ADM.PAYMENTMETHOD(id)
)
TABLESPACE PU_Data
STORAGE (
    INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE PU.PASSENGERXTRIPXPAYMENT IS 'Relationship table between PASSENGERXTRIP and PAYMENTMETHOD';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.id IS 'Unique identifier for passenger-trip-payment relationship';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.passenger_x_trip_id IS 'Foreign key to PASSENGERXTRIP table';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.payment_method_id IS 'Foreign key to PAYMENTMETHOD table';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.creator IS 'User who created the record';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.creation_date IS 'Record creation date';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.modifier IS 'User who modified the record';
COMMENT ON COLUMN PU.PASSENGERXTRIPXPAYMENT.modification_date IS 'Record modification date';

--------------------------------------------------------------------------------
--  J)  ADM table dependent on PU
--------------------------------------------------------------------------------
-- ============================================
-- 38. CHOSENCAPACITY Table
-- ============================================
CREATE TABLE ADM.CHOSENCAPACITY (
    id                NUMBER CONSTRAINT pk_CHOSENCAPACITY PRIMARY KEY
                         USING INDEX TABLESPACE ADM_Index
                         STORAGE (
                             INITIAL 10K NEXT 10K MINEXTENTS 1 
                             MAXEXTENTS UNLIMITED PCTINCREASE 0
                         ),
    vehicle_x_route_id NUMBER NOT NULL,
    chosen_number      NUMBER NOT NULL,
    creator            VARCHAR2(50),
    creation_date      DATE,
    modifier           VARCHAR2(50),
    modification_date  DATE,
  
    CONSTRAINT fk_vehicle_x_route
      FOREIGN KEY (vehicle_x_route_id)
      REFERENCES PU.VEHICLEXROUTE(id)
)
TABLESPACE ADM_Data
STORAGE (
  INITIAL 6144 NEXT 6144 MINEXTENTS 1 MAXEXTENTS 5
);

COMMENT ON TABLE ADM.CHOSENCAPACITY IS 'Table that stores chosen capacities for vehicle-route combinations';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.id IS 'Unique identifier for chosen capacity';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.vehicle_x_route_id IS 'Foreign key to VEHICLEXROUTE table';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.chosen_number IS 'Selected capacity number';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.creator IS 'User who created the record';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.creation_date IS 'Record creation date';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.modifier IS 'User who modified the record';
COMMENT ON COLUMN ADM.CHOSENCAPACITY.modification_date IS 'Record modification date';

--------------------------------------------------------------------------------
--  K)  Granting privileges
--------------------------------------------------------------------------------

