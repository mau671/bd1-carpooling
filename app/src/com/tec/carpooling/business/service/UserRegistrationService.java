package com.tec.carpooling.business.service;

import java.sql.SQLException;
import java.time.LocalDate;

/**
 * Service interface for user registration operations
 */
public interface UserRegistrationService {
    /**
     * Registers a new user in the system
     * 
     * @param firstName First name of the user
     * @param secondName Second name of the user (can be null)
     * @param firstSurname First surname of the user
     * @param secondSurname Second surname of the user (can be null)
     * @param idTypeId ID of the identification type
     * @param idNumber Identification number
     * @param phoneTypeId ID of the phone type
     * @param phoneNumber Phone number
     * @param email Email address
     * @param dateOfBirth Date of birth
     * @param genderId ID of the gender
     * @param institutionId ID of the institution
     * @param domainId ID of the email domain
     * @param username Username for the account
     * @param password Password (will be hashed before storage)
     * @return true if registration was successful, false otherwise
     * @throws SQLException if a database error occurs
     */
    boolean registerUser(
        String firstName,
        String secondName,
        String firstSurname,
        String secondSurname,
        long idTypeId,
        String idNumber,
        long phoneTypeId,
        String phoneNumber,
        String email,
        LocalDate dateOfBirth,
        long genderId,
        long institutionId,
        long domainId,
        String username,
        String password
    ) throws SQLException;
    
    /**
     * Registers a new user in the system with profile photo
     * 
     * @param firstName First name of the user
     * @param secondName Second name of the user (can be null)
     * @param firstSurname First surname of the user
     * @param secondSurname Second surname of the user (can be null)
     * @param idTypeId ID of the identification type
     * @param idNumber Identification number
     * @param phoneTypeId ID of the phone type
     * @param phoneNumber Phone number
     * @param email Email address
     * @param dateOfBirth Date of birth
     * @param genderId ID of the gender
     * @param institutionId ID of the institution
     * @param domainId ID of the email domain
     * @param username Username for the account
     * @param password Password (will be hashed before storage)
     * @param photoData Profile photo data (can be null)
     * @return true if registration was successful, false otherwise
     * @throws SQLException if a database error occurs
     */
    boolean registerUser(
        String firstName,
        String secondName,
        String firstSurname,
        String secondSurname,
        long idTypeId,
        String idNumber,
        long phoneTypeId,
        String phoneNumber,
        String email,
        LocalDate dateOfBirth,
        long genderId,
        long institutionId,
        long domainId,
        String username,
        String password,
        byte[] photoData
    ) throws SQLException;
} 