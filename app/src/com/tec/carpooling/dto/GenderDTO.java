/**
 * Data Transfer Object (DTO) for Gender information.
 * This class represents gender data transferred between layers of the application.
 * 
 * @author mauricio
 */
package com.tec.carpooling.dto;

import java.util.Objects;

public class GenderDTO {

    // Primary identifier for gender
    private String id;
    
    // Display name of the gender
    private String name;

    /**
     * Default constructor for GenderDTO.
     */
    public GenderDTO() {
    }
    
    /**
     * Parameterized constructor to create a GenderDTO with specified values.
     * 
     * @param id The unique identifier for the gender
     * @param name The display name of the gender
     */
    public GenderDTO(String id, String name) {
        this.id = id;
        this.name = name;
    }
    
    /**
     * Gets the gender identifier.
     * 
     * @return The gender identifier
     */
    public String getId() {
        return id;
    }
    
    /**
     * Sets the gender identifier.
     * 
     * @param id The gender identifier to set
     */
    public void setId(String id) {
        this.id = id;
    }
    
    /**
     * Gets the gender name.
     * 
     * @return The gender name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Sets the gender name.
     * 
     * @param name The gender name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    
    /**
     * Provides a string representation of this GenderDTO.
     * 
     * @return A string representation of this object
     */
    @Override
    public String toString() {
        return "GenderDTO{" + "id=" + id + ", name=" + name + '}';
    }
    
    /**
     * Checks if this GenderDTO is equal to another object.
     * Two GenderDTOs are considered equal if they have the same id.
     * 
     * @param o The object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        GenderDTO that = (GenderDTO) o;
        return Objects.equals(id, that.id);
    }

    /**
     * Generates a hash code for this GenderDTO.
     * 
     * @return The hash code value
     */
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
