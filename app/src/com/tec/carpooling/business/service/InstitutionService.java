package com.tec.carpooling.business.service;

import com.tec.carpooling.dto.InstitutionDTO;
import com.tec.carpooling.exception.InstitutionManagementException;
import java.util.List;

/**
 * Service interface for institution management operations.
 * Handles business logic related to institutions in the carpooling system.
 */
public interface InstitutionService {
     /**
      * Registers a new institution in the system.
      *
      * @param name The name of the institution to register
      * @return The created institution data
      * @throws InstitutionManagementException If there's a business rule violation
      * @throws Exception If any other error occurs
      */
     InstitutionDTO registerInstitution(String name) throws InstitutionManagementException, Exception;

     /**
      * Updates the name of an existing institution.
      *
      * @param id The institution identifier
      * @param newName The new name to be assigned
      * @return true if the update was successful, false otherwise
      * @throws InstitutionManagementException If there's a business rule violation
      * @throws Exception If any other error occurs
      */
     boolean updateInstitutionName(long id, String newName) throws InstitutionManagementException, Exception;

     /**
      * Deletes an institution from the system.
      *
      * @param id The institution identifier to be removed
      * @return true if the deletion was successful, false otherwise
      * @throws InstitutionManagementException If there's a business rule violation
      * @throws Exception If any other error occurs
      */
     boolean deleteInstitution(long id) throws InstitutionManagementException, Exception;

     /**
      * Retrieves an institution by its identifier.
      *
      * @param id The institution identifier to search for
      * @return The institution data if found
      * @throws Exception If any error occurs
      */
     InstitutionDTO findInstitutionById(long id) throws Exception;

     /**
      * Retrieves all institutions registered in the system.
      *
      * @return A list of all institutions
      * @throws Exception If any error occurs
      */
     List<InstitutionDTO> getAllInstitutions() throws Exception;

     /**
      * Gets all domain identifiers associated with an institution.
      *
      * @param institutionId The institution identifier
      * @return A list of domain identifiers
      * @throws Exception If any error occurs
      */
     List<Long> getDomainIdsForInstitution(long institutionId) throws Exception;

     /**
      * Updates the domain associations for an institution.
      *
      * @param institutionId The institution identifier
      * @param newDomainIds List of domain identifiers to associate with the institution
      * @return true if the update was successful, false otherwise
      * @throws InstitutionManagementException If there's a business rule violation
      * @throws Exception If any other error occurs
      */
     boolean updateDomainAssociationsForInstitution(long institutionId, List<Long> newDomainIds) 
               throws InstitutionManagementException, Exception;
}