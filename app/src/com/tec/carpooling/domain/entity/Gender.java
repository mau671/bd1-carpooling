package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Represents a gender entity in the system.
 * This class maps to the ADM.GENDER table.
 */
public class Gender {
    private long id;
    private String name;

    /**
     * Default constructor.
     */
    public Gender() { }

    /**
     * Gets the gender identifier.
     * 
     * @return The gender ID
     */
    public long getId() { 
        return id; 
    }

    /**
     * Sets the gender identifier.
     * 
     * @param id The gender ID to set
     */
    public void setId(long id) { 
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
     * Checks if this Gender is equal to another object.
     * Two Gender objects are considered equal if they have the same id.
     * 
     * @param o The object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Gender gender = (Gender) o;
        return id == gender.id;
    }

    /**
     * Generates a hash code for this Gender.
     * 
     * @return The hash code value
     */
    @Override
    public int hashCode() { 
        return Objects.hash(id); 
    }

    /**
     * Provides a string representation of this Gender.
     * 
     * @return A string representation of this object
     */
    @Override
    public String toString() { 
        return "Gender{id=" + id + ", name='" + name + "'}"; 
    }
}