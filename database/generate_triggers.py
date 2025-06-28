#!/usr/bin/env python3
"""
================================================================================
 CARPOOLING AUDIT TRIGGERS GENERATOR
================================================================================
 
 File: generate_triggers.py
 Purpose: Automatic generation of audit triggers for all tables in the carpooling database
 Project: IC4301 Database I - Project 01
 Version: 2.0
 Created: June 5, 2025
 
 Description:
   This script automatically generates audit triggers for all tables defined in
   01_Tables.sql. It parses the table definitions and creates:
   - Before Insert triggers (for creator and creation_date)
   - Before Update triggers (for modifier and modification_date)
   - After Update triggers (for logging changes to the LOGS table)
 
 Features:
   - Automatically detects all tables from 01_Tables.sql
   - Identifies database schemas (carpooling_adm vs carpooling_pu)
   - Generates triggers only for tables with audit columns
   - Creates comprehensive SQL script with proper formatting
   - Excludes system tables and non-auditable tables
 
 Usage:
   python3 generate_triggers.py
 
 Output:
   - v2/output/Triggers.sql: Complete triggers script ready for execution
 
================================================================================
"""

import re
import os
from datetime import datetime
from pathlib import Path

class TriggerGenerator:
    def __init__(self):
        self.current_dir = Path(__file__).parent
        self.tables_file = self.current_dir / "01_Tables.sql"
        self.output_file = self.current_dir / "Triggers.sql"
        
        # Tables that need audit triggers (have audit columns)
        self.adm_tables = []
        self.pu_tables = []
        
        # Audit columns that we track
        self.audit_columns = ['creator', 'creation_date', 'modifier', 'modification_date']
        
    def parse_tables_file(self):
        """Parse the 01_Tables.sql file to extract table information"""
        try:
            with open(self.tables_file, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # Split content by database sections
            sections = re.split(r'USE\s+(carpooling_\w+);', content)
            current_database = None
            
            for i, section in enumerate(sections):
                # Check if this section starts with a database name
                if section.strip() in ['carpooling_adm', 'carpooling_pu']:
                    current_database = section.strip()
                    continue
                
                # Skip if no current database context
                if not current_database:
                    continue
                
                # Find all CREATE TABLE statements in this section
                table_matches = re.finditer(
                    r'CREATE TABLE\s+(\w+)\s*\((.*?)\)\s*ENGINE=InnoDB',
                    section,
                    re.DOTALL | re.IGNORECASE
                )
                
                for match in table_matches:
                    table_name = match.group(1)
                    table_definition = match.group(2)
                    
                    # Check if table has audit columns
                    if self.has_audit_columns(table_definition):
                        table_info = {
                            'name': table_name,
                            'database': current_database,
                            'columns': self.extract_columns(table_definition)
                        }
                        
                        if current_database == 'carpooling_adm':
                            self.adm_tables.append(table_info)
                        elif current_database == 'carpooling_pu':
                            self.pu_tables.append(table_info)
            
            print(f"Found {len(self.adm_tables)} ADM tables with audit columns")
            print(f"Found {len(self.pu_tables)} PU tables with audit columns")
            
        except FileNotFoundError:
            print(f"Error: {self.tables_file} not found!")
            raise
        except Exception as e:
            print(f"Error parsing tables file: {e}")
            raise
    
    def has_audit_columns(self, table_definition):
        """Check if table definition contains audit columns"""
        return any(col in table_definition.lower() for col in ['creator', 'creation_date', 'modifier', 'modification_date'])
    
    def extract_columns(self, table_definition):
        """Extract column names from table definition (excluding audit columns)"""
        columns = []
        lines = table_definition.split('\n')
        
        for line in lines:
            line = line.strip()
            if line and not line.startswith('--') and not line.startswith('/*'):
                # Match column definitions
                col_match = re.match(r'(\w+)\s+\w+', line)
                if col_match:
                    col_name = col_match.group(1).lower()
                    # Exclude audit columns, constraints, and indexes
                    if (col_name not in self.audit_columns and 
                        not col_name.startswith('constraint') and
                        not col_name.startswith('index') and
                        not col_name.startswith('primary') and
                        not col_name.startswith('foreign') and
                        not col_name.startswith('unique')):
                        columns.append(col_name)
        
        return columns
    
    def generate_trigger_for_table(self, table_info):
        """Generate trigger SQL for a specific table"""
        table_name = table_info['name']
        database = table_info['database']
        columns = table_info['columns']
        
        trigger_sql = f"""
-- ========================================
-- AUDIT TRIGGERS FOR: {database}.{table_name}
-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
-- ========================================

-- Step 1: Remove existing triggers
DROP TRIGGER IF EXISTS {table_name}_bi;
DROP TRIGGER IF EXISTS {table_name}_bu;
DROP TRIGGER IF EXISTS {table_name}_au;

-- Step 2: Create BEFORE INSERT trigger
DELIMITER $$
CREATE TRIGGER {table_name}_bi
BEFORE INSERT ON {table_name}
FOR EACH ROW
SET NEW.creator = COALESCE(@app_user, CURRENT_USER()),
    NEW.creation_date = COALESCE(NEW.creation_date, CURRENT_DATE())$$
DELIMITER ;

-- Step 3: Create BEFORE UPDATE trigger
DELIMITER $$
CREATE TRIGGER {table_name}_bu
BEFORE UPDATE ON {table_name}
FOR EACH ROW
SET NEW.modifier = COALESCE(@app_user, CURRENT_USER()),
    NEW.modification_date = CURRENT_DATE()$$
DELIMITER ;
"""
        
        # Add AFTER UPDATE trigger only if there are auditable columns
        if columns:
            trigger_sql += f"""
-- Step 4: Create AFTER UPDATE trigger for audit logging
DELIMITER $$
CREATE TRIGGER {table_name}_au
AFTER UPDATE ON {table_name}
FOR EACH ROW
BEGIN
    DECLARE v_user VARCHAR(50) DEFAULT COALESCE(@app_user, CURRENT_USER());
"""
            
            # Add column-by-column change tracking
            for column in columns:
                trigger_sql += f"""
    IF NOT (OLD.`{column}` <=> NEW.`{column}`) THEN
        INSERT INTO carpooling_adm.LOGS 
        (schema_name, table_name, field_name, previous_value, current_value, 
         creator, creation_date, modifier, modification_date) VALUES 
        ('{database}', '{table_name}', '{column}', 
         OLD.`{column}`, NEW.`{column}`, 
         v_user, CURRENT_DATE(), v_user, CURRENT_DATE());
    END IF;"""
            
            trigger_sql += """
END$$
DELIMITER ;
"""
        
        return trigger_sql
    
    def generate_complete_script(self):
        """Generate the complete triggers script"""
        header = f"""/*
================================================================================
 CARPOOLING AUDIT TRIGGERS - COMPLETE SCRIPT
================================================================================
 
 File: Triggers.sql
 Purpose: Complete set of audit triggers for all carpooling database tables
 Project: IC4301 Database I - Project 01
 Version: 2.0
 Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
 
 Description:
   This script contains audit triggers for all tables in the carpooling system.
   Each table with audit columns gets three triggers:
   - BEFORE INSERT: Sets creator and creation_date automatically
   - BEFORE UPDATE: Sets modifier and modification_date automatically  
   - AFTER UPDATE: Logs field-level changes to carpooling_adm.LOGS table
 
 Prerequisites:
   - carpooling_adm.LOGS table must exist
   - Tables must have audit columns (creator, creation_date, modifier, modification_date)
   - Users must have TRIGGER privilege on respective databases
   - For application use, set @app_user session variable before operations
 
 Usage Instructions:
   1. Execute this script in MySQL as a user with TRIGGER privileges
   2. Verify triggers were created: SHOW TRIGGERS;
   3. Test with INSERT/UPDATE operations
   4. Check audit logs: SELECT * FROM carpooling_adm.LOGS;
 
 Application Usage:
   -- Set application user context
   SET @app_user = 'your_application_user';
   
   -- Perform database operations
   INSERT INTO carpooling_adm.GENDER (name) VALUES ('Male');
   UPDATE carpooling_adm.GENDER SET name = 'Masculine' WHERE name = 'Male';
   
   -- Check logs
   SELECT * FROM carpooling_adm.LOGS WHERE table_name = 'GENDER';
 
================================================================================
*/

-- Enable binary logging for triggers (execute as root/admin if needed)
-- SET GLOBAL log_bin_trust_function_creators = 1;

"""
        
        # Generate triggers for ADM tables
        adm_section = """
-- =====================================================================
-- ADM DATABASE TRIGGERS (carpooling_adm)
-- =====================================================================
-- Administrative and master data tables

-- Switch to ADM database context
USE carpooling_adm;
"""
        
        for table in self.adm_tables:
            adm_section += self.generate_trigger_for_table(table)
        
        # Generate triggers for PU tables
        pu_section = """
-- =====================================================================
-- PU DATABASE TRIGGERS (carpooling_pu) 
-- =====================================================================
-- Public user and operational data tables

-- Switch to PU database context
USE carpooling_pu;
"""
        
        for table in self.pu_tables:
            pu_section += self.generate_trigger_for_table(table)
        
        # Footer with testing instructions
        footer = f"""
-- =====================================================================
-- VERIFICATION AND TESTING
-- =====================================================================

-- Show all created triggers
SHOW TRIGGERS FROM carpooling_adm;
SHOW TRIGGERS FROM carpooling_pu;

-- Test example (uncomment to test):
/*
-- Set application user
SET @app_user = 'test_user';

-- Test insert (creator and creation_date should be auto-set)
INSERT INTO carpooling_adm.GENDER (name) VALUES ('Test Gender');

-- Test update (modifier, modification_date auto-set, changes logged)
UPDATE carpooling_adm.GENDER 
SET name = 'Updated Test Gender' 
WHERE name = 'Test Gender';

-- Check audit logs
SELECT * FROM carpooling_adm.LOGS 
WHERE table_name = 'GENDER' 
ORDER BY creation_date DESC, id DESC;

-- Cleanup test data
DELETE FROM carpooling_adm.GENDER WHERE name LIKE '%Test%';
DELETE FROM carpooling_adm.LOGS WHERE table_name = 'GENDER' AND creator = 'test_user';
*/

-- =====================================================================
-- SUMMARY
-- =====================================================================
/*
 * Triggers created for {len(self.adm_tables)} ADM tables:
 * {', '.join([t['name'] for t in self.adm_tables])}
 * 
 * Triggers created for {len(self.pu_tables)} PU tables:
 * {', '.join([t['name'] for t in self.pu_tables])}
 * 
 * Total triggers: {3 * (len(self.adm_tables) + len(self.pu_tables))} 
 * ({3 * len(self.adm_tables)} ADM + {3 * len(self.pu_tables)} PU)
 * 
 * Each table has 3 triggers:
 * - tablename_bi (BEFORE INSERT)
 * - tablename_bu (BEFORE UPDATE) 
 * - tablename_au (AFTER UPDATE)
 */
"""
        
        return header + adm_section + pu_section + footer
    
    def save_script(self, script_content):
        """Save the generated script to the output file"""
        try:
            # Ensure output directory exists
            self.output_file.parent.mkdir(parents=True, exist_ok=True)
            
            with open(self.output_file, 'w', encoding='utf-8') as file:
                file.write(script_content)
            
            print(f"✅ Triggers script generated successfully!")
            print(f"📁 Output file: {self.output_file}")
            print(f"📊 Total tables processed: {len(self.adm_tables) + len(self.pu_tables)}")
            print(f"🔧 Total triggers generated: {3 * (len(self.adm_tables) + len(self.pu_tables))}")
            
        except Exception as e:
            print(f"❌ Error saving script: {e}")
            raise
    
    def run(self):
        """Main execution method"""
        print("🚀 Starting Carpooling Audit Triggers Generator...")
        print("=" * 60)
        
        # Parse the tables file
        print("📖 Parsing 01_Tables.sql...")
        self.parse_tables_file()
        
        # Generate the complete script
        print("⚙️  Generating triggers script...")
        script_content = self.generate_complete_script()
        
        # Save the script
        print("💾 Saving triggers script...")
        self.save_script(script_content)
        
        print("=" * 60)
        print("✨ Generation completed successfully!")
        print(f"""
Next steps:
1. Review the generated file: {self.output_file}
2. Execute the script in MySQL with TRIGGER privileges
3. Verify with: SHOW TRIGGERS;
4. Test with sample INSERT/UPDATE operations
""")

def main():
    """Main entry point"""
    try:
        generator = TriggerGenerator()
        generator.run()
    except KeyboardInterrupt:
        print("\n❌ Generation cancelled by user")
    except Exception as e:
        print(f"❌ Error: {e}")
        return 1
    
    return 0

if __name__ == "__main__":
    exit(main())
