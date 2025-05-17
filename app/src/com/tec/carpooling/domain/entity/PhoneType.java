package com.tec.carpooling.domain.entity;

/**
 * Entity class representing a phone type.
 */
public class PhoneType {
    private long id;
    private String name;
    
    /**
     * Default constructor.
     */
    public PhoneType() {
    }
    
    /**
     * Constructor with parameters.
     * 
     * @param id The phone type ID
     * @param name The phone type name
     */
    public PhoneType(long id, String name) {
        this.id = id;
        this.name = name;
    }
    
    /**
     * Gets the phone type ID.
     * 
     * @return The phone type ID
     */
    public long getId() {
        return id;
    }
    
    /**
     * Sets the phone type ID.
     * 
     * @param id The phone type ID to set
     */
    public void setId(long id) {
        this.id = id;
    }
    
    /**
     * Gets the phone type name.
     * 
     * @return The phone type name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Sets the phone type name.
     * 
     * @param name The phone type name to set
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
        PhoneType phoneType = (PhoneType) o;
        return id == phoneType.id;
    }
    
    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }
} 