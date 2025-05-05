/*
 * UserDAO - Data Access Object for managing user-related database operations
 */
package com.tec.carpooling.data.dao;
import java.sql.SQLException;

/**
 * UserDAO handles data access operations for users in the carpooling system.
 * This class provides methods to check user roles and types in the system.
 *
 * @author mauricio
 */
public interface UserDAO {
    /**
     * Checks if a person is registered as a driver.
     * 
     * @param personId The ID of the person (ADM.PERSON.id)
     * @return true if there is an entry in PU.DRIVER for this person, false otherwise
     * @throws SQLException If a database error occurs
     */
    boolean isDriver(long personId) throws SQLException;

    /**
     * Checks if a person is registered as a passenger.
     * 
     * @param personId The ID of the person (ADM.PERSON.id)
     * @return true if there is an entry in PU.PASSENGER for this person, false otherwise
     * @throws SQLException If a database error occurs
     */
    boolean isPassenger(long personId) throws SQLException;
}
