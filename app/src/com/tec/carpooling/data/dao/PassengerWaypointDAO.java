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

    /**
     * Adds a waypoint to a passenger by calling:
     *   CALL carpooling_adm.add_passenger_waypoint(p_passenger_id, p_waypoint_id)
     */
    public void addPassengerWaypoint(long passengerId,
                                     long waypointId,
                                     Connection conn) throws SQLException {
        String sql = "{ CALL carpooling_adm.add_passenger_waypoint(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, waypointId);
            stmt.execute();
        }
    }

    /**
     * Updates an existing passenger-waypoint relation by calling:
     *   CALL carpooling_adm.update_passenger_waypoint(p_passenger_id,
     *                                                  p_old_waypoint_id,
     *                                                  p_new_waypoint_id)
     */
    public void updatePassengerWaypoint(long passengerId,
                                         long oldWaypointId,
                                         long newWaypointId,
                                         Connection conn) throws SQLException {
        String sql = "{ CALL carpooling_adm.update_passenger_waypoint(?, ?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, oldWaypointId);
            stmt.setLong(3, newWaypointId);
            stmt.execute();
        }
    }

    /**
     * Deletes a passenger-waypoint relation by calling:
     *   CALL carpooling_adm.delete_passenger_waypoint(p_passenger_id, p_waypoint_id)
     */
    public void deletePassengerWaypoint(long passengerId,
                                         long waypointId,
                                         Connection conn) throws SQLException {
        String sql = "{ CALL carpooling_adm.delete_passenger_waypoint(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, waypointId);
            stmt.execute();
        }
    }

}
