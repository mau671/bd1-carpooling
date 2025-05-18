package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.UserTypeDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Implementación del DAO para operaciones de tipo de usuario
 */
public class UserTypeDAOImpl implements UserTypeDAO {
    
    @Override
    public void registerAsDriver(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call ADM.ADM_USER_TYPE_PKG.register_as_driver(?)}")) {
            
            stmt.setLong(1, userId);
            stmt.execute();
        }
    }
    
    @Override
    public void registerAsPassenger(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call ADM.ADM_USER_TYPE_PKG.register_as_passenger(?)}")) {
            
            stmt.setLong(1, userId);
            stmt.execute();
        }
    }
    
    @Override
    public boolean isAdmin(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call ADM.ADM_USER_TYPE_PKG.is_admin(?, ?)}")) {
            
            stmt.setLong(1, userId);
            stmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            stmt.execute();
            
            return stmt.getInt(2) == 1;
        }
    }
    
    @Override
    public String getUserType(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call ADM.ADM_USER_TYPE_PKG.get_user_type(?, ?)}")) {
            
            stmt.setLong(1, userId);
            stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            stmt.execute();
            
            return stmt.getString(2);
        }
    }
} 