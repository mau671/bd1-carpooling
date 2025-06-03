
-- 1. Trigger BEFORE INSERT and UPDATE on GENDER
DELIMITER //

CREATE TRIGGER trg_gender_before_insert
BEFORE INSERT ON GENDER
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1); -- Usar USER() obtiene el usuario, mientras que '@' obtiene solo el nombre
    SET NEW.creation_date = CURDATE();
    
    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_gender_before_update
BEFORE UPDATE ON GENDER
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

DELIMITER //

-- 2. Trigger BEFORE INSERT and UPDATE on TYPE_IDENTIFICATION

DELIMITER //

CREATE TRIGGER trg_type_identification_before_insert
BEFORE INSERT ON TYPE_IDENTIFICATION
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_type_identification_before_update
BEFORE UPDATE ON TYPE_IDENTIFICATION
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

DELIMITER //

-- 3. Trigger BEFORE INSERT and UPDATE on TYPE_PHONE

DELIMITER //

CREATE TRIGGER trg_type_phone_before_insert
BEFORE INSERT ON TYPE_PHONE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_type_phone_before_update
BEFORE UPDATE ON TYPE_PHONE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

DELIMITER //

-- 4. Trigger BEFORE INSERT and UPDATE on COUNTRY

DELIMITER //

CREATE TRIGGER trg_country_before_insert
BEFORE INSERT ON COUNTRY
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_country_before_update
BEFORE UPDATE ON COUNTRY
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 5. Trigger BEFORE INSERT and UPDATE on PROVINCE

CREATE TRIGGER trg_province_before_insert
BEFORE INSERT ON PROVINCE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_province_before_update
BEFORE UPDATE ON PROVINCE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 6. Trigger BEFORE INSERT and UPDATE on CANTON

CREATE TRIGGER trg_canton_before_insert
BEFORE INSERT ON CANTON
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_canton_before_update
BEFORE UPDATE ON CANTON
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 7. Trigger BEFORE INSERT and UPDATE on DISTRICT

CREATE TRIGGER trg_district_before_insert
BEFORE INSERT ON DISTRICT
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_district_before_update
BEFORE UPDATE ON DISTRICT
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 8. Trigger BEFORE INSERT and UPDATE on STATUS

CREATE TRIGGER trg_status_before_insert
BEFORE INSERT ON STATUS
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_status_before_update
BEFORE UPDATE ON STATUS
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 9. Trigger BEFORE INSERT and UPDATE on MAXCAPACITY

CREATE TRIGGER trg_maxcapacity_before_insert
BEFORE INSERT ON MAXCAPACITY
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_maxcapacity_before_update
BEFORE UPDATE ON MAXCAPACITY
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

DELIMITER //

-- 10. Trigger BEFORE INSERT and UPDATE on LOGS
CREATE TRIGGER trg_logs_before_insert
BEFORE INSERT ON LOGS
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_logs_before_update
BEFORE UPDATE ON LOGS
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 11. Trigger BEFORE INSERT and UPDATE on PARAMETER
CREATE TRIGGER trg_parameter_before_insert
BEFORE INSERT ON PARAMETER
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_parameter_before_update
BEFORE UPDATE ON PARAMETER
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 12. Trigger BEFORE INSERT and UPDATE on PERSON
CREATE TRIGGER trg_person_before_insert
BEFORE INSERT ON PERSON
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_person_before_update
BEFORE UPDATE ON PERSON
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 13. Trigger BEFORE INSERT and UPDATE on ADMIN
CREATE TRIGGER trg_admin_before_insert
BEFORE INSERT ON ADMIN
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_admin_before_update
BEFORE UPDATE ON ADMIN
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 14. Trigger BEFORE INSERT and UPDATE on PAYMENTMETHOD
CREATE TRIGGER trg_paymentmethod_before_insert
BEFORE INSERT ON PAYMENTMETHOD
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_paymentmethod_before_update
BEFORE UPDATE ON PAYMENTMETHOD
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 15. Trigger BEFORE INSERT and UPDATE on CURRENCY
CREATE TRIGGER trg_currency_before_insert
BEFORE INSERT ON CURRENCY
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_currency_before_update
BEFORE UPDATE ON CURRENCY
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 16. Trigger BEFORE INSERT and UPDATE on INSTITUTION
CREATE TRIGGER trg_institution_before_insert
BEFORE INSERT ON INSTITUTION
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_institution_before_update
BEFORE UPDATE ON INSTITUTION
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 17. Trigger BEFORE INSERT and UPDATE on DOMAIN
CREATE TRIGGER trg_domain_before_insert
BEFORE INSERT ON DOMAIN
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_domain_before_update
BEFORE UPDATE ON DOMAIN
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 18. Trigger BEFORE INSERT and UPDATE on INSTITUTION_DOMAIN
CREATE TRIGGER trg_inst_domain_before_insert
BEFORE INSERT ON INSTITUTION_DOMAIN
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_inst_domain_before_update
BEFORE UPDATE ON INSTITUTION_DOMAIN
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- PU database triggers
-- 18. Trigger BEFORE INSERT and UPDATE on PHOTO
CREATE TRIGGER trg_photo_before_insert
BEFORE INSERT ON PHOTO
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_photo_before_update
BEFORE UPDATE ON PHOTO
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 20. Trigger BEFORE INSERT and UPDATE on PHONE
CREATE TRIGGER trg_phone_before_insert
BEFORE INSERT ON PHONE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_phone_before_update
BEFORE UPDATE ON PHONE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

