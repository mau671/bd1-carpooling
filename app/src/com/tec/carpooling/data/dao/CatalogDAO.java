package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.domain.entity.PhoneType;
import com.tec.carpooling.domain.entity.Domain;

import java.sql.SQLException;
import java.util.List;

/**
 * Data Access Object interface for catalog operations.
 * Handles retrieval of catalog data such as genders, institutions, etc.
 */
public interface CatalogDAO {
    
    /**
     * Retrieves all genders from the database.
     * 
     * @return List of all genders
     * @throws SQLException if a database error occurs
     */
    List<Gender> findAllGenders() throws SQLException;
    
    /**
     * Retrieves all institutions from the database.
     * 
     * @return List of all institutions
     * @throws SQLException if a database error occurs
     */
    List<Institution> findAllInstitutions() throws SQLException;
    
    /**
     * Retrieves all identification types from the database.
     * 
     * @return List of all identification types
     * @throws SQLException if a database error occurs
     */
    List<IdType> findAllIdTypes() throws SQLException;
    
    /**
     * Retrieves all phone types from the database.
     * 
     * @return List of all phone types
     * @throws SQLException if a database error occurs
     */
    List<PhoneType> findAllPhoneTypes() throws SQLException;
    
    /**
     * Retrieves all domains for a specific institution.
     * 
     * @param institutionId The ID of the institution
     * @return List of domains for the specified institution
     * @throws SQLException if a database error occurs
     */
    List<Domain> findDomainsByInstitution(long institutionId) throws SQLException;
} 