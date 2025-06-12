package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.dao.UserRegistrationDAO;
import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;

/**
 * Implementation of the user registration DAO for MySQL
 */
public class UserRegistrationDAOImpl implements UserRegistrationDAO {
    private static final String REGISTER_USER_PROCEDURE = 
        "{call carpooling_adm.register_complete_user(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
    
    private static final String ADD_PHOTO_PROCEDURE = 
        "{call carpooling_adm.add_photo(?, ?, ?)}";
    
    /**
     * Result class for user registration containing person_id and user_id
     */
    public static class RegistrationResult {
        private final int personId;
        private final int userId;
        
        public RegistrationResult(int personId, int userId) {
            this.personId = personId;
            this.userId = userId;
        }
        
        public int getPersonId() { return personId; }
        public int getUserId() { return userId; }
        public boolean isSuccessful() { return personId > 0 && userId > 0; }
    }
    
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
        RegistrationResult result = registerUserWithResult(firstName, secondName, firstSurname, 
            secondSurname, idTypeId, idNumber, phoneTypeId, phoneNumber, email, dateOfBirth, 
            genderId, institutionId, domainId, username, hashedPassword);
        return result.isSuccessful();
    }
    
    /**
     * Registers a user and returns the registration result with person_id and user_id
     */
    public RegistrationResult registerUserWithResult(
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
            
            // Set input parameters for register_complete_user
            stmt.setString(1, firstName);
            stmt.setString(2, secondName);
            stmt.setString(3, firstSurname);
            stmt.setString(4, secondSurname);
            stmt.setInt(5, (int)idTypeId);
            stmt.setString(6, idNumber);
            stmt.setInt(7, (int)phoneTypeId);
            stmt.setString(8, phoneNumber);
            stmt.setString(9, email);
            stmt.setDate(10, java.sql.Date.valueOf(dateOfBirth));
            stmt.setInt(11, (int)genderId);
            stmt.setInt(12, (int)institutionId);
            stmt.setInt(13, (int)domainId);
            stmt.setString(14, username);
            stmt.setString(15, hashedPassword);
            
            // Register output parameters
            stmt.registerOutParameter(16, Types.INTEGER); // o_person_id
            stmt.registerOutParameter(17, Types.INTEGER); // o_user_id
            
            // Execute the procedure
            stmt.execute();
            
            // Get the results
            int personId = stmt.getInt(16);
            int userId = stmt.getInt(17);
            
            return new RegistrationResult(personId, userId);
        }
    }
    
    /**
     * Adds a photo for a person
     * 
     * @param personId The person ID (foreign key to PERSON table)
     * @param imageData The image data as byte array
     * @return The photo ID if successful, -1 otherwise
     * @throws SQLException if a database error occurs
     */
    public long addPersonPhoto(long personId, byte[] imageData) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(ADD_PHOTO_PROCEDURE)) {
            
            stmt.setInt(1, (int)personId);
            stmt.setBytes(2, imageData);
            stmt.registerOutParameter(3, Types.INTEGER); // o_photo_id
            
            stmt.execute();
            
            return stmt.getInt(3);
        }
    }
} 