-- 21. Trigger BEFORE INSERT and UPDATE on EMAIL
CREATE TRIGGER trg_email_before_insert
BEFORE INSERT ON EMAIL
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;//

CREATE TRIGGER trg_email_before_update
BEFORE UPDATE ON EMAIL
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;//

DELIMITER //

-- 22. VEHICLE
CREATE TRIGGER trg_vehicle_before_insert
BEFORE INSERT ON VEHICLE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_vehicle_before_update
BEFORE UPDATE ON VEHICLE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 23. PHONE_PERSON
CREATE TRIGGER trg_phone_person_before_insert
BEFORE INSERT ON PHONE_PERSON
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_phone_person_before_update
BEFORE UPDATE ON PHONE_PERSON
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 24. INSTITUTION_PERSON
CREATE TRIGGER trg_institution_person_before_insert
BEFORE INSERT ON INSTITUTION_PERSON
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_institution_person_before_update
BEFORE UPDATE ON INSTITUTION_PERSON
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 25. PERSONUSER
CREATE TRIGGER trg_personuser_before_insert
BEFORE INSERT ON PERSONUSER
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_personuser_before_update
BEFORE UPDATE ON PERSONUSER
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 26. ROUTE
CREATE TRIGGER trg_route_before_insert
BEFORE INSERT ON ROUTE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_route_before_update
BEFORE UPDATE ON ROUTE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 27. VEHICLEXROUTE
CREATE TRIGGER trg_vehiclexroute_before_insert
BEFORE INSERT ON VEHICLEXROUTE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_vehiclexroute_before_update
BEFORE UPDATE ON VEHICLEXROUTE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 28. WAYPOINT
CREATE TRIGGER trg_waypoint_before_insert
BEFORE INSERT ON WAYPOINT
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_waypoint_before_update
BEFORE UPDATE ON WAYPOINT
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 29. TRIP
CREATE TRIGGER trg_trip_before_insert
BEFORE INSERT ON TRIP
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_trip_before_update
BEFORE UPDATE ON TRIP
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 30. STATUSXTRIP
CREATE TRIGGER trg_statusxtrip_before_insert
BEFORE INSERT ON STATUSXTRIP
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_statusxtrip_before_update
BEFORE UPDATE ON STATUSXTRIP
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 31. PASSENGER
CREATE TRIGGER trg_passenger_before_insert
BEFORE INSERT ON PASSENGER
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_passenger_before_update
BEFORE UPDATE ON PASSENGER
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 32. DRIVER
CREATE TRIGGER trg_driver_before_insert
BEFORE INSERT ON DRIVER
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_driver_before_update
BEFORE UPDATE ON DRIVER
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 33. PASSENGERXWAYPOINT
CREATE TRIGGER trg_passengerxwaypoint_before_insert
BEFORE INSERT ON PASSENGERXWAYPOINT
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_passengerxwaypoint_before_update
BEFORE UPDATE ON PASSENGERXWAYPOINT
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 34. DRIVERXVEHICLE
CREATE TRIGGER trg_driverxvehicle_before_insert
BEFORE INSERT ON DRIVERXVEHICLE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_driverxvehicle_before_update
BEFORE UPDATE ON DRIVERXVEHICLE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//


-- 35. MAXCAPACITYXVEHICLE
CREATE TRIGGER trg_maxcapacityxvehicle_before_insert
BEFORE INSERT ON MAXCAPACITYXVEHICLE
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_maxcapacityxvehicle_before_update
BEFORE UPDATE ON MAXCAPACITYXVEHICLE
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

DELIMITER //

-- 36. PASSENGERXTRIP
CREATE TRIGGER trg_passengerxtrip_before_insert
BEFORE INSERT ON PASSENGERXTRIP
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_passengerxtrip_before_update
BEFORE UPDATE ON PASSENGERXTRIP
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 37. PASSENGERXTRIPXPAYMENT
CREATE TRIGGER trg_passengerxtripxpayment_before_insert
BEFORE INSERT ON PASSENGERXTRIPXPAYMENT
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_passengerxtripxpayment_before_update
BEFORE UPDATE ON PASSENGERXTRIPXPAYMENT
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 38. CHOSENCAPACITY
CREATE TRIGGER trg_chosencapacity_before_insert
BEFORE INSERT ON CHOSENCAPACITY
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_chosencapacity_before_update
BEFORE UPDATE ON CHOSENCAPACITY
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

-- 39. INSTITUTION_REPORT
CREATE TRIGGER trg_institution_report_before_insert
BEFORE INSERT ON INSTITUTION_REPORT
FOR EACH ROW
BEGIN
    SET NEW.creator = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.creation_date = CURDATE();

    SET NEW.modifier = NEW.creator;
    SET NEW.modification_date = NEW.creation_date;
END;
//

CREATE TRIGGER trg_institution_report_before_update
BEFORE UPDATE ON INSTITUTION_REPORT
FOR EACH ROW
BEGIN
    SET NEW.modifier = SUBSTRING_INDEX(USER(), '@', 1);
    SET NEW.modification_date = CURDATE();
END;
//

DELIMITER ;
