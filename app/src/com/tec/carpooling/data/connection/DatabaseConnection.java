package com.tec.carpooling.data.connection;

import com.tec.carpooling.config.DatabaseConfig;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Handles database connection management for the carpooling application.
 * This class provides methods to obtain database connections.
 */
public class DatabaseConnection {
    
    /**
     * Establishes and returns a connection to the database.
     * 
     * @return A Connection object representing the database connection
     * @throws SQLException If a database access error occurs or connection parameters are invalid
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Load the driver (optional in JDBC 4.0+, but good for compatibility)
            Class.forName(DatabaseConfig.getDbDriver());
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error: Oracle JDBC driver not found.", e);
        }
        
        // Return connection using configuration parameters
        return DriverManager.getConnection(
            DatabaseConfig.getDbUrl(),
            DatabaseConfig.getDbUsername(),
            DatabaseConfig.getDbPassword()
        );
    }
    
    /* 
     * Improvement considerations:
     * 
     * 1. Implement a Connection Pool (HikariCP, Apache DBCP, C3P0)
     *    to reuse connections and improve performance.
     * 2. Centralize the closing of Connection, Statement, and ResultSet objects
     *    in utility methods or consistently use try-with-resources.
     */
}