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
    creation_user     VARCHAR2(50),
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
COMMENT ON COLUMN ADM.GENDER.creation_user IS 'User who created the record';
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
-- 11. LOGS Table
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
-- 12. PARAMETER Table
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
-- 13. PERSON Table (Master)
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
    creation_user            VARCHAR2(50),
    modification_date        DATE,
    modification_user        VARCHAR2(50),
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
COMMENT ON COLUMN ADM.PERSON.creation_user IS 'User who created the record';
COMMENT ON COLUMN ADM.PERSON.modification_date IS 'Record modification date';
COMMENT ON COLUMN ADM.PERSON.modification_user IS 'User who modified the record';
COMMENT ON COLUMN ADM.PERSON.gender_id IS 'Foreign key to GENDER table';
COMMENT ON COLUMN ADM.PERSON.type_identification_id IS 'Foreign key to TYPE_IDENTIFICATION table';

-- ============================================
-- 14. ADMIN Table (Inherits from PERSON via shared key)
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
-- 15. PAYMENTMETHOD Table
-- ============================================
CREATE TABLE ADM.PAYMENTMETHOD (
    id                NUMBER CONSTRAINT pk_PAYMENTMETHOD PRIMARY KEY,
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

-- ============================================
-- PU Tables Creation
-- ============================================

-- ============================================
-- 1. PHOTO Table (Dependent on PERSON)
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
-- 2. PHONE Table (Dependent on PERSON and TYPE_PHONE)
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
    
    -- FK to PERSON
    person_id         NUMBER CONSTRAINT phone_person_id_nn NOT NULL,
    CONSTRAINT fk_PHONE_PERSON
        FOREIGN KEY (person_id) REFERENCES ADM.PERSON(id),
    
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
COMMENT ON COLUMN PU.PHONE.person_id IS 'Foreign key to PERSON table';
COMMENT ON COLUMN PU.PHONE.type_phone_id IS 'Foreign key to TYPE_PHONE table';

-- ============================================
-- 4. EMAIL Table (Dependent on PERSON)
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