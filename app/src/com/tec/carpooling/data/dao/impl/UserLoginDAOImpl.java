package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.dao.UserLoginDAO;
import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.domain.entity.User;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 * Implementation of the UserLoginDAO interface
 */
public class UserLoginDAOImpl implements UserLoginDAO {
    private static final String AUTHENTICATE_USER_PROCEDURE = 
        "{? = call ADM.ADM_USER_AUTH_PKG.authenticate_user(?, ?)}";
    
    @Override
    public User authenticateUser(String username, String hashedPassword) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(AUTHENTICATE_USER_PROCEDURE)) {
            
            // Register the output parameter for the cursor
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            
            // Set input parameters
            stmt.setString(2, username);
            stmt.setString(3, hashedPassword);
            
            // Execute the procedure
            stmt.execute();
            
            // Get the result set from the cursor
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                if (rs.next()) {
                    return new User(
                        rs.getLong("id"),
                        rs.getString("username"),
                        rs.getLong("person_id")
                    );
                }
            }
            
            return null; // Authentication failed
        }
    }
} 