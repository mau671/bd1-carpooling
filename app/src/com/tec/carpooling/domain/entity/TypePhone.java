package com.tec.carpooling.domain.entity;

import java.util.Objects;

public class TypePhone {
    private long id;
    private String name;

    public TypePhone() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TypePhone typePhone = (TypePhone) o;
        return id == typePhone.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "TypePhone{id=" + id + ", name='" + name + "'}"; }
}