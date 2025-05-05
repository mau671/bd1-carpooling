package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Domain;
import com.tec.carpooling.exception.DomainManagementException;

import java.sql.SQLException;
import java.util.List;

/**
 * Data Access Object interface for Domain entities.
 * Provides methods to perform CRUD operations on Domain objects.
 */
public interface DomainDAO {
    /**
     * Persists a domain entity to the database.
     *
     * @param domain the domain to be saved
     * @return the saved domain with its generated ID
     * @throws SQLException if a database access error occurs
     * @throws DomainManagementException if there's an error in domain management logic
     */
    Domain save(Domain domain) throws SQLException, DomainManagementException;
    
    /**
     * Removes a domain entity from the database.
     *
     * @param id the ID of the domain to delete
     * @throws SQLException if a database access error occurs
     * @throws DomainManagementException if there's an error in domain management logic
     */
    void delete(long id) throws SQLException, DomainManagementException;
    
    /**
     * Retrieves a domain by its ID.
     *
     * @param id the ID of the domain to find
     * @return the found domain entity or null if not found
     * @throws SQLException if a database access error occurs
     */
    Domain findById(long id) throws SQLException;
    
    /**
     * Retrieves all domains from the database.
     *
     * @return a list containing all domain entities
     * @throws SQLException if a database access error occurs
     */
    List<Domain> findAll() throws SQLException;
}