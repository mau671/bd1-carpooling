package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.TypeIdentificationService;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.TypeIdentificationDAO;
import com.tec.carpooling.data.impl.TypeIdentificationDAOImpl; // Mejorar con DI
import com.tec.carpooling.dto.CatalogData;


public class TypeIdentificationServiceImpl implements TypeIdentificationService {

    // Inyección simple - ¡MEJORAR!
    private TypeIdentificationDAO typeIdentificationDAO = new TypeIdentificationDAOImpl();

    @Override
    public boolean registerTypeIdentification(CatalogData data) throws CatalogRegistrationException, Exception {
        if (data == null || data.getName() == null || data.getName().trim().isEmpty()) {
            throw new CatalogRegistrationException("El nombre del tipo de identificación no puede estar vacío.");
        }
        try {
            typeIdentificationDAO.registerTypeIdentification(data.getName().trim());
            return true;
        } catch (CatalogRegistrationException e) {
            throw e;
        } catch (Exception e) {
            // Loggear
            throw new Exception("Error inesperado al registrar el tipo de identificación.", e);
        }
    }
    // Implementar getAllTypeIdentifications() aquí si se necesita...
}