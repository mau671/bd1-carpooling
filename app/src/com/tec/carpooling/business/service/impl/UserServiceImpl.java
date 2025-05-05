package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.UserService;
import com.tec.carpooling.data.dao.UserDAO;
import com.tec.carpooling.data.dao.UserRegistrationException;
import com.tec.carpooling.data.impl.UserDAOImpl; // Simple injection, should improve with DI
import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.dto.LoginData;
import com.tec.carpooling.dto.UserRegistrationData;
import com.tec.carpooling.util.PasswordHasher;

/**
 * Implementation of the UserService interface that handles user-related business logic.
 * This service manages user registration and authentication.
 */
public class UserServiceImpl implements UserService {

    // Dependency Injection (simple implementation, should be improved with framework or constructor)
    private UserDAO userDAO = new UserDAOImpl(); // TODO: Improve this with proper DI

    /**
     * Registers a new user in the system.
     *
     * @param registrationData Data required for user registration
     * @return true if registration was successful, false otherwise
     * @throws UserRegistrationException When registration fails due to business rules
     * @throws Exception When unexpected errors occur
     */
    @Override
    public boolean registerUser(UserRegistrationData registrationData) throws UserRegistrationException, Exception {
        // 1. Basic validation in business layer
        if (registrationData.getPlainPassword() == null || registrationData.getPlainPassword().isEmpty()) {
             throw new UserRegistrationException("Password cannot be empty.");
        }
        // Additional validations could be added here

        try {
            // 2. Hash the password
            String hashedPassword = PasswordHasher.hashPassword(registrationData.getPlainPassword());
            registrationData.setHashedPassword(hashedPassword);

            // 3. Call DAO to execute the PL/SQL procedure
            long personId = userDAO.registerUserProcedure(registrationData);

            // 4. Verify result
            return personId > 0;

        } catch (UserRegistrationException e) {
            // Specific business error (user already exists, invalid domain, etc.)
            // Logging could be added here
            throw e; // Rethrow for presentation layer to handle
        } catch (Exception e) {
            // Unexpected error (SQL, configuration, etc.)
            // Detailed error logging could be added here
            throw new Exception("An unexpected error occurred during registration.", e);
        }
    }

    /**
     * Validates user credentials for login.
     *
     * @param loginData Contains username and password for authentication
     * @return true if credentials are valid, false otherwise
     * @throws Exception When unexpected errors occur during validation
     */
    @Override
    public boolean validateLogin(LoginData loginData) throws Exception {
        if (loginData.getUsername() == null || loginData.getUsername().isEmpty() ||
            loginData.getPlainPassword() == null || loginData.getPlainPassword().isEmpty()) {
            return false; // Could throw invalid data exception instead
        }

        try {
            // 1. Find user by username
            User user = userDAO.findUserByUsername(loginData.getUsername());

            // 2. If user doesn't exist, login fails
            if (user == null) {
                return false;
            }

            // 3. Verify password using the Hasher
            // Compare hash of provided password with stored hash
            return PasswordHasher.verifyPassword(loginData.getPlainPassword(), user.getPassword());

        } catch (Exception e) {
            // Logging could be added here
            throw new Exception("Error during login validation.", e);
        }
    }
}