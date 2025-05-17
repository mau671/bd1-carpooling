package com.tec.carpooling.exception;

/**
 * Custom exception to encapsulate specific errors 
 * that occur during the user registration process,
 * especially those returned by the database
 * (e.g., RAISE_APPLICATION_ERROR).
 */
public class UserRegistrationException extends Exception {

    /**
     * Constructor with error message.
     * 
     * @param message Description of the error.
     */
    public UserRegistrationException(String message) {
        super(message);
    }

    /**
     * Constructor with error message and original cause.
     * 
     * @param message Description of the error.
     * @param cause The original exception that caused this error (e.g., SQLException).
     */
    public UserRegistrationException(String message, Throwable cause) {
        super(message, cause);
    }
}