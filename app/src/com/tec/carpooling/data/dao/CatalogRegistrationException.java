package com.tec.carpooling.data.dao; // o exception

public class CatalogRegistrationException extends Exception {
    public CatalogRegistrationException(String message) {
        super(message);
    }
    public CatalogRegistrationException(String message, Throwable cause) {
        super(message, cause);
    }
}