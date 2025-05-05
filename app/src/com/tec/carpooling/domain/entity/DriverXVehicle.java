package com.tec.carpooling.domain.entity;

import java.util.Objects;

public class DriverXVehicle {
    private long id;
    private long vehicleId;
    private long driverId; // Corresponde a PU.DRIVER.person_id

    public DriverXVehicle() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public long getVehicleId() { return vehicleId; }
    public void setVehicleId(long vehicleId) { this.vehicleId = vehicleId; }
    public long getDriverId() { return driverId; }
    public void setDriverId(long driverId) { this.driverId = driverId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DriverXVehicle that = (DriverXVehicle) o;
        return id == that.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "DriverXVehicle{id=" + id + ", vehicleId=" + vehicleId + ", driverId=" + driverId + "}"; }
}