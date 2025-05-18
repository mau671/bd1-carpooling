/*
-- Initial INSERTS for the application parameters
INSERT INTO ADM.PARAMETER (id, name, value) VALUES (ADM.PARAMETER_SEQ.NEXTVAL, 'APP_NAME', 'BUDDYRIDE');
INSERT INTO ADM.PARAMETER (id, name, value) VALUES (ADM.PARAMETER_SEQ.NEXTVAL, 'APP_VERSION', '1.0.0');
INSERT INTO ADM.PARAMETER (id, name, value) VALUES (ADM.PARAMETER_SEQ.NEXTVAL, 'APP_URL', 'https://www.buddyrides.com');
INSERT INTO ADM.PARAMETER (id, name, value) VALUES (ADM.PARAMETER_SEQ.NEXTVAL, 'APP_LOGO' 'logo.png');
INSERT INTO ADM.PARAMETER (id, name, value) VALUES (ADM.PARAMETER_SEQ.NEXTVAL, 'APP_BANNER', 'banner.png');
INSERT INTO ADM.PARAMETER (id, name, value) VALUES (ADM.PARAMETER_SEQ.NEXTVAL, 'APP_BACKGROUND', 'background.png');
*/

-- ===================================
-- Institution related data
-- ===================================

-- Insert the main institution
INSERT INTO ADM.INSTITUTION (id, name) VALUES (ADM.INSTITUTION_SEQ.NEXTVAL, 'Costa Rica Institute of Technology');
COMMIT;

-- Insert domains associated with the institution
INSERT INTO ADM.DOMAIN (id, name) VALUES (ADM.DOMAIN_SEQ.NEXTVAL, 'itcr.ac.cr');
INSERT INTO ADM.DOMAIN (id, name) VALUES (ADM.DOMAIN_SEQ.NEXTVAL, 'tec.ac.cr');
INSERT INTO ADM.DOMAIN (id, name) VALUES (ADM.DOMAIN_SEQ.NEXTVAL, 'estudiantec.cr');
COMMIT;

-- Establish relationships between institution and domains
-- Primero eliminamos las relaciones existentes si las hay
DELETE FROM ADM.INSTITUTION_DOMAIN WHERE institution_id = 1;
COMMIT;

INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) VALUES (1, 1);
INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) VALUES (1, 2);
INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) VALUES (1, 3);
COMMIT;

-- ===================================
-- Person related data
-- ===================================

-- Insert gender options
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Male');
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Female');
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Other');
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Prefer not to say');
COMMIT;

-- Insert identification types
INSERT INTO ADM.TYPE_IDENTIFICATION (id, name) VALUES (ADM.TYPE_IDENTIFICATION_SEQ.NEXTVAL, 'ID Card');
INSERT INTO ADM.TYPE_IDENTIFICATION (id, name) VALUES (ADM.TYPE_IDENTIFICATION_SEQ.NEXTVAL, 'Passport');
COMMIT;

-- Insert phone types
INSERT INTO ADM.TYPE_PHONE (id, name) VALUES (ADM.TYPE_PHONE_SEQ.NEXTVAL, 'Mobile');
INSERT INTO ADM.TYPE_PHONE (id, name) VALUES (ADM.TYPE_PHONE_SEQ.NEXTVAL, 'Landline');
INSERT INTO ADM.TYPE_PHONE (id, name) VALUES (ADM.TYPE_PHONE_SEQ.NEXTVAL, 'Fax');
COMMIT;

-- ===================================
-- Payment and trip related data
-- ===================================

-- Insert payment methods
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Credit Card');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Debit Card');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'PayPal');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Sinpe Movil');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Cash');
COMMIT;

-- Insert currencies
INSERT INTO ADM.CURRENCY (id, name) VALUES (ADM.CURRENCY_SEQ.NEXTVAL, 'Colones');
INSERT INTO ADM.CURRENCY (id, name) VALUES (ADM.CURRENCY_SEQ.NEXTVAL, 'US Dollar');
COMMIT;

-- Insert trip status options
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'Pending');
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'In Progress');
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'Completed');
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'Cancelled');
COMMIT;

-- Insert vehicle capacity options
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 1);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 2);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 3);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 4);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 5);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 6);
COMMIT;

-- ===================================
-- User records
-- ===================================

/*
-- Register the first administrator
INSERT INTO ADM.PERSON (
    id, 
    first_name, 
    second_name, 
    first_surname, 
    second_surname, 
    identification_number,
    date_of_birth, 
    gender_id, 
    type_identification_id
) VALUES (
    ADM.PERSON_SEQ.NEXTVAL, 
    'Mauricio', 
    NULL, 
    'Gonzalez',
    'Prendas', 
    '604890987', 
    TO_DATE('2004-12-13', 'YYYY-MM-DD'), 
    1, 
    1
);
COMMIT;

-- Assign administrator role to the first user
-- Primero eliminamos el registro existente si lo hay
DELETE FROM ADM.ADMIN WHERE person_id = 1;
COMMIT;

INSERT INTO ADM.ADMIN (person_id) VALUES (1);
COMMIT;

-- Register the first regular user
INSERT INTO ADM.PERSON (
    id, 
    first_name, 
    second_name, 
    first_surname, 
    second_surname, 
    identification_number,
    date_of_birth, 
    gender_id, 
    type_identification_id
) VALUES (
    ADM.PERSON_SEQ.NEXTVAL, 
    'Carmen', 
    NULL, 
    'Hidalgo',
    'Paz', 
    '604890987', 
    TO_DATE('2004-12-13', 'YYYY-MM-DD'), 
    2, 
    1
);
COMMIT;

-- Add phone number for the regular user
INSERT INTO PU.PHONE (id, phone_number, type_phone_id) VALUES (PU.PHONE_SEQ.NEXTVAL, '8888-8888', 1);
COMMIT;

-- Add email for the regular user
INSERT INTO PU.EMAIL (id, name, person_id, domain_id) VALUES (PU.EMAIL_SEQ.NEXTVAL, 'carmenhidalgopaz', 2, 2);
COMMIT;

-- Admin USER data
INSERT INTO PU.PERSONUSER (
    id,
    username,
    password,
    person_id
) VALUES (
    PU.PERSONUSER_SEQ.NEXTVAL,
    'admin',
    'admin123',
    1
);
COMMIT;

-- Regular USER data
INSERT INTO PU.PERSONUSER (
    id,
    username,
    password,
    person_id
) VALUES (
    PU.PERSONUSER_SEQ.NEXTVAL,
    'carmen',
    'carmen123',
    2
);
COMMIT;
*/
