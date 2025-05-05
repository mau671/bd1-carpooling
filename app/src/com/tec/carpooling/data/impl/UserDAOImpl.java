/*
 * User Data Access Object Implementation
 * This class implements the UserDAO interface for database operations.
 */
package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.dao.UserDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.tec.carpooling.data.connection.DatabaseConnection;

/**
 * Implementation of the UserDAO interface. Provides database operations
 * for user role verification.
 *
 * @author mauricio
 */
public class UserDAOImpl implements UserDAO {
    
    /**
     * Checks if a person is registered as a driver.
     *
     * @param personId The unique identifier of the person
     * @return true if the person is a driver, false otherwise
     * @throws SQLException if a database access error occurs
     */
    @Override
    public boolean isDriver(long personId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM PU.DRIVER WHERE person_id = ?";
        return checkRoleExists(sql, personId);
    }

    /**
     * Checks if a person is registered as a passenger.
     *
     * @param personId The unique identifier of the person
     * @return true if the person is a passenger, false otherwise
     * @throws SQLException if a database access error occurs
     */
    @Override
    public boolean isPassenger(long personId) throws SQLException {
         String sql = "SELECT COUNT(*) FROM PU.PASSENGER WHERE person_id = ?";
         return checkRoleExists(sql, personId);
    }

    /**
     * Helper method to check existence in role tables.
     * Uses prepared statements to prevent SQL injection.
     *
     * @param sql The SQL query to execute
     * @param personId The person ID to check
     * @return true if the role exists for the person, false otherwise
     * @throws SQLException if a database access error occurs
     */
    private boolean checkRoleExists(String sql, long personId) throws SQLException {
        boolean exists = false;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, personId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking role for personId " + personId + ": " + e.getMessage());
            throw e; // Rethrow for higher layer handling
        }
        return exists;
    }
}
