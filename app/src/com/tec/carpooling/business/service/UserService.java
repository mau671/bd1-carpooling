package com.tec.carpooling.business.service;

import com.tec.carpooling.dto.LoginData;
import com.tec.carpooling.dto.LoginResultDTO;
import com.tec.carpooling.dto.UserRegistrationData;
import com.tec.carpooling.exception.UserRegistrationException;

/**
 * Service interface for user-related operations.
 * Handles user registration, authentication, and other user-related business logic.
 */
public interface UserService {

    /**
     * Registers a new user in the system.
     * 
     * @param registrationData User data required for registration
     * @return true if registration was successful, false otherwise
     * @throws UserRegistrationException If validation fails or specific database errors occur
     * @throws Exception If an unexpected error occurs
     */
    boolean registerUser(UserRegistrationData registrationData) throws UserRegistrationException, Exception;

    /**
     * Valida las credenciales de inicio de sesión y determina los roles del usuario.
     * @param loginData Datos de login (username, plainPassword).
     * @return Un LoginResultDTO que contiene el User y sus roles si el login es exitoso,
     *         o un DTO indicando fallo (user=null) si las credenciales son inválidas.
     * @throws Exception Si ocurre un error durante la validación (ej: error de BD).
     */
    LoginResultDTO validateLoginAndGetRoles(LoginData loginData) throws Exception;

    // Other user-related business methods...
}