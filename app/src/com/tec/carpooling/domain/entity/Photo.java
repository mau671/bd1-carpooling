package com.tec.carpooling.domain.entity;

import java.util.Arrays;
import java.util.Objects;

/**
 * Represents the PU.PHOTO entity in the database.
 * This class stores image data associated with a person.
 */
public class Photo {
    
    private long id; // Primary key
    private byte[] image; // BLOB content
    private long personId; // Foreign key to ADM.PERSON

    /**
     * Default constructor.
     */
    public Photo() { }

    /**
     * Gets the photo ID.
     * @return the unique identifier for this photo
     */
    public long getId() { return id; }
    
    /**
     * Sets the photo ID.
     * @param id the unique identifier to set
     */
    public void setId(long id) { this.id = id; }
    
    /**
     * Gets the image data.
     * @return byte array containing the image data
     */
    public byte[] getImage() { return image; }
    
    /**
     * Sets the image data.
     * @param image byte array containing the image data
     */
    public void setImage(byte[] image) { this.image = image; }
    
    /**
     * Gets the associated person ID.
     * @return the ID of the person this photo belongs to
     */
    public long getPersonId() { return personId; }
    
    /**
     * Sets the associated person ID.
     * @param personId the ID of the person this photo belongs to
     */
    public void setPersonId(long personId) { this.personId = personId; }

    /**
     * Compares this photo to another object for equality.
     * Photos are considered equal if they have the same ID.
     * 
     * @param o the object to compare with
     * @return true if the objects are equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Photo photo = (Photo) o;
        return id == photo.id; // Compare only by ID
    }
    
    /**
     * Generates a hash code for this photo based on its ID.
     * 
     * @return a hash code value for this object
     */
    @Override
    public int hashCode() { return Objects.hash(id); }

    /**
     * Returns a string representation of this photo.
     * The image content is not included in the string, only its size.
     * 
     * @return a string representation of the photo
     */
    @Override
    public String toString() {
        return "Photo{" +
               "id=" + id +
               ", imageSize=" + (image != null ? image.length : 0) + // Don't print the entire blob
               ", personId=" + personId +
               '}';
    }
}