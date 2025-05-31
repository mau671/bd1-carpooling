-- ============================================================================
-- PACKAGE: ADM_PERSON_PKG
-- Description: Manages operations related to persons in the system
-- ============================================================================
CREATE OR REPLACE PACKAGE ADM.ADM_PERSON_pkg IS
  PROCEDURE get_person_profile (
    p_person_id            IN  ADM.PERSON.id%TYPE,
    p_first_name           OUT VARCHAR2,
    p_second_name          OUT VARCHAR2,
    p_first_surname        OUT VARCHAR2,
    p_second_surname       OUT VARCHAR2,
    p_identification       OUT VARCHAR2,
    p_date_of_birth        OUT DATE,
    p_gender_id            OUT NUMBER,
    p_type_identification  OUT NUMBER
  );
END ADM_PERSON_pkg;
/

CREATE OR REPLACE PACKAGE BODY ADM.ADM_PERSON_pkg IS
  PROCEDURE get_person_profile(
    p_person_id            IN  ADM.PERSON.id%TYPE,
    p_first_name           OUT VARCHAR2,
    p_second_name          OUT VARCHAR2,
    p_first_surname        OUT VARCHAR2,
    p_second_surname       OUT VARCHAR2,
    p_identification       OUT VARCHAR2,
    p_date_of_birth        OUT DATE,
    p_gender_id            OUT NUMBER,
    p_type_identification  OUT NUMBER
  ) IS
  BEGIN
    SELECT
      first_name,
      second_name,
      first_surname,
      second_surname,
      identification_number,
      date_of_birth,
      gender_id,
      type_identification_id
    INTO
      p_first_name,
      p_second_name,
      p_first_surname,
      p_second_surname,
      p_identification,
      p_date_of_birth,
      p_gender_id,
      p_type_identification
    FROM
      ADM.PERSON
    WHERE
      id = p_person_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Set all OUT parameters to NULL or default values
      p_first_name := NULL;
      p_second_name := NULL;
      p_first_surname := NULL;
      p_second_surname := NULL;
      p_identification := NULL;
      p_date_of_birth := NULL;
      p_gender_id := NULL;
      p_type_identification := NULL;
  END get_person_profile;
END ADM_PERSON_pkg;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON ADM.PERSON TO PU;
GRANT SELECT ON ADM.PERSON_SEQ TO PU;
GRANT EXECUTE ON ADM.ADM_PERSON_PKG TO PU;