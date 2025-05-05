package com.tec.carpooling.domain.entity;

import java.util.Objects;

public class ChosenCapacity {
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
}