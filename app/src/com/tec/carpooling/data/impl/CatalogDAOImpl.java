package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CatalogDAO;
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.domain.entity.PhoneType;
import com.tec.carpooling.domain.entity.Domain;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 * Implementation of the CatalogDAO interface.
 * Handles database operations for catalog data.
 */
public class CatalogDAOImpl implements CatalogDAO {
    
    private static final String FIND_ALL_GENDERS = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_genders_cursor()}";
    private static final String FIND_ALL_INSTITUTIONS = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_institutions_cursor()}";
    private static final String FIND_ALL_ID_TYPES = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_id_types_cursor()}";
    private static final String FIND_ALL_PHONE_TYPES = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_phone_types_cursor()}";
    private static final String FIND_DOMAINS_BY_INSTITUTION = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_domains_by_institution_cursor(?)}";
    
    @Override
    public List<Gender> findAllGenders() throws SQLException {
        return executeCatalogQuery(FIND_ALL_GENDERS, this::mapToGender);
    }
    
    @Override
    public List<Institution> findAllInstitutions() throws SQLException {
        return executeCatalogQuery(FIND_ALL_INSTITUTIONS, this::mapToInstitution);
    }
    
    @Override
    public List<IdType> findAllIdTypes() throws SQLException {
        return executeCatalogQuery(FIND_ALL_ID_TYPES, this::mapToIdType);
    }
    
    @Override
    public List<PhoneType> findAllPhoneTypes() throws SQLException {
        return executeCatalogQuery(FIND_ALL_PHONE_TYPES, this::mapToPhoneType);
    }
    
    @Override
    public List<Domain> findDomainsByInstitution(long institutionId) throws SQLException {
        List<Domain> domains = new ArrayList<>();
        ResultSet rs = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(FIND_DOMAINS_BY_INSTITUTION)) {
            
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setLong(2, institutionId);
            cs.execute();
            
            rs = (ResultSet) cs.getObject(1);
            while (rs != null && rs.next()) {
                domains.add(mapToDomain(rs));
            }
            
            return domains;
            
        } finally {
            closeResultSet(rs);
        }
    }
    
    /**
     * Generic method to execute catalog queries.
     * 
     * @param <T> The type of entity to return
     * @param query The query to execute
     * @param mapper The function to map ResultSet to entity
     * @return List of entities
     * @throws SQLException if a database error occurs
     */
    private <T> List<T> executeCatalogQuery(String query, ResultSetMapper<T> mapper) throws SQLException {
        List<T> results = new ArrayList<>();
        ResultSet rs = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(query)) {
            
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            
            rs = (ResultSet) cs.getObject(1);
            while (rs != null && rs.next()) {
                results.add(mapper.map(rs));
            }
            
            return results;
            
        } finally {
            closeResultSet(rs);
        }
    }
    
    private Gender mapToGender(ResultSet rs) throws SQLException {
        Gender gender = new Gender();
        gender.setId(rs.getLong("id"));
        gender.setName(rs.getString("name"));
        return gender;
    }
    
    private Institution mapToInstitution(ResultSet rs) throws SQLException {
        Institution institution = new Institution();
        institution.setId(rs.getLong("id"));
        institution.setName(rs.getString("name"));
        return institution;
    }
    
    private IdType mapToIdType(ResultSet rs) throws SQLException {
        IdType idType = new IdType();
        idType.setId(rs.getLong("id"));
        idType.setName(rs.getString("name"));
        return idType;
    }
    
    private PhoneType mapToPhoneType(ResultSet rs) throws SQLException {
        PhoneType phoneType = new PhoneType();
        phoneType.setId(rs.getLong("id"));
        phoneType.setName(rs.getString("name"));
        return phoneType;
    }
    
    private Domain mapToDomain(ResultSet rs) throws SQLException {
        Domain domain = new Domain();
        domain.setId(rs.getLong("id"));
        domain.setName(rs.getString("name"));
        return domain;
    }
    
    private void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ignore) {
                // Log error if needed
            }
        }
    }
    
    /**
     * Functional interface for mapping ResultSet to entity.
     * 
     * @param <T> The type of entity to map to
     */
    @FunctionalInterface
    private interface ResultSetMapper<T> {
        T map(ResultSet rs) throws SQLException;
    }
} 