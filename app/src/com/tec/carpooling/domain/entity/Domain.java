package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Entity class representing an email domain.
 */
public class Domain {
    private long id;
    private String name;
    private long institutionId;
    
    /**
     * Default constructor.
     */
    public Domain() {
    }
    
    /**
     * Constructor with parameters.
     * 
     * @param id The domain ID
     * @param name The domain name
     * @param institutionId The ID of the institution this domain belongs to
     */
    public Domain(long id, String name, long institutionId) {
        this.id = id;
        this.name = name;
        this.institutionId = institutionId;
    }
    
    /**
     * Gets the domain ID.
     * 
     * @return The domain ID
     */
    public long getId() {
        return id;
    }
    
    /**
     * Sets the domain ID.
     * 
     * @param id The domain ID to set
     */
    public void setId(long id) {
        this.id = id;
    }
    
    /**
     * Gets the domain name.
     * 
     * @return The domain name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Sets the domain name.
     * 
     * @param name The domain name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    
    /**
     * Gets the institution ID.
     * 
     * @return The institution ID
     */
    public long getInstitutionId() {
        return institutionId;
    }
    
    /**
     * Sets the institution ID.
     * 
     * @param institutionId The institution ID to set
     */
    public void setInstitutionId(long institutionId) {
        this.institutionId = institutionId;
    }
    
    @Override
    public String toString() {
        return name;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Domain domain = (Domain) o;
        return id == domain.id;
    }
    
    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }
}