/*
 * File: 00.sql
 * Description: Database Initialization Script
 * 
 * This script initializes the database structure for the PU (Public User) and ADM (Administrator) schemas.
 * It creates the necessary tablespaces, user accounts, and grants appropriate privileges.
 * 
 * ===== Tablespaces =====
 * The script creates four tablespaces:
 * 1. PU_Data - Stores data for the PU schema (10MB initial, 200MB max)
 * 2. PU_Index - Stores indexes for the PU schema (10MB initial, 200MB max)
 * 3. ADM_Data - Stores data for the ADM schema (10MB initial, 200MB max)
 * 4. ADM_Index - Stores indexes for the ADM schema (10MB initial, 200MB max)
 * 
 * Each tablespace is configured with:
 * - Initial size of 10MB
 * - Autoextend enabled (grows by 512KB increments)
 * - Maximum size of 200MB
 * 
 * ===== Users =====
 * Two database users are created:
 * 1. PU - Public User schema with default tablespace PU_Data
 * 2. ADM - Administrator schema with default tablespace ADM_Data
 * 
 * Both users are assigned appropriate quotas:
 * - 10MB on their respective data tablespaces
 * - 10MB on their respective index tablespaces
 * - 5MB on the SYSTEM tablespace
 * 
 * ===== Privileges =====
 * Both users are granted identical privileges:
 * - CONNECT: Allows connection to the database
 * - CREATE SESSION: Allows creation of a database session
 * - CREATE TABLE: Allows table creation
 * - CREATE PROCEDURE: Allows stored procedure creation
 * - CREATE TRIGGER: Allows trigger creation
 * - CREATE SEQUENCE: Allows sequence creation
 * 
 * Note: File paths are configured for Windows environments and should be
 * adjusted for other operating systems as needed.
 */

-- Create PU_Data and PU_Index tablespaces
CREATE TABLESPACE PU_Data
    DATAFILE 'C:\app\dilan\oradata\DBProyecto\pudata01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON
    NEXT 512k
    MAXSIZE 200M;

CREATE TABLESPACE PU_Index
    DATAFILE 'C:\app\dilan\oradata\DBProyecto\puindex01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON
    NEXT 512k
    MAXSIZE 200M;

-- Create ADM tablespaces
CREATE TABLESPACE ADM_Data
    DATAFILE 'C:\app\hidal\oradata\LIGHTNING\Proyecto-1\admdata01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON
    NEXT 512k
    MAXSIZE 200M;

CREATE TABLESPACE ADM_Index
    DATAFILE 'C:\app\hidal\oradata\LIGHTNING\Proyecto-1\admindex01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON
    NEXT 512k
    MAXSIZE 200M;

-- Create PU schema (Public User)
CREATE USER PU 
    IDENTIFIED BY pu
    DEFAULT TABLESPACE PU_Data
    QUOTA 10M ON PU_Data
    TEMPORARY TABLESPACE temp
    QUOTA 5M ON SYSTEM
    QUOTA 10M ON PU_Index;

-- Create ADM schema (Administrator)
CREATE USER ADM 
    IDENTIFIED BY adm
    DEFAULT TABLESPACE ADM_Data
    QUOTA 10M ON ADM_Data
    TEMPORARY TABLESPACE temp
    QUOTA 5M ON SYSTEM
    QUOTA 10M ON ADM_Index;

-- Grant privileges to PU schema
GRANT CONNECT to PU;
GRANT CREATE SESSION to PU;
GRANT CREATE TABLE to PU;
GRANT CREATE PROCEDURE TO PU;
GRANT CREATE TRIGGER TO PU;
GRANT CREATE SEQUENCE TO PU;

-- Grant privileges to ADM schema
GRANT CONNECT to ADM;
GRANT CREATE SESSION to ADM;
GRANT CREATE TABLE to ADM;
GRANT CREATE PROCEDURE TO ADM;
GRANT CREATE TRIGGER TO ADM;
GRANT CREATE SEQUENCE TO ADM;
GRANT CREATE TYPE TO ADM;
