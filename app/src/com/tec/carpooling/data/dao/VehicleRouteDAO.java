/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.VehicleRoute;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class VehicleRouteDAO {
    public long linkVehicleToRoute(long vehicleId, long routeId, Connection conn) throws SQLException {
        String insertSql = "{CALL assign_vehicle_to_route(?, ?)}";
        try (CallableStatement stmt = conn.prepareCall(insertSql)) {
            stmt.setLong(1, vehicleId);
            stmt.setLong(2, routeId);
            stmt.execute();
        }

        // Now fetch the VEHICLEXROUTE id after insert
        String querySql = "SELECT id FROM VEHICLEXROUTE WHERE vehicle_id = ? AND route_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(querySql)) {
            stmt.setLong(1, vehicleId);
            stmt.setLong(2, routeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getLong("id");
                throw new SQLException("VehicleRoute link not found.");
            }
        }
    }
}