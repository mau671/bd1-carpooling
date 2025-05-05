package com.tec.carpooling.dto;

public class CatalogData {
    private String name;

    public CatalogData() { }

    public CatalogData(String name) {
        this.name = name;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}