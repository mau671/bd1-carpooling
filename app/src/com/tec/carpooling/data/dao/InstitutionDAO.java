package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.exception.InstitutionManagementException;
import java.sql.SQLException;
import java.util.List;

/**
 * Data Access Object interface for Institution entities.
 * Handles database operations related to educational institutions and their domains.
 */
public interface InstitutionDAO {
    /**
     * Saves a new institution to the database.
     * 
     * @param institution The institution entity to save
     * @return The saved institution with assigned ID
     * @throws SQLException If a database access error occurs
     * @throws InstitutionManagementException If there's an error in the institution management process
     */
    Institution save(Institution institution) throws SQLException, InstitutionManagementException;
    
    /**
     * Updates the name of an existing institution.
     * 
     * @param id The ID of the institution to update
     * @param newName The new name for the institution
     * @throws SQLException If a database access error occurs
     * @throws InstitutionManagementException If there's an error in the institution management process
     */
    void updateName(long id, String newName) throws SQLException, InstitutionManagementException;
    
    /**
     * Deletes an institution from the database.
     * 
     * @param id The ID of the institution to delete
     * @throws SQLException If a database access error occurs
     * @throws InstitutionManagementException If there's an error in the institution management process
     */
    void delete(long id) throws SQLException, InstitutionManagementException;
    
    /**
     * Finds an institution by its ID.
     * 
     * @param id The ID of the institution to find
     * @return The found institution or null if not found
     * @throws SQLException If a database access error occurs
     */
    Institution findById(long id) throws SQLException;
    
    /**
     * Retrieves all institutions from the database.
     * 
     * @return A list of all institutions
     * @throws SQLException If a database access error occurs
     */
    List<Institution> findAll() throws SQLException;
    
    /**
     * Finds all domain IDs associated with a specific institution.
     * 
     * @param institutionId The ID of the institution
     * @return A list of domain IDs associated with the institution
     * @throws SQLException If a database access error occurs
     */
    List<Long> findDomainIdsByInstitutionId(long institutionId) throws SQLException;
    
    /**
     * Updates the domain associations for a specific institution.
     * 
     * @param institutionId The ID of the institution
     * @param newDomainIds The new list of domain IDs to associate with the institution
     * @throws SQLException If a database access error occurs
     * @throws InstitutionManagementException If there's an error in the institution management process
     */
    void updateDomainAssociations(long institutionId, List<Long> newDomainIds) throws SQLException, InstitutionManagementException;
}