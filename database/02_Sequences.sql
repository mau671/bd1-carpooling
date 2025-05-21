--==============================================
-- Creation of sequences for ADM tables
-- These sequences are used for generating unique identifier values
-- for each table in the ADM schema
--==============================================

-- 1. GENDER - Stores gender types
CREATE SEQUENCE ADM.GENDER_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 2. TYPE_IDENTIFICATION - Stores identification document types
CREATE SEQUENCE ADM.TYPE_IDENTIFICATION_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 3. TYPE_PHONE - Stores phone number types
CREATE SEQUENCE ADM.TYPE_PHONE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 4. COUNTRY - Stores country information
CREATE SEQUENCE ADM.COUNTRY_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 5. PROVINCE - Stores province/state information
CREATE SEQUENCE ADM.PROVINCE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 6. CANTON - Stores canton/county information
CREATE SEQUENCE ADM.CANTON_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 7. DISTRICT - Stores district information
CREATE SEQUENCE ADM.DISTRICT_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 8. STATUS - Stores status types for various entities
CREATE SEQUENCE ADM.STATUS_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 9. MAX_CAPACITY - Stores capacity information
CREATE SEQUENCE ADM.MAXCAPACITY_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 10. LOGS - Stores system logs and audit trail
CREATE SEQUENCE ADM.LOGS_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 11. PARAMETER - Stores system parameters
CREATE SEQUENCE ADM.PARAMETER_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 12. PERSON - Stores basic person information
CREATE SEQUENCE ADM.PERSON_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 13. PAYMENT_METHOD - Stores payment method types
CREATE SEQUENCE ADM.PAYMENTMETHOD_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 14. CURRENCY - Stores currency types
CREATE SEQUENCE ADM.CURRENCY_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 15. INSTITUTION - Stores institution information
CREATE SEQUENCE ADM.INSTITUTION_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 16. DOMAIN - Stores domain information
CREATE SEQUENCE ADM.DOMAIN_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 17. CHOSEN_CAPACITY - Stores selected capacity information
CREATE SEQUENCE ADM.CHOSENCAPACITY_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;

--==============================================
-- Creation of sequences for PU tables
-- These sequences are used for generating unique identifier values
-- for each table in the PU schema related to public user functionality
--==============================================

-- 1. PHOTO - Stores user profile photos
CREATE SEQUENCE PU.PHOTO_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 2. PHONE - Stores phone contact information
CREATE SEQUENCE PU.PHONE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 3. EMAIL - Stores email contact information
CREATE SEQUENCE PU.EMAIL_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 4. PERSON_USER - Stores user account information
CREATE SEQUENCE PU.PERSONUSER_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 5. VEHICLE - Stores vehicle information
CREATE SEQUENCE PU.VEHICLE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 6. WAYPOINT - Stores route waypoints
CREATE SEQUENCE PU.WAYPOINT_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 7. ROUTE - Stores route information
CREATE SEQUENCE PU.ROUTE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 8. TRIP - Stores trip information
CREATE SEQUENCE PU.TRIP_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 9. VEHICLE_X_ROUTE - Stores vehicle-route relationships
CREATE SEQUENCE PU.VEHICLEXROUTE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 10. DRIVER_X_VEHICLE - Stores driver-vehicle assignments
CREATE SEQUENCE PU.DRIVERXVEHICLE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 11. MAX_CAPACITY_X_VEHICLE - Stores vehicle capacity information
CREATE SEQUENCE PU.MAXCAPACITYXVEHICLE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 12. PASSENGER_X_TRIP - Stores passenger trip registrations
CREATE SEQUENCE PU.PASSENGERXTRIP_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;
-- 13. PASSENGER_X_TRIP_X_PAYMENT - Stores passenger trip payment information
CREATE SEQUENCE PU.PASSENGERXTRIPXPAYMENT_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;

--==============================================
-- Creation of sequences for ADM tables (continued)
--==============================================
-- 15. INSTITUTION_REPORT - Stores institution report information
CREATE SEQUENCE ADM.INSTITUTION_REPORT_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 NOCYCLE;

--==============================================
-- Required Permissions
-- Grant permissions for sequence usage between schemas
--==============================================
-- Example: Grant permission to PU to use ADM sequences if PU needs to directly
-- insert and generate IDs (although PL/SQL packages usually handle this differently
-- using triggers in ADM)
-- GRANT SELECT ON ADM.PERSON_SEQ TO PU;
-- GRANT SELECT ON ADM.INSTITUTION_SEQ TO PU; -- If PU needs to directly insert institutions
-- GRANT SELECT ON ADM.DOMAIN_SEQ TO PU; -- If PU needs to directly insert domains

-- Grant for LOGS_SEQ is appropriate if PU needs to insert into ADM.LOGS
GRANT SELECT ON ADM.LOGS_SEQ TO PU;
GRANT SELECT ON ADM.INSTITUTION_SEQ TO PU;