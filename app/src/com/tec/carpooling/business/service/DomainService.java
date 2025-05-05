package com.tec.carpooling.business.service;

import com.tec.carpooling.dto.DomainDTO;
import com.tec.carpooling.exception.DomainManagementException;
import java.util.List;

/**
 * Service interface for Domain management operations.
 * Provides methods to create, delete, find and list domains.
 */
public interface DomainService {
    /**
     * Registers a new domain with the given name.
     *
     * @param name the name of the domain to register
     * @return the registered domain as a DTO
     * @throws DomainManagementException if there's a domain-specific error
     * @throws Exception if there's a general error during processing
     */
    DomainDTO registerDomain(String name) throws DomainManagementException, Exception;
    
    /**
     * Deletes a domain by its ID.
     *
     * @param id the ID of the domain to delete
     * @return true if deletion was successful, false otherwise
     * @throws DomainManagementException if there's a domain-specific error
     * @throws Exception if there's a general error during processing
     */
    boolean deleteDomain(long id) throws DomainManagementException, Exception;
    
    /**
     * Finds a domain by its ID.
     *
     * @param id the ID of the domain to find
     * @return the found domain as a DTO
     * @throws Exception if there's an error during processing
     */
    DomainDTO findDomainById(long id) throws Exception;
    
    /**
     * Retrieves all domains in the system.
     *
     * @return a list of all domains as DTOs
     * @throws Exception if there's an error during processing
     */
    List<DomainDTO> getAllDomains() throws Exception;
}