package com.tec.carpooling.domain.entity;

import java.util.Objects;

public class MaxCapacityXVehicle {
    private long id;
    private long maxCapacityId;
    private long vehicleId;

    public MaxCapacityXVehicle() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public long getMaxCapacityId() { return maxCapacityId; }
    public void setMaxCapacityId(long maxCapacityId) { this.maxCapacityId = maxCapacityId; }
    public long getVehicleId() { return vehicleId; }
    public void setVehicleId(long vehicleId) { this.vehicleId = vehicleId; }

     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MaxCapacityXVehicle that = (MaxCapacityXVehicle) o;
        return id == that.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "MaxCapacityXVehicle{id=" + id + ", maxCapacityId=" + maxCapacityId + ", vehicleId=" + vehicleId + "}"; }
}