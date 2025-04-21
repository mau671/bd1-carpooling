CREATE OR REPLACE PROCEDURE InsertPhoneType(
    p_id               IN NUMBER,
    p_name             IN VARCHAR2,
    p_creator          IN VARCHAR2,
    p_creation_date    IN DATE,
    p_modifier         IN VARCHAR2,
    p_modification_date IN DATE
)
AS
BEGIN
    INSERT INTO pu.type_phone (id, name, creator, creation_date, modifier, modification_date)
    VALUES (p_id, p_name, p_creator, p_creation_date, p_modifier, p_modification_date);
END;
/
COMMIT;