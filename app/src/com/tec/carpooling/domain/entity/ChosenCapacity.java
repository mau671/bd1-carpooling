/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

import java.util.Objects;

/**
 *
 * @author hidal
 */

public class ChosenCapacity {
    private long id;
    private long vehicleRouteId;
    private int chosenNumber;

    public ChosenCapacity() {}

    public ChosenCapacity(long id, long vehicleRouteId, int chosenNumber) {
        this.id = id;
        this.vehicleRouteId = vehicleRouteId;
        this.chosenNumber = chosenNumber;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getVehicleRouteId() { return vehicleRouteId; }
    public void setVehicleRouteId(long vehicleRouteId) { this.vehicleRouteId = vehicleRouteId; }

    public int getChosenNumber() { return chosenNumber; }
    public void setChosenNumber(int chosenNumber) { this.chosenNumber = chosenNumber; }
}

/*public class ChosenCapacity {
    private long id;
    private long vehicleXRouteId; // FK a PU.VEHICLEXROUTE.id
    private long chosenNumber; // Usar long para NUMBER

    public ChosenCapacity() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public long getVehicleXRouteId() { return vehicleXRouteId; }
    public void setVehicleXRouteId(long vehicleXRouteId) { this.vehicleXRouteId = vehicleXRouteId; }
    public long getChosenNumber() { return chosenNumber; }
    public void setChosenNumber(long chosenNumber) { this.chosenNumber = chosenNumber; }

     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ChosenCapacity that = (ChosenCapacity) o;
        return id == that.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "ChosenCapacity{id=" + id + ", vehicleXRouteId=" + vehicleXRouteId + ", chosenNumber=" + chosenNumber + "}"; }
}*/