package com.tec.carpooling.domain.entity;

/**
 * Entity class representing an identification type.
 */
public class IdType {
    private long id;
    private String name;
    
    /**
     * Default constructor.
     */
    public IdType() {
    }
    
    /**
     * Constructor with parameters.
     * 
     * @param id The ID type ID
     * @param name The ID type name
     */
    public IdType(long id, String name) {
        this.id = id;
        this.name = name;
    }
    
    /**
     * Gets the ID type ID.
     * 
     * @return The ID type ID
     */
    public long getId() {
        return id;
    }
    
    /**
     * Sets the ID type ID.
     * 
     * @param id The ID type ID to set
     */
    public void setId(long id) {
        this.id = id;
    }
    
    /**
     * Gets the ID type name.
     * 
     * @return The ID type name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Sets the ID type name.
     * 
     * @param name The ID type name to set
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
        IdType idType = (IdType) o;
        return id == idType.id;
    }
    
    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }
} 