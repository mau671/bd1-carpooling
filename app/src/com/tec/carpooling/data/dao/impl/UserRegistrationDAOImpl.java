package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.dao.UserRegistrationDAO;
import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;

/**
 * Implementation of the user registration DAO
 */
public class UserRegistrationDAOImpl implements UserRegistrationDAO {
    private static final String REGISTER_USER_PROCEDURE = 
        "{call ADM.ADM_USER_REGISTRATION_PKG.register_user(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
    
    @Override
    public boolean registerUser(
        String firstName,
        String secondName,
        String firstSurname,
        String secondSurname,
        long idTypeId,
        String idNumber,
        long phoneTypeId,
        String phoneNumber,
        String email,
        LocalDate dateOfBirth,
        long genderId,
        long institutionId,
        long domainId,
        String username,
        String hashedPassword
    ) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(REGISTER_USER_PROCEDURE)) {
            
            // Set input parameters
            stmt.setString(1, firstName);
            stmt.setString(2, secondName);
            stmt.setString(3, firstSurname);
            stmt.setString(4, secondSurname);
            stmt.setLong(5, idTypeId);
            stmt.setString(6, idNumber);
            stmt.setLong(7, phoneTypeId);
            stmt.setString(8, phoneNumber);
            stmt.setString(9, email);
            stmt.setDate(10, java.sql.Date.valueOf(dateOfBirth));
            stmt.setLong(11, genderId);
            stmt.setLong(12, institutionId);
            stmt.setLong(13, domainId);
            stmt.setString(14, username);
            stmt.setString(15, hashedPassword);
            
            // Register output parameters
            stmt.registerOutParameter(16, Types.NUMERIC); // person_id
            stmt.registerOutParameter(17, Types.NUMERIC); // user_id
            
            // Execute the procedure
            stmt.execute();
            
            // Check if registration was successful
            return stmt.getLong(16) > 0 && stmt.getLong(17) > 0;
        }
    }
} 