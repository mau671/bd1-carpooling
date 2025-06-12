package com.tec.carpooling.data.dao;

import java.sql.SQLException;

/**
 * Data Access Object interface for user type operations
 */
public interface UserTypeDAO {
    /**
     * Registra un usuario como conductor
     * 
     * @param userId ID del usuario
     * @throws SQLException Si ocurre un error de base de datos
     */
    void registerAsDriver(long userId) throws SQLException;
    
    /**
     * Registra un usuario como pasajero
     * 
     * @param userId ID del usuario
     * @throws SQLException Si ocurre un error de base de datos
     */
    void registerAsPassenger(long userId) throws SQLException;
    
    /**
     * Verifica si un usuario es administrador
     * 
     * @param userId ID del usuario
     * @return true si es administrador, false si no lo es
     * @throws SQLException Si ocurre un error de base de datos
     */
    boolean isAdmin(long userId) throws SQLException;
    
    /**
     * Obtiene el tipo de usuario actual
     * 
     * @param userId ID del usuario
     * @return "ADMIN" si es administrador, "DRIVER" si es conductor, "PASSENGER" si es pasajero, null si no está definido
     * @throws SQLException Si ocurre un error de base de datos
     */
    String getUserType(long userId) throws SQLException;
    
    boolean isPassenger(long userId) throws SQLException;
    boolean isDriver(long userId) throws SQLException;
} 