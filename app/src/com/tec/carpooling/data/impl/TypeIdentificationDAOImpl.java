package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.TypeIdentificationDAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class TypeIdentificationDAOImpl implements TypeIdentificationDAO {

    @Override
    public void registerTypeIdentification(String name) throws SQLException, CatalogRegistrationException {
        String sql = "{call ADM.ADM_CATALOG_MGMT_PKG.register_type_identification(?)}";

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, name);
            cs.execute();

        } catch (SQLException e) {
            handleTypeIdentificationException(e, name);
        }
    }

     private void handleTypeIdentificationException(SQLException e, String name) throws SQLException, CatalogRegistrationException {
        if (e.getErrorCode() == 20222) { // Código duplicado
            throw new CatalogRegistrationException("El tipo de identificación '" + name + "' ya existe.", e);
        } else if (e.getErrorCode() == 20221) { // Código nombre vacío
            throw new CatalogRegistrationException("El nombre del tipo de identificación no puede estar vacío.", e);
        } else {
            // Loggear
            throw e;
        }
    }
     // Implementar findAll(), findById() aquí si se necesita...
}