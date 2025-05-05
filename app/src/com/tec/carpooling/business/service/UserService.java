package com.tec.carpooling.business.service;

import com.tec.carpooling.dto.LoginData;
import com.tec.carpooling.dto.UserRegistrationData;
import com.tec.carpooling.data.dao.UserRegistrationException;

/**
 * Service interface for user-related operations.
 * Handles user registration, authentication, and other user-related business logic.
 */
public interface UserService {

    /**
     * Registers a new user in the system.
     * 
     * @param registrationData User data required for registration
     * @return true if registration was successful, false otherwise
     * @throws UserRegistrationException If validation fails or specific database errors occur
     * @throws Exception If an unexpected error occurs
     */
    boolean registerUser(UserRegistrationData registrationData) throws UserRegistrationException, Exception;

    /**
     * Validates user login credentials.
     * 
     * @param loginData Login credentials (username, plainPassword)
     * @return true if credentials are valid, false otherwise
     * @throws Exception If an error occurs during validation
     */
    boolean validateLogin(LoginData loginData) throws Exception;

    // Other user-related business methods...
}