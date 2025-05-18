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
    private String plateNumber;
    private int maxCapacity;
    private int tripCount; // currently always 0

    public VehicleInfo(String plateNumber, int maxCapacity, int tripCount) {
        this.plateNumber = plateNumber;
        this.maxCapacity = maxCapacity;
        this.tripCount = tripCount;
    }

    public String getPlateNumber() { return plateNumber; }
    public int getMaxCapacity() { return maxCapacity; }
    public int getTripCount() { return tripCount; }
}
