package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Represents the ADM.INSTITUTION entity.
 * This class contains information about academic institutions in the carpooling system.
 */
public class Institution {
    private long id;        // Unique identifier for the institution
    private String name;    // Name of the institution
    
    /**
     * Default constructor.
     */
    public Institution() { }
    
    /**
     * Gets the institution's ID.
     * @return the institution ID
     */
    public long getId() { 
        return id; 
    }
    
    /**
     * Sets the institution's ID.
     * @param id the institution ID to set
     */
    public void setId(long id) { 
        this.id = id; 
    }
    
    /**
     * Gets the institution's name.
     * @return the institution name
     */
    public String getName() { 
        return name; 
    }
    
    /**
     * Sets the institution's name.
     * @param name the institution name to set
     */
    public void setName(String name) { 
        this.name = name; 
    }

    /**
     * Compares this institution with another object for equality.
     * Institutions are considered equal if they have the same ID.
     * 
     * @param o the object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Institution that = (Institution) o;
        return id == that.id;
    }
    
    /**
     * Generates a hash code for this institution.
     * 
     * @return a hash code value for this institution
     */
    @Override
    public int hashCode() { 
        return Objects.hash(id); 
    }
    
    /**
     * Returns a string representation of this institution.
     * 
     * @return a string representation of this institution
     */
    @Override
    public String toString() { 
        return "Institution{id=" + id + ", name='" + name + "'}"; 
    }
}