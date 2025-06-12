package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.UserTypeDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Implementation of DAO for user type operations using MySQL stored procedures
 */
public class UserTypeDAOImpl implements UserTypeDAO {
    
    @Override
    public void registerAsDriver(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call carpooling_adm.register_as_driver(?)}")) {
            
            stmt.setLong(1, userId);
            stmt.execute();
        }
    }
    
    @Override
    public void registerAsPassenger(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call carpooling_adm.register_as_passenger(?)}")) {
            
            stmt.setLong(1, userId);
            stmt.execute();
        }
    }
    
    @Override
    public boolean isAdmin(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call carpooling_adm.is_admin(?, ?)}")) {
            
            stmt.setLong(1, userId);
            // Usar TINYINT en lugar de BOOLEAN para mejor compatibilidad con MySQL JDBC
            stmt.registerOutParameter(2, Types.TINYINT);
            stmt.execute();
            
            // MySQL BOOLEAN se mapea a TINYINT: 1 = true, 0 = false
            return stmt.getInt(2) == 1;
        }
    }
    
    @Override
    public String getUserType(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call carpooling_adm.get_user_type(?, ?)}")) {
            
            stmt.setLong(1, userId);
            stmt.registerOutParameter(2, Types.VARCHAR);
            stmt.execute();
            
            return stmt.getString(2);
        }
    }
    
    @Override
    public boolean isDriver(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call carpooling_adm.is_driver(?, ?)}")) {
            
            stmt.setLong(1, userId);
            stmt.registerOutParameter(2, Types.TINYINT);
            stmt.execute();
            
            return stmt.getInt(2) == 1;
        }
    }
    
    @Override
    public boolean isPassenger(long userId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{call carpooling_adm.is_passenger(?, ?)}")) {
            
            stmt.setLong(1, userId);
            stmt.registerOutParameter(2, Types.TINYINT);
            stmt.execute();
            
            return stmt.getInt(2) == 1;
        }
    }
} 