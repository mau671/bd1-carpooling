-- Initial INSERTS for the application parameters
INSERT INTO parameters (id, name, value) VALUES (1, 'app_name', 'My Application');
INSERT INTO parameters (id, name, value) VALUES (2, 'app_version', '1.0.0');
INSERT INTO parameters (id, name, value) VALUES (3, 'app_description', 'This is a sample application.');
INSERT INTO parameters (id, name, value) VALUES (4, 'app_author', 'John Doe');
INSERT INTO parameters (id, name, value) VALUES (5, 'app_license', 'MIT');
INSERT INTO parameters (id, name, value) VALUES (6, 'app_website', 'https://example.com');

-- ===================================
-- Institution related data
-- ===================================

-- Insert the main institution
INSERT INTO ADM.INSTITUTION (id, name) VALUES (ADM.INSTITUTION_SEQ.NEXTVAL, 'Costa Rica Institute of Technology');

-- Insert domains associated with the institution
INSERT INTO ADM.DOMAIN (id, name) VALUES (ADM.DOMAIN_SEQ.NEXTVAL, 'itcr.ac.cr');
INSERT INTO ADM.DOMAIN (id, name) VALUES (ADM.DOMAIN_SEQ.NEXTVAL, 'tec.ac.cr');
INSERT INTO ADM.DOMAIN (id, name) VALUES (ADM.DOMAIN_SEQ.NEXTVAL, 'estudiantec.cr');

-- Establish relationships between institution and domains
INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) VALUES (1, 1);
INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) VALUES (1, 2);
INSERT INTO ADM.INSTITUTION_DOMAIN (institution_id, domain_id) VALUES (1, 3);

-- ===================================
-- Person related data
-- ===================================

-- Insert gender options
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Male');
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Female');
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Other');
INSERT INTO ADM.GENDER (id, name) VALUES (ADM.GENDER_SEQ.NEXTVAL, 'Prefer not to say');

-- Insert identification types
INSERT INTO ADM.TYPE_IDENTIFICATION (id, name) VALUES (ADM.TYPE_IDENTIFICATION_SEQ.NEXTVAL, 'ID Card');
INSERT INTO ADM.TYPE_IDENTIFICATION (id, name) VALUES (ADM.TYPE_IDENTIFICATION_SEQ.NEXTVAL, 'Passport');

-- Insert phone types
INSERT INTO ADM.TYPE_PHONE (id, name) VALUES (ADM.TYPE_PHONE_SEQ.NEXTVAL, 'Mobile');
INSERT INTO ADM.TYPE_PHONE (id, name) VALUES (ADM.TYPE_PHONE_SEQ.NEXTVAL, 'Landline');
INSERT INTO ADM.TYPE_PHONE (id, name) VALUES (ADM.TYPE_PHONE_SEQ.NEXTVAL, 'Fax');

-- ===================================
-- Payment and trip related data
-- ===================================

-- Insert payment methods
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Credit Card');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Debit Card');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'PayPal');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Sinpe Movil');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.PAYMENTMETHOD_SEQ.NEXTVAL, 'Cash');

-- Insert currencies
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.CURRENCY_SEQ.NEXTVAL, 'Colones');
INSERT INTO ADM.PAYMENTMETHOD (id, name) VALUES (ADM.CURRENCY_SEQ.NEXTVAL, 'US Dollar');

-- Insert trip status options
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'Pending');
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'In Progress');
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'Completed');
INSERT INTO ADM.STATUS (id, name) VALUES (ADM.STATUS_SEQ.NEXTVAL, 'Cancelled');

-- Insert vehicle capacity options
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 1);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 2);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 3);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 4);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 5);
INSERT INTO ADM.MAXCAPACITY (id, capacity_number) VALUES (ADM.MAXCAPACITY_SEQ.NEXTVAL, 6);

-- ===================================
-- User records
-- ===================================

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

-- Assign administrator role to the first user
INSERT INTO ADM.ADMIN (person_id) VALUES (1);

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

-- Add phone number for the regular user
INSERT INTO PU.PHONE (id, phone_number, type_phone_id) VALUES (PU.PHONE_SEQ.NEXTVAL, '8888-8888', 1);

-- Add email for the regular user
INSERT INTO PU.EMAIL (id, name, person_id, domain_id) VALUES (PU.EMAIL_SEQ.NEXTVAL, 'carmenhidalgopaz', 3, 2);