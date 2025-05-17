package com.tec.carpooling.business.service;

import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.dto.CatalogData;
import com.tec.carpooling.dto.GenderDTO;
// import com.tec.carpooling.domain.entity.Gender;
import java.util.List;

/**
 * Service interface for managing gender-related operations.
 */
public interface GenderService {
    /**
     * Registers a new gender in the system.
     * 
     * @param data DTO containing the gender name
     * @return true if registration was successful
     * @throws CatalogRegistrationException if the name is invalid or already exists
     * @throws Exception if an unexpected error occurs
     */
    boolean registerGender(CatalogData data) throws CatalogRegistrationException, Exception;

    /**
     * Retrieves all genders from the system.
     * 
     * @return List of GenderDTO objects containing all genders
     * @throws Exception if an error occurs while retrieving the genders
     */
    List<GenderDTO> getAllGenders() throws Exception;

    // List<Gender> getAllGenders() throws Exception; // Ejemplo futuro
}