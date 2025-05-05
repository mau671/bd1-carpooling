package com.tec.carpooling.business.service.impl;

import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import com.tec.carpooling.business.service.UserService;
import com.tec.carpooling.data.dao.UserDAO;
import com.tec.carpooling.data.impl.UserDAOImpl;
import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.dto.LoginData;
import com.tec.carpooling.dto.LoginResultDTO;
import com.tec.carpooling.util.PasswordHasher;
import com.tec.carpooling.util.SessionManager;
import com.tec.carpooling.exception.UserRegistrationException;
import com.tec.carpooling.dto.UserRegistrationData;
import com.tec.carpooling.util.SessionManager;


/**
 * Implementation of the UserService interface that handles user authentication and role validation.
 */
public class UserServiceImpl implements UserService {

    private final UserDAO userDAO = new UserDAOImpl();

    /**
     * Registers a new user in the system.
     * 
     * @param registrationData User data required for registration
     * @return true if registration was successful, false otherwise
     * @throws UserRegistrationException If validation fails or specific database errors occur
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public boolean registerUser(UserRegistrationDTO registrationData) throws UserRegistrationException, Exception {
        // Registration logic here (not implemented in this snippet)
        return false;
    }

    /**
     * Validates user login credentials and retrieves associated roles.
     * 
     * @param loginData Object containing username and password
     * @return LoginResultDTO containing authenticated user and roles (if successful)
     * @throws Exception If a database error or unexpected problem occurs
     */
    @Override
    public LoginResultDTO validateLoginAndGetRoles(LoginData loginData) throws Exception {
        User user = null;
        Set<String> roles = new HashSet<>();

        // Validate input data
        if (isLoginDataInvalid(loginData)) {
            System.err.println("Login attempt with empty credentials.");
            return new LoginResultDTO(null, roles); // Login fails
        }

        try {
            // Find user by username
            user = userDAO.findUserByUsername(loginData.getUsername());

            // Verify user exists and password matches
            if (isAuthenticationFailed(user, loginData.getPlainPassword())) {
                System.out.println("Failed login for user: " + loginData.getUsername());
                return new LoginResultDTO(null, roles); // Login fails
            }

            // User authenticated, collect roles
            System.out.println("User authenticated: " + user.getUsername() + ", PersonID: " + user.getPersonId());
            roles = collectUserRoles(user.getPersonId());

            // Handle case when user has no roles
            if (roles.isEmpty()) {
                System.err.println("Warning! User " + user.getUsername() + " authenticated but has no roles (DRIVER/PASSENGER) assigned.");
                // For now, failing login if no functional role exists
                return new LoginResultDTO(null, roles);
            }

            // Successful login with user and roles
            System.out.println("Successful login for " + user.getUsername() + " with roles: " + roles);
            return new LoginResultDTO(user, roles);

        } catch (SQLException sqle) {
            // Log specific SQL error
            System.err.println("Database error during login for " + loginData.getUsername());
            sqle.printStackTrace();
            throw new Exception("Database error during login.", sqle);
        } catch (Exception e) {
            // Log unexpected error
            System.err.println("Unexpected error during login for " + loginData.getUsername());
            e.printStackTrace();
            throw new Exception("Unexpected error during login.", e);
        }
    }
    
    /**
     * Checks if login data is invalid (null or empty username/password).
     *
     * @param loginData The login credentials to validate
     * @return true if data is invalid, false otherwise
     */
    private boolean isLoginDataInvalid(LoginData loginData) {
        return loginData.getUsername() == null || loginData.getUsername().isEmpty() ||
               loginData.getPlainPassword() == null || loginData.getPlainPassword().isEmpty();
    }
    
    /**
     * Verifies if authentication should fail based on user existence and password.
     *
     * @param user The user to authenticate
     * @param plainPassword The password provided in plain text
     * @return true if authentication should fail, false otherwise
     */
    private boolean isAuthenticationFailed(User user, String plainPassword) {
        return user == null || !PasswordHasher.verifyPassword(plainPassword, user.getPassword());
    }
    
    /**
     * Collects all roles associated with a user.
     *
     * @param personId The person ID to check for roles
     * @return Set of role identifiers
     * @throws SQLException If a database error occurs
     */
    private Set<String> collectUserRoles(int personId) throws SQLException {
        Set<String> roles = new HashSet<>();
        
        if (userDAO.isDriver(personId)) {
            roles.add(SessionManager.ROLE_DRIVER);
            System.out.println("Role detected: DRIVER");
        }
        
        if (userDAO.isPassenger(personId)) {
            roles.add(SessionManager.ROLE_PASSENGER);
            System.out.println("Role detected: PASSENGER");
        }
        
        return roles;
    }
}
