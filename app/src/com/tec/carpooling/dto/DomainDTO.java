package com.tec.carpooling.dto;

import java.util.Objects;

/**
 * DTO (Data Transfer Object) for transferring domain data.
 * This class represents a domain entity in the system with basic identification and naming.
 * It provides standard object methods (equals, hashCode, toString) for proper object handling
 * in collections and display purposes.
 */
public class DomainDTO {
    private long id;
    private String name;

    /**
     * Constructs a new DomainDTO with the specified id and name.
     * 
     * @param id   The unique identifier for this domain
     * @param name The display name of the domain
     */
    public DomainDTO(long id, String name) {
        this.id = id;
        this.name = name;
    }

    /**
     * Gets the domain's unique identifier.
     * 
     * @return The domain's id
     */
    public long getId() { 
        return id; 
    }

    /**
     * Gets the domain's name.
     * 
     * @return The domain's name
     */
    public String getName() { 
        return name; 
    }

    /**
     * Returns a string representation of this domain, which is its name.
     * 
     * @return The domain's name
     */
    @Override
    public String toString() { 
        return name; 
    }
    
    /**
     * Determines if this domain is equal to another object.
     * Domains are considered equal if they have the same id.
     * 
     * @param o The object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DomainDTO that = (DomainDTO) o;
        return id == that.id;
    }

    /**
     * Generates a hash code for this domain based on its id.
     * 
     * @return A hash code value for this domain
     */
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}