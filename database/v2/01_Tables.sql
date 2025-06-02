/*
 * File: 01_Tables.sql
 * Description: MySQL Tables Creation Script
 * MySQL Version: 8.4.5 LTS
 * 
 * This script creates all necessary tables for the carpooling transportation system
 * migrated from Oracle to MySQL with appropriate documentation and database separation.
 * 
 * ===== Database Structure =====
 * ADM Database (carpooling_adm): Master/configuration tables and administrative data
 * PU Database (carpooling_pu): User data and operational tables
 * 
 * ===== Migration Notes =====
 * - Oracle schemas (ADM, PU) → MySQL databases (carpooling_adm, carpooling_pu)
 * - Oracle tablespaces → MySQL ENGINE=InnoDB with utf8mb4 charset
 * - Oracle NUMBER → MySQL INT (for IDs) or DECIMAL (for precision data)
 * - Oracle VARCHAR2 → MySQL VARCHAR
 * - Oracle DATE → MySQL DATE
 * - Oracle TIMESTAMP → MySQL TIMESTAMP
 * - Oracle BLOB → MySQL LONGBLOB
 * - Oracle storage clauses removed (MySQL handles automatically)
 * - Oracle COMMENT ON → MySQL column/table comments in CREATE statements
 * 
 * ===== Execution Order =====
 * 1. Connect to carpooling_adm database for ADM tables
 * 2. Connect to carpooling_pu database for PU tables
 * 3. Foreign keys reference across databases using database.table notation
 */

-- =====================================================================
-- ADM DATABASE TABLES
-- =====================================================================
-- Switch to ADM database for master/configuration tables
USE carpooling_adm;

