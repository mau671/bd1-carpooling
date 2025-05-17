package com.tec.carpooling.dto;

import java.util.Date;

/**
 * DTO para manejar los datos de registro de usuarios.
 */
public class UserRegistrationData {

    // Institution and Email data
    private long institutionId;
    private String email;

    // Personal Information
    private String firstName;
    private String secondName;
    private String firstSurname;
    private String secondSurname;
    private String idNumber;
    private Date dob; // Date of birth
    private long genderId;
    private long typeIdId; // ID type identifier

    // User Account data
    private String username;
    private String password;
    private String hashedPassword; // Hashed password (set by service)

    // Contact Information
    private String phoneNumber;
    private long typePhoneId;

    // Photo data
    private byte[] photoBlob; // Image as byte array from UI

    private long personId;

    /**
     * Default constructor.
     */
    public UserRegistrationData() {
    }

    public UserRegistrationData(String username, String password, long personId) {
        this.username = username;
        this.password = password;
        this.personId = personId;
    }

    // --- Getters and Setters for all fields ---

    /**
     * @return The institution identifier
     */
    public long getInstitutionId() { return institutionId; }
    
    /**
     * @param institutionId The institution identifier to set
     */
    public void setInstitutionId(long institutionId) { this.institutionId = institutionId; }
    
    /**
     * @return The user's email address
     */
    public String getEmail() { return email; }
    
    /**
     * @param email The email address to set
     */
    public void setEmail(String email) { this.email = email; }
    
    /**
     * @return The user's first name
     */
    public String getFirstName() { return firstName; }
    
    /**
     * @param firstName The first name to set
     */
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    /**
     * @return The user's second name
     */
    public String getSecondName() { return secondName; }
    
    /**
     * @param secondName The second name to set
     */
    public void setSecondName(String secondName) { this.secondName = secondName; }
    
    /**
     * @return The user's first surname
     */
    public String getFirstSurname() { return firstSurname; }
    
    /**
     * @param firstSurname The first surname to set
     */
    public void setFirstSurname(String firstSurname) { this.firstSurname = firstSurname; }
    
    /**
     * @return The user's second surname
     */
    public String getSecondSurname() { return secondSurname; }
    
    /**
     * @param secondSurname The second surname to set
     */
    public void setSecondSurname(String secondSurname) { this.secondSurname = secondSurname; }
    
    /**
     * @return The user's identification number
     */
    public String getIdNumber() { return idNumber; }
    
    /**
     * @param idNumber The identification number to set
     */
    public void setIdNumber(String idNumber) { this.idNumber = idNumber; }
    
    /**
     * @return The user's date of birth
     */
    public Date getDob() { return dob; }
    
    /**
     * @param dob The date of birth to set
     */
    public void setDob(Date dob) { this.dob = dob; }
    
    /**
     * @return The gender identifier
     */
    public long getGenderId() { return genderId; }
    
    /**
     * @param genderId The gender identifier to set
     */
    public void setGenderId(long genderId) { this.genderId = genderId; }
    
    /**
     * @return The ID type identifier
     */
    public long getTypeIdId() { return typeIdId; }
    
    /**
     * @param typeIdId The ID type identifier to set
     */
    public void setTypeIdId(long typeIdId) { this.typeIdId = typeIdId; }
    
    /**
     * @return The username
     */
    public String getUsername() { return username; }
    
    /**
     * @param username The username to set
     */
    public void setUsername(String username) { this.username = username; }
    
    /**
     * @return The password
     */
    public String getPassword() { return password; }
    
    /**
     * @param password The password to set
     */
    public void setPassword(String password) { this.password = password; }
    
    /**
     * @return The hashed password
     */
    public String getHashedPassword() { return hashedPassword; }
    
    /**
     * @param hashedPassword The hashed password to set
     */
    public void setHashedPassword(String hashedPassword) { this.hashedPassword = hashedPassword; }
    
    /**
     * @return The phone number
     */
    public String getPhoneNumber() { return phoneNumber; }
    
    /**
     * @param phoneNumber The phone number to set
     */
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    
    /**
     * @return The phone type identifier
     */
    public long getTypePhoneId() { return typePhoneId; }
    
    /**
     * @param typePhoneId The phone type identifier to set
     */
    public void setTypePhoneId(long typePhoneId) { this.typePhoneId = typePhoneId; }
    
    /**
     * @return The photo as a byte array
     */
    public byte[] getPhotoBlob() { return photoBlob; }
    
    /**
     * @param photoBlob The photo byte array to set
     */
    public void setPhotoBlob(byte[] photoBlob) { this.photoBlob = photoBlob; }

    public long getPersonId() {
        return personId;
    }
    
    public void setPersonId(long personId) {
        this.personId = personId;
    }

    /**
     * Returns a string representation of this object for debugging purposes.
     * 
     * @return A string representation of this object
     */
    @Override
    public String toString() {
        return "UserRegistrationData{" +
               "institutionId=" + institutionId +
               ", email='" + email + '\'' +
               ", username='" + username + '\'' +
               ", firstName='" + firstName + '\'' +
               ", firstSurname='" + firstSurname + '\'' +
               ", idNumber='" + idNumber + '\'' +
               ", personId=" + personId +
               '}';
    }
}