package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Representa la entidad PU.PHONE.
 */
public class Phone {
    private long id;
    private String phoneNumber;
    private long typePhoneId; // FK a ADM.TYPE_PHONE

    // Podrías añadir la entidad TypePhone si la necesitas a menudo
    // private TypePhone typePhoneDetails;

    public Phone() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public long getTypePhoneId() { return typePhoneId; }
    public void setTypePhoneId(long typePhoneId) { this.typePhoneId = typePhoneId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Phone phone = (Phone) o;
        return id == phone.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
     @Override
    public String toString() { return "Phone{id=" + id + ", phoneNumber='" + phoneNumber + "'}"; }
}