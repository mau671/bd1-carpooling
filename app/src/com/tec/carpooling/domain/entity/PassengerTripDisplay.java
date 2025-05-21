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
public class PassengerTripDisplay {
    private Date tripDate;
    private String startPoint;
    private String endPoint;
    private String plate;
    private String status;

    public PassengerTripDisplay(Date tripDate, String startPoint, String endPoint, String plate, String status) {
        this.tripDate = tripDate;
        this.startPoint = startPoint;
        this.endPoint = endPoint;
        this.plate = plate;
        this.status = status;
    }

    // Getters
    public Date getTripDate() { return tripDate; }
    public String getStartPoint() { return startPoint; }
    public String getEndPoint() { return endPoint; }
    public String getPlate() { return plate; }
    public String getStatus() { return status; }
}
