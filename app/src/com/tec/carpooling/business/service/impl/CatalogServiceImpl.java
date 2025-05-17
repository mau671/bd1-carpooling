package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.CatalogService;
import com.tec.carpooling.data.dao.CatalogDAO;
import com.tec.carpooling.data.impl.CatalogDAOImpl;
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.domain.entity.PhoneType;
import com.tec.carpooling.domain.entity.Domain;

import java.sql.SQLException;
import java.util.List;

/**
 * Implementation of the CatalogService interface.
 * Handles business logic for catalog data.
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
     * @param catalogDAO The catalog DAO to use
     */
    public CatalogServiceImpl(CatalogDAO catalogDAO) {
        this.catalogDAO = catalogDAO;
    }
    
    @Override
    public List<Gender> getAllGenders() throws SQLException {
        return catalogDAO.findAllGenders();
    }
    
    @Override
    public List<Institution> getAllInstitutions() throws SQLException {
        return catalogDAO.findAllInstitutions();
    }
    
    @Override
    public List<IdType> getAllIdTypes() throws SQLException {
        return catalogDAO.findAllIdTypes();
    }
    
    @Override
    public List<PhoneType> getAllPhoneTypes() throws SQLException {
        return catalogDAO.findAllPhoneTypes();
    }
    
    @Override
    public List<Domain> getDomainsByInstitution(long institutionId) throws SQLException {
        return catalogDAO.findDomainsByInstitution(institutionId);
    }
} 