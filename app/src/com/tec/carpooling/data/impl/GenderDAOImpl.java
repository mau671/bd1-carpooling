package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CatalogRegistrationException;
import com.tec.carpooling.data.dao.GenderDAO;
import com.tec.carpooling.domain.entity.Gender;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 * Implementation of the GenderDAO interface that handles database operations for Gender entities.
 */
public class GenderDAOImpl implements GenderDAO {

    private static final String REGISTER_GENDER_PROC = "{call ADM.ADM_CATALOG_MGMT_PKG.register_gender(?)}";
    private static final String FIND_ALL_GENDERS_FUNC = "{? = call ADM.ADM_CATALOG_MGMT_PKG.find_all_genders_cursor()}";
    
    private static final String ERROR_DUPLICATE = "Gender '%s' already exists.";
    private static final String ERROR_EMPTY_NAME = "Gender name cannot be empty.";
    private static final String ERROR_RETRIEVING = "Error retrieving genders from database.";

    @Override
    public void registerGender(String name) throws SQLException, CatalogRegistrationException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(REGISTER_GENDER_PROC)) {

            cs.setString(1, name);
            cs.execute();

        } catch (SQLException e) {
            handleGenderException(e, name);
        }
    }
    
    @Override
    public List<Gender> findAll() throws SQLException {
        List<Gender> genders = new ArrayList<>();
        ResultSet rs = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(FIND_ALL_GENDERS_FUNC)) {
            
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            
            rs = (ResultSet) cs.getObject(1);
            while (rs != null && rs.next()) {
                genders.add(mapToGender(rs));
            }
            
            return genders;
            
        } catch (SQLException e) {
            throw new SQLException(ERROR_RETRIEVING, e);
        } finally {
            closeResultSet(rs);
        }
    }

    /**
     * Maps a ResultSet row to a Gender entity.
     * 
     * @param rs The ResultSet containing the gender data
     * @return A Gender entity with the data from the ResultSet
     * @throws SQLException if an error occurs while accessing the ResultSet
     */
    private Gender mapToGender(ResultSet rs) throws SQLException {
        Gender gender = new Gender();
        gender.setId(rs.getLong("id"));
        gender.setName(rs.getString("name"));
        return gender;
    }

    /**
     * Handles specific gender-related exceptions.
     * 
     * @param e The SQLException to handle
     * @param name The gender name that caused the exception
     * @throws SQLException if a general database error occurs
     * @throws CatalogRegistrationException if the error is related to validation or duplicates
     */
    private void handleGenderException(SQLException e, String name) throws SQLException, CatalogRegistrationException {
        if (e.getErrorCode() == 20202) {
            throw new CatalogRegistrationException(String.format(ERROR_DUPLICATE, name), e);
        } else if (e.getErrorCode() == 20201) {
            throw new CatalogRegistrationException(ERROR_EMPTY_NAME, e);
        } else {
            throw e;
        }
    }

    /**
     * Safely closes a ResultSet.
     * 
     * @param rs The ResultSet to close
     */
    private void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ignore) {
                // Log error if needed
            }
        }
    }
}