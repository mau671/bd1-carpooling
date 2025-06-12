package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.dao.UserLoginDAO;
import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.domain.entity.User;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Implementation of the UserLoginDAO interface for MySQL
 */
public class UserLoginDAOImpl implements UserLoginDAO {
    private static final String AUTHENTICATE_USER_PROCEDURE = 
        "{call carpooling_adm.authenticate_user(?, ?)}";
    
    @Override
    public User authenticateUser(String username, String hashedPassword) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(AUTHENTICATE_USER_PROCEDURE)) {
            
            // Set input parameters
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            
            // Execute the procedure
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getLong("user_id"),
                        rs.getString("username"),
                        rs.getLong("person_id")
                    );
                }
            }
            
            return null; // Authentication failed
        }
    }
} 