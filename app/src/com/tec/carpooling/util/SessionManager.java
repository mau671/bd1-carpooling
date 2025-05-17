package com.tec.carpooling.util;

import com.tec.carpooling.domain.entity.User;
import java.util.Set;
import java.util.HashSet;

/**
 * Singleton class that manages the current user session in the application.
 * Handles user authentication state, roles, and session information.
 */
public class SessionManager {

    private static SessionManager instance;

    private User currentUser;
    private Set<String> userRoles; // Stores "ROLE_DRIVER", "ROLE_PASSENGER"
    private String currentRole;    // Currently selected role for the active session

    public static final String ROLE_DRIVER = "DRIVER";
    public static final String ROLE_PASSENGER = "PASSENGER";
    // Could also have ROLE_ADMIN in the future

    // Private constructor for Singleton pattern
    private SessionManager() {
        userRoles = new HashSet<>();
    }

    /**
     * Gets the single instance of SessionManager.
     * @return The Singleton instance.
     */
    public static synchronized SessionManager getInstance() {
        if (instance == null) {
            instance = new SessionManager();
        }
        return instance;
    }

    /**
     * Starts a session for a user with a specific role.
     * @param user The User object containing logged-in user details.
     * @param roles The available roles for this user (DRIVER, PASSENGER).
     * @param selectedRole The specific role selected for this session.
     */
    public void login(User user, Set<String> roles, String selectedRole) {
        if (user == null || roles == null || roles.isEmpty() || selectedRole == null || !roles.contains(selectedRole)) {
             // Could throw an exception if data is invalid
             System.err.println("Invalid login attempt in SessionManager");
             logout(); // Ensure no invalid session remains
             return;
        }
        this.currentUser = user;
        this.userRoles = new HashSet<>(roles); // Defensive copy
        this.currentRole = selectedRole;
        System.out.println("Session started for user: " + user.getUsername() + " with role: " + selectedRole);
    }

    /**
     * Closes the current session, clearing all user data.
     */
    public void logout() {
        this.currentUser = null;
        this.userRoles.clear();
        this.currentRole = null;
        System.out.println("Session closed.");
    }

    /**
     * Checks if a user is currently logged in.
     * @return true if there is an active session, false otherwise.
     */
    public boolean isLoggedIn() {
        return currentUser != null && currentRole != null;
    }

    /**
     * Gets the User object from the current session.
     * @return The logged-in User, or null if no session exists.
     */
    public User getCurrentUser() {
        return currentUser;
    }

    /**
     * Gets the person ID (ADM.PERSON) associated with the current user.
     * @return The person ID, or -1 if no session exists.
     */
    public long getPersonId() {
        return (currentUser != null) ? currentUser.getPersonId() : -1;
    }

    /**
     * Gets the user ID (PU.PERSONUSER) of the current user.
     * @return The user ID, or -1 if no session exists.
     */
    public long getUserId() {
        return (currentUser != null) ? currentUser.getId() : -1;
    }

    /**
     * Gets the username from the current session.
     * @return The username, or null if no session exists.
     */
    public String getUsername() {
        return (currentUser != null) ? currentUser.getUsername() : null;
    }

    /**
     * Gets all available roles for the logged-in user.
     * @return A Set with the roles (e.g., {"DRIVER", "PASSENGER"}). Returns an empty Set if no session exists.
     */
    public Set<String> getUserRoles() {
        return new HashSet<>(userRoles); // Returns a copy for external immutability
    }

    /**
     * Gets the selected role for the current session (DRIVER or PASSENGER).
     * @return The current role, or null if no session exists.
     */
    public String getCurrentRole() {
        return currentRole;
    }

    /**
     * Checks if the current user has a specific role available.
     * @param role The role to check (use constants ROLE_DRIVER, ROLE_PASSENGER).
     * @return true if the user has that role, false otherwise or if no session exists.
     */
    public boolean hasRole(String role) {
        return userRoles.contains(role);
    }

    /**
     * Changes the active role for the current session, if the user has that role available.
     * @param newRole The new role to activate.
     * @return true if the change was successful, false if the user doesn't have that role.
     */
    public boolean switchRole(String newRole) {
        if (isLoggedIn() && hasRole(newRole)) {
            this.currentRole = newRole;
            System.out.println("User " + getUsername() + " switched role to: " + newRole);
            return true;
        }
        System.err.println("Failed to switch role to: " + newRole + " for user: " + getUsername());
        return false;
    }
}