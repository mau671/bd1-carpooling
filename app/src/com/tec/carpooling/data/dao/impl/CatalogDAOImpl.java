package com.tec.carpooling.data.dao.impl;

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
 * Handles database operations for catalog data using Oracle stored procedures.
 */
public class CatalogDAOImpl implements CatalogDAO {
    
    private static final String GET_ALL_GENDERS = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_genders_cursor}";
    private static final String GET_ALL_INSTITUTIONS = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_institutions_cursor}";
    private static final String GET_ALL_ID_TYPES = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_id_types_cursor}";
    private static final String GET_ALL_PHONE_TYPES = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_phone_types_cursor}";
    private static final String GET_DOMAINS_BY_INSTITUTION = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_domains_by_inst_cursor(?)}";
    
    @Override
    public List<Gender> getAllGenders() throws SQLException {
        List<Gender> genders = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_GENDERS)) {
            
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Gender gender = new Gender(
                        rs.getLong("id"),
                        rs.getString("name")
                    );
                    genders.add(gender);
                }
            }
        }
        return genders;
    }
    
    @Override
    public List<Institution> getAllInstitutions() throws SQLException {
        List<Institution> institutions = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_INSTITUTIONS)) {
            
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Institution institution = new Institution(
                        rs.getLong("id"),
                        rs.getString("name")
                    );
                    institutions.add(institution);
                }
            }
        }
        return institutions;
    }
    
    @Override
    public List<IdType> getAllIdTypes() throws SQLException {
        List<IdType> idTypes = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_ID_TYPES)) {
            
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    IdType idType = new IdType(
                        rs.getLong("id"),
                        rs.getString("name")
                    );
                    idTypes.add(idType);
                }
            }
        }
        return idTypes;
    }
    
    @Override
    public List<PhoneType> getAllPhoneTypes() throws SQLException {
        List<PhoneType> phoneTypes = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_PHONE_TYPES)) {
            
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    PhoneType phoneType = new PhoneType(
                        rs.getLong("id"),
                        rs.getString("name")
                    );
                    phoneTypes.add(phoneType);
                }
            }
        }
        return phoneTypes;
    }
    
    @Override
    public List<Domain> getDomainsByInstitution(long institutionId) throws SQLException {
        List<Domain> domains = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_DOMAINS_BY_INSTITUTION)) {
            
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.setLong(2, institutionId);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Domain domain = new Domain(
                        rs.getLong("id"),
                        rs.getString("name"),
                        institutionId
                    );
                    domains.add(domain);
                }
            }
        }
        return domains;
    }
} 