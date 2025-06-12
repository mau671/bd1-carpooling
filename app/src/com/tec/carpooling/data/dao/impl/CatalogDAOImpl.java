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

/**
 * Implementation of the CatalogDAO interface.
 * Handles database operations for catalog data using MySQL stored procedures.
 */
public class CatalogDAOImpl implements CatalogDAO {
    
    // MySQL stored procedures for catalog operations
    private static final String GET_ALL_GENDERS = "{call carpooling_adm.list_genders()}";
    private static final String GET_ALL_INSTITUTIONS = "{call carpooling_adm.find_all_institutions()}";
    private static final String GET_ALL_ID_TYPES = "{call carpooling_adm.list_type_identifications()}";
    private static final String GET_ALL_PHONE_TYPES = "{call carpooling_adm.list_type_phones()}";
    private static final String GET_DOMAINS_BY_INSTITUTION = "{call carpooling_adm.find_domains_by_institution(?)}";
    
    @Override
    public List<Gender> getAllGenders() throws SQLException {
        List<Gender> genders = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_GENDERS);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Gender gender = new Gender(
                    rs.getLong("id"),
                    rs.getString("name")
                );
                genders.add(gender);
            }
        }
        return genders;
    }
    
    @Override
    public List<Institution> getAllInstitutions() throws SQLException {
        List<Institution> institutions = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_INSTITUTIONS);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Institution institution = new Institution(
                    rs.getLong("id"),
                    rs.getString("name")
                );
                institutions.add(institution);
            }
        }
        return institutions;
    }
    
    @Override
    public List<IdType> getAllIdTypes() throws SQLException {
        List<IdType> idTypes = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_ID_TYPES);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                IdType idType = new IdType(
                    rs.getLong("id"),
                    rs.getString("name")
                );
                idTypes.add(idType);
            }
        }
        return idTypes;
    }
    
    @Override
    public List<PhoneType> getAllPhoneTypes() throws SQLException {
        List<PhoneType> phoneTypes = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_ALL_PHONE_TYPES);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                PhoneType phoneType = new PhoneType(
                    rs.getLong("id"),
                    rs.getString("name")
                );
                phoneTypes.add(phoneType);
            }
        }
        return phoneTypes;
    }
    
    @Override
    public List<Domain> getDomainsByInstitution(long institutionId) throws SQLException {
        List<Domain> domains = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(GET_DOMAINS_BY_INSTITUTION)) {
            
            stmt.setLong(1, institutionId);
            try (ResultSet rs = stmt.executeQuery()) {
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