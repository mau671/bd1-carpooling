/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author hidal
 */
public class PassengerWaypointDAO {

    public void addPassengerWaypoint(long passengerId, long waypointId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXWAYPOINT_PKG.add_passenger_waypoint(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, waypointId);
            stmt.execute();
        }
    }

    public void updatePassengerWaypoint(long passengerId, long oldWaypointId, long newWaypointId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXWAYPOINT_PKG.update_passenger_waypoint(?, ?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, oldWaypointId);
            stmt.setLong(3, newWaypointId);
            stmt.execute();
        }
    }

    public void deletePassengerWaypoint(long passengerId, long waypointId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXWAYPOINT_PKG.delete_passenger_waypoint(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, waypointId);
            stmt.execute();
        }
    }
}
