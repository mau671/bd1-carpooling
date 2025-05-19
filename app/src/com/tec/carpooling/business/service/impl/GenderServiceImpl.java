package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.GenderService;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.GenderDAO;
import com.tec.carpooling.data.impl.GenderDAOImpl;
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.dto.CatalogData;
import com.tec.carpooling.dto.GenderDTO;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of the GenderService interface that handles gender-related operations.
 */
public class GenderServiceImpl implements GenderService {

    private static final String ERROR_EMPTY_NAME = "Gender name cannot be empty.";
    private static final String ERROR_UNEXPECTED = "Unexpected error while registering gender.";
    private static final String ERROR_RETRIEVING = "Error retrieving genders.";

    private final GenderDAO genderDAO;

    /**
     * Default constructor that initializes the DAO.
     */
    public GenderServiceImpl() {
        this.genderDAO = new GenderDAOImpl();
    }

    /**
     * Constructor that accepts a DAO for dependency injection.
     * 
     * @param genderDAO The GenderDAO implementation to use
     */
    public GenderServiceImpl(GenderDAO genderDAO) {
        this.genderDAO = genderDAO;
    }

    @Override
    public boolean registerGender(CatalogData data) throws CatalogRegistrationException, Exception {
        validateGenderData(data);
        
        try {
            genderDAO.registerGender(data.getName().trim());
            return true;
        } catch (CatalogRegistrationException e) {
            throw e;
        } catch (Exception e) {
            throw new Exception(ERROR_UNEXPECTED, e);
        }
    }

    @Override
    public List<GenderDTO> getAllGenders() throws Exception {
        try {
            List<Gender> genders = genderDAO.findAll();
            return genders.stream()
                         .map(this::mapToGenderDTO)
                          .collect(Collectors.toList());
        } catch (Exception e) {
            throw new Exception(ERROR_RETRIEVING, e);
        }
    }

    /**
     * Validates the gender registration data.
     * 
     * @param data The data to validate
     * @throws CatalogRegistrationException if the data is invalid
     */
    private void validateGenderData(CatalogData data) throws CatalogRegistrationException {
        if (data == null || data.getName() == null || data.getName().trim().isEmpty()) {
            throw new CatalogRegistrationException(ERROR_EMPTY_NAME);
        }
    }

    /**
     * Maps a Gender entity to a GenderDTO.
     * 
     * @param gender The Gender entity to map
     * @return The corresponding GenderDTO
     */
    private GenderDTO mapToGenderDTO(Gender gender) {
        if (gender == null) {
            return null;
        }
        return new GenderDTO(String.valueOf(gender.getId()), gender.getName());
    }
}