/*
 * UserDAO - Data Access Object for managing user-related database operations
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.User;
import java.sql.SQLException;

/**
 * UserDAO handles data access operations for users in the carpooling system.
 * This class provides methods to check user roles and types in the system.
 *
 * @author mauricio
 */
public interface UserDAO {
    /**
     * Busca un usuario por su nombre de usuario
     * @param username El nombre de usuario a buscar
     * @return El usuario encontrado o null si no existe
     * @throws SQLException Si ocurre un error de base de datos
     */
    User findUserByUsername(String username) throws SQLException;
    
    /**
     * Registra un nuevo usuario en el sistema
     * @param user El usuario a registrar
     * @return true si el registro fue exitoso, false en caso contrario
     * @throws SQLException Si ocurre un error de base de datos
     */
    boolean registerUser(User user) throws SQLException;
    
    /**
     * Verifica si un usuario es conductor
     * @param personId El ID de la persona
     * @return true si es conductor, false en caso contrario
     * @throws SQLException Si ocurre un error de base de datos
     */
    boolean isDriver(long personId) throws SQLException;

    /**
     * Verifica si un usuario es pasajero
     * @param personId El ID de la persona
     * @return true si es pasajero, false en caso contrario
     * @throws SQLException Si ocurre un error de base de datos
     */
    boolean isPassenger(long personId) throws SQLException;
}
