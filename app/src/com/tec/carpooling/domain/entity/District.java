/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

/**
 *
 * @author hidal
 */
public class District {
    private long id;
    private String name;
    private long cantonId;

    public District() {}

    public District(long id, String name, long cantonId) {
        this.id = id;
        this.name = name;
        this.cantonId = cantonId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getCantonId() {
        return cantonId;
    }

    public void setCantonId(long cantonId) {
        this.cantonId = cantonId;
    }

    @Override
    public String toString() {
        return name;
    }
}
