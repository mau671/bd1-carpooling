/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

import java.sql.Timestamp;
import java.sql.Date;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author hidal
 */
public class TripDetails {
    private Timestamp startTime;
    private Timestamp endTime;
    private Date tripDate;
    private BigDecimal pricePerPassenger;
    private String currencyName;
    private String plate;
    private int maxSeats;
    private int chosenSeats;
    private String driverName;
    private String gender;
    private int age;
    private String status;
    private List<double[]> coordinates;

    // NEW FIELDS
    private String startLocation;
    private String endLocation;
    private List<String> driverPhones;

    // Getters and setters
    public Timestamp getStartTime() { return startTime; }
    public void setStartTime(Timestamp startTime) { this.startTime = startTime; }

    public Timestamp getEndTime() { return endTime; }
    public void setEndTime(Timestamp endTime) { this.endTime = endTime; }

    public Date getTripDate() { return tripDate; }
    public void setTripDate(Date tripDate) { this.tripDate = tripDate; }

    public BigDecimal getPricePerPassenger() { return pricePerPassenger; }
    public void setPricePerPassenger(BigDecimal pricePerPassenger) { this.pricePerPassenger = pricePerPassenger; }

    public String getCurrencyName() { return currencyName; }
    public void setCurrencyName(String currencyName) { this.currencyName = currencyName; }

    public String getPlate() { return plate; }
    public void setPlate(String plate) { this.plate = plate; }

    public int getMaxSeats() { return maxSeats; }
    public void setMaxSeats(int maxSeats) { this.maxSeats = maxSeats; }

    public int getChosenSeats() { return chosenSeats; }
    public void setChosenSeats(int chosenSeats) { this.chosenSeats = chosenSeats; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<double[]> getCoordinates() { return coordinates; }
    public void setCoordinates(List<double[]> coordinates) { this.coordinates = coordinates; }

    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }

    public String getEndLocation() { return endLocation; }
    public void setEndLocation(String endLocation) { this.endLocation = endLocation; }

    public List<String> getDriverPhones() { return driverPhones; }
    public void setDriverPhones(List<String> driverPhones) { this.driverPhones = driverPhones; }
}
