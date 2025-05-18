CREATE OR REPLACE PROCEDURE validar_admin (
    p_input     IN VARCHAR2,
    p_password  IN VARCHAR2,
    p_es_valido OUT NUMBER  
) AS
    v_count INTEGER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM ADM.ADMIN a
    JOIN PU.PERSONUSER u ON a.PERSON_ID = u.PERSON_ID
    LEFT JOIN PU.EMAIL e ON e.PERSON_ID = a.PERSON_ID
    WHERE (u.USERNAME = p_input OR e.NAME = p_input)
      AND u.PASSWORD = p_password;

    p_es_valido := CASE WHEN v_count > 0 THEN 1 ELSE 0 END;
END validar_admin;
/


CREATE OR REPLACE PROCEDURE validar_usuario (
    p_input     IN VARCHAR2,
    p_password  IN VARCHAR2,
    p_es_valido OUT NUMBER
) AS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM PU.PERSONUSER u
    LEFT JOIN PU.EMAIL e ON u.PERSON_ID = e.PERSON_ID
    WHERE u.PASSWORD = p_password
      AND (u.USERNAME = p_input OR e.NAME = p_input);

    IF v_count > 0 THEN
        p_es_valido := 1;
    ELSE
        p_es_valido := 0;
    END IF;
END validar_usuario;
/

