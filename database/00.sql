
-- Crear los tablespaces GE_Data y GE_Index
CREATE TABLESPACE GE_Data
    DATAFILE '/u01/app/oracle/oradata/XE/gedata01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON
    NEXT 512k
    MAXSIZE 200M;

CREATE TABLESPACE GE_Index
    DATAFILE '/u01/app/oracle/oradata/XE/geindex01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON
    NEXT 512k
    MAXSIZE 200M;

-- 2. Crear el esquema GE
CREATE USER GE 
    IDENTIFIED BY ge
    DEFAULT TABLESPACE GE_Data
    QUOTA 10M ON GE_Data
    TEMPORARY TABLESPACE temp
    QUOTA 5M ON SYSTEM
    QUOTA 10M ON GE_Index;

GRANT CONNECT to GE;
GRANT CREATE SESSION to GE;
GRANT CREATE TABLE to GE;

-- Crear el esquema ADM (Hay que crear tablespaces??)
CREATE USER ADM 
    IDENTIFIED BY adm
    DEFAULT TABLESPACE GE_Data
    QUOTA 10M ON GE_Data
    TEMPORARY TABLESPACE temp
    QUOTA 5M ON SYSTEM
    QUOTA 10M ON GE_Index;
GRANT CONNECT to ADM;
GRANT CREATE SESSION to ADM;
GRANT CREATE TABLE to ADM;

-- ============================================
-- Crear las tablas
-- ============================================