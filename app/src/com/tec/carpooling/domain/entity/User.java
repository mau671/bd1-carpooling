package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Represents the PU.PERSONUSER entity, potentially including
 * or referencing data from ADM.PERSON.
 */
public class User {

    private long id; // ID from PU.PERSONUSER
    private String username;
    private String password; // Contains the password HASH stored in DB
    private long personId; // FK to ADM.PERSON

    // Option: Include direct reference to Person if populated by DAO
    private Person personDetails;

    /**
     * Default constructor.
     */
    public User() {
    }

    /**
     * Constructor with all fields
     * 
     * @param id ID of the user
     * @param username Username of the user
     * @param personId ID of the associated person
     */
    public User(long id, String username, long personId) {
        this.id = id;
        this.username = username;
        this.personId = personId;
    }

    /**
     * Gets the user ID.
     * @return The user ID.
     */
    public long getId() {
        return id;
    }

    /**
     * Sets the user ID.
     * @param id The user ID to set.
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * Gets the username.
     * @return The username.
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the username.
     * @param username The username to set.
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the HASHED password stored.
     * This is NOT the plain text password.
     * @return The password hash.
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the HASHED password.
     * @param password The password hash to set.
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the person ID (foreign key to Person entity).
     * @return The person ID.
     */
    public long getPersonId() {
        return personId;
    }

    /**
     * Sets the person ID.
     * @param personId The person ID to set.
     */
    public void setPersonId(long personId) {
        this.personId = personId;
    }

    /**
     * Gets the associated Person details.
     * @return The Person object with details.
     */
    public Person getPersonDetails() {
        return personDetails;
    }

    /**
     * Sets the associated Person details.
     * @param personDetails The Person object to associate with this user.
     */
    public void setPersonDetails(Person personDetails) {
        this.personDetails = personDetails;
    }

    /**
     * Compares this user with another object for equality.
     * Users are considered equal if they have the same ID.
     * @param o The object to compare with.
     * @return true if objects are equal, false otherwise.
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id; // Compare by User ID
    }

    /**
     * Generates a hash code for this user.
     * @return The hash code based on the user ID.
     */
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    /**
     * Returns a string representation of the user.
     * Password is excluded for security reasons.
     * @return A string representation of this user.
     */
    @Override
    public String toString() {
        return "User{" +
               "id=" + id +
               ", username='" + username + '\'' +
               ", personId=" + personId +
               '}';
    }
}