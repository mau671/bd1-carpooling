package com.tec.carpooling.data.dao;

import java.sql.SQLException;
// Podrías añadir métodos findById, findAll, etc., más adelante
// import com.tec.carpooling.domain.entity.Gender;
// import java.util.List;

public interface GenderDAO {
    /**
     * Registra un nuevo género en la base de datos.
     * Llama al procedimiento ADM.ADM_CATALOG_MGMT_PKG.register_gender.
     *
     * @param name El nombre del género a registrar.
     * @throws SQLException Si ocurre un error general de base de datos.
     * @throws CatalogRegistrationException Si el nombre está vacío o el género ya existe (mapeado desde errores PL/SQL 20201, 20202).
     */
    void registerGender(String name) throws SQLException, CatalogRegistrationException;

    // List<Gender> findAll() throws SQLException; // Ejemplo para el futuro
}