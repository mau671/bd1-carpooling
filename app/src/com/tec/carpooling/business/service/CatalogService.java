package com.tec.carpooling.business.service;

import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.domain.entity.PhoneType;
import com.tec.carpooling.domain.entity.Domain;

import java.sql.SQLException;
import java.util.List;

/**
 * Service interface for catalog operations.
 * Handles business logic for catalog data.
 */
public interface CatalogService {
    
    /**
     * Retrieves all genders.
     * 
     * @return List of all genders
     * @throws SQLException if a database error occurs
     */
    List<Gender> getAllGenders() throws SQLException;
    
    /**
     * Retrieves all institutions.
     * 
     * @return List of all institutions
     * @throws SQLException if a database error occurs
     */
    List<Institution> getAllInstitutions() throws SQLException;
    
    /**
     * Retrieves all identification types.
     * 
     * @return List of all identification types
     * @throws SQLException if a database error occurs
     */
    List<IdType> getAllIdTypes() throws SQLException;
    
    /**
     * Retrieves all phone types.
     * 
     * @return List of all phone types
     * @throws SQLException if a database error occurs
     */
    List<PhoneType> getAllPhoneTypes() throws SQLException;
    
    /**
     * Retrieves all domains for a specific institution.
     * 
     * @param institutionId The ID of the institution
     * @return List of domains for the specified institution
     * @throws SQLException if a database error occurs
     */
    List<Domain> getDomainsByInstitution(long institutionId) throws SQLException;
} 