-- ============================================
-- 1. GENDER Table (Master)
-- ============================================
CREATE TABLE GENDER (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for gender',
    name              VARCHAR(50) NOT NULL COMMENT 'Gender name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_gender_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Master table that stores different genders';

-- ============================================
-- 2. TYPE_IDENTIFICATION Table (Master)
-- ============================================
CREATE TABLE TYPE_IDENTIFICATION (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for identification type',
    name              VARCHAR(50) NOT NULL COMMENT 'Identification type name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_type_identification_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Master table that stores identification types';

-- ============================================
-- 3. TYPE_PHONE Table (Master)
-- ============================================
CREATE TABLE TYPE_PHONE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for phone type',
    name              VARCHAR(50) NOT NULL COMMENT 'Phone type name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_type_phone_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Master table that stores phone types';

-- ============================================
-- 4. COUNTRY Table
-- ============================================
CREATE TABLE COUNTRY (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for country',
    name              VARCHAR(50) NOT NULL COMMENT 'Country name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_country_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores countries';

-- ============================================
-- 5. PROVINCE Table
-- ============================================
CREATE TABLE PROVINCE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for province',
    country_id        INT NOT NULL COMMENT 'Identifier of the country to which the province belongs',
    name              VARCHAR(50) NOT NULL COMMENT 'Province name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_province_country FOREIGN KEY (country_id) REFERENCES COUNTRY(id),
    INDEX idx_province_country (country_id),
    INDEX idx_province_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores provinces';

-- ============================================
-- 6. CANTON Table
-- ============================================
CREATE TABLE CANTON (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for canton',
    province_id       INT NOT NULL COMMENT 'Identifier of the province to which the canton belongs',
    name              VARCHAR(50) NOT NULL COMMENT 'Canton name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_canton_province FOREIGN KEY (province_id) REFERENCES PROVINCE(id),
    INDEX idx_canton_province (province_id),
    INDEX idx_canton_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores cantons';

-- ============================================
-- 7. DISTRICT Table
-- ============================================
CREATE TABLE DISTRICT (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for district',
    canton_id         INT NOT NULL COMMENT 'Identifier of the canton to which the district belongs',
    name              VARCHAR(50) NOT NULL COMMENT 'District name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_district_canton FOREIGN KEY (canton_id) REFERENCES CANTON(id),
    INDEX idx_district_canton (canton_id),
    INDEX idx_district_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores districts';

-- ============================================
-- 8. STATUS Table
-- ============================================
CREATE TABLE STATUS (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for status',
    name              VARCHAR(50) NOT NULL COMMENT 'Status name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_status_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores different statuses';

-- ============================================
-- 9. MAXCAPACITY Table
-- ============================================
CREATE TABLE MAXCAPACITY (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for maximum capacity',
    capacity_number   INT COMMENT 'Maximum capacity number',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_maxcapacity_number (capacity_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores maximum capacities';

-- ============================================
-- 10. LOGS Table
-- ============================================
CREATE TABLE LOGS (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for log',
    schema_name       VARCHAR(10) COMMENT 'Name of the database schema',
    table_name        VARCHAR(30) COMMENT 'Name of the table where the change occurred',
    field_name        VARCHAR(30) COMMENT 'Name of the field that was modified',
    previous_value    VARCHAR(100) COMMENT 'Previous value before the change',
    current_value     VARCHAR(100) COMMENT 'Current value after the change',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_logs_schema_table (schema_name, table_name),
    INDEX idx_logs_creation (creation_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores system event logs';

-- ============================================
-- 11. PARAMETER Table
-- ============================================
CREATE TABLE PARAMETER (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for parameter',
    name              VARCHAR(50) NOT NULL COMMENT 'Parameter name',
    value             VARCHAR(50) NOT NULL COMMENT 'Value of the parameter',
    
    UNIQUE KEY uk_parameter_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores system configuration parameters';

-- ============================================
-- 12. PERSON Table (Master)
-- ============================================
CREATE TABLE PERSON (
    id                       INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for person',
    first_name               VARCHAR(50) NOT NULL COMMENT 'Person first name',
    second_name              VARCHAR(50) COMMENT 'Person second name',
    first_surname            VARCHAR(50) NOT NULL COMMENT 'Person first surname',
    second_surname           VARCHAR(50) COMMENT 'Person second surname',
    identification_number    VARCHAR(50) NOT NULL COMMENT 'Person identification number',
    date_of_birth            DATE NOT NULL COMMENT 'Person date of birth',
    creation_date            DATE COMMENT 'Record creation date',
    creator                  VARCHAR(50) COMMENT 'User who created the record',
    modification_date        DATE COMMENT 'Record modification date',
    modifier                 VARCHAR(50) COMMENT 'User who modified the record',
    gender_id                INT NOT NULL COMMENT 'Foreign key to GENDER table',
    type_identification_id   INT NOT NULL COMMENT 'Foreign key to TYPE_IDENTIFICATION table',

    CONSTRAINT fk_person_gender FOREIGN KEY (gender_id) REFERENCES GENDER(id),
    CONSTRAINT fk_person_type_identification FOREIGN KEY (type_identification_id) REFERENCES TYPE_IDENTIFICATION(id),
    
    UNIQUE KEY uk_person_identification (identification_number),
    INDEX idx_person_gender (gender_id),
    INDEX idx_person_type_id (type_identification_id),
    INDEX idx_person_names (first_name, first_surname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Master table that stores all person information';

-- ============================================
-- 13. ADMIN Table (Inherits from PERSON via shared key)
-- ============================================
CREATE TABLE ADMIN (
    person_id         INT PRIMARY KEY COMMENT 'Primary key and foreign key to PERSON table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_admin_person FOREIGN KEY (person_id) REFERENCES PERSON(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores system administrators';

-- ============================================
-- 14. PAYMENTMETHOD Table
-- ============================================
CREATE TABLE PAYMENTMETHOD (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for payment method',
    name              VARCHAR(50) NOT NULL COMMENT 'Payment method name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_paymentmethod_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores payment methods';

-- ============================================
-- 15. CURRENCY Table
-- ============================================
CREATE TABLE CURRENCY (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for currency',
    name              VARCHAR(50) NOT NULL COMMENT 'Currency name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_currency_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores currency in which to pay';

-- ============================================
-- 18. INSTITUTION Table (Master)
-- ============================================
CREATE TABLE INSTITUTION (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for institution',
    name              VARCHAR(100) NOT NULL COMMENT 'Institution name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_institution_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Master table that stores institutions';

-- ============================================
-- 19. DOMAIN Table (Master)
-- ============================================
CREATE TABLE DOMAIN (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for domain',
    name              VARCHAR(100) NOT NULL COMMENT 'Domain name',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_domain_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Master table that stores domains';

-- ============================================
-- 24. INSTITUTION_DOMAIN Table (Relationship between INSTITUTION and DOMAIN)
-- ============================================
CREATE TABLE INSTITUTION_DOMAIN (
    institution_id    INT NOT NULL COMMENT 'Foreign key to INSTITUTION table',
    domain_id         INT NOT NULL COMMENT 'Foreign key to DOMAIN table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    PRIMARY KEY (institution_id, domain_id),
    CONSTRAINT fk_institution_dom_institution FOREIGN KEY (institution_id) REFERENCES INSTITUTION(id),
    CONSTRAINT fk_institution_dom_domain FOREIGN KEY (domain_id) REFERENCES DOMAIN(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between INSTITUTION and DOMAIN';

-- =====================================================================
-- PU DATABASE TABLES  
-- =====================================================================
-- Switch to PU database for user data and operational tables
USE carpooling_pu;

-- ============================================
-- 16. PHOTO Table (Dependent on PERSON)
-- ============================================
CREATE TABLE PHOTO (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for photo',
    image             LONGBLOB COMMENT 'Binary image data',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    person_id         INT NOT NULL COMMENT 'Foreign key to PERSON table',

    CONSTRAINT fk_photo_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id),
    INDEX idx_photo_person (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores person photos';

-- ============================================
-- 17. PHONE Table (Dependent on PERSON and TYPE_PHONE)
-- ============================================
CREATE TABLE PHONE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for phone',
    phone_number      VARCHAR(20) NOT NULL COMMENT 'Phone number',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    type_phone_id     INT NOT NULL COMMENT 'Foreign key to TYPE_PHONE table',
    
    CONSTRAINT fk_phone_type_phone FOREIGN KEY (type_phone_id) REFERENCES carpooling_adm.TYPE_PHONE(id),
    INDEX idx_phone_type (type_phone_id),
    INDEX idx_phone_number (phone_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores person phone numbers';

-- ============================================
-- 20. EMAIL Table (Dependent on PERSON)
-- ============================================
CREATE TABLE EMAIL (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for email',
    name              VARCHAR(100) NOT NULL COMMENT 'Email address',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    person_id         INT NOT NULL COMMENT 'Foreign key to PERSON table',
    domain_id         INT NOT NULL COMMENT 'Foreign key to DOMAIN table',
    
    CONSTRAINT fk_email_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id),
    CONSTRAINT fk_email_domain FOREIGN KEY (domain_id) REFERENCES carpooling_adm.DOMAIN(id),
    
    INDEX idx_email_person (person_id),
    INDEX idx_email_domain (domain_id),
    INDEX idx_email_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores person email addresses';

-- ============================================
-- 21. VEHICLE Table
-- ============================================
CREATE TABLE VEHICLE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for vehicle',
    plate             VARCHAR(9) NOT NULL COMMENT 'Vehicle license plate',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    UNIQUE KEY uk_vehicle_plate (plate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores vehicles';

-- ============================================
-- 22. PHONE_PERSON Table (Relationship between PERSON and PHONE)
-- ============================================
CREATE TABLE PHONE_PERSON (
    person_id         INT NOT NULL COMMENT 'Foreign key to PERSON table',
    phone_id          INT NOT NULL COMMENT 'Foreign key to PHONE table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',

    PRIMARY KEY (person_id, phone_id),
    CONSTRAINT fk_phone_person_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id),
    CONSTRAINT fk_phone_person_phone FOREIGN KEY (phone_id) REFERENCES PHONE(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between PERSON and PHONE';

-- ============================================
-- 23. INSTITUTION_PERSON Table (Relationship between INSTITUTION and PERSON)
-- ============================================
CREATE TABLE INSTITUTION_PERSON (
    institution_id    INT NOT NULL COMMENT 'Foreign key to INSTITUTION table',
    person_id         INT NOT NULL COMMENT 'Foreign key to PERSON table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    PRIMARY KEY (institution_id, person_id),
    CONSTRAINT fk_institution_per_institution FOREIGN KEY (institution_id) REFERENCES carpooling_adm.INSTITUTION(id),
    CONSTRAINT fk_institution_per_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between INSTITUTION and PERSON';

-- ============================================
-- 25. PERSONUSER Table (renamed from USER)
-- ============================================
CREATE TABLE PERSONUSER (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for user',
    username          VARCHAR(50) NOT NULL COMMENT 'User username',
    password          VARCHAR(50) NOT NULL COMMENT 'User password',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    person_id         INT NOT NULL COMMENT 'Foreign key to PERSON table',
    
    CONSTRAINT fk_user_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id),
    UNIQUE KEY uk_user_username (username),
    INDEX idx_user_person (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores system users';

-- ============================================
-- 26. ROUTE Table
-- ============================================
CREATE TABLE ROUTE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for route',
    start_time        TIMESTAMP NOT NULL COMMENT 'Route start time',
    end_time          TIMESTAMP NOT NULL COMMENT 'Route end time',
    programming_date  DATE NOT NULL COMMENT 'Date when the route was programmed',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    INDEX idx_route_dates (programming_date, start_time),
    INDEX idx_route_times (start_time, end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores routes';

-- ============================================
-- 27. VEHICLEXROUTE Table (Relationship between VEHICLE and ROUTE)
-- ============================================
CREATE TABLE VEHICLEXROUTE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for vehicle-route relationship',
    vehicle_id        INT NOT NULL COMMENT 'Foreign key to VEHICLE table',
    route_id          INT NOT NULL COMMENT 'Foreign key to ROUTE table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_vehiclexroute_vehicle FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_vehiclexroute_route FOREIGN KEY (route_id) REFERENCES ROUTE(id),
    
    INDEX idx_vehiclexroute_vehicle (vehicle_id),
    INDEX idx_vehiclexroute_route (route_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between VEHICLE and ROUTE';

-- ============================================
-- 28. WAYPOINT Table (renamed from STOP)
-- ============================================
CREATE TABLE WAYPOINT (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for waypoint',
    district_id       INT COMMENT 'Foreign key to DISTRICT table',
    route_id          INT NOT NULL COMMENT 'Foreign key to ROUTE table',
    latitude          DECIMAL(9,6) COMMENT 'Waypoint latitude coordinate',
    longitude         DECIMAL(9,6) COMMENT 'Waypoint longitude coordinate',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_waypoint_district FOREIGN KEY (district_id) REFERENCES carpooling_adm.DISTRICT(id),
    CONSTRAINT fk_waypoint_route FOREIGN KEY (route_id) REFERENCES ROUTE(id),
    
    INDEX idx_waypoint_district (district_id),
    INDEX idx_waypoint_route (route_id),
    INDEX idx_waypoint_coords (latitude, longitude)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores waypoints/stops';

-- ============================================
-- 29. TRIP Table (Related to VEHICLE and ROUTE)
-- ============================================
CREATE TABLE TRIP (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for trip',
    vehicle_id        INT NOT NULL COMMENT 'Foreign key to VEHICLE table',
    route_id          INT NOT NULL COMMENT 'Foreign key to ROUTE table',
    id_currency       INT COMMENT 'Foreign key to CURRENCY table',
    price_per_passenger DECIMAL(10, 2) NOT NULL COMMENT 'The price each passenger has to pay',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_trip_vehicle FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_trip_route FOREIGN KEY (route_id) REFERENCES ROUTE(id),
    CONSTRAINT fk_trip_currency FOREIGN KEY (id_currency) REFERENCES carpooling_adm.CURRENCY(id),
    
    INDEX idx_trip_vehicle (vehicle_id),
    INDEX idx_trip_route (route_id),
    INDEX idx_trip_currency (id_currency),
    INDEX idx_trip_price (price_per_passenger)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores trips';

-- ============================================
-- 30. STATUSXTRIP Table (Relationship between TRIP and STATUS)
-- ============================================
CREATE TABLE STATUSXTRIP (
    trip_id           INT NOT NULL COMMENT 'Foreign key to TRIP table',
    status_id         INT NOT NULL COMMENT 'Foreign key to STATUS table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',

    PRIMARY KEY (trip_id, status_id),
    CONSTRAINT fk_statusxtrip_trip FOREIGN KEY (trip_id) REFERENCES TRIP(id),
    CONSTRAINT fk_statusxtrip_status FOREIGN KEY (status_id) REFERENCES carpooling_adm.STATUS(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between TRIP and STATUS';

-- ============================================
-- 31. PASSENGER Table (Inherits from PERSON)
-- ============================================
CREATE TABLE PASSENGER (
    person_id         INT PRIMARY KEY COMMENT 'Primary key and foreign key to PERSON table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_passenger_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores passenger information';

-- ============================================
-- 32. DRIVER Table (Inherits from PERSON)
-- ============================================
CREATE TABLE DRIVER (
    person_id         INT PRIMARY KEY COMMENT 'Primary key and foreign key to PERSON table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_driver_person FOREIGN KEY (person_id) REFERENCES carpooling_adm.PERSON(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores driver information';

-- ============================================
-- 33. PASSENGERXWAYPOINT Table (Relationship between PASSENGER and WAYPOINT)
-- ============================================
CREATE TABLE PASSENGERXWAYPOINT (
    passenger_id      INT NOT NULL COMMENT 'Foreign key to PASSENGER table',
    waypoint_id       INT NOT NULL COMMENT 'Foreign key to WAYPOINT table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    PRIMARY KEY (passenger_id, waypoint_id),
    CONSTRAINT fk_passenger_waypoint_passenger FOREIGN KEY (passenger_id) REFERENCES PASSENGER(person_id),
    CONSTRAINT fk_passenger_waypoint_waypoint FOREIGN KEY (waypoint_id) REFERENCES WAYPOINT(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between PASSENGER and WAYPOINT';

-- ============================================
-- 34. DRIVERXVEHICLE Table (Relationship between DRIVER and VEHICLE)
-- ============================================
CREATE TABLE DRIVERXVEHICLE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for driver-vehicle relationship',
    vehicle_id        INT NOT NULL COMMENT 'Foreign key to VEHICLE table',
    driver_id         INT NOT NULL COMMENT 'Foreign key to DRIVER table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_driverxvehicle_vehicle FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_driverxvehicle_driver FOREIGN KEY (driver_id) REFERENCES DRIVER(person_id),
    
    INDEX idx_driverxvehicle_vehicle (vehicle_id),
    INDEX idx_driverxvehicle_driver (driver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between DRIVER and VEHICLE';

-- ============================================
-- 35. MAXCAPACITYXVEHICLE Table (Relationship between MAXCAPACITY and VEHICLE)
-- ============================================
CREATE TABLE MAXCAPACITYXVEHICLE (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for max capacity-vehicle relationship',
    max_capacity_id   INT NOT NULL COMMENT 'Foreign key to MAXCAPACITY table',
    vehicle_id        INT NOT NULL COMMENT 'Foreign key to VEHICLE table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_maxcapacityxvehicle_vehicle FOREIGN KEY (vehicle_id) REFERENCES VEHICLE(id),
    CONSTRAINT fk_maxcapacityxvehicle_maxcap FOREIGN KEY (max_capacity_id) REFERENCES carpooling_adm.MAXCAPACITY(id),
    
    INDEX idx_maxcapacityxvehicle_vehicle (vehicle_id),
    INDEX idx_maxcapacityxvehicle_maxcap (max_capacity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between MAXCAPACITY and VEHICLE';

-- ============================================
-- 36. PASSENGERXTRIP Table (Relationship between PASSENGER and TRIP)
-- ============================================
CREATE TABLE PASSENGERXTRIP (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for passenger-trip relationship',
    passenger_id      INT NOT NULL COMMENT 'Foreign key to PASSENGER table',
    trip_id           INT NOT NULL COMMENT 'Foreign key to TRIP table',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_passengerxtrip_passenger FOREIGN KEY (passenger_id) REFERENCES PASSENGER(person_id),
    CONSTRAINT fk_passengerxtrip_trip FOREIGN KEY (trip_id) REFERENCES TRIP(id),
    
    INDEX idx_passengerxtrip_passenger (passenger_id),
    INDEX idx_passengerxtrip_trip (trip_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between PASSENGER and TRIP';

-- ============================================
-- 37. PASSENGERXTRIPXPAYMENT Table (Relationship between PASSENGERXTRIP and PAYMENTMETHOD)
-- ============================================
CREATE TABLE PASSENGERXTRIPXPAYMENT (
    id                    INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for passenger-trip-payment relationship',
    passenger_x_trip_id   INT NOT NULL COMMENT 'Foreign key to PASSENGERXTRIP table',
    payment_method_id     INT NOT NULL COMMENT 'Foreign key to PAYMENTMETHOD table',
    creator               VARCHAR(50) COMMENT 'User who created the record',
    creation_date         DATE COMMENT 'Record creation date',
    modifier              VARCHAR(50) COMMENT 'User who modified the record',
    modification_date     DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_passxtripxpay_passxtrip FOREIGN KEY (passenger_x_trip_id) REFERENCES PASSENGERXTRIP(id),
    CONSTRAINT fk_passxtripxpay_payment FOREIGN KEY (payment_method_id) REFERENCES carpooling_adm.PAYMENTMETHOD(id),
    
    INDEX idx_passxtripxpay_passxtrip (passenger_x_trip_id),
    INDEX idx_passxtripxpay_payment (payment_method_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Relationship table between PASSENGERXTRIP and PAYMENTMETHOD';

-- =====================================================================
-- ADM TABLES DEPENDENT ON PU TABLES
-- =====================================================================
-- Switch back to ADM database for tables that depend on PU
USE carpooling_adm;

-- ============================================
-- 38. CHOSENCAPACITY Table
-- ============================================
CREATE TABLE CHOSENCAPACITY (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for chosen capacity',
    vehicle_x_route_id INT NOT NULL COMMENT 'Foreign key to VEHICLEXROUTE table',
    chosen_number     INT NOT NULL COMMENT 'Selected capacity number',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
  
    CONSTRAINT fk_chosencapacity_vehicle_x_route FOREIGN KEY (vehicle_x_route_id) REFERENCES carpooling_pu.VEHICLEXROUTE(id),
    INDEX idx_chosencapacity_vxr (vehicle_x_route_id),
    INDEX idx_chosencapacity_number (chosen_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores chosen capacities for vehicle-route combinations';

-- ============================================
-- 39. INSTITUTION_REPORT Table
-- ============================================
CREATE TABLE INSTITUTION_REPORT (
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for report',
    institution_id    INT NOT NULL COMMENT 'Foreign key to INSTITUTION table',
    report_date       DATE NOT NULL COMMENT 'Date of the report',
    total_trips       INT NOT NULL COMMENT 'Total number of trips for the institution',
    total_passengers  INT NOT NULL COMMENT 'Total number of passengers for the institution',
    total_revenue     DECIMAL(10,2) NOT NULL COMMENT 'Total revenue generated for the institution',
    creator           VARCHAR(50) COMMENT 'User who created the record',
    creation_date     DATE COMMENT 'Record creation date',
    modifier          VARCHAR(50) COMMENT 'User who modified the record',
    modification_date DATE COMMENT 'Record modification date',
    
    CONSTRAINT fk_inst_report_institution FOREIGN KEY (institution_id) REFERENCES INSTITUTION(id),
    
    INDEX idx_institution_report_inst (institution_id),
    INDEX idx_institution_report_date (report_date),
    UNIQUE KEY uk_institution_report_date (institution_id, report_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Table that stores daily institution trip reports';

-- =====================================================================
-- VERIFICATION AND INFORMATION QUERIES
-- =====================================================================
/*
-- Uncomment these queries to verify table creation

-- Show all tables in carpooling_adm database
USE carpooling_adm;
SHOW TABLES;

-- Show all tables in carpooling_pu database  
USE carpooling_pu;
SHOW TABLES;

-- Show table structures (example for PERSON table)
DESCRIBE carpooling_adm.PERSON;

-- Show foreign key relationships
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_SCHEMA,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_SCHEMA IN ('carpooling_adm', 'carpooling_pu')
    AND TABLE_SCHEMA IN ('carpooling_adm', 'carpooling_pu')
ORDER BY 
    TABLE_SCHEMA, TABLE_NAME, ORDINAL_POSITION;
*/

-- =====================================================================
-- ADDITIONAL NOTES
-- =====================================================================
/*
 * MySQL Migration Completion Notes:
 * 
 * 1. CROSS-DATABASE FOREIGN KEYS:
 *    MySQL supports foreign keys across databases using database.table notation.
 *    Example: REFERENCES carpooling_adm.PERSON(id)
 * 
 * 2. AUTO_INCREMENT vs SEQUENCES:
 *    Oracle sequences are replaced with MySQL AUTO_INCREMENT columns.
 *    This provides automatic ID generation without separate sequence objects.
 * 
 * 3. DATA TYPES MAPPING:
 *    - Oracle NUMBER → MySQL INT (for IDs) or DECIMAL(precision,scale)
 *    - Oracle VARCHAR2(n) → MySQL VARCHAR(n)
 *    - Oracle DATE → MySQL DATE
 *    - Oracle TIMESTAMP → MySQL TIMESTAMP
 *    - Oracle BLOB → MySQL LONGBLOB
 * 
 * 4. INDEXES:
 *    Automatic indexes are created for:
 *    - Primary keys (automatic in MySQL)
 *    - Foreign keys (explicit INDEX statements)
 *    - Unique constraints (automatic in MySQL)
 *    - Common query patterns (explicit INDEX statements)
 * 
 * 5. STORAGE ENGINE:
 *    All tables use InnoDB for:
 *    - Foreign key constraint support
 *    - ACID compliance
 *    - Row-level locking
 *    - Crash recovery
 * 
 * 6. CHARACTER SET:
 *    utf8mb4 with utf8mb4_unicode_ci collation for:
 *    - Full Unicode support (including emojis)
 *    - Proper international sorting
 *    - Case-insensitive comparisons
 * 
 * 7. PRIVILEGE IMPLICATIONS:
 *    The original Oracle GRANT statements are not needed in MySQL as:
 *    - Each database has its own user (pu_user, adm_user)
 *    - Cross-database access is controlled by user privileges
 *    - Foreign key references work across databases automatically
 * 
 * Connection Examples:
 * ===================
 * 
 * For ADM operations:
 * mysql -h localhost -u adm_user -p'adm_password' carpooling_adm
 * 
 * For PU operations:
 * mysql -h localhost -u pu_user -p'pu_password' carpooling_pu
 * 
 * For cross-database queries (if user has permissions):
 * SELECT p.first_name, e.name as email
 * FROM carpooling_adm.PERSON p
 * JOIN carpooling_pu.EMAIL e ON p.id = e.person_id;
 */
