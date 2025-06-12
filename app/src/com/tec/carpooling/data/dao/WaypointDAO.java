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
public class WaypointDAO {

    public void createWaypointWithDistrict(long routeId, long districtId, Connection conn) throws SQLException {
        String sql = "{CALL create_waypoint_with_district(?, ?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, routeId);
            stmt.setLong(2, districtId);
            stmt.execute();
        }
    }

    public void createWaypointWithCoords(long routeId, double latitude, double longitude, Connection conn) throws SQLException {
        String sql = "{CALL create_waypoint_with_coords(?, ?, ?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, routeId);
            stmt.setDouble(2, latitude);
            stmt.setDouble(3, longitude);
            stmt.execute();
        }
    }
}

