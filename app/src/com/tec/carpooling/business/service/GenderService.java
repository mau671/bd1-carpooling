package com.tec.carpooling.business.service;

import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.dto.CatalogData;
// import com.tec.carpooling.domain.entity.Gender;
// import java.util.List;

public interface GenderService {
    /**
     * Registra un nuevo género.
     * @param data DTO que contiene el nombre del género.
     * @return true si el registro fue exitoso (lanza excepción si no).
     * @throws CatalogRegistrationException Si el nombre es inválido o ya existe.
     * @throws Exception Si ocurre un error inesperado.
     */
    boolean registerGender(CatalogData data) throws CatalogRegistrationException, Exception;

    // List<Gender> getAllGenders() throws Exception; // Ejemplo futuro
}