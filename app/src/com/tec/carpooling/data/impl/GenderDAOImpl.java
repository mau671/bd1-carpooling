package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.GenderDAO;
import com.tec.carpooling.domain.entity.Gender;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

public class GenderDAOImpl implements GenderDAO {

    @Override
    public void registerGender(String name) throws SQLException, CatalogRegistrationException {
        String sql = "{call ADM.ADM_CATALOG_MGMT_PKG.register_gender(?)}";

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, name);
            cs.execute();

        } catch (SQLException e) {
            handleGenderException(e, name); // Llama a un método helper
        }
    }
    
    @Override
    public List<Gender> findAll() throws SQLException {
        // Asume una función find_all_genders_cursor en ADM_CATALOG_MGMT_PKG
        String sql = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_genders_cursor()}";
        List<Gender> genders = new ArrayList<>();
        ResultSet rs = null;
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs != null && rs.next()) {
                genders.add(mapToGender(rs)); // Necesitas un método mapToGender
            }
        } catch (SQLException e) {
            System.err.println("Error SQL en findAllGenders:"); e.printStackTrace(); throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        }
        return genders;
    }

    private Gender mapToGender(ResultSet rs) throws SQLException {
        Gender g = new Gender();
        g.setId(rs.getLong("id"));
        g.setName(rs.getString("name"));
        return g;
    }

    // Método helper para manejar excepciones específicas de Género
    private void handleGenderException(SQLException e, String name) throws SQLException, CatalogRegistrationException {
         if (e.getErrorCode() == 20202) { // Código de error PL/SQL para duplicado
            throw new CatalogRegistrationException("El género '" + name + "' ya existe.", e);
        } else if (e.getErrorCode() == 20201) { // Código de error PL/SQL para nombre vacío
             throw new CatalogRegistrationException("El nombre del género no puede estar vacío.", e);
         } else {
            // Loggear error genérico: e.printStackTrace(); o usar Logger
            throw e; // Relanzar error SQL genérico
        }
    }

    // Implementar findAll(), findById() aquí si se necesita...
}