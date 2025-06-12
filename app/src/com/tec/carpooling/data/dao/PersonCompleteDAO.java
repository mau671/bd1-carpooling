package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Person;
import com.tec.carpooling.domain.entity.Institution;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for complete person profile operations using MySQL stored procedures
 * This DAO uses the get_person_complete_profile procedure which returns multiple result sets
 * for optimal performance
 */
public class PersonCompleteDAO {

    /**
     * Complete profile data container
     */
    public static class CompleteProfile {
        private Person person;
        private String genderName;
        private String typeIdentificationName;
        private List<String> emails;
        private List<PhoneInfo> phones;
        private List<Institution> institutions;
        
        public CompleteProfile() {
            this.emails = new ArrayList<>();
            this.phones = new ArrayList<>();
            this.institutions = new ArrayList<>();
        }
        
        // Getters and setters
        public Person getPerson() { return person; }
        public void setPerson(Person person) { this.person = person; }
        
        public String getGenderName() { return genderName; }
        public void setGenderName(String genderName) { this.genderName = genderName; }
        
        public String getTypeIdentificationName() { return typeIdentificationName; }
        public void setTypeIdentificationName(String typeIdentificationName) { this.typeIdentificationName = typeIdentificationName; }
        
        public List<String> getEmails() { return emails; }
        public void setEmails(List<String> emails) { this.emails = emails; }
        
        public List<PhoneInfo> getPhones() { return phones; }
        public void setPhones(List<PhoneInfo> phones) { this.phones = phones; }
        
        public List<Institution> getInstitutions() { return institutions; }
        public void setInstitutions(List<Institution> institutions) { this.institutions = institutions; }
    }
    
    /**
     * Phone information class (reused from PhoneDAO)
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
     * Gets complete profile information for a person using a single procedure call
     * 
     * @param personId The person ID
     * @param conn Database connection
     * @return CompleteProfile object with all person data
     * @throws SQLException if a database error occurs
     */
    public CompleteProfile getCompleteProfile(long personId, Connection conn) throws SQLException {
        CompleteProfile profile = new CompleteProfile();
        String sql = "{call carpooling_adm.get_person_complete_profile(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, personId);
            
            // Execute and process multiple result sets
            boolean hasResults = stmt.execute();
            int resultSetNumber = 1;
            
            while (hasResults) {
                try (ResultSet rs = stmt.getResultSet()) {
                    switch (resultSetNumber) {
                        case 1: // Basic person information
                            if (rs.next()) {
                                Person person = new Person();
                                person.setId(rs.getLong("id"));
                                person.setFirstName(rs.getString("first_name"));
                                person.setSecondName(rs.getString("second_name"));
                                person.setFirstSurname(rs.getString("first_surname"));
                                person.setSecondSurname(rs.getString("second_surname"));
                                person.setIdentificationNumber(rs.getString("identification_number"));
                                person.setDateOfBirth(rs.getDate("date_of_birth"));
                                person.setGenderId(rs.getLong("gender_id"));
                                person.setTypeIdentificationId(rs.getLong("type_identification_id"));
                                profile.setPerson(person);
                                
                                // Also store the names
                                profile.setGenderName(rs.getString("gender_name"));
                                profile.setTypeIdentificationName(rs.getString("type_identification_name"));
                            }
                            break;
                            
                        case 2: // Emails
                            while (rs.next()) {
                                String fullEmail = rs.getString("full_email");
                                profile.getEmails().add(fullEmail);
                            }
                            break;
                            
                        case 3: // Phones
                            while (rs.next()) {
                                String phoneNumber = rs.getString("phone_number");
                                String typeName = rs.getString("type_phone_name");
                                profile.getPhones().add(new PhoneInfo(phoneNumber, typeName));
                            }
                            break;
                            
                        case 4: // Institutions
                            while (rs.next()) {
                                Institution institution = new Institution();
                                institution.setId(rs.getLong("id"));
                                institution.setName(rs.getString("name"));
                                profile.getInstitutions().add(institution);
                            }
                            break;
                    }
                }
                
                hasResults = stmt.getMoreResults();
                resultSetNumber++;
            }
        }
        
        return profile;
    }
} 