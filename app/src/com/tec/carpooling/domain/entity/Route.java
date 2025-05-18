/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.domain.entity;

import java.sql.Timestamp;
import java.sql.Date;

/**
 *
 * @author hidal
 */
public class Route {
    private long id;
    private Timestamp startTime;
    private Timestamp endTime;
    private Date programmingDate;

    public Route() {}

    public Route(long id, Timestamp startTime, Timestamp endTime, Date programmingDate) {
        this.id = id;
        this.startTime = startTime;
        this.endTime = endTime;
        this.programmingDate = programmingDate;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public Timestamp getStartTime() { return startTime; }
    public void setStartTime(Timestamp startTime) { this.startTime = startTime; }

    public Timestamp getEndTime() { return endTime; }
    public void setEndTime(Timestamp endTime) { this.endTime = endTime; }

    public Date getProgrammingDate() { return programmingDate; }
    public void setProgrammingDate(Date programmingDate) { this.programmingDate = programmingDate; }
}
