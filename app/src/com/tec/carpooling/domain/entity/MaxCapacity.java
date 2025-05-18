/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

/**
 *
 * @author hidal
 */
public class MaxCapacity {
    private long id;
    private int capacity;

    public MaxCapacity(long id, int capacity) {
        this.id = id;
        this.capacity = capacity;
    }

    public long getId() {
        return id;
    }
    
    public void setId(long id) {
        this.id = id;
    }

    public int getCapacity() {
        return capacity;
    }

    @Override
    public String toString() {
        return String.valueOf(capacity); // This shows in the combo box
    }
}
