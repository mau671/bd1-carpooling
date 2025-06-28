/*
 * File: 00_Database_Setup.sql
 * Description: MySQL Database Initialization Script
 * MySQL Version: 8.4.5 LTS
 * 
 * This script initializes the MySQL database structure for the PU (Public User) and ADM (Administrator) schemas.
 * It creates the necessary databases, user accounts, and grants appropriate privileges.
 * 
 * ===== Databases =====
 * The script creates databases to replace Oracle tablespaces:
 * 1. carpooling_pu - Database for Public User schema
 * 2. carpooling_adm - Database for Administrator schema
 * 
 * Each database is configured with:
 * - UTF8MB4 character set for full Unicode support
 * - utf8mb4_unicode_ci collation for proper sorting
 * 
 * ===== Users =====
 * Two database users are created:
 * 1. pu_user - Public User with access to carpooling_pu database
 * 2. adm_user - Administrator with access to carpooling_adm database
 * 
 * Authentication method: caching_sha2_password (MySQL 8.4.5 LTS default)
 * 
 * ===== Privileges =====
 * Users are granted database-specific privileges:
 * 
 * PU User privileges on carpooling_pu:
 * - SELECT, INSERT, UPDATE, DELETE: Data manipulation operations
 * - CREATE, ALTER, DROP: Schema modification operations
 * - INDEX: Index management
 * - CREATE TEMPORARY TABLES: Temporary table creation
 * - EXECUTE: Stored procedure and function execution
 * - CREATE ROUTINE, ALTER ROUTINE: Stored procedure/function creation and modification
 * - TRIGGER: Trigger creation and management
 * 
 * ADM User privileges on carpooling_adm:
 * - All privileges granted to PU user
 * - EVENT: Event scheduler operations
 * - LOCK TABLES: Table locking capabilities
 * - REFERENCES: Foreign key creation
 * - CREATE VIEW, SHOW VIEW: View operations
 * 
 * ===== MySQL 8.4.5 LTS Compatibility =====
 * This script is designed specifically for MySQL 8.4.5 LTS and includes:
 * - Modern authentication methods
 * - Optimal character set and collation settings
 * - Security best practices for user creation
 * - Proper privilege granularity
 * 
 * ===== Usage Instructions =====
 * 1. Connect to MySQL as root user
 * 2. Execute this script to set up the database structure
 * 3. Applications can then connect using:
 *    - PU User: mysql://pu_user:pu_password@host:3306/carpooling_pu
 *    - ADM User: mysql://adm_user:adm_password@host:3306/carpooling_adm
 */

-- =====================================================================
-- DATABASE CREATION
-- =====================================================================

-- Create carpooling_pu database (equivalent to PU_Data/PU_Index tablespaces)
-- Stores all PU schema data and indexes
CREATE DATABASE IF NOT EXISTS carpooling_pu
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Create carpooling_adm database (equivalent to ADM_Data/ADM_Index tablespaces)
-- Stores all ADM schema data and indexes
CREATE DATABASE IF NOT EXISTS carpooling_adm
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- =====================================================================
-- USER CREATION
-- =====================================================================

-- Create PU User (Public User) - equivalent to Oracle PU schema
-- Public User for carpooling_pu database
CREATE USER IF NOT EXISTS 'pu_user'@'%' 
    IDENTIFIED BY 'pu_password';

-- Create ADM User (Administrator) - equivalent to Oracle ADM schema
-- Administrator user for carpooling_adm database  
CREATE USER IF NOT EXISTS 'adm_user'@'%' 
    IDENTIFIED BY 'adm_password';

-- =====================================================================
-- PRIVILEGE GRANTS FOR PU USER
-- =====================================================================

-- Grant comprehensive privileges to PU user on carpooling_pu database
GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_pu.* TO 'pu_user'@'%';
GRANT CREATE, ALTER, DROP ON carpooling_pu.* TO 'pu_user'@'%';
GRANT INDEX ON carpooling_pu.* TO 'pu_user'@'%';
GRANT CREATE TEMPORARY TABLES ON carpooling_pu.* TO 'pu_user'@'%';
GRANT EXECUTE ON carpooling_pu.* TO 'pu_user'@'%';
GRANT CREATE ROUTINE, ALTER ROUTINE ON carpooling_pu.* TO 'pu_user'@'%';
GRANT TRIGGER ON carpooling_pu.* TO 'pu_user'@'%';

-- =====================================================================
-- PRIVILEGE GRANTS FOR ADM USER
-- =====================================================================

