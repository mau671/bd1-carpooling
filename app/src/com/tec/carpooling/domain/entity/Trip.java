/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

import java.math.BigDecimal;

/**
 *
 * @author hidal
 */
public class Trip {
    private long id;
    private long vehicleId;
    private long routeId;
    private Long currencyId;
    private BigDecimal pricePerPassenger;

    public Trip() {}

    public Trip(long id, long vehicleId, long routeId, Long currencyId, BigDecimal pricePerPassenger) {
        this.id = id;
        this.vehicleId = vehicleId;
        this.routeId = routeId;
        this.currencyId = currencyId;
        this.pricePerPassenger = pricePerPassenger;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getVehicleId() { return vehicleId; }
    public void setVehicleId(long vehicleId) { this.vehicleId = vehicleId; }

    public long getRouteId() { return routeId; }
    public void setRouteId(long routeId) { this.routeId = routeId; }

    public Long getCurrencyId() { return currencyId; }
    public void setCurrencyId(Long currencyId) { this.currencyId = currencyId; }

    public BigDecimal getPricePerPassenger() { return pricePerPassenger; }
    public void setPricePerPassenger(BigDecimal pricePerPassenger) { this.pricePerPassenger = pricePerPassenger; }
}
