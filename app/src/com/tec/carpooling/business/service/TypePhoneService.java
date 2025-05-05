package com.tec.carpooling.business.service;

import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.dto.CatalogData;
// import com.tec.carpooling.domain.entity.TypePhone;
// import java.util.List;

public interface TypePhoneService {
    /**
     * Registra un nuevo tipo de teléfono.
     * @param data DTO que contiene el nombre del tipo.
     * @return true si el registro fue exitoso (lanza excepción si no).
     * @throws CatalogRegistrationException Si el nombre es inválido o ya existe.
     * @throws Exception Si ocurre un error inesperado.
     */
    boolean registerTypePhone(CatalogData data) throws CatalogRegistrationException, Exception;

    // List<TypePhone> getAllTypePhones() throws Exception; // Ejemplo futuro
}