-- Grant comprehensive privileges to ADM user on carpooling_adm database
GRANT SELECT, INSERT, UPDATE, DELETE ON carpooling_adm.* TO 'adm_user'@'%';
GRANT CREATE, ALTER, DROP ON carpooling_adm.* TO 'adm_user'@'%';
GRANT INDEX ON carpooling_adm.* TO 'adm_user'@'%';
GRANT CREATE TEMPORARY TABLES ON carpooling_adm.* TO 'adm_user'@'%';
GRANT EXECUTE ON carpooling_adm.* TO 'adm_user'@'%';
GRANT CREATE ROUTINE, ALTER ROUTINE ON carpooling_adm.* TO 'adm_user'@'%';
GRANT TRIGGER ON carpooling_adm.* TO 'adm_user'@'%';
GRANT EVENT ON carpooling_adm.* TO 'adm_user'@'%';
GRANT LOCK TABLES ON carpooling_adm.* TO 'adm_user'@'%';
GRANT REFERENCES ON carpooling_adm.* TO 'adm_user'@'%';
GRANT CREATE VIEW, SHOW VIEW ON carpooling_adm.* TO 'adm_user'@'%';

-- =====================================================================
-- FLUSH PRIVILEGES
-- =====================================================================

-- Apply all privilege changes
FLUSH PRIVILEGES;

-- =====================================================================
-- VERIFICATION QUERIES (Optional - for testing)
-- =====================================================================

-- Show created databases
-- SELECT SCHEMA_NAME as 'Created Databases' 
-- FROM INFORMATION_SCHEMA.SCHEMATA 
-- WHERE SCHEMA_NAME IN ('carpooling_pu', 'carpooling_adm');

-- Show created users
-- SELECT User, Host, Account_locked, Password_expired 
-- FROM mysql.user 
-- WHERE User IN ('pu_user', 'adm_user');

-- Show user privileges
-- SHOW GRANTS FOR 'pu_user'@'%';
-- SHOW GRANTS FOR 'adm_user'@'%';

-- =====================================================================
-- ADDITIONAL NOTES
-- =====================================================================

/*
 * Migration Notes from Oracle to MySQL:
 * 
 * 1. TABLESPACES → DATABASES:
 *    Oracle tablespaces (PU_Data, PU_Index, ADM_Data, ADM_Index) are replaced
 *    with separate MySQL databases (carpooling_pu, carpooling_adm).
 * 
 * 2. SCHEMAS → DATABASES:
 *    Oracle schemas (PU, ADM) become MySQL databases with dedicated users.
 * 
 * 3. USER AUTHENTICATION:
 *    - Oracle: CREATE USER ... IDENTIFIED BY password
 *    - MySQL: CREATE USER ... IDENTIFIED BY password (uses caching_sha2_password by default in 8.4.5)
 * 
 * 4. QUOTA MANAGEMENT:
 *    Oracle tablespace quotas are not directly equivalent in MySQL.
 *    Resource limits can be configured at the user level if needed.
 * 
 * 5. PRIVILEGES MAPPING:
 *    - Oracle CONNECT → MySQL connection capability (implicit)
 *    - Oracle CREATE SESSION → MySQL connection capability (implicit)
 *    - Oracle CREATE TABLE → MySQL CREATE
 *    - Oracle CREATE PROCEDURE → MySQL CREATE ROUTINE
 *    - Oracle CREATE TRIGGER → MySQL TRIGGER
 *    - Oracle CREATE SEQUENCE → MySQL AUTO_INCREMENT (no explicit grant needed)
 *    - Oracle CREATE TYPE → Not applicable in MySQL (uses built-in types)
 *    - Oracle CREATE JOB → MySQL EVENT
 * 
 * 6. CHARACTER SET:
 *    utf8mb4 is used for full Unicode support including emojis and special characters.
 * 
 * 7. COLLATION:
 *    utf8mb4_unicode_ci provides accurate Unicode sorting and comparison.
 * 
 * Connection Examples:
 * ===================
 * 
 * For PU User:
 * mysql -h localhost -u pu_user -p'pu_password' carpooling_pu
 * 
 * For ADM User:
 * mysql -h localhost -u adm_user -p'adm_password' carpooling_adm
 * 
 * JDBC URLs:
 * jdbc:mysql://localhost:3306/carpooling_pu?user=pu_user&password=pu_password
 * jdbc:mysql://localhost:3306/carpooling_adm?user=adm_user&password=adm_password
 * 
 * Docker Connection (using compose.yaml setup):
 * mysql -h 172.99.0.4 -u pu_user -p'pu_password' carpooling_pu
 * mysql -h 172.99.0.4 -u adm_user -p'adm_password' carpooling_adm
 */
