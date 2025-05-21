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
public class TripDisplay {
    private Date tripDate;
    private String startPoint;
    private String destinationPoint;
    private String plate;
    private String status;

    public TripDisplay(Date tripDate, String startPoint, String destinationPoint, String plate, String status) {
        this.tripDate = tripDate;
        this.startPoint = startPoint;
        this.destinationPoint = destinationPoint;
        this.plate = plate;
        this.status = status;
    }

    public Date getTripDate() { return tripDate; }
    public String getStartPoint() { return startPoint; }
    public String getDestinationPoint() { return destinationPoint; }
    public String getPlate() { return plate; }
    public String getStatus() { return status; }
}
