package com.tec.carpooling.exception;

public class DomainManagementException extends Exception {

    /**
     * Constructor for DomainManagementException.
     *
     * @param message The error message to be displayed.
     */
    public DomainManagementException(String message) {
        super(message);
    }

    /**
     * Constructor for DomainManagementException with a cause.
     *
     * @param message The error message to be displayed.
     * @param cause   The underlying cause of the exception.
     */
    public DomainManagementException(String message, Throwable cause) {
        super(message, cause);
    }
    
}
