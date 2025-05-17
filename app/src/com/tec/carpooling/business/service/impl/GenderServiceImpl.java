package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.GenderService;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.GenderDAO;
import com.tec.carpooling.data.impl.GenderDAOImpl; // Mejorar con DI
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.dto.CatalogData;
import com.tec.carpooling.dto.GenderDTO;
import java.util.List;
import java.util.stream.Collectors;

public class GenderServiceImpl implements GenderService {

    // Inyección simple - ¡MEJORAR!
    private GenderDAO genderDAO = new GenderDAOImpl();

    @Override
    public boolean registerGender(CatalogData data) throws CatalogRegistrationException, Exception {
        if (data == null || data.getName() == null || data.getName().trim().isEmpty()) {
            throw new CatalogRegistrationException("El nombre del género no puede estar vacío.");
        }
        try {
            genderDAO.registerGender(data.getName().trim());
            return true; // Si no lanza excepción, fue exitoso
        } catch (CatalogRegistrationException e) {
            throw e; // Relanzar error específico de negocio/DAO
        } catch (Exception e) {
            // Loggear error inesperado
            throw new Exception("Error inesperado al registrar el género.", e);
        }
    }

    // Implementar getAllGenders() aquí si se necesita...
    @Override
    public List<GenderDTO> getAllGenders() throws Exception { // Devuelve DTOs
        try {
            List<Gender> genders = genderDAO.findAll();
            return genders.stream()
                          .map(this::mapToGenderDTO) // Necesitas mapToGenderDTO
                          .collect(Collectors.toList());
        } catch (Exception e) {
            // Loggear
            throw new Exception("Error al obtener géneros.", e);
        }
    }

    private GenderDTO mapToGenderDTO(Gender gender) {
        if (gender == null) return null;
        return new GenderDTO(gender.getId(), gender.getName()); // Necesitas GenderDTO
    }
}