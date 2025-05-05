package com.tec.carpooling.domain.entity;

import java.util.Date;
import java.util.Objects;

/**
 * Representa la entidad ADM.PERSON.
 */
public class Person {

    private long id;
    private String firstName;
    private String secondName; // Opcional
    private String firstSurname;
    private String secondSurname; // Opcional
    private String identificationNumber;
    private Date dateOfBirth;
    private long genderId;
    private long typeIdentificationId;

    // --- Constructores ---
    public Person() {
    }

    // (Opcional: Constructor con campos si es útil)

    // --- Getters y Setters ---
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    public String getFirstSurname() {
        return firstSurname;
    }

    public void setFirstSurname(String firstSurname) {
        this.firstSurname = firstSurname;
    }

    public String getSecondSurname() {
        return secondSurname;
    }

    public void setSecondSurname(String secondSurname) {
        this.secondSurname = secondSurname;
    }

    public String getIdentificationNumber() {
        return identificationNumber;
    }

    public void setIdentificationNumber(String identificationNumber) {
        this.identificationNumber = identificationNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public long getGenderId() {
        return genderId;
    }

    public void setGenderId(long genderId) {
        this.genderId = genderId;
    }

    public long getTypeIdentificationId() {
        return typeIdentificationId;
    }

    public void setTypeIdentificationId(long typeIdentificationId) {
        this.typeIdentificationId = typeIdentificationId;
    }

    // --- equals, hashCode, toString (Opcional pero recomendado) ---
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return id == person.id; // Usualmente basta con el ID si es > 0
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Person{" +
               "id=" + id +
               ", firstName='" + firstName + '\'' +
               ", firstSurname='" + firstSurname + '\'' +
               ", identificationNumber='" + identificationNumber + '\'' +
               '}';
    }
}