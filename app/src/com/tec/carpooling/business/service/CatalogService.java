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
 * Provides business logic for managing catalog data.
 */
public interface CatalogService {
    
    /**
     * Retrieves all genders from the system.
     * 
     * @return List of Gender entities
     * @throws SQLException if a database access error occurs
     */
    List<Gender> getAllGenders() throws SQLException;
    
    /**
     * Retrieves all institutions from the system.
     * 
     * @return List of Institution entities
     * @throws SQLException if a database access error occurs
     */
    List<Institution> getAllInstitutions() throws SQLException;
    
    /**
     * Retrieves all identification types from the system.
     * 
     * @return List of IdType entities
     * @throws SQLException if a database access error occurs
     */
    List<IdType> getAllIdTypes() throws SQLException;
    
    /**
     * Retrieves all phone types from the system.
     * 
     * @return List of PhoneType entities
     * @throws SQLException if a database access error occurs
     */
    List<PhoneType> getAllPhoneTypes() throws SQLException;
    
    /**
     * Retrieves all domains for a specific institution.
     * 
     * @param institutionId The ID of the institution
     * @return List of Domain entities
     * @throws SQLException if a database access error occurs
     */
    List<Domain> getDomainsByInstitution(long institutionId) throws SQLException;
} 