package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Represents the ADM.DOMAIN entity.
 * This class models domains used for email addresses in the system.
 */
public class Domain {
    private long id;        // Unique identifier for the domain
    private String name;    // Domain name (e.g., "gmail.com")

    /**
     * Default constructor.
     */
    public Domain() { }

    /**
     * Gets the domain id.
     * @return the domain id
     */
    public long getId() { return id; }
    
    /**
     * Sets the domain id.
     * @param id the domain id to set
     */
    public void setId(long id) { this.id = id; }
    
    /**
     * Gets the domain name.
     * @return the domain name
     */
    public String getName() { return name; }
    
    /**
     * Sets the domain name.
     * @param name the domain name to set
     */
    public void setName(String name) { this.name = name; }

    /**
     * Compares this domain with another object for equality.
     * Domains are considered equal if they have the same id.
     * 
     * @param o the object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Domain domain = (Domain) o;
        return id == domain.id;
    }
    
    /**
     * Generates a hash code for this domain.
     * 
     * @return the hash code
     */
    @Override
    public int hashCode() { return Objects.hash(id); }
    
    /**
     * Returns a string representation of this domain.
     * 
     * @return a string representation
     */
    @Override
    public String toString() { return "Domain{id=" + id + ", name='" + name + "'}"; }
}