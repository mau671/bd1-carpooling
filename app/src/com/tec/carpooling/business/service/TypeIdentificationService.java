package com.tec.carpooling.business.service;

import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.dto.CatalogData;
// import com.tec.carpooling.domain.entity.TypeIdentification;
// import java.util.List;

public interface TypeIdentificationService {
     /**
     * Registra un nuevo tipo de identificación.
     * @param data DTO que contiene el nombre del tipo.
     * @return true si el registro fue exitoso (lanza excepción si no).
     * @throws CatalogRegistrationException Si el nombre es inválido o ya existe.
     * @throws Exception Si ocurre un error inesperado.
     */
    boolean registerTypeIdentification(CatalogData data) throws CatalogRegistrationException, Exception;

    // List<TypeIdentification> getAllTypeIdentifications() throws Exception; // Ejemplo futuro
}