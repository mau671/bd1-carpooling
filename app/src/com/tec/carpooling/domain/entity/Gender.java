package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Entity class representing a gender.
 */
public class Gender {
    private long id;
    private String name;

    /**
     * Default constructor.
     */
    public Gender() {
    }
    
    /**
     * Constructor with parameters.
     * 
     * @param id The gender ID
     * @param name The gender name
     */
    public Gender(long id, String name) {
        this.id = id;
        this.name = name;
    }
    
    /**
     * Gets the gender ID.
     * 
     * @return The gender ID
     */
    public long getId() {
        return id;
    }
    
    /**
     * Sets the gender ID.
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
    
    @Override
    public String toString() {
        return name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Gender gender = (Gender) o;
        return id == gender.id;
    }
    
    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }
}