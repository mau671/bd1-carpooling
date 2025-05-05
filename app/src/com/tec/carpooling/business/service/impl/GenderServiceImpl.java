package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.GenderService;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.GenderDAO;
import com.tec.carpooling.data.impl.GenderDAOImpl; // Mejorar con DI
import com.tec.carpooling.dto.CatalogData;

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
}