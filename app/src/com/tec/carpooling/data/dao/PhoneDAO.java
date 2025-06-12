package com.tec.carpooling.data.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Phone operations using MySQL stored procedures
 */
public class PhoneDAO {

    /**
     * Phone information class
     */
    public static class PhoneInfo {
        private String phoneNumber;
        private String phoneType;
        
        public PhoneInfo(String phoneNumber, String phoneType) {
            this.phoneNumber = phoneNumber;
            this.phoneType = phoneType;
        }
        
        public String getPhoneNumber() { return phoneNumber; }
        public String getPhoneType() { return phoneType; }
        
        @Override
        public String toString() {
            return phoneNumber + " (" + phoneType + ")";
        }
    }

    /**
     * Gets all phone numbers for a person with their types
     * 
     * @param personId The person ID
     * @param conn Database connection
     * @return List of PhoneInfo objects
     * @throws SQLException if a database error occurs
     */
    public List<PhoneInfo> getPhonesByPerson(long personId, Connection conn) throws SQLException {
        List<PhoneInfo> phones = new ArrayList<>();
        String sql = "{call carpooling_adm.get_person_phones(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, personId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String phoneNumber = rs.getString("phone_number");
                    String typeName = rs.getString("type_phone_name");
                    phones.add(new PhoneInfo(phoneNumber, typeName));
                }
            }
        }
        
        return phones;
    }
} 