package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.CatalogService;
import com.tec.carpooling.data.dao.CatalogDAO;
import com.tec.carpooling.data.dao.impl.CatalogDAOImpl;
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.domain.entity.PhoneType;
import com.tec.carpooling.domain.entity.Domain;

import java.sql.SQLException;
import java.util.List;

/**
 * Implementation of the CatalogService interface.
 * Provides business logic for managing catalog data.
 */
public class CatalogServiceImpl implements CatalogService {
    
    private final CatalogDAO catalogDAO;
    
    /**
     * Default constructor that initializes the DAO.
     */
    public CatalogServiceImpl() {
        this.catalogDAO = new CatalogDAOImpl();
    }
    
    /**
     * Constructor that accepts a custom DAO implementation.
     * 
     * @param catalogDAO The DAO implementation to use
     */
    public CatalogServiceImpl(CatalogDAO catalogDAO) {
        this.catalogDAO = catalogDAO;
    }
    
    @Override
    public List<Gender> getAllGenders() throws SQLException {
        return catalogDAO.getAllGenders();
    }
    
    @Override
    public List<Institution> getAllInstitutions() throws SQLException {
        return catalogDAO.getAllInstitutions();
    }
    
    @Override
    public List<IdType> getAllIdTypes() throws SQLException {
        return catalogDAO.getAllIdTypes();
    }
    
    @Override
    public List<PhoneType> getAllPhoneTypes() throws SQLException {
        return catalogDAO.getAllPhoneTypes();
    }
    
    @Override
    public List<Domain> getDomainsByInstitution(long institutionId) throws SQLException {
        return catalogDAO.getDomainsByInstitution(institutionId);
    }
} 