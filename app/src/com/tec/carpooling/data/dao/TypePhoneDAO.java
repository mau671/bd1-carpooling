package com.tec.carpooling.data.dao;

import java.sql.SQLException;
// import com.tec.carpooling.domain.entity.TypePhone;
// import java.util.List;

public interface TypePhoneDAO {
    /**
     * Registra un nuevo tipo de teléfono en la base de datos.
     * Llama al procedimiento ADM.ADM_CATALOG_MGMT_PKG.register_type_phone.
     *
     * @param name El nombre del tipo de teléfono a registrar.
     * @throws SQLException Si ocurre un error general de base de datos.
     * @throws CatalogRegistrationException Si el nombre está vacío o el tipo ya existe (mapeado desde errores PL/SQL 20211, 20212).
     */
    void registerTypePhone(String name) throws SQLException, CatalogRegistrationException;

     // List<TypePhone> findAll() throws SQLException; // Ejemplo para el futuro
}