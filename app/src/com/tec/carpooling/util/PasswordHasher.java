package com.tec.carpooling.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordHasher {

    /**
     * Hashes a password using SHA-256 and encodes it in Base64.
     *
     * @param plainPassword The plain text password.
     * @return The hashed password encoded in Base64 as a String.
     * @throws IllegalArgumentException if the password is null or empty.
     * @throws RuntimeException if the SHA-256 algorithm is not available.
     */
    public static String hashPassword(String plainPassword) {
        validatePasswordInput(plainPassword);
        
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = digest.digest(plainPassword.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Critical error: SHA-256 algorithm not found.", e);
        }
    }

    /**
     * Verifies if a plain text password matches a stored hash (SHA-256 + Base64).
     *
     * @param plainPassword The password entered by the user.
     * @param storedHashedPassword The hash stored in the database.
     * @return true if passwords match, false otherwise.
     */
    public static boolean verifyPassword(String plainPassword, String storedHashedPassword) {
        if (plainPassword == null || storedHashedPassword == null || storedHashedPassword.isEmpty()) {
            return false;
        }
        
        String hashedInput = hashPassword(plainPassword);
        return hashedInput.equals(storedHashedPassword);
    }
    
    private static void validatePasswordInput(String password) {
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }
    }
}
