package com.tec.carpooling.business.service;

import com.tec.carpooling.domain.entity.User;
import java.sql.SQLException;

/**
 * Service interface for user login operations
 */
public interface UserLoginService {
    /**
     * Authenticates a user with the given username and password
     * 
     * @param username The username to authenticate
     * @param password The password to verify (will be hashed internally)
     * @return User object if authentication is successful, null otherwise
     * @throws SQLException If a database access error occurs
     */
    User login(String username, String password) throws SQLException;
} 