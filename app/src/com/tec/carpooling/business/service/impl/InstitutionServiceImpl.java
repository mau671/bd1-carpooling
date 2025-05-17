package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.InstitutionService;
import com.tec.carpooling.data.dao.InstitutionDAO;
import com.tec.carpooling.data.impl.InstitutionDAOImpl; // Should use dependency injection!
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.dto.InstitutionDTO;
import com.tec.carpooling.exception.InstitutionManagementException;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of the InstitutionService interface that handles institution-related business logic.
 * This class serves as an intermediary between the presentation layer and the data access layer.
 */
public class InstitutionServiceImpl implements InstitutionService {

    // TODO: Improve this with dependency injection
    private InstitutionDAO institutionDAO = new InstitutionDAOImpl();

    /**
     * Constructor for dependency injection
     * 
     * @param institutionDAO The data access object for institutions
     */
    // public InstitutionServiceImpl(InstitutionDAO institutionDAO) {
    //     this.institutionDAO = institutionDAO;
    // }

    /**
     * Registers a new institution in the system.
     *
     * @param name The name of the institution to register
     * @return A DTO representing the registered institution
     * @throws InstitutionManagementException If there is a business logic error
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public InstitutionDTO registerInstitution(String name) throws InstitutionManagementException, Exception {
        if (name == null || name.trim().isEmpty()) {
            throw new InstitutionManagementException("Institution name cannot be empty.");
        }
        String trimmedName = name.trim();
        try {
            Institution institutionEntity = new Institution();
            institutionEntity.setName(trimmedName);
            Institution savedInstitution = institutionDAO.save(institutionEntity);
            return mapToInstitutionDTO(savedInstitution);
        } catch (InstitutionManagementException e) {
            throw e;
        } catch (Exception e) {
            // TODO: Add logging
            System.err.println("Error registering institution: " + e.getMessage());
            e.printStackTrace();
            throw new Exception("Unexpected error while registering institution '" + trimmedName + "'.", e);
        }
    }

    /**
     * Updates the name of an existing institution.
     *
     * @param id The ID of the institution to update
     * @param newName The new name for the institution
     * @return true if the update was successful
     * @throws InstitutionManagementException If there is a business logic error
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public boolean updateInstitutionName(long id, String newName) throws InstitutionManagementException, Exception {
        if (id <= 0) {
             throw new InstitutionManagementException("Invalid institution ID.");
        }
        if (newName == null || newName.trim().isEmpty()) {
            throw new InstitutionManagementException("New institution name cannot be empty.");
        }
        String trimmedName = newName.trim();
        try {
            institutionDAO.updateName(id, trimmedName);
            return true;
        } catch (InstitutionManagementException e) {
            throw e;
        } catch (Exception e) {
            // TODO: Add logging
            throw new Exception("Unexpected error while updating institution with ID " + id + ".", e);
        }
    }

    /**
     * Deletes an institution from the system.
     *
     * @param id The ID of the institution to delete
     * @return true if the deletion was successful
     * @throws InstitutionManagementException If there is a business logic error (e.g., cannot delete due to FK constraint)
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public boolean deleteInstitution(long id) throws InstitutionManagementException, Exception {
        if (id <= 0) {
            throw new InstitutionManagementException("Invalid institution ID.");
        }
        try {
            institutionDAO.delete(id);
            return true;
        } catch (InstitutionManagementException e) {
            throw e;
        } catch (Exception e) {
            // TODO: Add logging
            throw new Exception("Unexpected error while deleting institution with ID " + id + ".", e);
        }
    }

    /**
     * Finds an institution by its ID.
     *
     * @param id The ID of the institution to find
     * @return A DTO representing the found institution, or null if not found
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public InstitutionDTO findInstitutionById(long id) throws Exception {
        if (id <= 0) return null;
        try {
            Institution institution = institutionDAO.findById(id);
            return (institution != null) ? mapToInstitutionDTO(institution) : null;
        } catch (Exception e) {
            // TODO: Add logging
            throw new Exception("Error finding institution with ID " + id + ".", e);
        }
    }

    /**
     * Retrieves all institutions in the system.
     *
     * @return A list of DTOs representing all institutions
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public List<InstitutionDTO> getAllInstitutions() throws Exception {
        try {
            List<Institution> institutions = institutionDAO.findAll();
            return institutions.stream()
                              .map(this::mapToInstitutionDTO)
                              .collect(Collectors.toList());
        } catch (Exception e) {
            // TODO: Add logging
            System.err.println("Error retrieving list of institutions: " + e.getMessage());
            throw new Exception("Error retrieving list of institutions.", e);
        }
    }

    /**
     * Gets all domain IDs associated with an institution.
     *
     * @param institutionId The ID of the institution
     * @return A list of domain IDs associated with the institution
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public List<Long> getDomainIdsForInstitution(long institutionId) throws Exception {
        if (institutionId <= 0) {
            throw new IllegalArgumentException("Invalid institution ID.");
        }
        try {
            return institutionDAO.findDomainIdsByInstitutionId(institutionId);
        } catch (Exception e) {
            // TODO: Add logging
            throw new Exception("Error retrieving domain IDs for institution with ID " + institutionId + ".", e);
        }
    }

    /**
     * Updates the domain associations for an institution.
     *
     * @param institutionId The ID of the institution
     * @param newDomainIds A list of domain IDs to associate with the institution
     * @return true if the update was successful
     * @throws InstitutionManagementException If there is a business logic error
     * @throws Exception If an unexpected error occurs
     */
    @Override
    public boolean updateDomainAssociationsForInstitution(long institutionId, List<Long> newDomainIds) throws InstitutionManagementException, Exception {
        if (institutionId <= 0) {
            throw new InstitutionManagementException("Invalid institution ID.");
        }
        if (newDomainIds == null) {
            // Treat null as an empty list for the procedure
            newDomainIds = new ArrayList<>();
        }
        // We could validate here if the domain IDs exist before calling PL/SQL,
        // but PL/SQL could already handle this with FK constraint errors.

        try {
            institutionDAO.updateDomainAssociations(institutionId, newDomainIds);
            return true;
        } catch (InstitutionManagementException e) {
            throw e; // Specific error from association logic
        } catch (Exception e) {
            // TODO: Add logging
            throw new Exception("Unexpected error updating domain associations for institution with ID " + institutionId + ".", e);
        }
    }

    /**
     * Helper method to map an Institution entity to an InstitutionDTO.
     *
     * @param institution The institution entity to map
     * @return A DTO representing the institution
     */
    private InstitutionDTO mapToInstitutionDTO(Institution institution) {
        if (institution == null) return null;
        return new InstitutionDTO(institution.getId(), institution.getName());
    }
}