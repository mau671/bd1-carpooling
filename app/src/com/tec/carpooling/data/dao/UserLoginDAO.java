package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.User;
import java.sql.SQLException;

/**
 * Data Access Object interface for user login operations
 */
public interface UserLoginDAO {
    /**
     * Authenticates a user with the given username and password
     * 
     * @param username The username to authenticate
     * @param hashedPassword The hashed password to verify
     * @return User object if authentication is successful, null otherwise
     * @throws SQLException If a database access error occurs
     */
    User authenticateUser(String username, String hashedPassword) throws SQLException;
} 