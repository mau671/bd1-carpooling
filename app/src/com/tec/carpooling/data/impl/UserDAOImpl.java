/*
 * User Data Access Object Implementation
 * This class implements the UserDAO interface for database operations.
 */
package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.dao.UserDAO;
import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Implementation of the UserDAO interface. Provides database operations
 * for user role verification.
 *
 * @author mauricio
 */
public class UserDAOImpl implements UserDAO {
    
    @Override
    public User findUserByUsername(String username) throws SQLException {
        String sql = "{call PU.USER_AUTH_PKG.VALIDATE_USER(?, ?, ?, ?, ?)}";
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            // Configurar parámetros de entrada
            stmt.setString(1, username);
            stmt.setString(2, ""); // Password vacío para solo buscar por username
            
            // Registrar parámetros de salida
            stmt.registerOutParameter(3, java.sql.Types.NUMERIC); // user_id
            stmt.registerOutParameter(4, java.sql.Types.NUMERIC); // person_id
            stmt.registerOutParameter(5, java.sql.Types.NUMERIC); // success
            
            // Ejecutar procedimiento
            stmt.execute();
            
            // Verificar resultado
            if (stmt.getInt(5) == 1) {
                User user = new User();
                user.setId(stmt.getLong(3));
                user.setUsername(username);
                user.setPersonId(stmt.getLong(4));
                return user;
            }
            
            return null;
        }
    }
    
    @Override
    public boolean registerUser(User user) throws SQLException {
        String sql = "{call PU.USER_AUTH_PKG.REGISTER_USER(?, ?, ?, ?, ?)}";
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            // Configurar parámetros
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setLong(3, user.getPersonId());
            stmt.registerOutParameter(4, java.sql.Types.NUMERIC); // user_id
            stmt.registerOutParameter(5, java.sql.Types.NUMERIC); // success
            
            // Ejecutar procedimiento
            stmt.execute();
            
            // Verificar resultado
            if (stmt.getInt(5) == 1) {
                user.setId(stmt.getLong(4));
                return true;
            }
            
            return false;
        }
    }
    
    @Override
    public boolean isDriver(long personId) throws SQLException {
        String sql = "{call PU.USER_AUTH_PKG.CHECK_DRIVER_ROLE(?, ?)}";
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setLong(1, personId);
            stmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            
            stmt.execute();
            
            return stmt.getInt(2) == 1;
        }
    }
    
    @Override
    public boolean isPassenger(long personId) throws SQLException {
        String sql = "{call PU.USER_AUTH_PKG.CHECK_PASSENGER_ROLE(?, ?)}";
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setLong(1, personId);
            stmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            
            stmt.execute();
            
            return stmt.getInt(2) == 1;
        }
    }
}
