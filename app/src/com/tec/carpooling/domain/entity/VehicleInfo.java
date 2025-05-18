/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

/**
 *
 * @author hidal
 */
public class VehicleInfo {
    private long id;
    private String plateNumber;
    private int maxCapacity;
    private int tripCount; // currently always 0

    public VehicleInfo(long id, String plateNumber, int maxCapacity, int tripCount) {
        this.id = id;
        this.plateNumber = plateNumber;
        this.maxCapacity = maxCapacity;
        this.tripCount = tripCount;
    }
    
    public long getId() { return id; }
    public String getPlateNumber() { return plateNumber; }
    public int getMaxCapacity() { return maxCapacity; }
    public int getTripCount() { return tripCount; }
    
    @Override
    public String toString() {
        return plateNumber;
    }
    
}
