package com.tec.carpooling.data.dao;

import java.sql.SQLException;
// import com.tec.carpooling.domain.entity.TypeIdentification;
// import java.util.List;

public interface TypeIdentificationDAO {
    /**
     * Registra un nuevo tipo de identificación en la base de datos.
     * Llama al procedimiento ADM.ADM_CATALOG_MGMT_PKG.register_type_identification.
     *
     * @param name El nombre del tipo de identificación a registrar.
     * @throws SQLException Si ocurre un error general de base de datos.
     * @throws CatalogRegistrationException Si el nombre está vacío o el tipo ya existe (mapeado desde errores PL/SQL 20221, 20222).
     */
    void registerTypeIdentification(String name) throws SQLException, CatalogRegistrationException;

    // List<TypeIdentification> findAll() throws SQLException; // Ejemplo para el futuro
}