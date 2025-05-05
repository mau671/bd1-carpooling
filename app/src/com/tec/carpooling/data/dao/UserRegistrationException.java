package com.tec.carpooling.data.dao; // O com.tec.carpooling.exception

/**
 * Excepción personalizada para encapsular errores específicos
 * ocurridos durante el proceso de registro de usuarios,
 * especialmente aquellos devueltos por la base de datos
 * (ej: RAISE_APPLICATION_ERROR).
 */
public class UserRegistrationException extends Exception {

    /**
     * Constructor con mensaje de error.
     * @param message Descripción del error.
     */
    public UserRegistrationException(String message) {
        super(message);
    }

    /**
     * Constructor con mensaje de error y causa original.
     * @param message Descripción del error.
     * @param cause La excepción original que causó este error (ej: SQLException).
     */
    public UserRegistrationException(String message, Throwable cause) {
        super(message, cause);
    }
}