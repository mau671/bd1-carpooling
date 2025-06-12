package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.UserRegistrationService;
import com.tec.carpooling.data.dao.UserRegistrationDAO;
import com.tec.carpooling.data.dao.impl.UserRegistrationDAOImpl;
import com.tec.carpooling.data.dao.impl.UserRegistrationDAOImpl.RegistrationResult;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Base64;

/**
 * Implementation of the user registration service
 */
public class UserRegistrationServiceImpl implements UserRegistrationService {
    private final UserRegistrationDAOImpl userRegistrationDAO;
    
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
        return registerUser(firstName, secondName, firstSurname, secondSurname,
                idTypeId, idNumber, phoneTypeId, phoneNumber, email, dateOfBirth,
                genderId, institutionId, domainId, username, password, null);
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
        String password,
        byte[] photoData
    ) throws SQLException {
        // Hash the password using SHA-256 and Base64 encoding
        String hashedPassword = hashPassword(password);
        
        // Call the DAO to register the user and get the result with user_id
        RegistrationResult registrationResult = userRegistrationDAO.registerUserWithResult(
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
        
        // Check if registration was successful
        if (!registrationResult.isSuccessful()) {
            return false;
        }
        
        // If registration successful and photo data provided, add the photo
        if (photoData != null && photoData.length > 0) {
            try {
                // Use the person_id from registration result (more direct since PHOTO table references PERSON)
                long photoId = userRegistrationDAO.addPersonPhoto(registrationResult.getPersonId(), photoData);
                if (photoId <= 0) {
                    System.err.println("Warning: User registered successfully but photo upload failed: Invalid photo ID returned");
                    return true; // Registration was successful even if photo failed
                }
            } catch (SQLException e) {
                // Log the error but don't fail the registration
                System.err.println("Warning: User registered successfully but photo upload failed: " + e.getMessage());
                return true; // Registration was successful even if photo failed
            }
        }
        
        return true;
    }
    
    /**
     * Hashes a password using SHA-256 and Base64 encoding
     * 
     * @param password The password to hash
     * @return The hashed password
     * @throws RuntimeException if the hashing algorithm is not available
     */
    private String hashPassword(String password) throws RuntimeException {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error: SHA-256 algorithm not available", e);
        }
    }
} 