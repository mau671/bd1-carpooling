package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.UserRegistrationService;
import com.tec.carpooling.data.dao.UserRegistrationDAO;
import com.tec.carpooling.data.dao.impl.UserRegistrationDAOImpl;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Base64;

/**
 * Implementation of the user registration service
 */
public class UserRegistrationServiceImpl implements UserRegistrationService {
    private final UserRegistrationDAO userRegistrationDAO;
    
    public UserRegistrationServiceImpl() {
        this.userRegistrationDAO = new UserRegistrationDAOImpl();
    }
    
    @Override
    public boolean registerUser(
        String firstName,
        String secondName,
        String firstSurname,
        String secondSurname,
        long idTypeId,
        String idNumber,
        long phoneTypeId,
        String phoneNumber,
        String email,
        LocalDate dateOfBirth,
        long genderId,
        long institutionId,
        long domainId,
        String username,
        String password
    ) throws SQLException {
        // Hash the password using SHA-256 and Base64 encoding
        String hashedPassword = hashPassword(password);
        
        // Call the DAO to register the user
        return userRegistrationDAO.registerUser(
            firstName,
            secondName,
            firstSurname,
            secondSurname,
            idTypeId,
            idNumber,
            phoneTypeId,
            phoneNumber,
            email,
            dateOfBirth,
            genderId,
            institutionId,
            domainId,
            username,
            hashedPassword
        );
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