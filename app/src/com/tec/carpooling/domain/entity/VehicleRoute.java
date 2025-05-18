/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

/**
 *
 * @author hidal
 */
public class VehicleRoute {
    private long id;
    private long vehicleId;
    private long routeId;

    public VehicleRoute() {}

    public VehicleRoute(long id, long vehicleId, long routeId) {
        this.id = id;
        this.vehicleId = vehicleId;
        this.routeId = routeId;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getVehicleId() { return vehicleId; }
    public void setVehicleId(long vehicleId) { this.vehicleId = vehicleId; }

    public long getRouteId() { return routeId; }
    public void setRouteId(long routeId) { this.routeId = routeId; }
}
