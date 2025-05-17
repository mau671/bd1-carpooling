package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Gender;
import java.sql.SQLException;
import java.util.List;
// Podrías añadir métodos findById, findAll, etc., más adelante
// import com.tec.carpooling.domain.entity.Gender;
// import java.util.List;

/**
 * Data Access Object interface for Gender entity.
 * Handles all database operations related to genders.
 */
public interface GenderDAO {
    /**
     * Registers a new gender in the database.
     * Calls the ADM.ADM_CATALOG_MGMT_PKG.register_gender procedure.
     *
     * @param name The name of the gender to register
     * @throws SQLException if a general database error occurs
     * @throws CatalogRegistrationException if the name is empty or the gender already exists
     */
    void registerGender(String name) throws SQLException, CatalogRegistrationException;
    
    /**
     * Retrieves all genders from the database.
     * 
     * @return List of all Gender entities
     * @throws SQLException if a database error occurs
     */
    List<Gender> findAll() throws SQLException;

    // List<Gender> findAll() throws SQLException; // Ejemplo para el futuro
}