package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.DomainService;
import com.tec.carpooling.data.dao.DomainDAO;
import com.tec.carpooling.data.impl.DomainDAOImpl; // Inject!
import com.tec.carpooling.domain.entity.Domain;
import com.tec.carpooling.dto.DomainDTO;
import com.tec.carpooling.exception.DomainManagementException;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of the DomainService interface.
 * Handles business logic for Domain entity operations.
 */
public class DomainServiceImpl implements DomainService {

    // TODO: Improve this with dependency injection
    private DomainDAO domainDAO = new DomainDAOImpl();

    /**
     * Constructor for dependency injection (preferred approach)
     * 
     * @param domainDAO Data access object for Domain entities
     */
    // public DomainServiceImpl(DomainDAO domainDAO) {
    //     this.domainDAO = domainDAO;
    // }

    /**
     * Registers a new domain in the system.
     *
     * @param name The domain name to register
     * @return A DTO representing the registered domain
     * @throws DomainManagementException When domain validation fails
     * @throws Exception For unexpected errors
     */
    @Override
    public DomainDTO registerDomain(String name) throws DomainManagementException, Exception {
        if (name == null || name.trim().isEmpty()) {
            throw new DomainManagementException("Domain name cannot be empty.");
        }
        // Could add domain format validation here
        String trimmedName = name.trim().toLowerCase(); // Normalize

        try {
            Domain domainEntity = new Domain();
            domainEntity.setName(trimmedName);
            Domain savedDomain = domainDAO.save(domainEntity); // DAO returns entity with ID
            return mapToDomainDTO(savedDomain); // Convert to DTO for business/presentation layer
        } catch (DomainManagementException e) {
            throw e; // Rethrow specific error
        } catch (Exception e) {
            // Log error
            throw new Exception("Unexpected error when registering domain '" + trimmedName + "'.", e);
        }
    }

    /**
     * Deletes a domain from the system.
     *
     * @param id The ID of the domain to delete
     * @return true if the domain was successfully deleted
     * @throws DomainManagementException When domain cannot be deleted
     * @throws Exception For unexpected errors
     */
    @Override
    public boolean deleteDomain(long id) throws DomainManagementException, Exception {
        if (id <= 0) {
            throw new DomainManagementException("Invalid domain ID.");
        }
        try {
            domainDAO.delete(id);
            return true; // Assumes success if no exception
        } catch (DomainManagementException e) {
            throw e; // Rethrow specific error (e.g., domain associated with institution)
        } catch (Exception e) {
            // Log error
            throw new Exception("Unexpected error when deleting domain ID " + id + ".", e);
        }
    }

    /**
     * Finds a domain by its ID.
     *
     * @param id The ID of the domain to find
     * @return A DTO representing the found domain or null if not found
     * @throws Exception For unexpected errors
     */
    @Override
    public DomainDTO findDomainById(long id) throws Exception {
        if (id <= 0) return null; // Or throw exception
        try {
            Domain domain = domainDAO.findById(id);
            return (domain != null) ? mapToDomainDTO(domain) : null;
        } catch (Exception e) {
            // Log error
            throw new Exception("Error finding domain ID " + id + ".", e);
        }
    }

    /**
     * Retrieves all domains from the system.
     *
     * @return A list of DTOs representing all domains
     * @throws Exception For unexpected errors
     */
    @Override
    public List<DomainDTO> getAllDomains() throws Exception {
        try {
            List<Domain> domains = domainDAO.findAll();
            // Convert list of Entities to list of DTOs using Streams
            return domains.stream()
                          .map(this::mapToDomainDTO)
                          .collect(Collectors.toList());
        } catch (Exception e) {
            // Log error
            throw new Exception("Error retrieving the list of domains.", e);
        }
    }

    /**
     * Helper method to map Domain entity to DTO.
     *
     * @param domain The domain entity to map
     * @return A DTO representing the domain entity
     */
    private DomainDTO mapToDomainDTO(Domain domain) {
        if (domain == null) return null;
        return new DomainDTO(domain.getId(), domain.getName());
    }
}