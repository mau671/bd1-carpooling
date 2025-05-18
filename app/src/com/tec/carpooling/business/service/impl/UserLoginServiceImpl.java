package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.UserLoginService;
import com.tec.carpooling.data.dao.UserLoginDAO;
import com.tec.carpooling.data.dao.impl.UserLoginDAOImpl;
import com.tec.carpooling.domain.entity.User;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Base64;

/**
 * Implementation of the UserLoginService interface
 */
public class UserLoginServiceImpl implements UserLoginService {
    private final UserLoginDAO userLoginDAO;
    
    public UserLoginServiceImpl() {
        this.userLoginDAO = new UserLoginDAOImpl();
    }
    
    @Override
    public User login(String username, String password) throws SQLException {
        // Hash the password using SHA-256 and Base64 encoding
        String hashedPassword = hashPassword(password);
        
        // Call the DAO to authenticate the user
        return userLoginDAO.authenticateUser(username, hashedPassword);
    }
    
    /**
     * Hashes a password using SHA-256 and Base64 encoding
     * 
     * @param password The password to hash
     * @return The hashed password
     */
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
} 