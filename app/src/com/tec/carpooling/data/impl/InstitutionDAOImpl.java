package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.InstitutionDAO;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.exception.InstitutionManagementException; // Asegura import

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OracleTypes; // Para CURSOR y ARRAY/TABLE type
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;


public class InstitutionDAOImpl implements InstitutionDAO {

    @Override
    public Institution save(Institution institution) throws SQLException, InstitutionManagementException {
        String sql = "{call ADM.ADM_INSTITUTION_MGMT_PKG.create_institution(?, ?)}";
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, institution.getName());
            cs.registerOutParameter(2, Types.NUMERIC); // o_institution_id
            cs.execute();
            long generatedId = cs.getLong(2);
            if (generatedId <= 0) throw new SQLException("El procedimiento create_institution no devolvió ID.");
            institution.setId(generatedId);

        } catch (SQLException e) {
            handleInstitutionException(e, institution.getName(), "registrar");
        }
        return institution;
    }

    @Override
    public void updateName(long id, String newName) throws SQLException, InstitutionManagementException {
        String sql = "{call ADM.ADM_INSTITUTION_MGMT_PKG.update_institution_name(?, ?)}";
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.setLong(1, id);
            cs.setString(2, newName);
            cs.execute();
        } catch (SQLException e) {
            handleInstitutionException(e, newName, "actualizar nombre para ID " + id);
        }
    }

    @Override
    public void delete(long id) throws SQLException, InstitutionManagementException {
        String sql = "{call ADM.ADM_INSTITUTION_MGMT_PKG.delete_institution(?)}";
         try (Connection conn = DatabaseConnection.getConnection();
              CallableStatement cs = conn.prepareCall(sql)) {
             cs.setLong(1, id);
             cs.execute();
         } catch (SQLException e) {
            handleInstitutionException(e, String.valueOf(id), "eliminar");
        }
    }

    @Override
    public Institution findById(long id) throws SQLException {
        String sql = "{? = call ADM.ADM_INSTITUTION_MGMT_PKG.find_institution_by_id_cursor(?)}";
        Institution institution = null;
        ResultSet rs = null;
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setLong(2, id);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs != null && rs.next()) {
                institution = mapToInstitution(rs);
            }
        } catch (SQLException e) {
             System.err.println("Error SQL en findInstitutionById:");
             e.printStackTrace();
             throw e;
        } finally {
             if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        }
        return institution;
    }

    @Override
    public List<Institution> findAll() throws SQLException {
        String sql = "{? = call ADM.ADM_INSTITUTION_MGMT_PKG.find_all_institutions_cursor()}";
        List<Institution> institutions = new ArrayList<>();
        ResultSet rs = null;
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs != null && rs.next()) {
                institutions.add(mapToInstitution(rs));
            }
        } catch (SQLException e) {
             System.err.println("Error SQL en findAllInstitutions:");
             e.printStackTrace();
             throw e;
        } finally {
             if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        }
        return institutions;
    }

     @Override
    public List<Long> findDomainIdsByInstitutionId(long institutionId) throws SQLException {
        // Usa la nueva función PL/SQL que devuelve un cursor con IDs
        String sql = "{? = call ADM.ADM_INSTITUTION_MGMT_PKG.get_assoc_domain_ids_cur(?)}";
        List<Long> domainIds = new ArrayList<>();
        ResultSet rs = null;
         try (Connection conn = DatabaseConnection.getConnection();
              CallableStatement cs = conn.prepareCall(sql)) {

             cs.registerOutParameter(1, OracleTypes.CURSOR);
             cs.setLong(2, institutionId);
             cs.execute();
             rs = (ResultSet) cs.getObject(1);

             while (rs != null && rs.next()) {
                 domainIds.add(rs.getLong("domain_id")); // Asume que la columna se llama domain_id
             }
         } catch (SQLException e) {
              System.err.println("Error SQL en findDomainIdsByInstitutionId:");
              e.printStackTrace();
              throw e;
         } finally {
              if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
         }
         return domainIds;
    }


    // updateDomainAssociations llama al procedure que recibe el array (sin cambios respecto a la versión anterior)
    @Override
    public void updateDomainAssociations(long institutionId, List<Long> newDomainIds) throws SQLException, InstitutionManagementException {
        String sql = "{call ADM.ADM_INSTITUTION_MGMT_PKG.update_institution_domains(?, ?)}";
        Connection conn = null;
        CallableStatement cs = null;
        Array oraArray = null;

        try {
            conn = DatabaseConnection.getConnection();
            OracleConnection oraConn = conn.unwrap(OracleConnection.class);
            cs = conn.prepareCall(sql);

            cs.setLong(1, institutionId);

            Object[] domainIdObjects = newDomainIds.stream().map(Long::valueOf).toArray();
            ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor("ADM.ID_TABLE_TYPE", oraConn);
            oraArray = new ARRAY(descriptor, oraConn, domainIdObjects);
            cs.setArray(2, oraArray);

            cs.execute();

        } catch (SQLException e) {
           handleInstitutionException(e, String.valueOf(institutionId), "actualizar dominios asociados");
        } finally {
             if (oraArray != null) try { oraArray.free(); } catch (SQLException ignore) {} // Liberar array
             if (cs != null) try { cs.close(); } catch (SQLException ignore) {}
             if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }


    // Helper para mapear ResultSet a Entidad (sin cambios)
    private Institution mapToInstitution(ResultSet rs) throws SQLException {
        Institution inst = new Institution();
        inst.setId(rs.getLong("id"));
        inst.setName(rs.getString("name"));
        return inst;
    }

    // Helper para manejar excepciones PL/SQL (sin cambios)
    private void handleInstitutionException(SQLException e, String identifier, String operation) throws SQLException, InstitutionManagementException {
        int errorCode = e.getErrorCode();
         if (errorCode >= 20000 && errorCode <= 20099) { // Rango de errores definidos en el paquete
             String errorMessage = "Error desconocido";
             try{ // Intenta extraer el mensaje de negocio
                errorMessage = e.getMessage().split("ORA-\\d{5}:\\s*")[1].trim();
             } catch(Exception ex){
                 errorMessage = e.getMessage(); // Usa el mensaje completo si el split falla
             }
             throw new InstitutionManagementException("Error al " + operation + " institución '" + identifier + "': " + errorMessage, e);
         } else if (e.getErrorCode() == 1) { // Duplicado genérico
              throw new InstitutionManagementException("Error al " + operation + ": La institución o nombre '" + identifier + "' ya existe o viola restricción.", e);
         } else if (e.getErrorCode() == 2292) { // FK genérico
              throw new InstitutionManagementException("Error al " + operation + " institución ID '" + identifier + "': Está referenciada por otros datos.", e);
         } else {
            System.err.println("Error SQL no mapeado al " + operation + " institución " + identifier + ":");
            e.printStackTrace();
            throw e;
        }
    }
}