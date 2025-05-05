package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.TypePhoneDAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class TypePhoneDAOImpl implements TypePhoneDAO {

    @Override
    public void registerTypePhone(String name) throws SQLException, CatalogRegistrationException {
        String sql = "{call ADM.ADM_CATALOG_MGMT_PKG.register_type_phone(?)}";

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, name);
            cs.execute();

        } catch (SQLException e) {
            handleTypePhoneException(e, name);
        }
    }

    private void handleTypePhoneException(SQLException e, String name) throws SQLException, CatalogRegistrationException {
        if (e.getErrorCode() == 20212) { // Código duplicado
            throw new CatalogRegistrationException("El tipo de teléfono '" + name + "' ya existe.", e);
        } else if (e.getErrorCode() == 20211) { // Código nombre vacío
            throw new CatalogRegistrationException("El nombre del tipo de teléfono no puede estar vacío.", e);
        } else {
            // Loggear
            throw e;
        }
    }
     // Implementar findAll(), findById() aquí si se necesita...
}