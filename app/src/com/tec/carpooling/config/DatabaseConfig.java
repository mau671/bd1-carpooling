package com.tec.carpooling.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Configuration class responsible for loading and providing access to database connection properties.
 * This class reads configuration from a properties file located in the classpath.
 */
public class DatabaseConfig {

    private static final Properties properties = new Properties();
    private static final String PROPERTIES_FILE = "/config/db.properties"; // Path in classpath

    /**
     * Static initializer block that loads database configuration when the class is loaded.
     * If the properties file cannot be found or read, appropriate error messages are displayed.
     */
    static {
        try (InputStream input = DatabaseConfig.class.getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                System.err.println("Error: Could not find file " + PROPERTIES_FILE);
                // Consider throwing an exception here to stop the application if critical
            } else {
                properties.load(input);
            }
        } catch (IOException ex) {
            // Log the error appropriately
            System.err.println("Error loading database configuration: " + ex.getMessage());
            // Consider throwing a RuntimeException
        }
    }

    /**
     * Returns the database URL from configuration.
     * 
     * @return the database connection URL
     */
    public static String getDbUrl() {
        return properties.getProperty("db.url");
    }

    /**
     * Returns the database username from configuration.
     * 
     * @return the database username
     */
    public static String getDbUsername() {
        return properties.getProperty("db.username");
    }

    /**
     * Returns the database password from configuration.
     * 
     * @return the database password
     */
    public static String getDbPassword() {
        return properties.getProperty("db.password");
    }

    /**
     * Returns the database driver class name from configuration.
     * If not specified in the properties file, returns a default Oracle driver.
     * 
     * @return the database driver class name
     */
    public static String getDbDriver() {
        return properties.getProperty("db.driver", "oracle.jdbc.driver.OracleDriver"); // Default value
    }
}