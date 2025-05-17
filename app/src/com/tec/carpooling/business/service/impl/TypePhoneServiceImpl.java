package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.TypePhoneService;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.TypePhoneDAO;
import com.tec.carpooling.data.impl.TypePhoneDAOImpl; // Mejorar con DI
import com.tec.carpooling.dto.CatalogData;

public class TypePhoneServiceImpl implements TypePhoneService {

    // Inyección simple - ¡MEJORAR!
    private TypePhoneDAO typePhoneDAO = new TypePhoneDAOImpl();

    @Override
    public boolean registerTypePhone(CatalogData data) throws CatalogRegistrationException, Exception {
         if (data == null || data.getName() == null || data.getName().trim().isEmpty()) {
            throw new CatalogRegistrationException("El nombre del tipo de teléfono no puede estar vacío.");
        }
        try {
            typePhoneDAO.registerTypePhone(data.getName().trim());
            return true;
        } catch (CatalogRegistrationException e) {
            throw e;
        } catch (Exception e) {
            // Loggear
            throw new Exception("Error inesperado al registrar el tipo de teléfono.", e);
        }
    }
     // Implementar getAllTypePhones() aquí si se necesita...
}