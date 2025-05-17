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

    private static final String ROLE_DRIVER = "DRIVER";
    private static final String ROLE_PASSENGER = "PASSENGER";
    
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
    public boolean registerUser(UserRegistrationData registrationData) throws UserRegistrationException, Exception {
        try {
            validateRegistrationData(registrationData);
            checkExistingUser(registrationData.getUsername());
            
            User newUser = createUserFromRegistrationData(registrationData);
            return userDAO.registerUser(newUser);
            
        } catch (SQLException e) {
            throw new UserRegistrationException("Error registering user: " + e.getMessage(), e);
        }
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
        try {
            if (isLoginDataInvalid(loginData)) {
                return createFailedLoginResult();
            }
            
            User user = userDAO.findUserByUsername(loginData.getUsername());
            if (isAuthenticationFailed(user, loginData.getPlainPassword())) {
                return createFailedLoginResult();
            }
            
            Set<String> roles = collectUserRoles(user.getPersonId());
            return new LoginResultDTO(user, roles);
            
        } catch (SQLException e) {
            throw new Exception("Error validating credentials: " + e.getMessage(), e);
        }
    }
    
    private void validateRegistrationData(UserRegistrationData data) throws UserRegistrationException {
        if (data == null || 
            data.getUsername() == null || data.getUsername().isEmpty() ||
            data.getPassword() == null || data.getPassword().isEmpty() ||
            data.getPersonId() <= 0) {
            throw new UserRegistrationException("Invalid registration data");
        }
    }
    
    private void checkExistingUser(String username) throws SQLException, UserRegistrationException {
        User existingUser = userDAO.findUserByUsername(username);
        if (existingUser != null) {
            throw new UserRegistrationException("Username is already in use");
        }
    }
    
    private User createUserFromRegistrationData(UserRegistrationData data) {
        User newUser = new User();
        newUser.setUsername(data.getUsername());
        newUser.setPassword(PasswordHasher.hashPassword(data.getPassword()));
        newUser.setPersonId(data.getPersonId());
        return newUser;
    }
    
    private boolean isLoginDataInvalid(LoginData loginData) {
        return loginData == null || 
               loginData.getUsername() == null || loginData.getUsername().isEmpty() ||
               loginData.getPlainPassword() == null || loginData.getPlainPassword().isEmpty();
    }
    
    private LoginResultDTO createFailedLoginResult() {
        return new LoginResultDTO(null, new HashSet<>());
    }
    
    private boolean isAuthenticationFailed(User user, String plainPassword) {
        return user == null || !PasswordHasher.verifyPassword(plainPassword, user.getPassword());
    }
    
    private Set<String> collectUserRoles(long personId) throws SQLException {
        Set<String> roles = new HashSet<>();
        
        if (userDAO.isDriver(personId)) {
            roles.add(ROLE_DRIVER);
        }
        if (userDAO.isPassenger(personId)) {
            roles.add(ROLE_PASSENGER);
        }
        
        return roles;
    }
}

