package com.tec.carpooling.business.service.impl;

import com.tec.carpooling.business.service.UserTypeService;
import com.tec.carpooling.data.dao.UserTypeDAO;
import com.tec.carpooling.data.dao.impl.UserTypeDAOImpl;
import java.sql.SQLException;

/**
 * Implementation of the UserTypeService interface
 */
public class UserTypeServiceImpl implements UserTypeService {
    private final UserTypeDAO userTypeDAO;
    
    public UserTypeServiceImpl() {
        this.userTypeDAO = new UserTypeDAOImpl();
    }
    
    @Override
    public void registerAsDriver(long userId) throws SQLException {
        userTypeDAO.registerAsDriver(userId);
    }
    
    @Override
    public void registerAsPassenger(long userId) throws SQLException {
        userTypeDAO.registerAsPassenger(userId);
    }
    
    @Override
    public boolean isAdmin(long userId) throws SQLException {
        return userTypeDAO.isAdmin(userId);
    }
    
    @Override
    public String getUserType(long userId) throws SQLException {
        return userTypeDAO.getUserType(userId);
    }
    
    @Override
    public boolean isDriver(long userId) throws SQLException {
        return userTypeDAO.isDriver(userId);
    }
    
    @Override
    public boolean isPassenger(long userId) throws SQLException {
        return userTypeDAO.isPassenger(userId);
    }
} 