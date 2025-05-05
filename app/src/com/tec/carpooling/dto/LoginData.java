package com.tec.carpooling.dto;

/**
 * DTO (Data Transfer Object) for transporting login credentials
 * from the presentation layer to the business layer.
 */
public class LoginData {

    // Fields with proper names and meaning
    private String username;
    private String plainPassword; // Password in plain text, will be hashed in service layer

    /**
     * Default constructor
     */
    public LoginData() {
    }

    /**
     * Parameterized constructor
     * 
     * @param username The user's username or email
     * @param plainPassword The user's password in plain text
     */
    public LoginData(String username, String plainPassword) {
        this.username = username;
        this.plainPassword = plainPassword;
    }

    /**
     * Gets the username
     * 
     * @return The username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the username
     * 
     * @param username The username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the plain text password
     * 
     * @return The plain text password
     */
    public String getPlainPassword() {
        return plainPassword;
    }

    /**
     * Sets the plain text password
     * 
     * @param plainPassword The plain text password to set
     */
    public void setPlainPassword(String plainPassword) {
        this.plainPassword = plainPassword;
    }

    /**
     * Returns a string representation of the object.
     * Password is intentionally excluded for security reasons.
     * 
     * @return A string representation of the object
     */
    @Override
    public String toString() {
        return "LoginData{" +
               "username='" + username + '\'' +
               // Password omitted for security reasons
               '}';
    }
}