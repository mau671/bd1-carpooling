/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

import java.sql.Date;

/**
 *
 * @author hidal
 */
public class TripSummary {
    private long tripId;
    private Date tripDate;
    private String startPoint;

    public TripSummary(long tripId, Date tripDate, String startPoint) {
        this.tripId = tripId;
        this.tripDate = tripDate;
        this.startPoint = startPoint;
    }

    public long getTripId() {
        return tripId;
    }

    public Date getTripDate() {
        return tripDate;
    }

    public String getStartPoint() {
        return startPoint;
    }

    @Override
    public String toString() {
        return startPoint + " - " + tripDate;
    }
}