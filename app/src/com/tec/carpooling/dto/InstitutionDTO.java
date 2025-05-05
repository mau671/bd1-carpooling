package com.tec.carpooling.dto;

import java.util.Objects;

/**
 * DTO (Data Transfer Object) for institution data.
 * This class represents an institution within the carpooling system.
 * It encapsulates the basic attributes of an institution including ID and name.
 */
public class InstitutionDTO {
    
    private long id;      // Unique identifier for the institution
    private String name;  // Name of the institution

    /**
     * Constructs an InstitutionDTO with specified ID and name.
     * 
     * @param id   The unique identifier for the institution
     * @param name The name of the institution
     */
    public InstitutionDTO(long id, String name) {
        this.id = id;
        this.name = name;
    }

    /**
     * Returns the institution's unique identifier.
     * 
     * @return The ID of the institution
     */
    public long getId() { 
        return id; 
    }
    
    /**
     * Returns the institution's name.
     * 
     * @return The name of the institution
     */
    public String getName() { 
        return name; 
    }

    /**
     * Returns the institution name as a string representation.
     * Important for JComboBox display if used in the UI.
     * 
     * @return The name of the institution
     */
    @Override
    public String toString() {
        return name;
    }
    
    /**
     * Compares this institution to another object for equality.
     * Institutions are considered equal if they have the same ID.
     * 
     * @param o The object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InstitutionDTO that = (InstitutionDTO) o;
        return id == that.id;
    }
    
    /**
     * Generates a hash code for this institution.
     * 
     * @return The hash code value
     */
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}