package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 * Representa la entidad PU.EMAIL.
 */
public class Email {
    private long id;
    private String name; // La dirección de correo electrónico
    private long personId; // FK a ADM.PERSON

    public Email() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public long getPersonId() { return personId; }
    public void setPersonId(long personId) { this.personId = personId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Email email = (Email) o;
        return id == email.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "Email{id=" + id + ", name='" + name + "'}"; }
}