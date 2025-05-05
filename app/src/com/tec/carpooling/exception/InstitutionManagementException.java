package com.tec.carpooling.exception;

public class InstitutionManagementException extends Exception {

    /**
     * Constructor for InstitutionManagementException.
     *
     * @param message The error message to be displayed.
     */
    public InstitutionManagementException(String message) {
        super(message);
    }

    /**
     * Constructor for InstitutionManagementException with a cause.
     *
     * @param message The error message to be displayed.
     * @param cause   The underlying cause of the exception.
     */
    public InstitutionManagementException(String message, Throwable cause) {
        super(message, cause);
    }
    
}
